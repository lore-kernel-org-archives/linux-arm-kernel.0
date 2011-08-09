From: subashrp@gmail.com (Subash Patel)
Date: Tue, 09 Aug 2011 11:32:59 +0530
Subject: RFC[PATCH 3/6] ARM: S5P64X0: Add pin-mux setup support for SDHCI
In-Reply-To: <1312793277-18689-4-git-send-email-rajeshwari.s@samsung.com>
References: <1312793277-18689-1-git-send-email-rajeshwari.s@samsung.com>
	<1312793277-18689-4-git-send-email-rajeshwari.s@samsung.com>
Message-ID: <4E40CD93.70600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajeshwari,

Please find my comments below:

On 08/08/2011 02:17 PM, Rajeshwari Shinde wrote:
> This patch provides pin-mux setup files for HSMMC support on
> S5P6440 and S5P6450 platforms.
>
> Signed-off-by: Rajeshwari Shinde<rajeshwari.s@samsung.com>
> ---
>   arch/arm/mach-s5p64x0/Makefile           |    2 +
>   arch/arm/mach-s5p64x0/setup-sdhci-gpio.c |  109 ++++++++++++++++++++++++++++++
>   arch/arm/mach-s5p64x0/setup-sdhci.c      |   46 +++++++++++++
>   3 files changed, 157 insertions(+), 0 deletions(-)
>   create mode 100644 arch/arm/mach-s5p64x0/setup-sdhci-gpio.c
>   create mode 100644 arch/arm/mach-s5p64x0/setup-sdhci.c
>
> diff --git a/arch/arm/mach-s5p64x0/Makefile b/arch/arm/mach-s5p64x0/Makefile
> index 5f6afdf..6642448 100644
> --- a/arch/arm/mach-s5p64x0/Makefile
> +++ b/arch/arm/mach-s5p64x0/Makefile
> @@ -28,3 +28,5 @@ obj-y				+= dev-audio.o
>   obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
>
>   obj-$(CONFIG_S5P64X0_SETUP_I2C1)	+= setup-i2c1.o
> +obj-$(CONFIG_S5P64X0_SETUP_SDHCI)	+= setup-sdhci.o
> +obj-$(CONFIG_S5P64X0_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
> diff --git a/arch/arm/mach-s5p64x0/setup-sdhci-gpio.c b/arch/arm/mach-s5p64x0/setup-sdhci-gpio.c
> new file mode 100644
> index 0000000..616b277
> --- /dev/null
> +++ b/arch/arm/mach-s5p64x0/setup-sdhci-gpio.c
> @@ -0,0 +1,109 @@
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
> +#include<linux/platform_device.h>
> +#include<linux/io.h>
> +#include<linux/gpio.h>
> +
> +#include<mach/regs-gpio.h>
> +#include<mach/regs-clock.h>
> +
> +#include<plat/gpio-cfg.h>
> +#include<plat/sdhci.h>
> +
> +#define S5P6450_ID (0x50000)
> +
> +void s5p64x0_setup_sdhci0_cfg_gpio(struct platform_device *dev, int width)
> +{
> +	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;

You have used struct platform_device *pdev and struct platform_device 
*dev alternatively in this patch series. Its better to maintain 
consistency. As a practice pdev is used for struct platform_device and 
dev is used for struct device for keeping code readable (else it is 
confusing as one above)

> +	unsigned int id = __raw_readl(S5P64X0_SYS_ID)&  0xFF000;
> +
proper indentation of code required.

> +	/* Set all the necessary GPG pins to special-function 2 -
> +	 * CLK, CMD and Data pins
> +	*/
> +	if (id == S5P6450_ID)
> +		s3c_gpio_cfgrange_nopull(S5P6450_GPG(0), 2 + width,
> +					 S3C_GPIO_SFN(2));
> +	else
> +		s3c_gpio_cfgrange_nopull(S5P6440_GPG(0), 2 + width,
> +					 S3C_GPIO_SFN(2));
> +
> +	/* Set GPG[6] pin to special-function 2 - MMC0 CDn */
> +	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
> +		if (id == S5P6450_ID) {
> +			s3c_gpio_setpull(S5P6450_GPG(6), S3C_GPIO_PULL_UP);
> +			s3c_gpio_cfgpin(S5P6450_GPG(6), S3C_GPIO_SFN(2));
> +		} else {
> +			s3c_gpio_setpull(S5P6440_GPG(6), S3C_GPIO_PULL_UP);
> +			s3c_gpio_cfgpin(S5P6440_GPG(6), S3C_GPIO_SFN(2));
> +		}
> +	}
> +}
> +
> +void s5p64x0_setup_sdhci1_cfg_gpio(struct platform_device *dev, int width)
> +{
> +	struct s3c_sdhci_platdata *pdata = dev->dev.platform_data;
> +	unsigned int id = __raw_readl(S5P64X0_SYS_ID)&  0xFF000;
indentation between &
> +
> +	/* Set GPH[0:1] pins to special-function 2 - CLK and CMD */
> +	if (id == S5P6450_ID)
> +		s3c_gpio_cfgrange_nopull(S5P6450_GPH(0), 2, S3C_GPIO_SFN(2));
> +	else
> +		s3c_gpio_cfgrange_nopull(S5P6440_GPH(0), 2 , S3C_GPIO_SFN(2));
> +
> +	switch (width) {
> +	case 8:
> +		/* Set data pins GPH[6:9] special-function 2 */
> +		if (id == S5P6450_ID)
> +			s3c_gpio_cfgrange_nopull(S5P6450_GPH(6), 4,
> +						 S3C_GPIO_SFN(2));
> +		else
> +			s3c_gpio_cfgrange_nopull(S5P6440_GPH(6), 4,
> +						 S3C_GPIO_SFN(2));
> +	case 4:
> +		/* set data pins GPH[2:5] special-function 2 */
> +		if (id == S5P6450_ID)
> +			s3c_gpio_cfgrange_nopull(S5P6450_GPH(2), 4,
> +						 S3C_GPIO_SFN(2));
> +		else
> +			s3c_gpio_cfgrange_nopull(S5P6440_GPH(2), 4,
> +						 S3C_GPIO_SFN(2));
> +	default:
> +		break;
> +	}
> +
> +	/* Set GPG[6] pin to special-funtion 3 : MMC1 CDn */
> +	if (pdata->cd_type == S3C_SDHCI_CD_INTERNAL) {
> +		if (id == S5P6450_ID) {
> +			s3c_gpio_setpull(S5P6450_GPG(6), S3C_GPIO_PULL_UP);
> +			s3c_gpio_cfgpin(S5P6450_GPG(6), S3C_GPIO_SFN(3));
> +		} else {
> +			s3c_gpio_setpull(S5P6440_GPG(6), S3C_GPIO_PULL_UP);
> +			s3c_gpio_cfgpin(S5P6440_GPG(6), S3C_GPIO_SFN(3));
> +		}
> +	}
> +}
> +
> +void s5p6440_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
> +{
> +	/* Set GPC[4:5] pins to special-function 3 - CLK and CMD */
> +	s3c_gpio_cfgrange_nopull(S5P6440_GPC(4), 2, S3C_GPIO_SFN(3));
> +
> +	/* Set data pins GPH[6:9] pins to special-function 3 */
> +	s3c_gpio_cfgrange_nopull(S5P6440_GPH(6), 4, S3C_GPIO_SFN(3));
> +}
> +
> +void s5p6450_setup_sdhci2_cfg_gpio(struct platform_device *dev, int width)
> +{
> +	/* Set all the necessary GPG pins to special-function 3 */
> +	s3c_gpio_cfgrange_nopull(S5P6450_GPG(7), 2 + width, S3C_GPIO_SFN(3));
> +}
> diff --git a/arch/arm/mach-s5p64x0/setup-sdhci.c b/arch/arm/mach-s5p64x0/setup-sdhci.c
> new file mode 100644
> index 0000000..4c64db6
> --- /dev/null
> +++ b/arch/arm/mach-s5p64x0/setup-sdhci.c
> @@ -0,0 +1,46 @@
> +/* linux/arch/arm/mach-s5p64x0/setup-sdhci.c
> + *
> + * Copyright (c) 2011 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * S5P64X0 - Helper functions for setting up SDHCI device(s) (HSMMC)
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include<linux/kernel.h>
> +#include<linux/types.h>
> +#include<linux/interrupt.h>
> +#include<linux/platform_device.h>
> +#include<linux/io.h>
> +
> +#include<linux/mmc/card.h>
> +#include<linux/mmc/host.h>
> +
> +#include<plat/regs-sdhci.h>
> +#include<plat/sdhci.h>
> +
> +void s5p64x0_setup_sdhci_cfg_card(struct platform_device *dev,
> +				    void __iomem *r,
> +				    struct mmc_ios *ios,
> +				    struct mmc_card *card)
> +{
> +	u32 ctrl2;
> +
> +	/* don't need to alter anything acording to card-type */
Should the comment be -> "no need to alter anything according to card 
type" instead?
> +	__raw_writel(S3C64XX_SDHCI_CONTROL4_DRIVE_9mA,
> +			r + S3C64XX_SDHCI_CONTROL4);
> +
> +	ctrl2 = __raw_readl(r + S3C_SDHCI_CONTROL2);
> +	ctrl2&= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
ctrl &= S3C_SDHCI_CTRL2_SELBASECLK_MASK;
> +
> +	ctrl2 |= (S3C64XX_SDHCI_CTRL2_ENSTAASYNCCLR |
> +		  S3C64XX_SDHCI_CTRL2_ENCMDCNFMSK |
> +		  S3C_SDHCI_CTRL2_DFCNT_NONE |
> +		  S3C_SDHCI_CTRL2_ENCLKOUTHOLD);
> +
> +	__raw_writel(ctrl2, r + S3C_SDHCI_CONTROL2);
> +	__raw_writel(0, r + S3C_SDHCI_CONTROL3);
> +}

Regards,
Subash
