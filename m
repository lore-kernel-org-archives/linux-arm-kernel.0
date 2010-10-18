From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 18 Oct 2010 21:17:40 +0900
Subject: [PATCH v2 4/4] ARM: S3C2416: Add platform helpers for setup SDHCI
In-Reply-To: <1277220124-16225-5-git-send-email-jekhor@gmail.com>
References: <1277220124-16225-1-git-send-email-jekhor@gmail.com>
	<1277220124-16225-5-git-send-email-jekhor@gmail.com>
Message-ID: <049a01cb6ebe$76faf170$64f0d450$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yauhen Kharuzhy wrote:
> 
> Samsung S3C2416 has two SDHCI controllers compatible with other
> Samsung's SoCs (S3C64XX, S5PC100 etc...).
> 
> Add required platform setup code that the devices can be used with
> sdhci-s3c driver.
> 
> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  arch/arm/mach-s3c2416/Kconfig              |   12 +++++
>  arch/arm/mach-s3c2416/Makefile             |    4 ++
>  arch/arm/mach-s3c2416/s3c2416.c            |    5 ++
>  arch/arm/mach-s3c2416/setup-sdhci-gpio.c   |   60
> +++++++++++++++++++++++++++
>  arch/arm/mach-s3c2416/setup-sdhci.c        |   62
> ++++++++++++++++++++++++++++
>  arch/arm/plat-samsung/include/plat/sdhci.h |   34 +++++++++++++++
>  6 files changed, 177 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s3c2416/setup-sdhci-gpio.c
>  create mode 100644 arch/arm/mach-s3c2416/setup-sdhci.c
> 
> diff --git a/arch/arm/mach-s3c2416/Kconfig b/arch/arm/mach-s3c2416/Kconfig
> index eafb0ed..3e2b53d 100644
> --- a/arch/arm/mach-s3c2416/Kconfig
> +++ b/arch/arm/mach-s3c2416/Kconfig
> @@ -25,6 +25,17 @@ config S3C2416_DMA
>  	help
>  	  Internal config node for S3C2416 DMA support
> 
> +config S3C2416_SETUP_SDHCI
> +	bool
> +	select S3C2416_SETUP_SDHCI_GPIO
> +	help
> +	  Internal helper functions for S3C2416 based SDHCI systems
> +
> +config S3C2416_SETUP_SDHCI_GPIO
> +	bool
> +	help
> +	  Common setup code for SDHCI gpio.
> +
>  menu "S3C2416 Machines"
> 
>  config MACH_SMDK2416
> @@ -36,6 +47,7 @@ config MACH_SMDK2416
>  	select S3C_DEV_HSMMC1
>  	select S3C_DEV_NAND
>  	select S3C_DEV_USB_HOST
> +	select S3C2416_SETUP_SDHCI
>  	help
>  	  Say Y here if you are using an SMDK2416
> 
> diff --git a/arch/arm/mach-s3c2416/Makefile
b/arch/arm/mach-s3c2416/Makefile
> index 6c12c7b..4f83f94 100644
> --- a/arch/arm/mach-s3c2416/Makefile
> +++ b/arch/arm/mach-s3c2416/Makefile
> @@ -14,6 +14,10 @@ obj-$(CONFIG_CPU_S3C2416)	+= irq.o
> 
>  #obj-$(CONFIG_S3C2416_DMA)	+= dma.o
> 
> +# Device setup
> +obj-$(CONFIG_S3C2416_SETUP_SDHCI) += setup-sdhci.o
> +obj-$(CONFIG_S3C2416_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
> +
>  # Machine support
> 
>  obj-$(CONFIG_MACH_SMDK2416)	+= mach-smdk2416.o
> diff --git a/arch/arm/mach-s3c2416/s3c2416.c b/arch/arm/mach-
> s3c2416/s3c2416.c
> index 355ab62..06eacf8 100644
> --- a/arch/arm/mach-s3c2416/s3c2416.c
> +++ b/arch/arm/mach-s3c2416/s3c2416.c
> @@ -53,6 +53,7 @@
>  #include <plat/s3c2416.h>
>  #include <plat/devs.h>
>  #include <plat/cpu.h>
> +#include <plat/sdhci.h>
> 
>  #include <plat/iic-core.h>
> 
> @@ -115,6 +116,10 @@ void __init s3c2416_map_io(void)
>  	s3c24xx_gpiocfg_default.set_pull = s3c_gpio_setpull_updown;
>  	s3c24xx_gpiocfg_default.get_pull = s3c_gpio_getpull_updown;
> 
> +	/* initialize device information early */
> +	s3c2416_default_sdhci0();
> +	s3c2416_default_sdhci1();
> +
>  	iotable_init(s3c2416_iodesc, ARRAY_SIZE(s3c2416_iodesc));
>  }
> 
> diff --git a/arch/arm/mach-s3c2416/setup-sdhci-gpio.c b/arch/arm/mach-
> s3c2416/setup-sdhci-gpio.c
> new file mode 100644
> index 0000000..ebdab15
> --- /dev/null
> +++ b/arch/arm/mach-s3c2416/setup-sdhci-gpio.c
> @@ -0,0 +1,60 @@
> +/* linux/arch/arm/plat-s3c2416/setup-sdhci-gpio.c
> + *
> + * Copyright 2010 Promwad Innovation Company
> + *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
> + *
> + * S3C2416 - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
> + *
> + * Based on mach-s3c64xx/setup-sdhci-gpio.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +
> +#include <mach/gpio.h>

should be <linux/gpio.h>

> +#include <mach/regs-gpio.h>
> +#include <plat/gpio-cfg.h>
> +
> +/* Note: hsmmc1 and hsmmc0 are swapped versus datasheet */
> +
> +void s3c2416_setup_sdhci1_cfg_gpio(struct platform_device *dev, int
width)
> +{
> +	unsigned int gpio;
> +	unsigned int end;
> +
> +	end = S3C2410_GPE(7 + width);
> +
> +	/* Set all the necessary GPE pins to special-function 0 */
> +	for (gpio = S3C2410_GPE(5); gpio < end; gpio++) {
> +		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> +	}

could you please update above gpio setup functions like following?

s3c_gpio_cfgrange_nopull(S3C2410_GPE(5), 2 + width, S3C_GPIO_SFN(2));

> +}
> +
> +void s3c2416_setup_sdhci0_cfg_gpio(struct platform_device *dev, int
width)
> +{
> +	unsigned int gpio;
> +	unsigned int end;
> +
> +	end = S3C2410_GPL(0 + width);
> +
> +	/* Set all the necessary GPG pins to special-function 0 */
> +	for (gpio = S3C2410_GPL(0); gpio < end; gpio++) {
> +		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(2));
> +		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
> +	}

s3c_gpio_cfgrange_nopull(S3C2410_GPL(0), width, S3C_GPIO_SFN(2));

> +
> +	s3c_gpio_cfgpin(S3C2410_GPL(8), S3C_GPIO_SFN(2));
> +	s3c_gpio_setpull(S3C2410_GPL(8), S3C_GPIO_PULL_NONE);
> +	s3c_gpio_cfgpin(S3C2410_GPL(9), S3C_GPIO_SFN(2));
> +	s3c_gpio_setpull(S3C2410_GPL(9), S3C_GPIO_PULL_NONE);

s3c_gpio_cfgranbe_nopull(S3C2410_GPL(8), 2, S3C_GPIO_SFN(2));

> +}
> +
> +

no need above empty lines...

> diff --git a/arch/arm/mach-s3c2416/setup-sdhci.c b/arch/arm/mach-
> s3c2416/setup-sdhci.c
> new file mode 100644
> index 0000000..345ddd1
> --- /dev/null
> +++ b/arch/arm/mach-s3c2416/setup-sdhci.c
> @@ -0,0 +1,62 @@
> +/* linux/arch/arm/mach-s3c2416/setup-sdhci.c
> + *
> + * Copyright 2010 Promwad Innovation Company
> + *	Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
> + *
> + * S3C2416 - Helper functions for settign up SDHCI device(s) (HSMMC)
> + *
> + * Based on mach-s3c64xx/setup-sdhci.c
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +
> +#include <linux/mmc/card.h>
> +#include <linux/mmc/host.h>
> +
> +#include <plat/regs-sdhci.h>
> +#include <plat/sdhci.h>
> +
> +/* clock sources for the mmc bus clock, order as for the ctrl2[5..4] */
> +
> +char *s3c2416_hsmmc_clksrcs[4] = {
> +	[0] = "hsmmc",
> +	[1] = "hsmmc",
> +	[2] = "hsmmc-if",
> +	/* [3] = "48m", - note not successfully used yet */
> +};
> +
> +void s3c2416_setup_sdhci_cfg_card(struct platform_device *dev,
> +				  void __iomem *r,
> +				  struct mmc_ios *ios,
> +				  struct mmc_card *card)
> +{
> +	u32 ctrl2, ctrl3;
> +
> +	ctrl2 = readl(r + S3C_SDHCI_CONTROL2);
> +	ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
> +	ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
> +		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
> +		  S3C_SDHCI_CTRL2_ENFBCLKRX |
> +		  S3C_SDHCI_CTRL2_DFCNT_NONE |
> +		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
> +
> +	if (ios->clock < 25 * 1000000)
> +		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL3 |
> +			 S3C_SDHCI_CTRL3_FCSEL2 |
> +			 S3C_SDHCI_CTRL3_FCSEL1 |
> +			 S3C_SDHCI_CTRL3_FCSEL0);
> +	else
> +		ctrl3 = (S3C_SDHCI_CTRL3_FCSEL1 | S3C_SDHCI_CTRL3_FCSEL0);
> +
> +	writel(ctrl2, r + S3C_SDHCI_CONTROL2);
> +	writel(ctrl3, r + S3C_SDHCI_CONTROL3);
> +}
> +

no need above empty line.

> diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-
> samsung/include/plat/sdhci.h
> index 13f9fb2..d408140 100644
> --- a/arch/arm/plat-samsung/include/plat/sdhci.h
> +++ b/arch/arm/plat-samsung/include/plat/sdhci.h
> @@ -78,6 +78,8 @@ extern void s3c64xx_setup_sdhci2_cfg_gpio(struct
> platform_device *, int w);
>  extern void s5pv210_setup_sdhci0_cfg_gpio(struct platform_device *, int
w);
>  extern void s5pv210_setup_sdhci1_cfg_gpio(struct platform_device *, int
w);
>  extern void s5pv210_setup_sdhci2_cfg_gpio(struct platform_device *, int
w);
> +extern void s3c2416_setup_sdhci0_cfg_gpio(struct platform_device *, int
w);
> +extern void s3c2416_setup_sdhci1_cfg_gpio(struct platform_device *, int
w);
> 
>  /* S3C6400 SDHCI setup */
> 
> @@ -270,6 +272,38 @@ static inline void s5pv210_default_sdhci1(void) { }
>  static inline void s5pv210_default_sdhci2(void) { }
>  #endif /* CONFIG_S5PC100_SETUP_SDHCI */
> 
> +/* S3C2416 SDHCI setup */
> +#ifdef CONFIG_S3C2416_SETUP_SDHCI
> +extern char *s3c2416_hsmmc_clksrcs[4];
> +
> +extern void s3c2416_setup_sdhci_cfg_card(struct platform_device *dev,
> +					   void __iomem *r,
> +					   struct mmc_ios *ios,
> +					   struct mmc_card *card);
> +
> +#ifdef CONFIG_S3C_DEV_HSMMC
> +static inline void s3c2416_default_sdhci0(void)
> +{
> +	s3c_hsmmc0_def_platdata.clocks = s3c2416_hsmmc_clksrcs;
> +	s3c_hsmmc0_def_platdata.cfg_gpio = s3c2416_setup_sdhci0_cfg_gpio;
> +	s3c_hsmmc0_def_platdata.cfg_card = s3c2416_setup_sdhci_cfg_card;
> +}
> +#else
> +static inline void s3c2416_default_sdhci0(void) { }
> +#endif /* CONFIG_S3C_DEV_HSMMC */

could you please update above like current plat-samung/include/plat/sdhci.h?

> +
> +#ifdef CONFIG_S3C_DEV_HSMMC1
> +static inline void s3c2416_default_sdhci1(void)
> +{
> +	s3c_hsmmc1_def_platdata.clocks = s3c2416_hsmmc_clksrcs;
> +	s3c_hsmmc1_def_platdata.cfg_gpio = s3c2416_setup_sdhci1_cfg_gpio;
> +	s3c_hsmmc1_def_platdata.cfg_card = s3c2416_setup_sdhci_cfg_card;
> +}
> +#else
> +static inline void s3c2416_default_sdhci1(void) { }
> +#endif /* CONFIG_S3C_DEV_HSMMC1 */
> +
> +#endif /* CONFIG_S3C2416_SETUP_SDHCI */
> 
> 
> 
No need above empty lines...

> --


Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
