From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 3 Sep 2010 20:53:32 +0200
Subject: [PATCH 2/7] [RFC] ARM: shmobile: remove unneeded hack to
	calculate zreladdr
In-Reply-To: <AANLkTimV5MFqQ+r-uE2M3bVtEqtNfuxq+jkGdW-J8Bis@mail.gmail.com>
References: <20100903095504.GC13643@pengutronix.de>
	<1283507818-1573-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTimV5MFqQ+r-uE2M3bVtEqtNfuxq+jkGdW-J8Bis@mail.gmail.com>
Message-ID: <20100903185332.GC17152@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Eric,

On Fri, Sep 03, 2010 at 09:39:45PM +0800, Eric Miao wrote:
> 2010/9/3 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > The calculated value in Makefile.boot isn't used anymore since
> >
> > ? ? ? ?e69edc79 (ARM: Auto calculate ZRELADDR and provide option for exceptions)
> >
> > and physoffset can better be set in mach/memory.h depending on the
> > actual machine type.
> >
> > Cc: Paul Mundt <lethal@linux-sh.org>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Cc: linux-sh at vger.kernel.org
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> > ?arch/arm/mach-shmobile/Kconfig ? ? ? ? ? ? ? | ? 11 -----------
> > ?arch/arm/mach-shmobile/Makefile.boot ? ? ? ? | ? ?9 ---------
> > ?arch/arm/mach-shmobile/include/mach/memory.h | ? 15 ++++++++++++++-
> > ?3 files changed, 14 insertions(+), 21 deletions(-)
> > ?delete mode 100644 arch/arm/mach-shmobile/Makefile.boot
> >
> > diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
> > index 54b479c..45e134e 100644
> > --- a/arch/arm/mach-shmobile/Kconfig
> > +++ b/arch/arm/mach-shmobile/Kconfig
> > @@ -61,17 +61,6 @@ comment "SH-Mobile System Configuration"
> >
> > ?menu "Memory configuration"
> >
> > -config MEMORY_START
> > - ? ? ? hex "Physical memory start address"
> > - ? ? ? default "0x50000000" if MACH_G3EVM
> > - ? ? ? default "0x40000000" if MACH_G4EVM
> > - ? ? ? default "0x40000000" if MACH_AP4EVB
> > - ? ? ? default "0x00000000"
> > - ? ? ? ---help---
> > - ? ? ? ? Tweak this only when porting to a new machine which does not
> > - ? ? ? ? already have a defconfig. Changing it from the known correct
> > - ? ? ? ? value on any of the known systems will only lead to disaster.
> > -
> > ?config MEMORY_SIZE
> > ? ? ? ?hex "Physical memory size"
> > ? ? ? ?default "0x08000000" if MACH_G3EVM
> > diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
> > deleted file mode 100644
> > index 1c08ee9..0000000
> > --- a/arch/arm/mach-shmobile/Makefile.boot
> > +++ /dev/null
> > @@ -1,9 +0,0 @@
> > -__ZRELADDR ? ? := $(shell /bin/bash -c 'printf "0x%08x" \
> > - ? ? ? ? ? ? ? ? ? ?$$[$(CONFIG_MEMORY_START) + 0x8000]')
> > -
> > - ? zreladdr-y ? := $(__ZRELADDR)
> > -
> > -# Unsupported legacy stuff
> > -#
> > -#params_phys-y (Instead: Pass atags pointer in r2)
> > -#initrd_phys-y (Instead: Use compiled-in initramfs)
> > diff --git a/arch/arm/mach-shmobile/include/mach/memory.h b/arch/arm/mach-shmobile/include/mach/memory.h
> > index 377584e..100f734 100644
> > --- a/arch/arm/mach-shmobile/include/mach/memory.h
> > +++ b/arch/arm/mach-shmobile/include/mach/memory.h
> > @@ -1,7 +1,20 @@
> > ?#ifndef __ASM_MACH_MEMORY_H
> > ?#define __ASM_MACH_MEMORY_H
> >
> > -#define PHYS_OFFSET ? ?UL(CONFIG_MEMORY_START)
> > +#define SH7367_PHYS_OFFSET UL(0x50000000)
> > +#define SH7372_PHYS_OFFSET UL(0x40000000)
> > +#define SH7377_PHYS_OFFSET UL(0x40000000)
> > +
> > +#if !defined(CONFIG_RUNTIME_PHYS_OFFSET)
> > +# if defined(CONFIG_ARCH_SH7367)
> > +# ?define PHYS_OFFSET ?SH7367_PHYS_OFFSET
> > +# elif defined(CONFIG_ARCH_SH7372)
> > +# ?define PHYS_OFFSET ?SH7372_PHYS_OFFSET
> > +# elif defined(CONFIG_ARCH_SH7377)
> > +# ?define PHYS_OFFSET ?SH7377_PHYS_OFFSET
> > +# endif
> > +#endif /* if !defined(CONFIG_RUNTIME_PHYS_OFFSET) */
> > +
> 
> Looks like the CONFIG_MEMORY_START was a configurable option, tho
> not sure if it can be configured to other values, but making it fixed here
> doesn't seem to be a consistent change. (meaning there is assumption
> here).
That is why I put RFC in the subject :-)  Anyhow, ZRELADDR is hard coded
since e69edc79 (without ZRELADDR_AUTO).  And the help text suggested to
only tweak it "when porting to a new machine which does not already have
a defconfig".  As a person making a new port should be able to add a new
default for ZRELADDR to arch/arm/Kconfig I think it's OK to remove the
possibility to create a broken kernel for the people that don't work on
a new port.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
