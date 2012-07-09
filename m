From: pavel@denx.de (Pavel Machek)
Date: Mon, 9 Jul 2012 13:30:21 +0200
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <4FF483D2.70000@gmail.com>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <1340805007-3313-2-git-send-email-dinguyen@altera.com>
 <4FF483D2.70000@gmail.com>
Message-ID: <20120709113021.GB12130@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > +config ARCH_SOCFPGA
> > +	bool "Altera SOCFPGA family"
> > +	select CPU_V7
> > +	select ARM_GIC
> > +	select ARM_AMBA
> > +	select CLKDEV_LOOKUP
> > +	select MIGHT_HAVE_CACHE_L2X0
> > +	select HAVE_MACH_CLKDEV
> > +	select GENERIC_CLOCKEVENTS
> > +	select ARCH_WANT_OPTIONAL_GPIOLIB
> > +	select GPIO_PL061 if GPIOLIB
> > +	select NEED_MACH_MEMORY_H
> > +	select USE_OF
> 
> Alphabetize the selects.

Umm... Others are not alphabetized, either. Something like this to
group them logically?

> > @@ -1596,6 +1614,7 @@ config HZ
> >  	default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER
> >  	default AT91_TIMER_HZ if ARCH_AT91
> >  	default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE
> > +	default SOCFPGA_TIMER_HZ if ARCH_SOCFPGA
> 
> Is this really needed?

Probably not. Removed.

> > +struct clk_ops {
> > +	long	(*round)(struct clk *, unsigned long);
> > +	int	(*set)(struct clk *, unsigned long);
> > +};
> 
> Use common clk infrastructure.

Yep, done already.

> > +#define IO_SPACE_LIMIT 0xffffffff
> > +
> > +#define __io(a)		__typesafe_io(a)
> > +#define __mem_pci(a)	(a)
> 
> You don't need io.h, remove it.

Will do, thanks.

> > --- /dev/null
> > +++ b/arch/arm/mach-socfpga/include/mach/iomap.h
> > @@ -0,0 +1,37 @@
> > +#include <asm/sizes.h>
> > +
> > +/* macro to get at IO space when running virtually */
> > +#ifdef CONFIG_MMU
> 
> Do you really support !MMU?

No. Will remove.

> > +#define SOFTIRQ_SOCFPGA_GPIO_2_28	(IRQ_SOCFPGA_GIC_START + 269)
> > +#define SOFTIRQ_SOCFPGA_GPIO_2_29	(IRQ_SOCFPGA_GIC_START + 270)
> > +
> 
> All these defines should come from DT.

Yes. Most of them do now, will fix the rest.

> > +#define NR_IRQS			512
> 
> As mentioned, use SPARSE_IRQ.

Fixed. As mentioned :-).

> > +#define PLAT_PHYS_OFFSET	UL(0x00000000)
> > +
> > +#if !defined(__ASSEMBLY__) && defined(CONFIG_ZONE_DMA)
> > +
> > +#define ISA_DMA_THRESHOLD	(PHYS_OFFSET + SZ_256M - 1)
> > +#define MAX_DMA_ADDRESS		(PAGE_OFFSET + SZ_256M)
> > +#endif
> 
> You shouldn't need memory.h.

Ok.

> > --- /dev/null
> > +++ b/arch/arm/mach-socfpga/include/mach/system.h
> > @@ -0,0 +1,31 @@
> > +static inline void arch_idle(void)
> > +{
> > +	/*
> > +	 * This should do all the clock switching
> > +	 * and wait for interrupt tricks
> > +	 */
> > +	cpu_do_idle();
> > +}
> 
> This isn't needed any longer and system.h should be removed.

Ok.

> > --- /dev/null
> > +++ b/arch/arm/mach-socfpga/platsmp.c
...
> > +/*
> > + * control for which core is the next to come out of the secondary
> > + * boot "holding pen"
> > + */
> > +int __cpuinitdata pen_release = -1;
> 
> None of this pen stuff is needed if you properly reset cores when
> hot-unplugged. All this is only needed if you only go to wfi when hot
> unplugged. See highbank platsmp.c for an example without pen code.

Will take a look, thanks!

> > diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> > index 101b968..2f9a81e 100644
> > --- a/arch/arm/mm/Kconfig
> > +++ b/arch/arm/mm/Kconfig
> > @@ -381,7 +381,7 @@ config CPU_V6K
> >  
> >  # ARMv7
> >  config CPU_V7
> > -	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
> > +	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX || ARCH_SOCFPGA
> 
> This is not needed.

Already fixed.

Thanks for the review. This is the easy stuff, I'll remove the
memory.h/system.h next, then address the SMP thing.
									Pavel

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d203253..ab3b389 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -252,18 +252,18 @@ choice
 
 config ARCH_SOCFPGA
 	bool "Altera SOCFPGA family"
-	select CPU_V7
-	select ARM_GIC
 	select ARM_AMBA
-	select CLKDEV_LOOKUP
-	select MIGHT_HAVE_CACHE_L2X0
-	select HAVE_MACH_CLKDEV
-	select GENERIC_CLOCKEVENTS
+	select ARM_GIC
+	select CPU_V7
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select GPIO_PL061 if GPIOLIB
+	select CLKDEV_LOOKUP
+	select GENERIC_CLOCKEVENTS
+	select HAVE_MACH_CLKDEV
+	select MIGHT_HAVE_CACHE_L2X0
 	select NEED_MACH_MEMORY_H
-	select USE_OF
 	select SPARSE_IRQ
+	select USE_OF
 	help
 	  This enables support for Altera SOCFPGA Cyclone V platform
 
@@ -1615,7 +1615,6 @@ config HZ
 	default OMAP_32K_TIMER_HZ if ARCH_OMAP && OMAP_32K_TIMER
 	default AT91_TIMER_HZ if ARCH_AT91
 	default SHMOBILE_TIMER_HZ if ARCH_SHMOBILE
-	default SOCFPGA_TIMER_HZ if ARCH_SOCFPGA
 	default 100
 
 config THUMB2_KERNEL
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 81358e6..7f1b72b 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -6,10 +6,3 @@ config MACH_SOCFPGA_CYCLONE5
 	select COMMON_CLK
 	help
 	  Include support for the Altera(R) Cyclone5 development platform.
-
-config SOCFPGA_TIMER_HZ
-	int "Kernel internal timer frequency "
-	range 20 1024
-	default "100"
-	help
-	  Kernel internal timer frequency should be a divisor of 77161.
diff --git a/arch/arm/mach-socfpga/include/mach/iomap.h b/arch/arm/mach-socfpga/include/mach/iomap.h
index 656482d..d5f8493 100644
--- a/arch/arm/mach-socfpga/include/mach/iomap.h
+++ b/arch/arm/mach-socfpga/include/mach/iomap.h
@@ -20,7 +20,6 @@
 #include <asm/sizes.h>
 
 /* macro to get at IO space when running virtually */
-#ifdef CONFIG_MMU
 /*
  * Statically mapped addresses:
  *
@@ -29,9 +28,6 @@
  * 1fxx xxxx -> fexx xxxx
  */
 #define IO_ADDRESS(x)		(((x) & 0x03ffffff) + 0xfb000000)
-#else
-#define IO_ADDRESS(x)		(x)
-#endif
 #define __io_address(n)		IOMEM(IO_ADDRESS(n))
 
-#endif
\ No newline at end of file
+#endif

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
