From: romain.perier@free-electrons.com (Romain Perier)
Date: Thu, 8 Sep 2016 16:52:16 +0200
Subject: [crypto] [marvell-cesa] Possible regression after Linux 4.7
In-Reply-To: <57ce53d6.0a28190a.3d6d2.44b2@mx.google.com>
References: <57ce53d6.0a28190a.3d6d2.44b2@mx.google.com>
Message-ID: <57D17B20.8070606@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le 06/09/2016 07:27, radioconfusion at gmail.com a ?crit :
> Hello,
>
> I'm testing the marvell-cesa -driver on Armada 385 board and I think I've found
> a regression between Linux 4.7 and 4.8-rc4.
> I want to accelerate my curl connections. So I compiled the 4.8-rc4 with
> marvell-cesa enabled and HEAD revision of cryptodev-linux.
>
> Here is my output:
>
> ~# uname -r
> 4.8.0-rc4
> ~# modprobe cryptodev
> ~# modprobe marvell-cesa
> ~# curl -k --ciphers AES256-SHA256 https://myserver/myfile >/dev/null
>    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
>                                   Dload  Upload   Total   Spent    Left  Speed
>   19  200M   19 39.7M    0     0  16.2M      0  0:00:12  0:00:02  0:00:10 16.2M
> curl: (56) SSL read: error:1408F119:SSL routines:SSL3_GET_RECORD:decryption
> failed or bad record mac, errno 0
>
> This error is quite easy to reproduce. Especially if you have some other
> connections open at same time or two simultaneous curl-connections.
> I had a ssh-connection running top(1).
>
> I can not reproduce this with Linux 4.7 or without modprobing marvell-cesa.
>
> I'm not using any special kernel parameter, patches, custom dts, etc.
>
> Best Regards,
> Jussi
>

Thank you for your feedbacks.
I can reproduce the issue with and without multiple engines. With the 
following steps:

1. open an ssh connection on the target, and start the following command:

#  while true; do curl -k -v --ciphers AES256-SHA256 https://foobar 
 >/dev/null > /dev/null; done


2. From the uart :
# curl -k --ciphers AES256-SHA256 https://foobar >/dev/null

Then, the second command will fail easily.

However, I have found an interesting thing, If I use only --ciphers 
AES256, it works perfectly fine, could you confirm this ?

In any case, I will investigate.

Thanks!
Romain
-- 
Romain Perier, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
