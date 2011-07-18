From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 18 Jul 2011 11:13:36 +0900
Subject: [PATCH 1/3] ARM: S5P64X0: Add HSMMC setup for host Controller
In-Reply-To: <1308571049-4412-2-git-send-email-rajeshwari.s@samsung.com>
References: <1308571049-4412-1-git-send-email-rajeshwari.s@samsung.com>
	<1308571049-4412-2-git-send-email-rajeshwari.s@samsung.com>
Message-ID: <047801cc44f0$4fb16f50$ef144df0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rajeshwari Shinde wrote:
> 
> From: rajeshwari.s <rajeshwari.s@samsung.com>
> 
Maybe ' Rajeshwari Shinde' instead of rajeshwari.s?

> Adds support for HSMMC for S5P64X0 platform, performs
> setup for host controller and related GPIO.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Rajeshwari.S <rajeshwari.s@samsung.com>
> ---
>  arch/arm/mach-s5p64x0/Kconfig            |   31 ++++++++
>  arch/arm/mach-s5p64x0/Makefile           |    2 +
>  arch/arm/mach-s5p64x0/setup-sdhci-gpio.c |  121
> ++++++++++++++++++++++++++++++
>  arch/arm/mach-s5p64x0/setup-sdhci.c      |   54 +++++++++++++
>  4 files changed, 208 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-s5p64x0/setup-sdhci-gpio.c
>  create mode 100644 arch/arm/mach-s5p64x0/setup-sdhci.c
> 
> diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
> index 017af4c..ed823b0 100644
> --- a/arch/arm/mach-s5p64x0/Kconfig
> +++ b/arch/arm/mach-s5p64x0/Kconfig
> @@ -26,6 +26,17 @@ config S5P64X0_SETUP_I2C1
>  	help
>  	  Common setup code for i2c bus 1.
> 
> +config S5P64X0_SETUP_SDHCI
> +	bool
> +	select S5P64X0_SETUP_SDHCI_GPIO
> +	help
> +	  Internal helper functions for S5P64X0 based SDHCI systems
> +
> +config S5P64X0_SETUP_SDHCI_GPIO
> +	bool
> +	help
> +	  Common setup code for SDHCI gpio.
> +
>  # machine support
> 
>  config MACH_SMDK6440
> @@ -34,11 +45,15 @@ config MACH_SMDK6440
>  	select S3C_DEV_I2C1
>  	select S3C_DEV_RTC
>  	select S3C_DEV_WDT
> +	select S3C_DEV_HSMMC
> +	select S3C_DEV_HSMMC1
> +	select S3C_DEV_HSMMC2
>  	select S3C64XX_DEV_SPI
>  	select SAMSUNG_DEV_ADC
>  	select SAMSUNG_DEV_PWM
>  	select SAMSUNG_DEV_TS
>  	select S5P64X0_SETUP_I2C1
> +	select S5P64X0_SETUP_SDHCI
>  	help
>  	  Machine support for the Samsung SMDK6440
> 
> @@ -48,12 +63,28 @@ config MACH_SMDK6450
>  	select S3C_DEV_I2C1
>  	select S3C_DEV_RTC
>  	select S3C_DEV_WDT
> +	select S3C_DEV_HSMMC
> +	select S3C_DEV_HSMMC1
> +	select S3C_DEV_HSMMC2
>  	select S3C64XX_DEV_SPI
>  	select SAMSUNG_DEV_ADC
>  	select SAMSUNG_DEV_PWM
>  	select SAMSUNG_DEV_TS
>  	select S5P64X0_SETUP_I2C1
> +	select S5P64X0_SETUP_SDHCI
>  	help
>  	  Machine support for the Samsung SMDK6450
> 
> +menu "Use 8-bit SDHCI bus width"
> +
> +config S5P64X0_SD_CH1_8BIT
> +	bool "SDHCI Channel 1 (Slot 1)"
> +	depends on MACH_SMDK6450 || MACH_SMDK6440

Is this available on only SMDK6440 and SMDK6450?

> +	default n

no need.

> +	help
> +	  Support SDHCI Channel 1 8-bit bus.
> +	  If selected, Channel 2 is disabled.
> +
> +endmenu
> +
>  endif
> diff --git a/arch/arm/mach-s5p64x0/Makefile
b/arch/arm/mach-s5p64x0/Makefile
> index ae6bf6f..60ff9b4 100644
> --- a/arch/arm/mach-s5p64x0/Makefile
> +++ b/arch/arm/mach-s5p64x0/Makefile
> @@ -28,3 +28,5 @@ obj-y				+= dev-audio.o
>  obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
> 
>  obj-$(CONFIG_S5P64X0_SETUP_I2C1)	+= setup-i2c1.o
> +obj-$(CONFIG_S5P64X0_SETUP_SDHCI)	+= setup-sdhci.o
> +obj-$(CONFIG_S5P64X0_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
> diff --git a/arch/arm/mach-s5p64x0/setup-sdhci-gpio.c b/arch/arm/mach-
> s5p64x0/setup-sdhci-gpio.c
> new file mode 100644
> index 0000000..31541b3
> --- /dev/null
> +++ b/arch/arm/mach-s5p64x0/setup-sdhci-gpio.c
> @@ -0,0 +1,121 @@
> +/* linux/arch/arm/mach-s5p64x0/setup-sdhci-gpio.c
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5P64X0 - Helper functions for setting up SDHCI device(s) GPIO (HSMMC)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +
> +#include <mach/gpio.h>
> +#include <mach/regs-gpio.h>
> +
> +#include <plat/gpio-cfg.h>
> +#include <plat/sdhci.h>
> +
> +

one empty line is enough.

> +void s5p6440_setup_sdhci0_cfg_gpio(struct platform_device *dev, int
width)
> +{
> +	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
> +
> +	/* Set all the necessary GPG pins to special-function 2 */
> +	s3c_gpio_cfgrange_nopull(S5P6440_GPG(0), 2 + width,
> S3C_GPIO_SFN(2));
> +
> +	/* Set GPG[6] pin to special-function 2 - MMC0 CDn */
> +	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
> +		s3c_gpio_setpull(S5P6440_GPG(6), S3C_GPIO_PULL_UP);
> +		s3c_gpio_cfgpin(S5P6440_GPG(6), S3C_GPIO_SFN(2));
> +	}
> +}
> +
> +void s5p6440_setup_sdhci1_cfg_gpio(struct platform_device *dev, int
width)
> +{
> +	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
> +
> +	/* Set GPH[0:1] pins to special-function 2 - CLK and CMD */
> +	s3c_gpio_cfgrange_nopull(S5P6440_GPH(0), 2 , S3C_GPIO_SFN(2));
> +
> +	switch (width) {
> +	case 8:
> +		/* Set data pins GPH[6:9] special-function 2 */
> +		s3c_gpio_cfgrange_nopull(S5P6440_GPH(6), 4,
> S3C_GPIO_SFN(2));
> +	case 4:
> +		/* set data pins GPH[2:5] special-function 2 */
> +		s3c_gpio_cfgrange_nopull(S5P6440_GPH(2), 4,
> S3C_GPIO_SFN(2));
> +	default:
> +		break;
> +	}
> +
> +	/* Set GPG[6] pin to special-funtion 3 : MMC1 CDn */
> +	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
> +		s3c_gpio_setpull(S5P6440_GPG(6), S3C_GPIO_PULL_UP);
> +		s3c_gpio_cfgpin(S5P6440_GPG(6), S3C_GPIO_SFN(3));
> +	}
> +}

The setup of sdhci0 and sdhci1 are similar/same on s5p64440 and s5p6450
except gpio pin.
Isn't there any way to handle it in each same function?

> +
> +void s5p6440_setup_sdhci2_cfg_gpio(struct platform_device *dev, int
width)
> +{
> +	/* Set GPC[4:5] pins to special-function 3 - CLK and CMD */
> +	s3c_gpio_cfgrange_nopull(S5P6440_GPC(4), 2, S3C_GPIO_SFN(3));
> +
> +	/* Set data pins GPH[6:9] pins to special-function 3 */
> +	s3c_gpio_cfgrange_nopull(S5P6440_GPH(6), 4, S3C_GPIO_SFN(3));
> +
> +	/* No MMC2 CDn available */
> +}
> +
> +

Same, one empty line is enough.

> +/* S5P6450 SDHCI GPIO Settings */
> +void s5p6450_setup_sdhci0_cfg_gpio(struct platform_device *dev, int
width)
> +{
> +	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
> +
> +	/* Set all the necessary GPG pins to special-function 2 */
> +	s3c_gpio_cfgrange_nopull(S5P6450_GPG(0), 2 + width,
> S3C_GPIO_SFN(2));
> +
> +	/* Set GPG[6] to special-function 2 : MMC0 CDn */
> +	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
> +		s3c_gpio_setpull(S5P6450_GPG(6), S3C_GPIO_PULL_UP);
> +		s3c_gpio_cfgpin(S5P6450_GPG(6), S3C_GPIO_SFN(2));
> +	}
> +}
> +
> +void s5p6450_setup_sdhci1_cfg_gpio(struct platform_device *dev, int
width)
> +{
> +	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
> +
> +	/* Set GPH[0:1] pins to special-function 2 - CLK and CMD */
> +	s3c_gpio_cfgrange_nopull(S5P6450_GPH(0), 2, S3C_GPIO_SFN(2));
> +
> +	switch (width) {
> +	case 8:
> +		/* Set data pins GPH[6:9] to special-function 2 */
> +		s3c_gpio_cfgrange_nopull(S5P6450_GPH(6), 4,
> S3C_GPIO_SFN(2));
> +	case 4:
> +		/* Set data pins GPH[2:5] to special-function 2 */
> +		s3c_gpio_cfgrange_nopull(S5P6450_GPH(2), 4,
> S3C_GPIO_SFN(2));
> +	default:
> +		break;
> +	}
> +
> +	/* Set GPG[6] pin to special-funtion 3 : MMC1 CDn */
> +	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
> +		s3c_gpio_setpull(S5P6450_GPG(6), S3C_GPIO_PULL_UP);
> +		s3c_gpio_cfgpin(S5P6450_GPG(6), S3C_GPIO_SFN(3));
> +	}
> +}
> +
> +void s5p6450_setup_sdhci2_cfg_gpio(struct platform_device *dev, int
width)
> +{
> +
> +	/* Set all the necessary GPG pins to special-function 3 */
> +	s3c_gpio_cfgrange_nopull(S5P6450_GPG(7), 2 + width,
> S3C_GPIO_SFN(3));
> +
> +	/* No MMC2 CDn available */
> +}
> diff --git a/arch/arm/mach-s5p64x0/setup-sdhci.c
b/arch/arm/mach-s5p64x0/setup-
> sdhci.c
> new file mode 100644
> index 0000000..729b824
> --- /dev/null
> +++ b/arch/arm/mach-s5p64x0/setup-sdhci.c
> @@ -0,0 +1,54 @@
> +/* linux/arch/arm/mach-s5p64x0/setup-sdhci.c
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5P64X0 - Helper functions for settign up SDHCI device(s) (HSMMC)
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
> +char *s5p64x0_hsmmc_clksrcs[4] = {
> +	[0] = NULL,
> +	[1] = NULL,
> +	[2] = "sclk_mmc",	/* mmc_bus */
> +	[3] = NULL,
> +};
> +
> +void s5p64x0_setup_sdhci_cfg_card(struct platform_device *dev,
> +				    void __iomem *r,
> +				    struct mmc_ios *ios,
> +				    struct mmc_card *card)
> +{
> +	u32 ctrl2 = 0, ctrl3 = 0;
> +
> +	/* don't need to alter anything acording to card-type */
> +	__raw_writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA,
> +			r + S3C64XX_SDHCI_CONTROL4);
> +
> +	ctrl2 = __raw_readl(r + S3C_SDHCI_CONTROL2);
> +	ctrl2 &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
> +	ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
> +		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
> +		  S3C_SDHCI_CTRL2_DFCNT_NONE |
> +		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
> +
> +	__raw_writel(ctrl2, r + S3C_SDHCI_CONTROL2);
> +	__raw_writel(ctrl3, r + S3C_SDHCI_CONTROL3);
> +}
> --
> 1.7.0.4



Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
