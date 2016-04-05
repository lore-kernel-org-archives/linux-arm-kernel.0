From: fijam@archlinux.us (JM)
Date: Tue, 5 Apr 2016 22:30:01 +0200
Subject: marvell_cesa fails to register on kirkwood (88F6282)
In-Reply-To: <CAKzmTe01UShsocA7VbZziWWqt2k-5yJwYH0MnddXHT+s3Oni=w@mail.gmail.com>
References: <20160205090246.GE32272@lunn.ch>
 <20160205112907.796afb05@bbrezillon>
 <CAKzmTe20fT8BcRaDaf2gz92KMAK0kEUkaD-kPq_cPF1WKBdroA@mail.gmail.com>
 <87vb632maf.fsf@free-electrons.com>
 <CAKzmTe1AqNQwjcsAULotd010NXuk1AYjj5p6UoqT_Zu=BCHdcw@mail.gmail.com>
 <87mvrf2l6p.fsf@free-electrons.com> <87io232kat.fsf@free-electrons.com>
 <8760y2vqje.fsf@natisbad.org> <87twlmdg2b.fsf@natisbad.org>
 <CAKzmTe24iz1Ka7Kkke=ZTVbDGZxxDjBH0m2iEVCQOGuuEpi4Gg@mail.gmail.com>
 <20160208172302.GQ10826@n2100.arm.linux.org.uk>
 <CAKzmTe01UShsocA7VbZziWWqt2k-5yJwYH0MnddXHT+s3Oni=w@mail.gmail.com>
Message-ID: <CAKzmTe2bDfvixrSxW-uVgkaCDCWrQrp1=-bKna8ns2=0DSVE+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 14, 2016 at 1:09 AM, JM <fijam@archlinux.us> wrote:
> I have rebuilt the kernel again, trying to get close to Arnaud's Duov2
> config, and amazingly, it works!
>
> $ dmesg | grep -i cesa
> [    8.158636] marvell-cesa f1030000.crypto: CESA device successfully registered
>
> I have all the goodies in /proc/crypto as well.
>
> So apparently the bug lurks somewhere in the difference between:
>
> http://heap.ovh/files/config-4.4.1.vanilla <- debian's config
> http://heap.ovh/files/config-kirkwood-new <- duov2-like config
>
> I could try to narrow it down, but I can only build natively, and I am
> quite clueless as to where to start, so it would take some time...
>
> Best regards,
> Jan
>
> On Mon, Feb 8, 2016 at 6:23 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
>> On Sat, Feb 06, 2016 at 04:14:49PM +0100, JM wrote:
>>> On Fri, Feb 5, 2016 at 10:04 PM, Arnaud Ebalard <arno@natisbad.org> wrote:
>>> > Hi,
>>> >
>>> >> I'll try and do the same now w/ CESA support compiled as module to see
>>> >> what I get. I'll keep you posted.
>>> >
>>> > root at mood:~# insmod /tmp/marvell-cesa.ko
>>> > [  573.897977] marvell-cesa f1030000.crypto: CESA device successfully registered
>>> >
>>> > root at mood:~# uname -a
>>> > Linux mood 4.4.0.duov2 #2 Fri Feb 5 21:42:49 CET 2016 armv5tel GNU/Linux
>>> >
>>> > root at mood:~# zcat /proc/config.gz | grep -i CESA
>>> > # CONFIG_CRYPTO_DEV_MV_CESA is not set
>>> > CONFIG_CRYPTO_DEV_MARVELL_CESA=m
>>> >
>>> > Cheers,
>>> >
>>> > a+
>>> >
>>> > ps: my config is temporarily at http://natisbad.org/config-duov2-cesa
>>>
>>> I've built a vanilla 4.4.1 kernel image without any debian-specific
>>> patches but using the same oldconfig
>>> (http://heap.ovh/files/config-4.4.1.vanilla).
>>>
>>> # uname -a
>>> Linux yukikaze 4.4.1.vanilla #1 Sat Feb 6 14:18:19 CET 2016 armv5tel GNU/Linux
>>>
>>> # modprobe marvell_cesa allhwsupport=1
>>>
>>> # dmesg | tail -n1
>>> [  116.972828] marvell-cesa: probe of f1030000.crypto failed with error -12
>>>
>>> The dtb hasn't changed:
>>> # diff -s kirkwood-ts219-6282.dtb dtb-4.4.1.vanilla
>>> Files kirkwood-ts219-6282.dtb and dtb-4.4.1.vanilla are identical
>>>
>>> I am also attaching lsmod: http://heap.ovh/files/lsmod-vanilla-4.4.1
>>> and full dmesg: http://heap.ovh/files/dmesg-vanilla-4.4.1
>>>
>>> Perhaps I am missing something obvious? I suppose the next step would
>>> be to build a minimal kernel based on the config for the duov2?
>>
>> As you have built your own kernel, may I suggest that you add some
>> debug code into mv_cesa_dev_dma_init(), mv_cesa_get_sram(), and
>> mv_cesa_probe() to print which of the many locations that returns
>> -ENOMEM is triggering the above error.
>>
>> In passing, I notice that:
>>
>>         cesa->regs = devm_ioremap_resource(dev, res);
>>         if (IS_ERR(cesa->regs))
>>                 return -ENOMEM;
>>
>> is wrong.  devm_ioremap_resource() returns an errno-encoded pointer
>> which should be used to report the error number.  This should be:
>>
>>         cesa->regs = devm_ioremap_resource(dev, res);
>>         if (IS_ERR(cesa->regs))
>>                 return PTR_ERR(cesa->regs);
>>
>> --
>> RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
>> FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
>> according to speedtest.net.

I have made some progress on this, apparently there is some weird
interaction between the old and new cesa modules.

# diff /boot/config-4.4.0-1-marvell /boot/config-4.4.6.test2
35c35
< CONFIG_LOCALVERSION=""
---
> CONFIG_LOCALVERSION=".test2"
6196c6196
< CONFIG_CRYPTO_DEV_MV_CESA=m
---
> # CONFIG_CRYPTO_DEV_MV_CESA is not set

Building the kernel with only the new marvell_cesa module is in fact
sufficient for having it register successfully:

dmesg | grep -i cesa
[    8.056151] marvell-cesa f1030000.crypto: CESA device successfully registered

With the default debian config [1] both mv_cesa and marvell_cesa are
built as modules. During boot, mv_cesa is registered first, but
marvell_cesa also silently loads (nothing in dmesg) and appears in
lsmod.

Doing rmmod mv_cesa; rmmod marvell_cesa; modprobe marvell_cesa
allhwsupport=1; dmesg | tail -n 1 results in the previously described:

[  920.383498] marvell-cesa: probe of f1030000.crypto failed with error -12


I tried to blacklist mv_cesa by adding the following to /etc/modprobe.d/local :
blacklist mv_cesa
install mv_cesa /bin/false

However, after rebuilding initramfs, reflashing and rebooting, both
mv_cesa and marvell_cesa (silently) still get loaded... I have no
explanation for that, maybe it's a userspace or PEBKAC problem.
I hope this will point you in the right direction as to this weird issue.

Best regards,
Jan

1. https://anonscm.debian.org/cgit/kernel/linux.git/tree/debian/config/config?id=42fd34bcd1d54c7bc8d9783479990041f46efa8e
+
https://anonscm.debian.org/cgit/kernel/linux.git/tree/debian/config/armel/config.marvell?id=42fd34bcd1d54c7bc8d9783479990041f46efa8e
