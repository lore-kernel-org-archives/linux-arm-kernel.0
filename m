From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 30 Oct 2014 10:23:05 +0100
Subject: [PATCH 1/3] ARM: mediatek: Add Reset Controller for MediaTek SoC
In-Reply-To: <1414638733-10080-2-git-send-email-flora.fu@mediatek.com>
References: <1414638733-10080-1-git-send-email-flora.fu@mediatek.com>
 <1414638733-10080-2-git-send-email-flora.fu@mediatek.com>
Message-ID: <1414660985.3069.6.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Flora,

apart from the question about whether the regmap should be looked up by
phandle or from the parent device if we can put reset nodes as children
of the syscon nodes, I have two small nitpicks below.

Am Donnerstag, den 30.10.2014, 11:12 +0800 schrieb
flora.fu at mediatek.com:
> From: Flora Fu <flora.fu@mediatek.com>
> 
> Add a driver in reset controller.
> 
> Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> ---
>  drivers/reset/Makefile    |   1 +
>  drivers/reset/reset-mtk.c | 149 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 150 insertions(+)
>  create mode 100644 drivers/reset/reset-mtk.c
> 
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index 60fed3d..adcebdf 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -2,3 +2,4 @@ obj-$(CONFIG_RESET_CONTROLLER) += core.o
>  obj-$(CONFIG_ARCH_SOCFPGA) += reset-socfpga.o
>  obj-$(CONFIG_ARCH_SUNXI) += reset-sunxi.o
>  obj-$(CONFIG_ARCH_STI) += sti/
> +obj-$(CONFIG_ARCH_MEDIATEK) += reset-mtk.o
> diff --git a/drivers/reset/reset-mtk.c b/drivers/reset/reset-mtk.c
> new file mode 100644
> index 0000000..e2211f7
> --- /dev/null
> +++ b/drivers/reset/reset-mtk.c
> @@ -0,0 +1,149 @@
> +/*
> + * Copyright (c) 2014 MediaTek Inc.
> + * Author: Flora.Fu <flora.fu@mediatek.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/reset-controller.h>
> +#include <linux/slab.h>

Do you need to include <linux/slab.h>?

> +struct mt_reset_data {
> +	struct regmap *regmap;
> +	unsigned int resetbase;
> +	unsigned int size;
> +	struct reset_controller_dev rcdev;
> +};
> +
> +static int mt_reset_assert(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	struct regmap *regmap;
> +	unsigned addr;
> +	unsigned mask;
> +	struct mt_reset_data *data = container_of(rcdev,
> +						     struct mt_reset_data,
> +						     rcdev);
> +	regmap = data->regmap;
> +	addr = data->resetbase + ((id / 32) << 2);
> +	mask = BIT(id % 32);
> +
> +	return regmap_update_bits(regmap, addr, mask, mask);
> +}
> +
> +static int mt_reset_deassert(struct reset_controller_dev *rcdev,
> +				unsigned long id)
> +{
> +	struct regmap *regmap;
> +	unsigned addr;
> +	unsigned mask;
> +	struct mt_reset_data *data = container_of(rcdev,
> +						     struct mt_reset_data,
> +						     rcdev);
> +
> +	regmap = data->regmap;
> +	addr = data->resetbase + ((id / 32) << 2);
> +	mask = BIT(id % 32);
> +
> +	return regmap_update_bits(regmap, addr, mask, ~mask);
> +}
> +
> +static struct reset_control_ops mt_reset_ops = {
> +	.assert = mt_reset_assert,
> +	.deassert = mt_reset_deassert,
> +};
> +
> +static int mt_reset_probe(struct platform_device *pdev)
> +{
> +	struct mt_reset_data *data;
> +	struct device_node *np = pdev->dev.of_node;
> +	unsigned int resetbase;
> +	unsigned int width;
> +	int ret;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->regmap = syscon_regmap_lookup_by_phandle(np,
> +		"mediatek,syscon-reset");
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(&pdev->dev, "couldn't get syscon-reset regmap\n");
> +		return PTR_ERR(data->regmap);
> +	}
> +
> +	ret = of_property_read_u32_index(np, "mediatek,syscon-reset", 1,
> +		&resetbase);
> +	if (ret) {
> +		dev_err(&pdev->dev, "couldn't read reset base from syscon!\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = of_property_read_u32_index(np, "mediatek,syscon-reset", 2,
> +		&width);
> +	if (ret) {
> +		dev_err(&pdev->dev, "couldn't read reset bytes from syscon!\n");
> +		return -EINVAL;
> +	}
> +
> +	data->resetbase = resetbase;
> +	data->size = width >> 2;

It is common to measure size of a resource in bytes, so maybe it would
be easier to understand if you renamed width to size and renamed
data->size to something like data->num_regs.

> +	data->rcdev.owner = THIS_MODULE;
> +	data->rcdev.nr_resets = data->size * 32;
> +	data->rcdev.ops = &mt_reset_ops;
> +	data->rcdev.of_node = pdev->dev.of_node;
> +
> +	return reset_controller_register(&data->rcdev);
> +}
> +
> +static int mt_reset_remove(struct platform_device *pdev)
> +{
> +	struct mt_reset_data *data = platform_get_drvdata(pdev);
> +
> +	reset_controller_unregister(&data->rcdev);
> +	return 0;
> +}
> +
> +static const struct of_device_id mt_reset_dt_ids[] = {
> +	{ .compatible = "mediatek,reset", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mt_reset_dt_ids);
> +
> +static struct platform_driver mt_reset_driver = {
> +	.probe = mt_reset_probe,
> +	.remove = mt_reset_remove,
> +	.driver = {
> +		.name = "mtk-reset",
> +		.owner = THIS_MODULE,
> +		.of_match_table = mt_reset_dt_ids,
> +	},
> +};
> +
> +static int __init mt_reset_init(void)
> +{
> +	return platform_driver_register(&mt_reset_driver);
> +}
> +module_init(mt_reset_init);
> +
> +static void __exit mt_reset_exit(void)
> +{
> +	platform_driver_unregister(&mt_reset_driver);
> +}
> +module_exit(mt_reset_exit);

You can use the module_platform_driver(mt_reset_driver); macro here.

> +MODULE_AUTHOR("Flora Fu <flora.fu@mediatek.com>");
> +MODULE_DESCRIPTION("MediaTek SoC Generic Reset Controller");
> +MODULE_LICENSE("GPL");

regards
Philipp
