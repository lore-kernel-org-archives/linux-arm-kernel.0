From: matt.porter@linaro.org (Matt Porter)
Date: Fri, 6 Sep 2013 13:14:01 -0400
Subject: [PATCH v7 1/3] gpio: bcm281xx: Add GPIO driver
In-Reply-To: <1377882914-30152-2-git-send-email-markus.mayer@linaro.org>
References: <1377882914-30152-1-git-send-email-markus.mayer@linaro.org>
 <1377882914-30152-2-git-send-email-markus.mayer@linaro.org>
Message-ID: <20130906171400.GC10973@ohporter.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 30, 2013 at 10:15:12AM -0700, Markus Mayer wrote:

<snip>

> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index ef3e983..fcd0751 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_GPIO_ADP5520)	+= gpio-adp5520.o
>  obj-$(CONFIG_GPIO_ADP5588)	+= gpio-adp5588.o
>  obj-$(CONFIG_GPIO_AMD8111)	+= gpio-amd8111.o
>  obj-$(CONFIG_GPIO_ARIZONA)	+= gpio-arizona.o
> +obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
>  obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
>  obj-$(CONFIG_GPIO_CLPS711X)	+= gpio-clps711x.o
>  obj-$(CONFIG_GPIO_CS5535)	+= gpio-cs5535.o
> diff --git a/drivers/gpio/gpio-bcm-kona.c b/drivers/gpio/gpio-bcm-kona.c
> new file mode 100644
> index 0000000..f0f7a96
> --- /dev/null
> +++ b/drivers/gpio/gpio-bcm-kona.c
> @@ -0,0 +1,631 @@
> +/*
> + * Copyright (C) 2012-2013 Broadcom Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/bitops.h>

Need #include <linux/err.h>

> +#include <linux/io.h>
> +#include <linux/gpio.h>
> +#include <linux/of_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/module.h>
> +#include <linux/irqdomain.h>
> +#include <linux/irqchip/chained_irq.h>

<snip>

> +	kona_gpio->irq_domain = irq_domain_add_linear(dev->of_node,
> +						      chip->ngpio,
> +						      &bcm_kona_irq_ops,
> +						      kona_gpio);
> +	if (!kona_gpio->irq_domain) {
> +		dev_err(dev, "Couldn't allocate IRQ domain\n");
> +		return -ENXIO;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	kona_gpio->reg_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(kona_gpio->reg_base)) {

gpio-bcm-kona.c:568:2: error: implicit declaration of function ?IS_ERR?

-Matt
