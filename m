From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 03 Mar 2016 15:18:29 +0100
Subject: [PATCH 06/17] reset: Add PLX Technology Reset Controller driver
In-Reply-To: <1457005210-18485-7-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457005210-18485-7-git-send-email-narmstrong@baylibre.com>
Message-ID: <1457014709.3425.53.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

Am Donnerstag, den 03.03.2016, 12:39 +0100 schrieb Neil Armstrong:
> Add System reset controller driver for PLX Technology OXNAS SoC Family.
> 
> CC: Ma Haijun <mahaijuns@gmail.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/reset/Kconfig       |   4 ++
>  drivers/reset/Makefile      |   1 +
>  drivers/reset/reset-oxnas.c | 149 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 154 insertions(+)
>  create mode 100644 drivers/reset/reset-oxnas.c
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index df37212..f0ea63b 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -12,5 +12,9 @@ menuconfig RESET_CONTROLLER
>  
>  	  If unsure, say no.
>  
> +config RESET_OXNAS
> +	bool
> +	select MFD_SYSCON

I'd prefer not to select MFD_SYSCON here, but rather let ARCH_OXNAS do
that.

>  source "drivers/reset/sti/Kconfig"
>  source "drivers/reset/hisilicon/Kconfig"
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 4d7178e..97e04c5 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -7,3 +7,4 @@ obj-$(CONFIG_ARCH_STI) += sti/
>  obj-$(CONFIG_ARCH_HISI) += hisilicon/
>  obj-$(CONFIG_ARCH_ZYNQ) += reset-zynq.o
>  obj-$(CONFIG_ATH79) += reset-ath79.o
> +obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
> diff --git a/drivers/reset/reset-oxnas.c b/drivers/reset/reset-oxnas.c
> new file mode 100644
> index 0000000..d0ab670
> --- /dev/null
> +++ b/drivers/reset/reset-oxnas.c
> @@ -0,0 +1,149 @@
> +/*
> + * drivers/reset/reset-oxnas.c
> + *
> + * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
> + * Copyright (C) 2014 Ma Haijun <mahaijuns@gmail.com>
> + * Copyright (C) 2009 Oxford Semiconductor Ltd
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms and conditions of the GNU General Public License,
> + * version 2, as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope it will be useful, but WITHOUT
> + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
> + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
> + * more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <linux/err.h>
> +#include <linux/io.h>

Is there any need to include linux/io.h ?

> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/types.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>
> +
> +/* Regmap offsets */
> +#define RST_SET_REGOFFSET	0x34
> +#define RST_CLR_REGOFFSET	0x38
> +
> +struct oxnas_reset {
> +	struct regmap *regmap;
> +	struct reset_controller_dev rcdev;
> +};
> +
> +static int oxnas_reset_reset(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	struct oxnas_reset *data =
> +		container_of(rcdev, struct oxnas_reset, rcdev);
> +
> +	regmap_write(data->regmap, RST_SET_REGOFFSET, BIT(id));
> +	msleep(50);

Is this the right delay for all of the resets in this register?
If not, I'd drop the .reset callback.

> +	regmap_write(data->regmap, RST_CLR_REGOFFSET, BIT(id));
> +
> +	return 0;
> +}
> +
> +static int oxnas_reset_assert(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	struct oxnas_reset *data =
> +		container_of(rcdev, struct oxnas_reset, rcdev);
> +
> +	regmap_write(data->regmap, RST_SET_REGOFFSET, BIT(id));
> +
> +	return 0;
> +}
> +
> +static int oxnas_reset_deassert(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	struct oxnas_reset *data =
> +		container_of(rcdev, struct oxnas_reset, rcdev);
> +
> +	regmap_write(data->regmap, RST_CLR_REGOFFSET, BIT(id));
> +
> +	return 0;
> +}
> +
> +static struct reset_control_ops oxnas_reset_ops = {

const

> +	.reset		= oxnas_reset_reset,
> +	.assert		= oxnas_reset_assert,
> +	.deassert	= oxnas_reset_deassert,
> +};
> +
> +static const struct of_device_id oxnas_reset_dt_ids[] = {
> +	 { .compatible = "plxtech,nas782x-reset", },
> +	 { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, oxnas_reset_dt_ids);
> +
> +static int oxnas_reset_probe(struct platform_device *pdev)
> +{
> +	struct oxnas_reset *data;
> +	struct device *parent;
> +
> +	parent = pdev->dev.parent;
> +	if (!parent) {
> +		dev_err(&pdev->dev, "no parent\n");

Can this even happen?

> +		return -ENODEV;
> +	}
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->regmap = syscon_node_to_regmap(parent->of_node);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(&pdev->dev, "failed to get parent regmap\n");
> +		return -ENODEV;

Better print the error code and return it.

> +	}
> +
> +	data->rcdev.owner = THIS_MODULE;
> +	data->rcdev.nr_resets = 32;
> +	data->rcdev.ops = &oxnas_reset_ops;
> +	data->rcdev.of_node = pdev->dev.of_node;
> +	reset_controller_register(&data->rcdev);

Move this down a bit:

> +
> +	platform_set_drvdata(pdev, data);
> +
> +	return 0;

and
	return reset_controller_register(&data->rcdev);
here.

> +}
> +
> +static int oxnas_reset_remove(struct platform_device *pdev)
> +{
> +	struct oxnas_reset *data = platform_get_drvdata(pdev);
> +
> +	reset_controller_unregister(&data->rcdev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver oxnas_reset_driver = {
> +	.probe	= oxnas_reset_probe,
> +	.remove	= oxnas_reset_remove,
> +	.driver = {
> +		.name		= "oxnas-reset",
> +		.owner		= THIS_MODULE,

The .owner field is overwritten by __platform_driver_register() anyway,
just drop it.

> +		.of_match_table	= oxnas_reset_dt_ids,
> +	},
> +};
> +
> +static int __init oxnas_reset_init(void)
> +{
> +	return platform_driver_probe(&oxnas_reset_driver,
> +				     oxnas_reset_probe);
> +}
> +
> +/*
> + * Reset controller does not support probe deferral, so it has to be
> + * initialized before any user, in particular, PCIE uses subsys_initcall.
> + */
> +arch_initcall(oxnas_reset_init);

That doesn't sound right. (of_)reset_control_get return -EPROBE_DEFER if
the rcdev isn't found in the list. Could you elaborate on this?

regards
Philipp
