From: dromede@gmail.com (=?UTF-8?B?TWFya28gS2F0acSH?=)
Date: Wed, 5 Dec 2012 23:18:47 +0100
Subject: [ARM] head.S change broke platform device registration?
In-Reply-To: <20121204221851.GJ14363@n2100.arm.linux.org.uk>
References: <CAHod+GdVobkgOj6bsFhn6qqLhysQoEzcDtAS05u1kPnssSfObg@mail.gmail.com>
 <50B88A59.6070207@arm.com>
 <CAHod+GeZQx6-pUHPocbyMJCLawMUhrZuZf=mrgWax=L7eNJGhg@mail.gmail.com>
 <20121130143435.GP19440@n2100.arm.linux.org.uk>
 <CAHod+GdXfZb1OHapJBYpCD74svYyaGaiZpqHLPtjHbWGa-3eLA@mail.gmail.com>
 <20121204221851.GJ14363@n2100.arm.linux.org.uk>
Message-ID: <CAHod+Gd6NJsuJVRos52e9+NcweqcSu=HArT_qoV0ygb_Xbfaiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> You're going to have to boot -rc7, mount debugfs and read
> /sys/kernel/debug/gpio to find out what is claiming those GPIOs that
> the MAX device wants to use.  There is only _one_ other device for PXA
> for Sharp devices which is hard-coded to the same GPIO numbers and that's
> the Scoop 2 device - but that's not registered for the !machine_is_akita()
> case.
>
> Everything you've reported points to machine_is_akita() being false, which
> it won't be given your Machine: line above.
>
> So.. I don't know, and no one can explain the behaviour you're seeing.

No. I messed up. Dmesg log i posted earlier was from 3.7.0-rc7 with
424e5994e63326a42012f003f1174f3c363c7b62 reverted. Russell,
your theory was correct, vanilla 3.7.0-rc7 on an akita, with the .config
i posted earlier, will boot with machine id == borzoi. So
machine_is_akita () is false and max7310
won't be registered. This also explains why i get clobbered gpio lines
when i tried to explicitly register just the
max7310. Since the kernel boots with machine id == borzoi, it wil also
register the second scoop device
before max7310 init and max7310 probe will fail.

Now, why does it register as borzoi? Well, i looked at my .config
(same one i posted earlier) and i noticed
this:

CONFIG_MACH_AKITA=y
CONFIG_MACH_SPITZ=y
CONFIG_MACH_BORZOI=y

Akita and spitz should be defined, spitz gets defined automatically if
you define akita. There's no reason for
CONFIG_MACH_BORZOI=y, i probably forgot to deselect it. So i disable
CONFIG_MACH_BORZOI, recompile and try to
boot vanilla 3.7.0-rc7. Now it hangs right after "Uncompressing
Linux... done, booting the kernel." Naturally,
reverting 424e5994e63326a42012f003f1174f3c363c7b62 makes everything work normal.
