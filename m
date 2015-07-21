From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 21 Jul 2015 12:10:06 -0700
Subject: [PATCH 3/4] clk: 88pm800: Add clk provider driver for 88pm800
 family of devices
In-Reply-To: <1437476823-3358-4-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437476823-3358-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437476823-3358-4-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <55AE990E.2040004@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2015 04:07 AM, Vaibhav Hiremath wrote:
> diff --git a/drivers/clk/clk-88pm800.c b/drivers/clk/clk-88pm800.c
> new file mode 100644
> index 0000000..cf1c162
> --- /dev/null
> +++ b/drivers/clk/clk-88pm800.c
> @@ -0,0 +1,345 @@
> +/*
> + * clk-88pm800.c - Clock driver for 88PM800 family of devices
> + *
> + * This driver is created based on clk-s2mps11.c
> + *
> + * Copyright (C) 2015 Linaro Ltd.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/clkdev.h>
> +#include <linux/regmap.h>
> +#include <linux/clk-provider.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/88pm80x.h>
> +
> +/* Number of clocks output from 88pm800 family of device */
> +enum {
> +	PM800_CLK32K_1 = 0,
> +	PM800_CLK32K_2,
> +	PM800_CLK32K_3,
> +	PM800_CLKS_NUM,
> +};
> +
> +struct pm800_clk {
> +	struct pm80x_chip *chip;
> +	struct device_node *clk_np;
> +	struct clk_hw hw;
> +	struct clk *clk;
> +	struct clk_lookup *lookup;
> +	u32 mask;
> +	u32 shift;
> +	unsigned int reg;
> +};
> +
> +static struct pm800_clk *to_pm800_clk(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct pm800_clk, hw);
> +}
> +
> +static int pm800_clk_prepare(struct clk_hw *hw)
> +{
> +	struct pm800_clk *pm800 = to_pm800_clk(hw);
> +	int ret;
> +
> +	/* We always want to use XO clock */
> +	ret = regmap_update_bits(pm800->chip->regmap,
> +				 pm800->reg,
> +				 pm800->mask,
> +				 PM800_32K_OUTX_SEL_XO_32KHZ << pm800->shift);
> +
> +	return ret;

Can be simplified to:

     return regmap_update_bits()

> +}
> +
> +static void pm800_clk_unprepare(struct clk_hw *hw)
> +{
> +	struct pm800_clk *pm800 = to_pm800_clk(hw);
> +	int ret;
> +
> +	ret = regmap_update_bits(pm800->chip->regmap, pm800->reg,
> +				pm800->mask, ~pm800->mask);

Why have ret at all in a void function?

> +}
> +
> +static int pm800_clk_is_prepared(struct clk_hw *hw)
> +{
> +	int ret;
> +	u32 val;
> +	struct pm800_clk *pm800 = to_pm800_clk(hw);
> +
> +	ret = regmap_read(pm800->chip->regmap,
> +				pm800->reg, &val);
> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	return ((val & pm800->mask) >> pm800->shift);

One too many parentheses here.

> +}
> +
> +static unsigned long pm800_clk_recalc_rate(struct clk_hw *hw,
> +					     unsigned long parent_rate)
> +{
> +	return 32768;
> +}
> +
> +static struct clk_ops pm800_clk_ops = {

const?

> +	.prepare	= pm800_clk_prepare,
> +	.unprepare	= pm800_clk_unprepare,
> +	.is_prepared	= pm800_clk_is_prepared,
> +	.recalc_rate	= pm800_clk_recalc_rate,
> +};
> +
> +static struct clk_init_data pm800_clks_init[PM800_CLKS_NUM] = {
> +	[PM800_CLK32K_1] = {
> +		.name	= "pm800_clk32k_1",
> +		.ops	= &pm800_clk_ops,
> +		.flags	= CLK_IS_ROOT,
> +	},
> +	[PM800_CLK32K_2] = {
> +		.name	= "pm800_clk32k_2",
> +		.ops	= &pm800_clk_ops,
> +		.flags	= CLK_IS_ROOT,
> +	},
> +	[PM800_CLK32K_3] = {
> +		.name	= "pm800_clk32k_3",
> +		.ops	= &pm800_clk_ops,
> +		.flags	= CLK_IS_ROOT,
> +	},
> +};
> +
> +static struct clk_init_data pm860_clks_init[PM800_CLKS_NUM] = {
> +	[PM800_CLK32K_1] = {
> +		.name	= "pm800_clk32k_1",
> +		.ops	= &pm800_clk_ops,
> +		.flags	= CLK_IS_ROOT,
> +	},
> +	[PM800_CLK32K_2] = {
> +		.name	= "pm800_clk32k_2",
> +		.ops	= &pm800_clk_ops,
> +		.flags	= CLK_IS_ROOT,
> +	},
> +};
> +
> +static int pm800_init_clk(struct pm800_clk *pm800_clks)
> +{
> +
> +	int ret;
> +
> +	/* Enable XO_LJ : Low jitter clock of 32KHz from XO */
> +	ret = regmap_update_bits(pm800_clks->chip->regmap, PM800_LOW_POWER2,
> +			PM800_LOW_POWER2_XO_LJ_EN, PM800_LOW_POWER2_XO_LJ_EN);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable USE_XO : Use XO clock for all internal timing reference */
> +	ret = regmap_update_bits(pm800_clks->chip->regmap, PM800_RTC_CONTROL,
> +			PM800_RTC1_USE_XO, PM800_RTC1_USE_XO);
> +	if (ret)
> +		return ret;
> +
> +	/* OSC_FREERUN: Enable Osc free running mode by clearing the bit */
> +	ret = regmap_update_bits(pm800_clks->chip->regmap, PM800_OSC_CNTRL1,
> +			PM800_OSC_CNTRL1_OSC_FREERUN_EN, 0);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct device_node *pm800_clk_parse_dt(struct platform_device *pdev,
> +		struct clk_init_data *clks_init)
> +{
> +	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
> +	struct device_node *clk_np;
> +	int i;
> +
> +	if (!chip->dev->of_node)
> +		return ERR_PTR(-EINVAL);
> +
> +	clk_np = of_get_child_by_name(chip->dev->of_node, "clocks");
> +	if (!clk_np) {
> +		dev_err(&pdev->dev, "could not find clock sub-node\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	for (i = 0; i < PM800_CLKS_NUM; i++) {
> +		if (!clks_init[i].name)
> +			continue; /* Skip clocks not present in some devices */
> +
> +		of_property_read_string_index(clk_np, "clock-output-names", i,
> +				&clks_init[i].name);
> +	}
> +
> +	return clk_np;
> +}
> +
> +static int pm800_clk_probe(struct platform_device *pdev)
> +{
> +	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
> +	struct pm800_clk *pm800_clks;
> +	struct clk_init_data *clks_init;
> +	static struct clk **clk_table;
> +	static struct clk_onecell_data *of_clk_data;
> +	int i, ret = 0;

Drop assignment to ret please.

> +
> +	pm800_clks = devm_kzalloc(&pdev->dev,
> +				sizeof(*pm800_clks) * PM800_CLKS_NUM,
> +				GFP_KERNEL);

devm_kcalloc()

> +	if (!pm800_clks)
> +		return -ENOMEM;
> +
> +	clk_table = devm_kzalloc(&pdev->dev,
> +				sizeof(struct clk *) * PM800_CLKS_NUM,
> +				GFP_KERNEL);

devm_kcalloc()

> +	if (!clk_table)
> +		return -ENOMEM;
> +
> +	switch (platform_get_device_id(pdev)->driver_data) {
> +	case CHIP_PM800:
> +		clks_init = pm800_clks_init;
> +		break;
> +	case CHIP_PM860:
> +		clks_init = pm860_clks_init;
> +		break;
> +	default:
> +		dev_err(&pdev->dev, "Invalid device type\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Store clocks of_node in first element of pm800_clks array */
> +	pm800_clks->clk_np = pm800_clk_parse_dt(pdev, clks_init);
> +	if (IS_ERR(pm800_clks->clk_np))
> +		return PTR_ERR(pm800_clks->clk_np);
> +
> +	of_clk_data = devm_kzalloc(&pdev->dev,
> +				sizeof(*of_clk_data),
> +				GFP_KERNEL);
> +	if (!of_clk_data)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < PM800_CLKS_NUM; i++) {
> +		if (!clks_init[i].name)
> +			continue; /* Skip clocks not present in some devices */
> +
> +		pm800_clks[i].chip = chip;
> +		pm800_clks[i].hw.init = &clks_init[i];
> +		/*
> +		 * As of now, mask and shift formula below works for both
> +		 * 88PM800 and it's family of devices,
> +		 *
> +		 *  PM800_RTC_MISC2:
> +		 *      1:0	= CK_32K_OUT1_SEL
> +		 *      3:2	= CK_32K_OUT2_SEL
> +		 *      5:4	= CK_32K_OUT3_SEL
> +		 */
> +		pm800_clks[i].shift = (i * 2);

Drop parentheses please.

> +		pm800_clks[i].mask = PM800_32K_OUTX_SEL_MASK << pm800_clks[i].shift;
> +		pm800_clks[i].reg = PM800_RTC_MISC2;
> +
> +		pm800_clks[i].clk = devm_clk_register(&pdev->dev,
> +							&pm800_clks[i].hw);
> +		if (IS_ERR(pm800_clks[i].clk)) {
> +			dev_err(&pdev->dev, "Fail to register : %s\n",
> +						clks_init[i].name);
> +			ret = PTR_ERR(pm800_clks[i].clk);
> +			goto err;
> +		}
> +
> +		pm800_clks[i].lookup = clkdev_create(pm800_clks[i].clk,
> +					clks_init[i].name, NULL);
> +		if (!pm800_clks[i].lookup) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		clk_table[i] = pm800_clks[i].clk;
> +	}
> +
> +	of_clk_data->clks = clk_table;
> +	of_clk_data->clk_num = PM800_CLKS_NUM;
> +	ret = of_clk_add_provider(pm800_clks->clk_np, of_clk_src_onecell_get,
> +			of_clk_data);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Fail to add OF clk provider : %d\n", ret);
> +		goto err;
> +	}
> +
> +	/* Common for all 32KHz clock output */
> +	ret = pm800_init_clk(&pm800_clks[0]);

Shouldn't we do this before registering the clocks with the framework?

> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to initialize clk : %d\n", ret);
> +		goto err;
> +	}
> +
> +	platform_set_drvdata(pdev, pm800_clks);
> +
> +	return 0;
> +
> +err:
> +	for (i = 0; i < PM800_CLKS_NUM; i++) {
> +		if (pm800_clks[i].lookup)
> +			clkdev_drop(pm800_clks[i].lookup);
> +	}
> +
> +	return ret;
> +}
> +
> +static int pm800_clk_remove(struct platform_device *pdev)
> +{
> +	struct pm800_clk *pm800_clks = platform_get_drvdata(pdev);
> +	int i;
> +
> +	of_clk_del_provider(pm800_clks[0].clk_np);
> +	/* Drop the reference obtained in pm800_clk_parse_dt */
> +	of_node_put(pm800_clks[0].clk_np);

This is odd. Why are we keeping the reference in the driver?

> +
> +	for (i = 0; i < PM800_CLKS_NUM; i++) {
> +		if (pm800_clks[i].lookup)
> +			clkdev_drop(pm800_clks[i].lookup);
> +	}
> +
> +	return 0;
> +}
> +
> [..]
> +
> +static int __init pm800_clk_init(void)
> +{
> +	return platform_driver_register(&pm800_clk_driver);
> +}
> +subsys_initcall(pm800_clk_init);
> +
> +static void __init pm800_clk_cleanup(void)

s/__init/__exit/

> +{
> +	platform_driver_unregister(&pm800_clk_driver);
> +}
> +module_exit(pm800_clk_cleanup);
> +
> +MODULE_DESCRIPTION("88PM800 Clock Driver");
> +MODULE_AUTHOR("Vaibhav Hiremath <vaibhav.hiremath@linaro.org>");
> +MODULE_LICENSE("GPL");


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
