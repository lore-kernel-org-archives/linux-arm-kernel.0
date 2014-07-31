From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 31 Jul 2014 15:26:59 +0300
Subject: [PATCH 2/2] clk: initial clock driver for TWL6030
In-Reply-To: <1406728949-7560-3-git-send-email-sassmann@kpanic.de>
References: <1406728949-7560-1-git-send-email-sassmann@kpanic.de>
 <1406728949-7560-3-git-send-email-sassmann@kpanic.de>
Message-ID: <53DA3613.9010305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/2014 05:02 PM, Stefan Assmann wrote:
> Adding a clock driver for the TI TWL6030. The driver prepares the
> CLK32KG clock, which is required for the wireless LAN.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  .../devicetree/bindings/clock/ti/twl6030.txt       |   4 +
>  drivers/clk/Kconfig                                |   7 +
>  drivers/clk/ti/Makefile                            |   1 +
>  drivers/clk/ti/clk-6030.c                          | 141 +++++++++++++++++++++
>  drivers/mfd/twl-core.c                             |   3 +
>  5 files changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/twl6030.txt
>  create mode 100644 drivers/clk/ti/clk-6030.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti/twl6030.txt b/Documentation/devicetree/bindings/clock/ti/twl6030.txt
> new file mode 100644
> index 0000000..d290ad4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti/twl6030.txt
> @@ -0,0 +1,4 @@
> +Binding for TI TWL6030.
> +
> +Required properties:
> +- compatible: "ti,twl6030-clk32kg"


This is not really helping out. Where would you put this compatible? How it is
related to twl6030?

> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 9f9c5ae..4e89e8b 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -65,6 +65,13 @@ config COMMON_CLK_S2MPS11
>  	  clock. These multi-function devices have two (S2MPS14) or three
>  	  (S2MPS11, S5M8767) fixed-rate oscillators, clocked at 32KHz each.
>  
> +config CLK_TWL6030
> +	tristate "Clock driver for twl6030"
> +	depends on TWL4030_CORE
> +	---help---
> +	  Enable the TWL6030 clock CLK32KG which is disabled by default.
> +	  Needed on the Pandaboard for the wireless LAN.

This is not relevant information. I'm sure the CLK32KG from twl6030 can be or
is used for other purposes on other boards.

> +
>  config CLK_TWL6040
>  	tristate "External McPDM functional clock from twl6040"
>  	depends on TWL6040_CORE
> diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
> index ed4d0aa..04f25ea 100644
> --- a/drivers/clk/ti/Makefile
> +++ b/drivers/clk/ti/Makefile
> @@ -10,4 +10,5 @@ obj-$(CONFIG_SOC_OMAP5)			+= $(clk-common) clk-54xx.o
>  obj-$(CONFIG_SOC_DRA7XX)		+= $(clk-common) clk-7xx.o \
>  					   clk-dra7-atl.o
>  obj-$(CONFIG_SOC_AM43XX)		+= $(clk-common) clk-43xx.o
> +obj-$(CONFIG_CLK_TWL6030)		+= $(clk-common) clk-6030.o
>  endif
> diff --git a/drivers/clk/ti/clk-6030.c b/drivers/clk/ti/clk-6030.c
> new file mode 100644
> index 0000000..baa965b
> --- /dev/null
> +++ b/drivers/clk/ti/clk-6030.c
> @@ -0,0 +1,141 @@
> +/*
> + * drivers/clk/ti/clk-6030.c
> + *
> + *  Copyright (C) 2014 Stefan Assmann <sassmann@kpanic.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Clock driver for ti twl6030.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk-provider.h>
> +#include <linux/i2c/twl.h>
> +#include <linux/platform_device.h>
> +
> +struct twl6030_desc {
> +	struct clk *clk;
> +	struct clk_hw hw;
> +	bool enabled;
> +};
> +
> +#define to_twl6030_desc(_hw) container_of(_hw, struct twl6030_desc, hw)
> +
> +static int twl6030_clk32kg_prepare(struct clk_hw *hw)
> +{
> +	struct twl6030_desc *desc = to_twl6030_desc(hw);
> +	int ret;
> +
> +	ret = twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER,
> +			       TWL6030_GRP_CON << TWL6030_CFG_STATE_GRP_SHIFT |
> +			       TWL6030_CFG_STATE_ON,
> +			       TWL6030_PM_RECEIVER_CLK32KG_CFG_STATE);

What is going to happen if someone ask for this clock before the twl-core is
initialized?


> +	if (ret == 0)
> +		desc->enabled = true;
> +
> +	return ret;
> +}
> +void twl6030_clk32kg_unprepare(struct clk_hw *hw)
> +{
> +	struct twl6030_desc *desc = to_twl6030_desc(hw);
> +
> +	twl_i2c_write_u8(TWL_MODULE_PM_RECEIVER,
> +			 TWL6030_GRP_CON << TWL6030_CFG_STATE_GRP_SHIFT |
> +			 TWL6030_CFG_STATE_OFF,
> +			 TWL6030_PM_RECEIVER_CLK32KG_CFG_STATE);
> +	desc->enabled = false;
> +}
> +
> +static int twl6030_clk32kg_is_prepared(struct clk_hw *hw)
> +{
> +	struct twl6030_desc *desc = to_twl6030_desc(hw);
> +
> +	return desc->enabled;
> +}
> +
> +static const struct clk_ops twl6030_clk32kg_ops = {
> +	.prepare	= twl6030_clk32kg_prepare,
> +	.unprepare	= twl6030_clk32kg_unprepare,
> +	.is_prepared	= twl6030_clk32kg_is_prepared,
> +};
> +
> +static void __init of_ti_twl6030_clk32kg_setup(struct device_node *node)
> +{
> +	struct twl6030_desc *clk_hw = NULL;
> +	struct clk_init_data init = { 0 };
> +	struct clk_lookup *clookup;
> +	struct clk *clk;
> +
> +	clookup = kzalloc(sizeof(*clookup), GFP_KERNEL);
> +	if (!clookup) {
> +		pr_err("%s: could not allocate clookup\n", __func__);
> +		return;
> +	}
> +	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
> +	if (!clk_hw) {
> +		pr_err("%s: could not allocate clk_hw\n", __func__);
> +		goto err_clk_hw;
> +	}
> +
> +	clk_hw->hw.init = &init;
> +
> +	init.name = node->name;
> +	init.ops = &twl6030_clk32kg_ops;
> +	init.flags = CLK_IS_ROOT;
> +
> +	clk = clk_register(NULL, &clk_hw->hw);
> +	if (!IS_ERR(clk)) {
> +		clookup->con_id = kstrdup("clk32kg", GFP_KERNEL);
> +		clookup->clk = clk;
> +		clkdev_add(clookup);
> +
> +		return;
> +	}
> +
> +	kfree(clookup);
> +err_clk_hw:
> +	kfree(clk_hw);
> +}
> +CLK_OF_DECLARE(of_ti_twl6030_clk32kg, "ti,twl6030-clk32kg", of_ti_twl6030_clk32kg_setup);
> +
> +static int of_twl6030_clk32kg_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct clk *clk;
> +	int ret = 0;
> +
> +	if (!node)
> +		return -ENODEV;
> +
> +	clk = clk_get(&pdev->dev, "clk32kg");
> +	if (IS_ERR(clk))
> +		ret = -EPROBE_DEFER;
> +	else
> +		clk_prepare(clk);

Why would you do this? The point of a clock provider is that you can
enable/disable the clock on demand. Here you enable the clock and leave it
enabled for the rest of the time...

clk-dra7-atl deals with similar issue

> +
> +	return ret;
> +}
> +
> +static struct of_device_id of_twl6030_clk32kg_match_tbl[] = {
> +	{ .compatible = "ti,twl6030-clk32kg", },

Hrm, not sure if this is correct. you have "ti,twl6030-clk32kg" as compatible
for the platform driver _and_ you have the same "ti,twl6030-clk32kg"
compatible for the declared clock.
This does not seams right.

I think you should not have compatible for the platform driver at all, rather
you need to create the needed platform device in the twl-core to probe the
driver, then look up for the clock node.

I think in terms of HW setup the Palmas clock is the closest to twl6030's 32K
clocks. It might worth taking a look at that for hints. It is not using
CLK_OF_DECLARE() since it is external chip, but it does the job.


> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, of_twl6030_clk32kg_match_tbl);
> +
> +static struct platform_driver twl6030_clk_driver = {
> +	.driver = {
> +		.name = "twl6030-clk32kg",
> +		.owner = THIS_MODULE,
> +		.of_match_table = of_twl6030_clk32kg_match_tbl,
> +	},
> +	.probe = of_twl6030_clk32kg_probe,
> +};
> +module_platform_driver(twl6030_clk_driver);
> +
> +MODULE_AUTHOR("Stefan Assmann <sassmann@kpanic.de>");
> +MODULE_DESCRIPTION("clock driver for TI SoC based boards with twl6030");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index db11b4f..440fe4e 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -34,6 +34,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/err.h>
>  #include <linux/device.h>
>  #include <linux/of.h>
> @@ -1012,6 +1013,8 @@ static void clocks_init(struct device *dev,
>  	u32 rate;
>  	u8 ctrl = HFCLK_FREQ_26_MHZ;
>  
> +	of_clk_init(NULL);
> +

I don't think this is in the right place. twl-core should not call a generic
clk init function.

>  	osc = clk_get(dev, "fck");
>  	if (IS_ERR(osc)) {
>  		printk(KERN_WARNING "Skipping twl internal clock init and "
> 


-- 
P?ter
