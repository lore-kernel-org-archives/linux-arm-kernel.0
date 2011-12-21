From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Dec 2011 19:54:21 +0000
Subject: [RFC PATCH] ARM: new architecture for Energy Micro's EFM32
 Cortex-M3 SoCs
In-Reply-To: <201112211634.15954.arnd@arndb.de>
References: <1324480428-13344-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <201112211634.15954.arnd@arndb.de>
Message-ID: <20111221195421.GJ2577@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2011 at 04:34:15PM +0000, Arnd Bergmann wrote:
> > diff --git a/arch/arm/mach-efm32/include/mach/io.h b/arch/arm/mach-efm32/include/mach/io.h
> > new file mode 100644
> > index 0000000..00b6af6
> > --- /dev/null
> > +++ b/arch/arm/mach-efm32/include/mach/io.h
> > @@ -0,0 +1,7 @@
> > +#ifndef __MACH_IO_H__
> > +#define __MACH_IO_H__
> > +
> > +#define __io(a)			__typesafe_io(a)
> > +#define __mem_pci(a)		(a)
> > +
> > +#endif /* __MACH_IO_H__ */
> 
> Can you already build with __io not defined? That should catch any drivers
> that try to access the PC-style I/O ports.

And don't forget to select NO_IOPORT in the configuration as well.

> > --- a/arch/arm/mm/Kconfig
> > +++ b/arch/arm/mm/Kconfig
> > @@ -432,7 +432,7 @@ config CPU_V7
> >  # ARMv7
> >  config CPU_V7M
> >  	bool "Support ARMv7-M processors"
> > -	depends on MACH_REALVIEW_EB && EXPERIMENTAL
> > +	depends on (MACH_REALVIEW_EB && EXPERIMENTAL) || ARCH_EFM32
> >  	select THUMB2_KERNEL
> >  	select ARM_THUMB
> >  	select CPU_32v7M
> 
> Hmm, since you *have* to enable this option for a successful build,
> wouldn't it make more sense to 'select' this from ARCH_EFM32.

It'd help if Catalin conformed to the well established way in the rest
of the CPU specific configuration.  Rather than making this depend on
realview etc, make the presentation of the prompt conditional on
realview etc.  Then ARCH_EFM32 can simply select CPU_V7M without
generating any warnings.

In other words:

config CPU_whatever
	bool "whatever" if <symbols-which-may-have-this-cpu>

and elsewhere:

config PLATFORM_which_always_has_CPU_whatever
	select CPU_whatever
