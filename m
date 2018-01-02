From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 2 Jan 2018 19:49:44 +0100 (CET)
Subject: [PATCH 3/4] bcm2835-gpio-exp: Driver for GPIO expander via
 mailbox service
In-Reply-To: <bcac00c71b29c359b59053a30d817a8f17d6731d.1514898134.git.baruch@tkos.co.il>
References: <cover.1514898134.git.baruch@tkos.co.il>
 <bcac00c71b29c359b59053a30d817a8f17d6731d.1514898134.git.baruch@tkos.co.il>
Message-ID: <2013811470.181895.1514918984637@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

additionally the my comments on Michael's patches in March 2017, some new below.

> Baruch Siach <baruch@tkos.co.il> hat am 2. Januar 2018 um 14:19 geschrieben:
> 
> 
> From: Dave Stevenson <dave.stevenson@raspberrypi.org>
> 
> Pi3 and Compute Module 3 have a GPIO expander that the
> VPU communicates with.
> There is a mailbox service that now allows control of this
> expander, so add a kernel driver that can make use of it.
> 
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  drivers/gpio/Kconfig        |   7 ++
>  drivers/gpio/Makefile       |   1 +
>  drivers/gpio/gpio-bcm-exp.c | 254 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 262 insertions(+)
>  create mode 100644 drivers/gpio/gpio-bcm-exp.c
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index d6a8e851ad13..e2aab64ea772 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -128,6 +128,13 @@ config GPIO_AXP209
>  	help
>  	  Say yes to enable GPIO support for the AXP209 PMIC
>  
> +config GPIO_BCM_EXP
> +	bool "Broadcom Exp GPIO"

same as in the binding, i don't think this is specific to Broadcom.

> +	depends on OF_GPIO && RASPBERRYPI_FIRMWARE && (ARCH_BCM2835 || COMPILE_TEST)

This is too long. Please split up.

> +	help
> +	  Turn on GPIO support for Broadcom chips using the firmware mailbox
> +	  to communicate with VideoCore on BCM283x chips.
> +
>  config GPIO_BCM_KONA
>  	bool "Broadcom Kona GPIO"
>  	depends on OF_GPIO && (ARCH_BCM_MOBILE || COMPILE_TEST)
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 4bc24febb889..c5f481b1d53c 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_GPIO_ARIZONA)	+= gpio-arizona.o
>  obj-$(CONFIG_GPIO_ATH79)	+= gpio-ath79.o
>  obj-$(CONFIG_GPIO_ASPEED)	+= gpio-aspeed.o
>  obj-$(CONFIG_GPIO_AXP209)	+= gpio-axp209.o
> +obj-$(CONFIG_GPIO_BCM_EXP)	+= gpio-bcm-exp.o
>  obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
>  obj-$(CONFIG_GPIO_BD9571MWV)	+= gpio-bd9571mwv.o
>  obj-$(CONFIG_GPIO_BRCMSTB)	+= gpio-brcmstb.o
> diff --git a/drivers/gpio/gpio-bcm-exp.c b/drivers/gpio/gpio-bcm-exp.c
> new file mode 100644
> index 000000000000..d68adafaee4a
> --- /dev/null
> +++ b/drivers/gpio/gpio-bcm-exp.c
> @@ -0,0 +1,254 @@
> +/*
> + *  Broadcom expander GPIO driver
> + *
> + *  Uses the firmware mailbox service to communicate with the
> + *  GPIO expander on the VPU.
> + *
> + *  Copyright (C) 2017 Raspberry Pi Trading Ltd.
> + *
> + *  Author: Dave Stevenson <dave.stevenson@raspberrypi.org>
> + *  Based on gpio-bcm-virt.c by Dom Cobley <popcornmix@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */

SPDX identifier?

> +
> +#include <linux/err.h>
> +#include <linux/gpio.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <soc/bcm2835/raspberrypi-firmware.h>
> +
> +#define MODULE_NAME "brcmexp-gpio"
> +#define NUM_GPIO 8
> +
> +struct brcmexp_gpio {
> +	struct gpio_chip gc;
> +	struct device *dev;
> +	struct rpi_firmware *fw;
> +};
> +
> +struct gpio_set_config {
> +	u32 gpio, direction, polarity, term_en, term_pull_up, state;
> +};
> +
> +struct gpio_get_config {
> +	u32 gpio, direction, polarity, term_en, term_pull_up;
> +};
> +
> +struct gpio_get_set_state {
> +	u32 gpio, state;
> +};
> +
> +static int brcmexp_gpio_get_polarity(struct gpio_chip *gc, unsigned int off)
> +{
> +	struct brcmexp_gpio *gpio;
> +	struct gpio_get_config get;
> +	int ret;
> +
> +	gpio = container_of(gc, struct brcmexp_gpio, gc);
> +
> +	get.gpio = off + gpio->gc.base;	/* GPIO to update */

Please don't misuse the gpiochip base to communicate with the firmware. AFAIK the gc.base should be -1 (dynamic), so better use a define for the base.

> +
> +	ret = rpi_firmware_property(gpio->fw, RPI_FIRMWARE_GET_GPIO_CONFIG,
> +				    &get, sizeof(get));
> +	if (ret) {
> +		dev_err(gpio->dev,
> +			"Failed to get GPIO %u config (%d)\n", off, ret);
> +		return ret;
> +	}

Shouldn't we also check the in-bound status at get.gpio?
And in all the other gpio ops?

> ...
> +
> +static int brcmexp_gpio_probe(struct platform_device *pdev)
> +{
> +	int err = 0;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct device_node *fw_node;
> +	struct rpi_firmware *fw;
> +	struct brcmexp_gpio *ucb;
> +
> +	fw_node = of_parse_phandle(np, "firmware", 0);
> +	if (!fw_node) {
> +		dev_err(dev, "Missing firmware node\n");
> +		return -ENOENT;
> +	}
> +
> +	fw = rpi_firmware_get(fw_node);
> +	if (!fw)
> +		return -EPROBE_DEFER;
> +
> +	ucb = devm_kzalloc(dev, sizeof(*ucb), GFP_KERNEL);
> +	if (!ucb)
> +		return -EINVAL;
> +
> +	ucb->fw = fw;
> +	ucb->dev = dev;
> +	ucb->gc.label = MODULE_NAME;
> +	ucb->gc.owner = THIS_MODULE;
> +	ucb->gc.of_node = np;
> +	ucb->gc.base = 128;

As said above this should be -1

Stefan
