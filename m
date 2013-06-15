From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 15 Jun 2013 14:02:19 +0200
Subject: [PATCH 17/28] ARM: EXYNOS: Decouple ARCH_EXYNOS from PLAT_S5P
In-Reply-To: <171e01ce696b$0320a010$0961e030$%kim@samsung.com>
References: <1371238384-1504-1-git-send-email-t.figa@samsung.com>
 <1371238384-1504-18-git-send-email-t.figa@samsung.com>
 <171e01ce696b$0320a010$0961e030$%kim@samsung.com>
Message-ID: <3115610.gZ5pQeM66b@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Thanks for review.

On Saturday 15 of June 2013 10:52:37 Kukjin Kim wrote:
> Tomasz Figa wrote:
> > After removing support for ATAGS based boot on Exynos, there is not
> > much that can be shared between Exynos and other S5P platforms. This
> > patch makes Exynos a standalone Samsung platform, not using PLAT_S5P.
> > 
> > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> > 
> >  arch/arm/Kconfig                | 4 ++++
> >  arch/arm/Makefile               | 1 +
> >  arch/arm/mach-exynos/Kconfig    | 1 +
> >  arch/arm/plat-samsung/Kconfig   | 8 +++-----
> >  arch/arm/plat-samsung/pm-gpio.c | 5 +++--
> >  5 files changed, 12 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 9c69e6c..21bf253 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -795,7 +795,9 @@ config ARCH_EXYNOS
> > 
> >  	bool "Samsung EXYNOS"
> >  	select ARCH_HAS_CPUFREQ
> >  	select ARCH_HAS_HOLES_MEMORYMODEL
> > 
> > +	select ARCH_REQUIRE_GPIOLIB
> > 
> >  	select ARCH_SPARSEMEM_ENABLE
> > 
> > +	select ARM_GIC
> > 
> >  	select CLKDEV_LOOKUP
> >  	select COMMON_CLK
> >  	select CPU_V7
> > 
> > @@ -807,7 +809,9 @@ config ARCH_EXYNOS
> > 
> >  	select HAVE_S3C_RTC if RTC_CLASS
> >  	select NEED_MACH_GPIO_H
> >  	select NEED_MACH_MEMORY_H
> > 
> > +	select S5P_GPIO_DRVSTR
> > 
> >  	select SAMSUNG_ATAGS
> > 
> > +	select SAMSUNG_GPIOLIB_4BIT
> 
> SAMSUNG_GPIOLIB_4BIT is not used anywhere...

Right. It seems to be a defined Kconfig symbol that is selected in several 
places, but nothing actually uses it. Will remove it.

> >  	select USE_OF
> >  	help
> >  	
> >  	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
> > 
> > diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> > index 1ba358b..2192a3f 100644
> > --- a/arch/arm/Makefile
> > +++ b/arch/arm/Makefile
> > @@ -204,6 +204,7 @@ plat-$(CONFIG_PLAT_ORION)	+= orion
> > 
> >  plat-$(CONFIG_PLAT_PXA)		+= pxa
> >  plat-$(CONFIG_PLAT_S3C24XX)	+= samsung
> >  plat-$(CONFIG_PLAT_S5P)		+= samsung
> > 
> > +plat-$(CONFIG_ARCH_EXYNOS)	+= samsung
> 
> Put it in alphabetical order.

Right, sorry.

> >  plat-$(CONFIG_PLAT_VERSATILE)	+= versatile
> >  
> >  ifeq ($(CONFIG_ARCH_EBSA110),y)
> > 
> > diff --git a/arch/arm/mach-exynos/Kconfig
> > b/arch/arm/mach-exynos/Kconfig index 0d93ebe..47d8d9e 100644
> > --- a/arch/arm/mach-exynos/Kconfig
> > +++ b/arch/arm/mach-exynos/Kconfig
> > @@ -18,6 +18,7 @@ config ARCH_EXYNOS4
> > 
> >  	select HAVE_SMP
> >  	select MIGHT_HAVE_CACHE_L2X0
> >  	select PINCTRL
> > 
> > +	select GIC_NON_BANKED
> 
> Please put it in alphabetical order

OK.

> >  	help
> >  	
> >  	  Samsung EXYNOS4 SoCs based systems
> > 
> > diff --git a/arch/arm/plat-samsung/Kconfig
> > b/arch/arm/plat-samsung/Kconfig index 1c607da..6c23722 100644
> > --- a/arch/arm/plat-samsung/Kconfig
> > +++ b/arch/arm/plat-samsung/Kconfig
> > @@ -6,7 +6,7 @@
> > 
> >  config PLAT_SAMSUNG
> >  
> >  	bool
> > 
> > -	depends on PLAT_S3C24XX || ARCH_S3C64XX || PLAT_S5P
> > +	depends on PLAT_S3C24XX || ARCH_S3C64XX || PLAT_S5P || ARCH_EXYNOS
> > 
> >  	default y
> >  	select GENERIC_IRQ_CHIP
> >  	select NO_IOPORT
> > 
> > @@ -15,12 +15,10 @@ config PLAT_SAMSUNG
> > 
> >  config PLAT_S5P
> >  
> >  	bool
> > 
> > -	depends on (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210 ||
> > ARCH_EXYNOS)
> > +	depends on (ARCH_S5P64X0 || ARCH_S5PC100 || ARCH_S5PV210)
> > 
> >  	default y
> >  	select ARCH_REQUIRE_GPIOLIB
> > 
> > -	select ARM_GIC if ARCH_EXYNOS
> > -	select ARM_VIC if !ARCH_EXYNOS
> > -	select GIC_NON_BANKED if ARCH_EXYNOS4
> > +	select ARM_VIC
> > 
> >  	select NO_IOPORT
> >  	select PLAT_SAMSUNG
> >  	select S3C_GPIO_TRACK
> > 
> > diff --git a/arch/arm/plat-samsung/pm-gpio.c
> > b/arch/arm/plat-samsung/pm- gpio.c
> > index c2ff92c..a8de3cf 100644
> > --- a/arch/arm/plat-samsung/pm-gpio.c
> > +++ b/arch/arm/plat-samsung/pm-gpio.c
> > @@ -192,7 +192,8 @@ struct samsung_gpio_pm samsung_gpio_pm_2bit = {
> > 
> >  	.resume = samsung_gpio_pm_2bit_resume,
> >  
> >  };
> > 
> > -#if defined(CONFIG_ARCH_S3C64XX) || defined(CONFIG_PLAT_S5P)
> > +#if defined(CONFIG_ARCH_S3C64XX) || defined(CONFIG_PLAT_S5P) \
> > +	|| defined(CONFIG_ARCH_EXYNOS)
> > 
> >  static void samsung_gpio_pm_4bit_save(struct samsung_gpio_chip *chip)
> >  {
> >  
> >  	chip->pm_save[1] = __raw_readl(chip->base + OFFS_CON);
> > 
> > @@ -302,7 +303,7 @@ struct samsung_gpio_pm samsung_gpio_pm_4bit = {
> > 
> >  	.save	= samsung_gpio_pm_4bit_save,
> >  	.resume = samsung_gpio_pm_4bit_resume,
> >  
> >  };
> > 
> > -#endif /* CONFIG_ARCH_S3C64XX || CONFIG_PLAT_S5P */
> > +#endif /* CONFIG_ARCH_S3C64XX || CONFIG_PLAT_S5P ||
> > CONFIG_ARCH_EXYNOS */> 
> >  /**
> >  
> >   * samsung_pm_save_gpio() - save gpio chip data for suspend
> > 
> > --
> > 1.8.2.1
> 
> How about PLAT_S5P in drivers/media/platform/ and drivers/usb/?

Right, they have to be updated with PLAT_S5P || ARCH_EXYNOS. I will send a 
fixed version.

Best regards,
Tomasz

> - Kukjin
> 
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-samsung-soc" in the body of a message to
> majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
