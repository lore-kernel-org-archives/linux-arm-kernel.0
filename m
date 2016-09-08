From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 22:16:29 +0200
Subject: [PATCH] ARM: mmp: replace NO_IRQ
In-Reply-To: <20160906212206.GF1041@n2100.armlinux.org.uk>
References: <20160906140808.2883875-1-arnd@arndb.de>
 <CA+55aFyrGTG3xzecScrTQKaqkZ96DizeH2aSjJENKB_DCD6hxA@mail.gmail.com>
 <20160906212206.GF1041@n2100.armlinux.org.uk>
Message-ID: <37535175.pdT5SD2Phz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 6, 2016 10:22:06 PM CEST Russell King - ARM Linux wrote:
> oak uses NCR5380.  NCR5380 is shared across multiple architectures
> which have a random selection of NO_IRQ defined as 0 or -1.  To
> convert this without regression takes a multi-step process:
> 
> 1. Verify all architectures using NCR5380 never pass 0 as a valid IRQ
>    (they shouldn't today - I think this is true for ARM in this
>    instance.)
> 2. change NCR5380 to recognise both -1 and 0 as being invalid IRQs
>    (with a <= 0 test) and kill NO_IRQ in the NCR5380 code.
> 3. Kill off the uses of NO_IRQ being passed into the NCR5380 code,
>    passing 0 instead.
> 4. Optionally (and preferably) change the test to be !instance->irq.
> 
> If we just do the "eliminate NO_IRQ by changing it to constant 0" in
> either NCR5380 or oak.c on its own, we're going to end up with a
> regression - at least until the other catches up.

>From looking at how this driver has been handled elsewhere, the plan
seems to be to do it one architecture at a time, and almost
all have killed off NO_IRQ at this point, making it impossible
to use IRQ 0 on an NCR5380 derivative.

The driver has had this snippet since 2014 with commit 22f5f10d2dad
("ncr5380: Fix SCSI_IRQ_NONE bugs"):

#ifndef NO_IRQ
#define NO_IRQ          0
#endif

and this is used on almost all architectures now, including the
two other ones that have architecture specific drivers (powerpc
and m68k).

The architectures that still provide NO_IRQ are:

c6x, openrisc: these have no ISA, PCI or any platform
	specific	NCR5380 variant, so they are irrelevant here.
powerpc: defines NO_IRQ as 0, and is in the process of removing
	that.
sparc, parisc, mn10300: these have PCI slots but no ISA slots, and
	could have DMX3191D in theory, but none of the other front-ends.
	The dmx3191d driver doesn't use interrupts, so that's fine too.
arm: I've submitted patches for all other uses of the NO_IRQ macro
	that are possible on ARM, so this driver remains.

If we can show that no ARM machine uses NCR5380 with a valid IRQ 0,
thenthe definition can be removed from arch/arm/include/asm/irq.h
as soon as my last patch is merged.

We can also trivially remove the defintitions of NO_IRQ from c6x,
mn10300, openrisc, parisc and sparc, as nothing relies on them,
and Michael Ellerman has a series for all the powerpc drivers.
	
FWIW, there are a couple of other drivers that use the same
#ifdef trick as NCR5380:

drivers/ata/sata_dwc_460ex.c:#ifndef NO_IRQ
drivers/ata/sata_dwc_460ex.c:#define NO_IRQ		0
drivers/ata/sata_dwc_460ex.c-#endif
-> wrong, must use hardcoded '0'

drivers/input/touchscreen/ucb1400_ts.c:#ifndef NO_IRQ
drivers/input/touchscreen/ucb1400_ts.c:#define NO_IRQ	0
drivers/input/touchscreen/ucb1400_ts.c-#endif
-> wrong, must use hardcoded '0'

drivers/mmc/host/of_mmc_spi.c:#ifndef NO_IRQ
drivers/mmc/host/of_mmc_spi.c:#define NO_IRQ 0
drivers/mmc/host/of_mmc_spi.c-#endif
-> unused since the only user was found broken and fixed

drivers/pcmcia/pd6729.c:#ifndef NO_IRQ
drivers/pcmcia/pd6729.c:#define NO_IRQ	((unsigned int)(0))
drivers/pcmcia/pd6729.c-#endif
-> wrong, must use hardcoded '0'

drivers/rtc/rtc-m48t59.c:#ifndef NO_IRQ
drivers/rtc/rtc-m48t59.c:#define NO_IRQ	(-1)
drivers/rtc/rtc-m48t59.c-#endif
-> correct, but the only platform using it doesn't provide
   an interrupt

I guess I'll send patches for these five drivers too.

	Arnd
