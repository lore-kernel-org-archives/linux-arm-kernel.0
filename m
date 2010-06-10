From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 11 Jun 2010 00:06:00 +0200
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option for
	exceptions
In-Reply-To: <AANLkTikulOGKEoAYptacYPgM8PAJ49JlGUO6rJWY5gqF@mail.gmail.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
	<20100610090015.GD3422@pengutronix.de>
	<AANLkTin9qGAJGSgu9Y2YjI_W8UwBITd-QYyGERcLLUgP@mail.gmail.com>
	<20100610095808.GA31057@pengutronix.de>
	<AANLkTikulOGKEoAYptacYPgM8PAJ49JlGUO6rJWY5gqF@mail.gmail.com>
Message-ID: <AANLkTimr0lj3Gsxw0LNf-tOX474HrSZ2-lntjrEYpu3a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/6/10 Eric Miao <eric.miao@canonical.com>:
> 2010/6/10 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:

>> But zreladdr is always physoffset + textoffset, isn't it?
>
> I'm not completely sure about the u300 case.

OK as you see in mach-u300/Makefile.boot we have ZRELADDR
at two different locations:

0x28E08000 or 0x48008000

(textoffset is 0x8000 IIRC)

The stuff in mach-u300/include/memory.h play with the Kconfig
options in mach-u300/Kconfig and is supposed to provide
dynamic resize of the memory for the 0x28e08000 variant,
because that variant can actually be reconfigured by the boot loader
(memory will be assigned to another CPU).

Then PHYS_OFFSET is set to the closest 2MiB boundary toward
lower addresses since this is required by ARM Linux.

As you can see in the Kconfig we currently have 13 MiB meaning
PHYS_OFFSET will be
0x28000000 + (13 - 13&1) *1024*1024 = 0x28C00000

This way we comply with the 2MiB alignment requirement,
even though in this case the actual physical memory begins
at 0x28D00000. So the first MiB does not really exist. This is
then compensated for in arch/arm/mm/mmu.c:

        /*
         * U300 - This platform family can share physical memory
         * between two ARM cpus, one running Linux and the other
         * running another OS.
         */
        if (machine_is_u300()) {
#ifdef CONFIG_MACH_U300_SINGLE_RAM
#if ((CONFIG_MACH_U300_ACCESS_MEM_SIZE & 1) == 1) &&    \
        CONFIG_MACH_U300_2MB_ALIGNMENT_FIX
                res_size = 0x00100000;
#endif
#endif
        }

So we reserve the first MiB which is not actually memory, so
that this will not be used, and Linux will actually make use of
the memory from 0x28D00000.

If we had reserved 14MiB instead it would be:
0x28000000 + (14 - 14&1) *1024*1024 = 0x28E00000

And then it would have matched.

The ZRELADDR in Makefile.boot is actually just some
convention for the bootloader, it will work as long as we
shrink the memory used by the other CPU, if we expand it
past 14MiB everything breaks, like for 16 MiB for the other
CPU physical memory begins at 0x29000000 and trying
to have ZRELADDR at 28e08000 will just result in a
bus error.

So the relation between ZRELADDR and PHYS_OFFSET
on the U300 is:

if CONFIG_MACH_U300_SINGLE_RAM
PHYS_OFFSET = 0x28000000 +
  reserved_for_other_cpu_rounded_to_closest_2MiB_lower_addresses
ZRELADDR = 0x28e00000 + textoffset
else
PHYS_OFFSET = 0x48000000
ZRELADDR = 0x48000000 + textoffset
endif

So the assumption holds if
!CONFIG_MACH_U300_SINGLE_RAM

Else it is complicated.

Yours,
Linus Walleij
