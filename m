From: jekhor@gmail.com (Yauhen Kharuzhy)
Date: Tue, 30 Nov 2010 10:34:47 +0200
Subject: [PATCH 03/10] ARM: S3C2416: Add platform helpers for setup SDHCI
In-Reply-To: <001d01cb9061$64a8e990$2dfabcb0$%kim@samsung.com>
References: <1290969027-10178-1-git-send-email-jekhor@gmail.com>
	<1290969027-10178-3-git-send-email-jekhor@gmail.com>
	<001d01cb9061$64a8e990$2dfabcb0$%kim@samsung.com>
Message-ID: <20101130083447.GC19722@jeknote.loshitsa1.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 04:37:03PM +0900, Kukjin Kim wrote:
> Yauhen Kharuzhy wrote:
> > 
> > Samsung S3C2416 has two SDHCI controllers compatible with other
> > Samsung's SoCs (S3C64XX, S5PC100 etc...).
> > 
> > Add required platform setup code that the devices can be used with
> > sdhci-s3c driver.
> > 
> > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> > ---
> >  arch/arm/mach-s3c2416/Kconfig              |   12 +++++
> >  arch/arm/mach-s3c2416/Makefile             |    4 ++
> >  arch/arm/mach-s3c2416/s3c2416.c            |    5 ++
> >  arch/arm/mach-s3c2416/setup-sdhci-gpio.c   |   58
> ++++++++++++++++++++++++++
> >  arch/arm/mach-s3c2416/setup-sdhci.c        |   62
> > ++++++++++++++++++++++++++++
> >  arch/arm/plat-samsung/include/plat/sdhci.h |   35 ++++++++++++++++
> >  6 files changed, 176 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-s3c2416/setup-sdhci-gpio.c
> >  create mode 100644 arch/arm/mach-s3c2416/setup-sdhci.c
> > 
> > diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
> > index 27b3e7c..2eaadcf 100644
> > --- a/arch/arm/mach-s3c2416/Kconfig
> > +++ b/arch/arm/mach-s3c2416/Kconfig
> > @@ -30,6 +30,17 @@ config S3C2416_PM
> >  	help
> >  	  Internal config node to apply S3C2416 power management
> > 
> > +config S3C2416_SETUP_SDHCI
> > +	bool
> > +	select S3C2416_SETUP_SDHCI_GPIO
> > +	help
> > +	  Internal helper functions for S3C2416 based SDHCI systems
> > +
> > +config S3C2416_SETUP_SDHCI_GPIO
> > +	bool
> > +	help
> > +	  Common setup code for SDHCI gpio.
> > +
> >  menu "S3C2416 Machines"
> > 
> >  config MACH_SMDK2416
> > @@ -41,6 +52,7 @@ config MACH_SMDK2416
> >  	select S3C_DEV_HSMMC1
> >  	select S3C_DEV_NAND
> >  	select S3C_DEV_USB_HOST
> > +	select S3C2416_SETUP_SDHCI
> >  	select S3C2416_PM if PM
> >  	help
> >  	  Say Y here if you are using an SMDK2416
> > diff --git a/arch/arm/mach-s3c2416/Makefile
> b/arch/arm/mach-s3c2416/Makefile
> > index ef038d6..7b805b2 100644
> > --- a/arch/arm/mach-s3c2416/Makefile
> > +++ b/arch/arm/mach-s3c2416/Makefile
> > @@ -14,6 +14,10 @@ obj-$(CONFIG_CPU_S3C2416)	+= irq.o
> >  obj-$(CONFIG_S3C2416_PM)	+= pm.o
> >  #obj-$(CONFIG_S3C2416_DMA)	+= dma.o
> > 
> > +# Device setup
> > +obj-$(CONFIG_S3C2416_SETUP_SDHCI) += setup-sdhci.o
> > +obj-$(CONFIG_S3C2416_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
> > +
> >  # Machine support
> > 
> >  obj-$(CONFIG_MACH_SMDK2416)	+= mach-smdk2416.o
> > diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-
> > s3c2416/s3c2416.c
> > index 63f39cd..ba7fd87 100644
> > --- a/arch/arm/mach-s3c2416/s3c2416.c
> > +++ b/arch/arm/mach-s3c2416/s3c2416.c
> > @@ -53,6 +53,7 @@
> >  #include <plat/s3c2416.h>
> >  #include <plat/devs.h>
> >  #include <plat/cpu.h>
> > +#include <plat/sdhci.h>
> > 
> >  #include <plat/iic-core.h>
> >  #include <plat/fb-core.h>
> > @@ -115,6 +116,10 @@ void __init s3c2416_map_io(void)
> >  	s3c24xx_gpiocfg_default.set_pull = s3c_gpio_setpull_updown;
> >  	s3c24xx_gpiocfg_default.get_pull = s3c_gpio_getpull_updown;
> > 
> > +	/* initialize device information early */
> > +	s3c2416_default_sdhci0();
> > +	s3c2416_default_sdhci1();
> > +
> >  	iotable_init(s3c2416_iodesc, ARRAY_SIZE(s3c2416_iodesc));
> >  }
> > 
> > diff --git a/arch/arm/mach-s3c2416/setup-sdhci-gpio.c b/arch/arm/mach-
> > s3c2416/setup-sdhci-gpio.c
> > new file mode 100644
> > index 0000000..68ac523
> > --- /dev/null
> > +++ b/arch/arm/mach-s3c2416/setup-sdhci-gpio.c
> > @@ -0,0 +1,58 @@
> > +/* linux/arch/arm/plat-s3c2416/setup-sdhci-gpio.c
> > + *
> > + * Copyright 2010 Promwad Innovation Company
> > + *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
> > + *
> > + * S3C2416 - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
> > + *
> > + * Based on mach-s3c64xx/setup-sdhci-gpio.c
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > +*/
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/types.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/io.h>
> > +
> > +#include <mach/gpio.h>
> 
> Should be <linux/gpio.h>
> 
> > +#include <mach/regs-gpio.h>
> > +#include <plat/gpio-cfg.h>
> > +
> > +void s3c2416_setup_sdhci0_cfg_gpio(struct platform_device *dev, int
> width)
> > +{
> > +	unsigned int gpio;
> > +	unsigned int end;
> > +
> > +	end = S3C2410_GPE(7 + width);
> > +
> > +	/* Set all the necessary GPE pins to special-function 0 */
> > +	for (gpio = S3C2410_GPE(5); gpio < end; gpio++) {
> > +		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> > +		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> > +	}
> > +}
> 
> Following is better.
> 
> +void s3c2416_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
> +{
> +	s3c_gpio_cfgrange_nopull(S3C2410_GPE(5), 2 + width,
> S3C_GPIO_SFN(2));
> +}
Hmm... Cool GPIO helpers. Thanks for pointing me to them :)

> 
> > +
> > +void s3c2416_setup_sdhci1_cfg_gpio(struct platform_device *dev, int
> width)
> > +{
> > +	unsigned int gpio;
> > +	unsigned int end;
> > +
> > +	end = S3C2410_GPL(0 + width);
> > +
> > +	/* Set all the necessary GPG pins to special-function 0 */
> > +	for (gpio = S3C2410_GPL(0); gpio < end; gpio++) {
> > +		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> > +		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> > +	}
> > +
> > +	s3c_gpio_cfgpin(S3C2410_GPL(8), S3C_GPIO_SFN(2));
> > +	s3c_gpio_setpull(S3C2410_GPL(8), S3C_GPIO_PULL_NONE);
> > +	s3c_gpio_cfgpin(S3C2410_GPL(9), S3C_GPIO_SFN(2));
> > +	s3c_gpio_setpull(S3C2410_GPL(9), S3C_GPIO_PULL_NONE);
> > +}
> > +
> > +
> no need 2 empty lines.
> 
> Same...how about following?
> 
> +void s3c2416_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
> +{
> +	s3c_gpio_cfgrange_nopull(S3C2410_GPL(0), width, S3C_GPIO_SFN(2));
> +	s3c_gpio_cfgrange_nopull(S3C2410_GPL(8), 2, S3C_GPIO_SFN(2));
> +}
> 
> > diff --git a/arch/arm/mach-s3c2416/setup-sdhci.c b/arch/arm/mach-
> > s3c2416/setup-sdhci.c
> > new file mode 100644
> > index 0000000..345ddd1
> > --- /dev/null
> > +++ b/arch/arm/mach-s3c2416/setup-sdhci.c
> > @@ -0,0 +1,62 @@
> > +/* linux/arch/arm/mach-s3c2416/setup-sdhci.c
> > + *
> > + * Copyright 2010 Promwad Innovation Company
> > + *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
> > + *
> > + * S3C2416 - Helper functions for settign up SDHCI device(s) (HSMMC)
> > + *
> > + * Based on mach-s3c64xx/setup-sdhci.c
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > +*/
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/types.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/io.h>
> > +
> > +#include <linux/mmc/card.h>
> > +#include <linux/mmc/host.h>
> > +
> > +#include <plat/regs-sdhci.h>
> > +#include <plat/sdhci.h>
> > +
> > +/* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
> > +
> > +char *s3c2416_hsmmc_clksrcs[4] = {
> > +	[0] = "hsmmc",
> > +	[1] = "hsmmc",
> > +	[2] = "hsmmc-if",
> > +	/* [3] = "48m", - note not successfully used yet */
> > +};
> > +
> > +void s3c2416_setup_sdhci_cfg_card(struct platform_device *dev,
> > +				  void __iomem *r,
> > +				  struct mmc_ios *ios,
> > +				  struct mmc_card *card)
> > +{
> > +	u32 ctrl2, ctrl3;
> > +
> > +	ctrl2 = readl(r + S3C_SDHCI_CONTROL2);
> > +	ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
> > +	ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
> > +		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
> > +		  S3C_SDHCI_CTRL2_ENFBCLKRX |
> > +		  S3C_SDHCI_CTRL2_DFCNT_NONE |
> > +		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
> > +
> > +	if (ios->clock < 25 * 1000000)
> > +		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL3 |
> > +			 S3C_SDHCI_CTRL3_FCSEL2 |
> > +			 S3C_SDHCI_CTRL3_FCSEL1 |
> > +			 S3C_SDHCI_CTRL3_FCSEL0);
> > +	else
> > +		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 | S3C_SDHCI_CTRL3_FCSEL0);
> > +
> > +	writel(ctrl2, r + S3C_SDHCI_CONTROL2);
> > +	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
> > +}
> > +
> 
> no need last 1 empty line.
> 
> > diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-
> > samsung/include/plat/sdhci.h
> > index 85853f8..81d801e 100644
> > --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> > +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> > @@ -121,6 +121,8 @@ extern void s5pv310_setup_sdhci0_cfg_gpio(struct
> > platform_device *, int w);
> >  extern void s5pv310_setup_sdhci1_cfg_gpio(struct platform_device *, int
> w);
> >  extern void s5pv310_setup_sdhci2_cfg_gpio(struct platform_device *, int
> w);
> >  extern void s5pv310_setup_sdhci3_cfg_gpio(struct platform_device *, int
> w);
> > +extern void s3c2416_setup_sdhci0_cfg_gpio(struct platform_device *, int
> w);
> > +extern void s3c2416_setup_sdhci1_cfg_gpio(struct platform_device *, int
> w);
> > 
> >  /* S3C64XX SDHCI setup */
> > 
> > @@ -299,6 +301,39 @@ static inline void s5pv210_default_sdhci3(void) { }
> > 
> >  #endif /* CONFIG_S5PV210_SETUP_SDHCI */
> > 
> > +/* S3C2416 SDHCI setup */
> > +#ifdef CONFIG_S3C2416_SETUP_SDHCI
> > +extern char *s3c2416_hsmmc_clksrcs[4];
> > +
> > +extern void s3c2416_setup_sdhci_cfg_card(struct platform_device *dev,
> > +					   void __iomem *r,
> > +					   struct mmc_ios *ios,
> > +					   struct mmc_card *card);
> > +
> > +#ifdef CONFIG_S3C_DEV_HSMMC
> > +static inline void s3c2416_default_sdhci0(void)
> > +{
> > +	s3c_hsmmc0_def_platdata.clocks = s3c2416_hsmmc_clksrcs;
> > +	s3c_hsmmc0_def_platdata.cfg_gpio = s3c2416_setup_sdhci0_cfg_gpio;
> > +	s3c_hsmmc0_def_platdata.cfg_card = s3c2416_setup_sdhci_cfg_card;
> > +}
> > +#else
> > +static inline void s3c2416_default_sdhci0(void) { }
> > +#endif /* CONFIG_S3C_DEV_HSMMC */
> 
> +static inline void s3c2416_default_sdhci0(void)
> +{
> +#ifdef CONFIG_S3C_DEV_HSMMC
> +	s3c_hsmmc0_def_platdata.clocks = s3c2416_hsmmc_clksrcs;
> +	s3c_hsmmc0_def_platdata.cfg_gpio = s3c2416_setup_sdhci0_cfg_gpio;
> +	s3c_hsmmc0_def_platdata.cfg_card = s3c2416_setup_sdhci_cfg_card;
> +#endif
> +}
> 
> And please move this before s3c6400_setup_...
> 
> > +
> > +#ifdef CONFIG_S3C_DEV_HSMMC1
> > +static inline void s3c2416_default_sdhci1(void)
> > +{
> > +	s3c_hsmmc1_def_platdata.clocks = s3c2416_hsmmc_clksrcs;
> > +	s3c_hsmmc1_def_platdata.cfg_gpio = s3c2416_setup_sdhci1_cfg_gpio;
> > +	s3c_hsmmc1_def_platdata.cfg_card = s3c2416_setup_sdhci_cfg_card;
> > +}
> > +#else
> > +static inline void s3c2416_default_sdhci1(void) { }
> > +#endif /* CONFIG_S3C_DEV_HSMMC1 */
> > +
> 
> +static inline void s3c2416_default_sdhci1(void)
> +{
> +#ifdef CONFIG_S3C_DEV_HSMMC1
> +	s3c_hsmmc1_def_platdata.clocks = s3c2416_hsmmc_clksrcs;
> +	s3c_hsmmc1_def_platdata.cfg_gpio = s3c2416_setup_sdhci1_cfg_gpio;
> +	s3c_hsmmc1_def_platdata.cfg_card = s3c2416_setup_sdhci_cfg_card;
> +#endif
> +}
> 
> > +#endif /* CONFIG_S3C2416_SETUP_SDHCI */
> > +
> >  /* S5PV310 SDHCI setup */
> >  #ifdef CONFIG_S5PV310_SETUP_SDHCI
> >  extern char *s5pv310_hsmmc_clksrcs[4];
> > --
> 
> And there was no error on board?

No. Both channels works good on my board.

OK. Will fix and re-send this patch.


-- 
Yauhen Kharuzhy		jekhor _at_ gmail.com
			JID: jek at jabber.ru

A: No
Q: Should I quote below my post?
