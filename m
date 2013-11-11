From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 11 Nov 2013 11:18:55 +0100
Subject: [PATCH v3 1/4] reset: Add Allwinner SoCs Reset Controller Driver
In-Reply-To: <1382707365-4776-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1382707365-4776-1-git-send-email-maxime.ripard@free-electrons.com>
 <1382707365-4776-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1384165135.5191.5.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Am Freitag, den 25.10.2013, 14:22 +0100 schrieb Maxime Ripard:
> The Allwinner A31 and most of the other Allwinner SoCs have an IP
> maintaining a few other IPs in the SoC in reset by default. Among these
> IPs are the A31's High Speed Timers, hence why we can't use the regular
> driver construct in every cases, and need to call the registering
> function directly during machine initialisation.
> 
> Apart from this, the implementation is fairly straightforward, and could
> easily be moved to a generic MMIO-based reset controller driver if the
> need ever arise.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/reset/Makefile      |   1 +
>  drivers/reset/reset-sunxi.c | 156 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 157 insertions(+)
>  create mode 100644 drivers/reset/reset-sunxi.c
> 
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 1e2d83f..cc29832 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_RESET_CONTROLLER) += core.o
> +obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
> diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
> new file mode 100644
> index 0000000..5bbd59a
> --- /dev/null
> +++ b/drivers/reset/reset-sunxi.c
> @@ -0,0 +1,156 @@
> +/*
> + * Allwinner SoCs Reset Controller driver
> + *
> + * Copyright 2013 Maxime Ripard
> + *
> + * Maxime Ripard <maxime.ripard@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +struct sunxi_reset_data {
> +	void __iomem				*membase;
> +	struct reset_controller_dev		rcdev;
> +};
> +
> +static int sunxi_reset_assert(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	struct sunxi_reset_data *data = container_of(rcdev,
> +						     struct sunxi_reset_data,
> +						     rcdev);
> +	int bank = id / BITS_PER_LONG;
> +	int offset = id % BITS_PER_LONG;
> +	u32 reg = readl(data->membase + (bank * 4));
> +
> +	writel(reg & ~BIT(offset), data->membase + (bank * 4));

the reset core just passes through calls to reset_controller_assert
directly, ...

> +
> +	return 0;
> +}
> +
> +static int sunxi_reset_deassert(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	struct sunxi_reset_data *data = container_of(rcdev,
> +						     struct sunxi_reset_data,
> +						     rcdev);
> +	int bank = id / BITS_PER_LONG;
> +	int offset = id % BITS_PER_LONG;
> +	u32 reg = readl(data->membase + (bank * 4));
> +
> +	writel(reg | BIT(offset), data->membase + (bank * 4));

... so those read-modify-write cycles in sunxi_reset_assert and here
should be protected with a lock.

> +	return 0;
> +}
> +
> +static struct reset_control_ops sunxi_reset_ops = {
> +	.assert		= sunxi_reset_assert,
> +	.deassert	= sunxi_reset_deassert,
> +};
> +
> +static int sunxi_reset_init(struct device_node *np)
> +{
> +	struct sunxi_reset_data *data;
> +	struct resource res;
> +	resource_size_t size;
> +	int ret;
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	ret = of_address_to_resource(np, 0, &res);
> +	if (ret)
> +		goto err_alloc;
> +
> +	size = resource_size(&res);
> +	data->membase = ioremap(res.start, size);
> +	if (!data->membase) {
> +		ret = -ENOMEM;
> +		goto err_alloc;
> +	}
> +
> +	data->rcdev.owner = THIS_MODULE;
> +	data->rcdev.nr_resets = size * 32;
> +	data->rcdev.ops = &sunxi_reset_ops;
> +	data->rcdev.of_node = np;
> +	reset_controller_register(&data->rcdev);
> +
> +	return 0;
> +
> +err_alloc:
> +	kfree(data);
> +	return ret;
> +};
> +
> +/*
> + * These are the reset controller we need to initialize early on in
> + * our system, before we can even think of using a regular device
> + * driver for it.
> + */
> +static const struct of_device_id sunxi_early_reset_dt_ids[] __initdata = {
> +	{ .compatible = "allwinner,sun6i-a31-ahb1-reset", },
> +	{ /* sentinel */ },
> +};
> +
> +void __init sun6i_reset_init(void)
> +{
> +	struct device_node *np;
> +
> +	for_each_matching_node(np, sunxi_early_reset_dt_ids)
> +		sunxi_reset_init(np);
> +}
> +
> +/*
> + * And these are the controllers we can register through the regular
> + * device model.
> + */
> +static const struct of_device_id sunxi_reset_dt_ids[] = {
> +	 { .compatible = "allwinner,sun4i-clock-reset", },
> +	 { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, sunxi_reset_dt_ids);
> +
> +static int sunxi_reset_probe(struct platform_device *pdev)
> +{
> +	return sunxi_reset_init(pdev->dev.of_node);
> +}
> +
> +static int sunxi_reset_remove(struct platform_device *pdev)
> +{
> +	struct sunxi_reset_data *data = platform_get_drvdata(pdev);
> +
> +	reset_controller_unregister(&data->rcdev);
> +	iounmap(data->membase);
> +	kfree(data);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sunxi_reset_driver = {
> +	.probe	= sunxi_reset_probe,
> +	.remove	= sunxi_reset_remove,
> +	.driver = {
> +		.name		= "sunxi-reset",
> +		.owner		= THIS_MODULE,
> +		.of_match_table	= sunxi_reset_dt_ids,
> +	},
> +};
> +module_platform_driver(sunxi_reset_driver);
> +
> +MODULE_AUTHOR("Maxime Ripard <maxime.ripard@free-electrons.com");
> +MODULE_DESCRIPTION("Allwinner SoCs Reset Controller Driver");
> +MODULE_LICENSE("GPL");

regards
Philipp
