From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 06 Feb 2016 22:57:04 +0100
Subject: marvell_cesa fails to register on kirkwood (88F6282)
In-Reply-To: <CAKzmTe24iz1Ka7Kkke=ZTVbDGZxxDjBH0m2iEVCQOGuuEpi4Gg@mail.gmail.com>
 (JM's message of "Sat, 6 Feb 2016 16:14:49 +0100")
References: <CAKzmTe0mvZD5UwqM47uXbM7Z7oAJpE4g4BVMba1hkzqNu+Zbgw@mail.gmail.com>
 <20160205090246.GE32272@lunn.ch> <20160205112907.796afb05@bbrezillon>
 <CAKzmTe20fT8BcRaDaf2gz92KMAK0kEUkaD-kPq_cPF1WKBdroA@mail.gmail.com>
 <87vb632maf.fsf@free-electrons.com>
 <CAKzmTe1AqNQwjcsAULotd010NXuk1AYjj5p6UoqT_Zu=BCHdcw@mail.gmail.com>
 <87mvrf2l6p.fsf@free-electrons.com>
 <87io232kat.fsf@free-electrons.com> <8760y2vqje.fsf@natisbad.org>
 <87twlmdg2b.fsf@natisbad.org>
 <CAKzmTe24iz1Ka7Kkke=ZTVbDGZxxDjBH0m2iEVCQOGuuEpi4Gg@mail.gmail.com>
Message-ID: <87y4axy027.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

JM <fijam@archlinux.us> writes:

> On Fri, Feb 5, 2016 at 10:04 PM, Arnaud Ebalard <arno@natisbad.org> wrote:
>> Hi,
>>
>>> I'll try and do the same now w/ CESA support compiled as module to see
>>> what I get. I'll keep you posted.
>>
>> root at mood:~# insmod /tmp/marvell-cesa.ko
>> [  573.897977] marvell-cesa f1030000.crypto: CESA device successfully registered
>>
>> root at mood:~# uname -a
>> Linux mood 4.4.0.duov2 #2 Fri Feb 5 21:42:49 CET 2016 armv5tel GNU/Linux
>>
>> root at mood:~# zcat /proc/config.gz | grep -i CESA
>> # CONFIG_CRYPTO_DEV_MV_CESA is not set
>> CONFIG_CRYPTO_DEV_MARVELL_CESA=m
>>
>> Cheers,
>>
>> a+
>>
>> ps: my config is temporarily at http://natisbad.org/config-duov2-cesa
>
> I've built a vanilla 4.4.1 kernel image without any debian-specific
> patches but using the same oldconfig
> (http://heap.ovh/files/config-4.4.1.vanilla).
>
> # uname -a
> Linux yukikaze 4.4.1.vanilla #1 Sat Feb 6 14:18:19 CET 2016 armv5tel GNU/Linux
>
> # modprobe marvell_cesa allhwsupport=1
>
> # dmesg | tail -n1
> [  116.972828] marvell-cesa: probe of f1030000.crypto failed with error -12
>
> The dtb hasn't changed:
> # diff -s kirkwood-ts219-6282.dtb dtb-4.4.1.vanilla
> Files kirkwood-ts219-6282.dtb and dtb-4.4.1.vanilla are identical
>
> I am also attaching lsmod: http://heap.ovh/files/lsmod-vanilla-4.4.1
> and full dmesg: http://heap.ovh/files/dmesg-vanilla-4.4.1
>
> Perhaps I am missing something obvious? I suppose the next step would
> be to build a minimal kernel based on the config for the duov2?

I must confess your problem is interesting ;-)

I did a diff between your .config and mine for the Duo v2 and then tried
to enable/disable the most promising options you had and the one I had
not but I cannot reproduce the what you get, i.e. marvell_cesa module
always loads as expectec. 

So, I also think the best path would be to use my Duo v2 file w/ your dtb
and run it on your device.

Last (unrelated) remark/question: looking at the .dts for your ts219, I
noticed one thing I am curious about:

        memory {
                device_type = "memory";
                reg = <0x00000000 0x20000000>;
        };

        ...

        ocp at f1000000 {
                pinctrl: pin-controller at 10000 {

                        pinctrl-0 = <&pmx_ram_size &pmx_board_id>;
                        pinctrl-names = "default";

                        pmx_ram_size: pmx-ram-size {
                                /* RAM: 0: 256 MB, 1: 512 MB */
                                marvell,pins = "mpp36";
                                marvell,function = "gpio";
                        };

It seems 512MB are declared for all TS219 devices but the level
available on mpp36 provides the real amount of RAM in the device.
Who/What is expected to do the adjustment on platform w/ only 256MB, if
any?

Cheers,

a+
