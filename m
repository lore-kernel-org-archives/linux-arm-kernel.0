From: radioconfusion@gmail.com (radioconfusion at gmail.com)
Date: Fri, 09 Sep 2016 10:24:50 +0300
Subject: [crypto] [marvell-cesa] Possible regression after Linux 4.7
Message-ID: <57d263c4.d5002e0a.8975e.0df2@mx.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
Thu,  8 Sep 2016 16:52:16 +0200, Romain Perier wrote:
> > Hello,
> >
> > I'm testing the marvell-cesa -driver on Armada 385 board and I think I've found
> > a regression between Linux 4.7 and 4.8-rc4.
> > I want to accelerate my curl connections. So I compiled the 4.8-rc4 with
> > marvell-cesa enabled and HEAD revision of cryptodev-linux.
> >
> > Here is my output:
> >
> > ~# uname -r
> > 4.8.0-rc4
> > ~# modprobe cryptodev
> > ~# modprobe marvell-cesa
> > ~# curl -k --ciphers AES256-SHA256 https://myserver/myfile >/dev/null
> >    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
> >                                   Dload  Upload   Total   Spent    Left  Speed
> >   19  200M   19 39.7M    0     0  16.2M      0  0:00:12  0:00:02  0:00:10 16.2M
> > curl: (56) SSL read: error:1408F119:SSL routines:SSL3_GET_RECORD:decryption
> > failed or bad record mac, errno 0
> >
--- snip ---
>
> Thank you for your feedbacks.
> I can reproduce the issue with and without multiple engines.

Thank you for your testing. Do you mean that you can reproduce it with
Linux 4.7 too?

> However, I have found an interesting thing, If I use only --ciphers
> AES256, it works perfectly fine, could you confirm this ?

Yes, I can confirm. And I have found the reason too.
Most of available ciphers will not be accelerated at all.
Only these ones I have verified to be accelerated by cesa:
AES256-SHA256
AES256-SHA
AES128-SHA256
AES128-SHA

When cesa is working, I can see "irq/42-f1090000" on process list of top(1) and
curl doesn't take all of available cpu.

It's not easy to detect acceleration by performance because I tested with
Linux 4.7 and older cryptodev (1.8 release) and I got average curl throughput
~22 MiB/s with AES256-SHA256 + cesa. Without cesa I got ~20 MiB/s average with
same configuration.

> In any case, I will investigate.

Thank you very much.

Best Regards,
Jussi
