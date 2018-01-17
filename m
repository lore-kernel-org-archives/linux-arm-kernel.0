From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 17 Jan 2018 21:01:53 +0530
Subject: [PATCH v5 19/44] clk: davinci: New driver for TI DA8XX CFGCHIP
 clocks
In-Reply-To: <1515377863-20358-20-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-20-git-send-email-david@lechnology.com>
Message-ID: <c3c0f9cf-b93e-6d1e-1e44-7dcef1ea11cf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 January 2018 07:47 AM, David Lechner wrote:
> This adds a new driver for the gate and multiplexer clocks in the
> CFGCHIPn syscon registers on TI DA8XX-type SoCs.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  drivers/clk/davinci/Makefile        |   2 +
>  drivers/clk/davinci/da8xx-cfgchip.c | 203 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 205 insertions(+)
>  create mode 100644 drivers/clk/davinci/da8xx-cfgchip.c
> 
> diff --git a/drivers/clk/davinci/Makefile b/drivers/clk/davinci/Makefile
> index 6c388d4..11178b7 100644
> --- a/drivers/clk/davinci/Makefile
> +++ b/drivers/clk/davinci/Makefile
> @@ -1,6 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  ifeq ($(CONFIG_COMMON_CLK), y)
> +obj-$(CONFIG_ARCH_DAVINCI_DA8XX)	+= da8xx-cfgchip.o
> +
>  obj-y += pll.o
>  obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= pll-da830.o
>  obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= pll-da850.o
> diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
> new file mode 100644
> index 0000000..772e09a
> --- /dev/null
> +++ b/drivers/clk/davinci/da8xx-cfgchip.c
> @@ -0,0 +1,203 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clock driver for DA8xx/AM17xx/AM18xx/OMAP-L13x CFGCHIP
> + *
> + * Copyright (C) 2017 David Lechner <david@lechnology.com>

2018

> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/mfd/da8xx-cfgchip.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#ifdef CONFIG_OF

Is this ifdef really needed, or included to save space for non-OF
builds? I think it can be removed if not really needed.

> +static void da8xx_cfgchip_gate_clk_init(struct device_node *np, u32 reg,
> +					u32 mask)
> +{
> +	struct da8xx_cfgchip_gate_clk *clk;
> +	struct clk_init_data init;
> +	const char *name = np->name;
> +	const char *parent_name;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	of_property_read_string(np, "clock-output-names", &name);
> +	parent_name = of_clk_get_parent_name(np, 0);
> +
> +	regmap = syscon_node_to_regmap(of_get_parent(np));
> +	if (IS_ERR(regmap)) {
> +		pr_err("%s: no regmap for syscon parent of %s (%ld)\n",
> +		       __func__, np->full_name, PTR_ERR(regmap));

please use pr_fmt for this driver too.

> +static void da8xx_cfgchip_mux_clk_init(struct device_node *np, u32 reg,
> +				       u32 mask)
> +{
> +	struct da8xx_cfgchip_mux_clk *clk;
> +	struct clk_init_data init;
> +	const char *name = np->name;
> +	const char *parent_names[2];
> +	struct regmap *regmap;
> +	int ret;
> +
> +	ret = of_property_match_string(np, "clock-names", "pll0_sysclk2");
> +	parent_names[0] = of_clk_get_parent_name(np, ret);
> +	if (!parent_names[0]) {
> +		pr_err("%s: missing pll0_sysclk2 clock\n", __func__);
> +		return;
> +	}
> +
> +	ret = of_property_match_string(np, "clock-names", "pll1_sysclk2");
> +	parent_names[1] = of_clk_get_parent_name(np, ret);
> +	if (!parent_names[1]) {
> +		pr_err("%s: missing pll1_sysclk2 clock\n", __func__);
> +		return;
> +	}

The fact that you are looking specifically for pll0_sysclk2 and
pll1_sysclk2 makes it really specific to async3 and the same function
cannot be used for something like EMIFA clock source. Can this part of
the function be factored out so rest of the function can still be reused
for another clock?

Thanks,
Sekhar
