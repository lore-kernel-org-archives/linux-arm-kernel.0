From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 05 Feb 2016 21:41:09 +0100
Subject: marvell_cesa fails to register on kirkwood (88F6282)
In-Reply-To: <87io232kat.fsf@free-electrons.com> (Gregory CLEMENT's message of
 "Fri, 05 Feb 2016 17:28:42 +0100")
References: <CAKzmTe0mvZD5UwqM47uXbM7Z7oAJpE4g4BVMba1hkzqNu+Zbgw@mail.gmail.com>
 <20160205090246.GE32272@lunn.ch> <20160205112907.796afb05@bbrezillon>
 <CAKzmTe20fT8BcRaDaf2gz92KMAK0kEUkaD-kPq_cPF1WKBdroA@mail.gmail.com>
 <87vb632maf.fsf@free-electrons.com>
 <CAKzmTe1AqNQwjcsAULotd010NXuk1AYjj5p6UoqT_Zu=BCHdcw@mail.gmail.com>
 <87mvrf2l6p.fsf@free-electrons.com>
 <87io232kat.fsf@free-electrons.com>
Message-ID: <8760y2vqje.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

Gregory CLEMENT <gregory.clement@free-electrons.com> writes:

> Hi,
>
> +cc Arnaud
>  
>  On ven., f?vr. 05 2016, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
>
>> Hi JM,
>>  
>>  On ven., f?vr. 05 2016, JM <fijam@archlinux.us> wrote:
>>
>>> On Fri, Feb 5, 2016 at 4:45 PM, Gregory CLEMENT
>>> <gregory.clement@free-electrons.com> wrote:
>>>> Hi JM,
>>>>
>>>>  On ven., f?vr. 05 2016, JM <fijam@archlinux.us> wrote:
>>>>
>>>>> On Fri, Feb 5, 2016 at 11:29 AM, Boris Brezillon
>>>>> <boris.brezillon@free-electrons.com> wrote:
>>>>>> Jan, Andrew
>>>>>>
>>>>>> On Fri, 5 Feb 2016 10:02:46 +0100
>>>>>> Andrew Lunn <andrew@lunn.ch> wrote:
>>>>>>
>>>>>>> On Fri, Feb 05, 2016 at 06:01:18AM +0100, JM wrote:
>>>>>>> > Hi,
>>>>>>> >
>>>>>>> > I am testing marvell_cesa on a kirkwood device (QNAP TS-212p, Marvell
>>>>>>> > Kirkwood 88F6282, dts: http://pastebin.com/Gk95KFHf ).
>>>>>>> > As of kernel 4.4 (4.4.0-trunk-kirkwood #1 Debian 4.4-1~exp1) it fails
>>>>>>> > in the following way:
>>>>>>> >
>>>>>>> > modprobe marvell_cesa allhwsupport=1
>>>>>>> > dmesg | tail -n 1
>>>>>>> > [ 1057.855091] marvell-cesa: probe of f1030000.crypto failed with error -12
>>>>>>> >
>>>>>>> > or:
>>>>>>> >
>>>>>>> > modprobe marvell_cesa
>>>>>>> > dmesg | tail -n 1
>>>>>>> > [ 9178.399357] marvell-cesa: probe of f1030000.crypto failed with error -524
>>>>>>> >
>>>>>>> > With kernel 4.3 it would fail with error -22 on that hardware. There
>>>>>>> > are scattered reports from other users experiencing the same issue
>>>>>>> > (1,2,3)
>>>>>>> >
>>>>>>> > I wonder if this is a result of an invalid definition of the
>>>>>>> > crypto-sram in the dts of this SoC, or perhaps some other problem
>>>>>>> > (PEBKAC included).
>>>>>>>
>>>>>>> Hi Jan
>>>>>>>
>>>>>>> Do you have SRAM enabled in your kernel configuration. The
>>>>>>> mvebu_v5_defconfig does not have it, which is a bug really.
>>>>>>
>>>>>> Hm, the CRYPTO_DEV_MARVELL_CESA option selects the SRAM one [1].
>>>>>> Anyway, I also think this error is related to the SRAM (not sure why the
>>>>>> driver is not able to get the SRAM though).
>>>>>>
>>>>>> Best Regards,
>>>>>>
>>>>>> Boris
>>>>>>
>>>>>> [1]http://lxr.free-electrons.com/source/drivers/crypto/Kconfig#L168
>>>>>>
>>>>>>
>>>>>> --
>>>>>> Boris Brezillon, Free Electrons
>>>>>> Embedded Linux and Kernel engineering
>>>>>> http://free-electrons.com
>>>>>
>>>>> Hi,
>>>>>
>>>>> Thanks for getting back to me. Indeed, CONFIG_SRAM is enabled, I put
>>>>> the complete .config here: http://pastebin.com/40eKMJqE
>>>>>
>>>>> If there is anything I can do to help squish this bug, please let me
>>>>> know.
>>>>
>>>> How do you get your dts?
>>>> it seems that you generated it from your dtb (or from /proc).
>>>>
>>>> I tried to do the same from arch/arm/boot/dts/kirkwood-ts219-6282.dtb,
>>>> but the resulting dts is too different for an easy comparison.
>>>>
>>>> Could you also provide your dtb, maybe by using the same dtc with the
>>>> option -s I will manage to get the something easier to compare.
>>>
>>
>>> Yes, I simply used dtc -I fs /proc/device-tree to obtain the dts.
>>>
>>> Here is the relevant .dtb file : http://heap.ovh/files/kirkwood-ts219-6282.dtb
>>>
>>
>> OK so this dtb is exacly the one from the mainline. As most of the CESU
>> stuff is set in te dtis, we will be able to compare it on the other
>> kirkwood based board.
>>
>> Gregory
>
> So with the help of Boris we checked the ranges propreties, the reg
> property and the clock too. Everyting seems OK.
>
> Arnaud,
>
> as you are the on who tested the cesa on kirkwood, do you remember if
> you needed to add specific Kconfig or to made some change in the dts?

Here is the result I get on my ReadyNAS Duo v2 (88F6282, see below) w/ a
stock 4.4 kernel I just cross-compiled w/ a gcc 4.9.2. The kernel has no
modules and uses an appended DTB (u-boot on the platform is pretyy old):

root at mood:~# dmesg | grep -i cesa
[    3.306135] marvell-cesa f1030000.crypto: CESA device successfully registered

root at mood:~# uname -a
Linux mood 4.4.0.duov2 #1 Fri Feb 5 21:11:25 CET 2016 armv5tel GNU/Linux

root at mood:~# cat /proc/cpuinfo 
processor       : 0
model name      : Feroceon 88FR131 rev 1 (v5l)
BogoMIPS        : 1594.16
Features        : swp half thumb fastmult edsp 
CPU implementer : 0x56
CPU architecture: 5TE
CPU variant     : 0x2
CPU part        : 0x131
CPU revision    : 1

Hardware        : Marvell Kirkwood (Flattened Device Tree)
Revision        : 0000
Serial          : 0000000000000000

I'll try and do the same now w/ CESA support compiled as module to see
what I get. I'll keep you posted.

As a side note, a simple grep on the .config file you provided at
http://pastebin.com/40eKMJqE makes me wonder why it has some
grsec options residue. Did you test on a stock 4.4 kernel or on
something w/ additional patches? If the latter, could you check what a
stock kernel gives?

Cheers,

a+
