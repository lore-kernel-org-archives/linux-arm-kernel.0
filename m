From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 9 May 2016 15:49:53 -0700
Subject: [PATCH 2/4] drvers/clk: Support fourth generation Aspeed SoCs
In-Reply-To: <1462797111-14271-3-git-send-email-joel@jms.id.au>
References: <1462797111-14271-1-git-send-email-joel@jms.id.au>
 <1462797111-14271-3-git-send-email-joel@jms.id.au>
Message-ID: <20160509224953.GZ3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09, Joel Stanley wrote:
> diff --git a/drivers/clk/aspeed/clk-g4.c b/drivers/clk/aspeed/clk-g4.c
> new file mode 100644
> index 000000000000..91677e9177f5
> --- /dev/null
> +++ b/drivers/clk/aspeed/clk-g4.c
> @@ -0,0 +1,109 @@
> +/*
> + * Copyright 2016 IBM Corporation
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/clk.h>

Hopefully this include isn't needed.

> +#include <linux/clk-provider.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/clkdev.h>
> +
> +static void __init aspeed_of_hpll_clk_init(struct device_node *node)
> +{
> +	struct clk *clk, *clkin_clk;
> +	void __iomem *base;
> +	int reg, rate, clkin;
> +	const char *name = node->name;
> +	const char *parent_name;
> +	const int rates[][4] = {
> +		{384, 360, 336, 408},
> +		{400, 375, 350, 425},
> +	};
> +
> +	of_property_read_string(node, "clock-output-names", &name);
> +	parent_name = of_clk_get_parent_name(node, 0);
> +
> +	base = of_iomap(node, 0);
> +	if (!base) {
> +		pr_err("%s: of_iomap failed\n", node->full_name);
> +		return;
> +	}
> +	reg = readl(base);
> +	iounmap(base);
> +
> +	clkin_clk = of_clk_get(node, 0);
> +	if (IS_ERR(clkin_clk)) {
> +		pr_err("%s: of_clk_get failed\n", node->full_name);
> +		return;
> +	}
> +
> +	clkin = clk_get_rate(clkin_clk);
> +
> +	reg = (reg >> 8) & 0x2;
> +
> +	if (clkin == 48000000 || clkin == 24000000)
> +		rate = rates[0][reg] * 1000000;
> +	else if (clkin == 25000000)
> +		rate = rates[1][reg] * 1000000;
> +	else {
> +		pr_err("%s: unknown clkin frequency %dHz\n",
> +				node->full_name, clkin);
> +		WARN_ON(1);
> +	}
> +
> +	clk = clk_register_fixed_rate(NULL, name, parent_name, 0, rate);

Please write a proper clk driver that sets clkin to be the parent
of this clk registered here and then calculates the frequency
based on the parent clk rate and the strapping registers via the
recalc rate callback. Also please move this to a platform driver
instead of using CLK_OF_DECLARE assuming this isn't required for
any timers in the system.

> +	if (IS_ERR(clk)) {
> +		pr_err("%s: failed to register clock\n", node->full_name);
> +		return;
> +	}
> +
> +	clk_register_clkdev(clk, NULL, name);

Do you have clkdev users? If not then please drop this.

> +	of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +}
> +CLK_OF_DECLARE(aspeed_hpll_clock, "aspeed,g4-hpll-clock",
> +	       aspeed_of_hpll_clk_init);
> +
> +static void __init aspeed_of_apb_clk_init(struct device_node *node)
> +{
> +	struct clk *clk, *hpll_clk;
> +	void __iomem *base;
> +	int reg, rate;
> +	const char *name = node->name;
> +	const char *parent_name;
> +
> +	of_property_read_string(node, "clock-output-names", &name);
> +	parent_name = of_clk_get_parent_name(node, 0);
> +
> +	base = of_iomap(node, 0);
> +	if (!base) {
> +		pr_err("%s: of_iomap failed\n", node->full_name);
> +		return;
> +	}
> +	reg = readl(base);
> +	iounmap(base);
> +
> +	hpll_clk = of_clk_get(node, 0);
> +	if (IS_ERR(hpll_clk)) {
> +		pr_err("%s: of_clk_get failed\n", node->full_name);
> +		return;
> +	}
> +
> +	reg = (reg >> 23) & 0x3;
> +	rate = clk_get_rate(hpll_clk) / (2 + 2 * reg);
> +
> +	clk = clk_register_fixed_rate(NULL, name, parent_name, 0, rate);
> +	if (IS_ERR(clk)) {
> +		pr_err("%s: failed to register clock\n", node->full_name);
> +		return;
> +	}
> +
> +	clk_register_clkdev(clk, NULL, name);
> +	of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +}
> +CLK_OF_DECLARE(aspeed_apb_clock, "aspeed,g4-apb-clock",
> +	       aspeed_of_apb_clk_init);

Following on Rob's comment, please combine this into one driver
instead of having different DT nodes for different clks that are
all really part of one clock controller hw block.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
