From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Jun 2016 12:43:34 -0700
Subject: [PATCH 06/10] clk: mvebu: Add the xtal clock for Armada 3700 SoC
In-Reply-To: <1465565018-14172-7-git-send-email-gregory.clement@free-electrons.com>
References: <1465565018-14172-1-git-send-email-gregory.clement@free-electrons.com>
 <1465565018-14172-7-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160630194334.GZ1521@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10, Gregory CLEMENT wrote:
> diff --git a/drivers/clk/mvebu/armada-37xx-xtal.c b/drivers/clk/mvebu/armada-37xx-xtal.c
> new file mode 100644
> index 000000000000..fb051a75b2c2
> --- /dev/null
> +++ b/drivers/clk/mvebu/armada-37xx-xtal.c
> @@ -0,0 +1,93 @@
> +/*
> + * Marvell Armada 37xx SoC xtal clocks
> + *
> + * Copyright (C) 2016 Marvell
> + *
> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#define NB_GPIO1_LATCH	0xC
> +#define XTAL_MODE	    BIT(31)
> +
> +static struct clk *xtal_clk;

Please allocate this at driver probe time instead, or even just
assign it to be the platform driver's drvdata.

> +
> +static int armada_3700_xtal_clock_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	const char *xtal_name = "xtal";
> +	struct device_node *parent;
> +	struct regmap *regmap;
> +	unsigned int rate;
> +	u32 reg;
> +	int ret;
> +
> +	parent = np->parent;
> +	if (!parent) {
> +		dev_err(&pdev->dev, "no parrent\n");

s/parrent/parent/

> +		return -ENODEV;
> +	}
> +
> +	regmap = syscon_node_to_regmap(parent);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&pdev->dev, "cannot get regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	ret = regmap_read(regmap, NB_GPIO1_LATCH, &reg);
> +	if (ret) {
> +		dev_err(&pdev->dev, "cannot read from regmap\n");
> +		return ret;
> +	}
> +
> +	if (reg & XTAL_MODE)
> +		rate = 40000000;
> +	else
> +		rate = 25000000;
> +
> +	of_property_read_string_index(np, "clock-output-names", 0, &xtal_name);
> +	xtal_clk = clk_register_fixed_rate(NULL, xtal_name, NULL, 0, rate);

Please move this to use the clk_hw_register_fixed_rate() function
instead and update of_clk_add_provider to register a clk_hw
instead of clk pointer.

> +	if (IS_ERR(xtal_clk))
> +		return PTR_ERR(xtal_clk);
> +	of_clk_add_provider(np, of_clk_src_simple_get, xtal_clk);

What if this fails?

> +
> +	return 0;
> +}

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
