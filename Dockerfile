FROM ubuntu:16.04

ENV JAVA_HOME=/usr
ENV HADOOP_HOME=/usr/local/hadoop-2.7.2
ENV HIVE_HOME=/usr/local/apache-hive-2.1.0-bin
ENV PATH=$PATH:$HADOOP_HOME/bin:$HIVE_HOME/bin

RUN apt-get update
RUN apt-get -y install ssh rsync curl openjdk-8-jre
RUN curl http://mirror.dkm.cz/apache/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz | \
    tar -xz -C /usr/local/
RUN curl http://apache.miloslavbrada.cz/hive/hive-2.1.0/apache-hive-2.1.0-bin.tar.gz | \
    tar -xz -C /usr/local/

RUN mkdir -p /user/hive/warehouse

RUN $HADOOP_HOME/bin/hadoop fs -chmod g+w /tmp
RUN $HADOOP_HOME/bin/hadoop fs -chmod g+w /user/hive/warehouse

RUN schematool -dbType derby -initSchema

EXPOSE 10000

CMD hiveserver2

