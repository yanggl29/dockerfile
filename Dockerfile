FROM ubuntu:22.04
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN echo "deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse\n\
	deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse\n\
	deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse\n\
	deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy main restricted universe multiverse\n\
	deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-security main restricted universe multiverse\n\
	deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ jammy-updates main restricted universe multiverse" > /etc/apt/sources.list \
    && apt-get update && apt-get upgrade --assume-yes \
    && apt-get -f install vim --assume-yes \
    && apt-get install -y build-essential \
    && apt-get install -y software-properties-common \
    && apt-get install -y curl git htop man unzip vim wget zsh sudo locales \
    && apt-get install gdb cgdb bear libreadline-dev zlib1g-dev -y \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8 

RUN useradd --create-home --no-log-init --shell /bin/zsh username
RUN adduser username sudo \
    && echo 'username:xxxxxx' | chpasswd

USER username
WORKDIR /home/username
