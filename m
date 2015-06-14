From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 14 Jun 2015 16:27:10 +0100
Subject: [PATCH v5 08/17] gpio: port LoCoMo gpio support from old driver
In-Reply-To: <1433797008-6246-9-git-send-email-dbaryshkov@gmail.com>
References: <1433797008-6246-1-git-send-email-dbaryshkov@gmail.com>
 <1433797008-6246-9-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20150614152710.GG7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 08, 2015 at 11:56:39PM +0300, Dmitry Eremin-Solenikov wrote:
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index f71bb97..98655ae 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
>  obj-$(CONFIG_GPIO_KEMPLD)	+= gpio-kempld.o
>  obj-$(CONFIG_ARCH_KS8695)	+= gpio-ks8695.o
>  obj-$(CONFIG_GPIO_INTEL_MID)	+= gpio-intel-mid.o
> +obj-$(CONFIG_GPIO_LOCOMO)	+= gpio-locomo.o
>  obj-$(CONFIG_GPIO_LOONGSON)	+= gpio-loongson.o
>  obj-$(CONFIG_GPIO_LP3943)	+= gpio-lp3943.o
>  obj-$(CONFIG_ARCH_LPC32XX)	+= gpio-lpc32xx.o
> diff --git a/drivers/gpio/gpio-locomo.c b/drivers/gpio/gpio-locomo.c
> new file mode 100644
> index 0000000..dd9a1ca
> --- /dev/null
> +++ b/drivers/gpio/gpio-locomo.c
> @@ -0,0 +1,170 @@
> +/*
> + * Sharp LoCoMo support for GPIO
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This file contains all generic LoCoMo support.
> + *
> + * All initialization functions provided here are intended to be called
> + * from machine specific code with proper arguments when required.
> + */
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/bitops.h>
> +#include <linux/err.h>
> +#include <linux/gpio.h>
> +#include <linux/io.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/locomo.h>
> +
> +struct locomo_gpio {
> +	struct regmap *regmap;
> +
> +	struct gpio_chip gpio;
> +
> +	u16 rising_edge;
> +	u16 falling_edge;
> +
> +	unsigned int save_gpo;
> +	unsigned int save_gpe;
> +};
> +
> +static int locomo_gpio_get(struct gpio_chip *chip,
> +		unsigned offset)
> +{
> +	struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
> +	unsigned int gpl;
> +
> +	regmap_read(lg->regmap, LOCOMO_GPL, &gpl);
> +
> +	return gpl & BIT(offset);

Aren't gpio_get() functions supposed to return a 0/1 status, not a 0/BIT(n)
status?

> +#ifdef CONFIG_PM_SLEEP
> +static int locomo_gpio_suspend(struct device *dev)
> +{
> +	struct locomo_gpio *lg = dev_get_drvdata(dev);
> +
> +	regmap_read(lg->regmap, LOCOMO_GPO, &lg->save_gpo);
> +	regmap_write(lg->regmap, LOCOMO_GPO, 0x00);
> +	regmap_read(lg->regmap, LOCOMO_GPE, &lg->save_gpe);
> +	regmap_write(lg->regmap, LOCOMO_GPE, 0x00);

Are you sure this is correct?  If there are any output signals which
are pulled up, this will make them glitch as you seem to first write
zero to the output register (which will pull anything that is configured
as an output low), and then program all lines as inputs.  I haven't
checked what the existing code does though...

> +static int locomo_gpio_probe(struct platform_device *pdev)
> +{
> +	struct locomo_gpio *lg;
> +	int ret;
> +	struct locomo_gpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
> +
> +	lg = devm_kzalloc(&pdev->dev, sizeof(struct locomo_gpio),
> +			GFP_KERNEL);
> +	if (!lg)
> +		return -ENOMEM;
> +
> +	lg->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!lg->regmap)
> +		return -EINVAL;
> +
> +	platform_set_drvdata(pdev, lg);
> +
> +	regmap_write(lg->regmap, LOCOMO_GPO, 0x00);
> +	regmap_write(lg->regmap, LOCOMO_GPE, 0x00);
> +	regmap_write(lg->regmap, LOCOMO_GPD, 0x00);
> +	regmap_write(lg->regmap, LOCOMO_GIE, 0x00);

Do we really want to initialise all outputs like this?  It suffers from
the problem I mention above - it sets all outputs to zero, then sets
them as inputs, which can lead to glitching.  What if (eg) the LCD was
left enabled?  This would mean you're not going through the proper
power-down sequence for the LCD (for example).

TBH, I think GPIO needs to have a way to claim output GPIOs _without_
programming their current state for situations like this.  That seems
to have been an oversight in the model for a while now - it's impossible
to claim GPIO outputs without setting their initial value, and it may
be important in case you don't know whether the attached LCD is enabled
or disabled, and the attached LCD may require a specific sequence of
power removal manipulated by GPIOs.  I think this is something for the
GPIO people to think about rather than you though...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
