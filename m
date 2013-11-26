From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 26 Nov 2013 15:35:10 +0100
Subject: [PATCH RFC v2 01/17] clk: shmobile: r8a7779: Add clocks support
In-Reply-To: <1385451139-29686-2-git-send-email-horms+renesas@verge.net.au>
References: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
 <1385451139-29686-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <2841540.2tjHq5kk6t@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

Thank you for the patch.

On Tuesday 26 November 2013 16:32:03 Simon Horman wrote:
> Add clocks support for the r8a7779 SoC
> 
> Based on work for the r8a7790 and r8a7791 SoCs by Laurent Pinchart.
> 
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  .../bindings/clock/renesas,r8a7779-cpg-clocks.txt  |  22 +++
>  drivers/clk/shmobile/Makefile                      |   1 +
>  drivers/clk/shmobile/clk-r8a7779.c                 | 166 ++++++++++++++++++
>  include/linux/clk/shmobile.h                       |   1 +
>  4 files changed, 190 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
> create mode 100644 drivers/clk/shmobile/clk-r8a7779.c
> 
> diff --git
> a/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
> b/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
> new file mode 100644
> index 0000000..5636685
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,r8a7779-cpg-clocks.txt
> @@ -0,0 +1,22 @@
> +* Renesas R8A7779 Clock Pulse Generator (CPG)
> +
> +The CPG generates core clocks for the R8A7779. It includes one PLL and
> +several fixed ratio dividers.

The H1 CPG looks pretty similar to the M1 CPG. What about rcar-gen1 CPG 
bindings ?

> +Required Properties:
> +
> +  - compatible: Must be "renesas,r8a7779-cpg-clocks"
> +  - reg: Base address and length of the memory resource used by the CPG
> +  - clock-output-names: Supported clocks are "plla", "z", "zs", "s", "s1",
> +    "p", "out".

Doesn't the CPG have an external clock input that needs to be specified, and 
thus need a clocks property ?

> +Example
> +-------
> +
> +	cpg_clocks: cpg_clocks at ffc80000 {
> +		compatible = "renesas,r8a7779-cpg-clocks";
> +		reg = <0 0xffc80000 0 0x80>;
> +		#clock-cells = <1>;
> +		clock-output-names = "plla", "z", "zs", "s", "s1", "p", "out";
> +	};
> diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
> index 4df35a0..49b852a 100644
> --- a/drivers/clk/shmobile/Makefile
> +++ b/drivers/clk/shmobile/Makefile
> @@ -1,6 +1,7 @@
>  obj-$(CONFIG_ARCH_EMEV2)		+= clk-emev2.o
>  obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-gen2.o
>  obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o
> +obj-$(CONFIG_ARCH_R8A7779)		+= clk-r8a7779.o
>  obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-div6.o
>  obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-mstp.o
> 
> diff --git a/drivers/clk/shmobile/clk-r8a7779.c
> b/drivers/clk/shmobile/clk-r8a7779.c new file mode 100644
> index 0000000..dee898e
> --- /dev/null
> +++ b/drivers/clk/shmobile/clk-r8a7779.c
> @@ -0,0 +1,166 @@
> +/*
> + * r8a7779 Core CPG Clocks
> + *
> + * Copyright (C) 2013 Horms Solutions Ltd.
> + *
> + * Contact: Simon Horman <horms@verge.net.au>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>
> +#include <linux/clk/shmobile.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/spinlock.h>
> +
> +#include <dt-bindings/clock/r8a7779-clock.h>
> +
> +#define CPG_NUM_CLOCKS			(R8A7779_CLK_OUT + 1)
> +
> +struct r8a7779_cpg {
> +	struct clk_onecell_data data;
> +	spinlock_t lock;
> +	void __iomem *reg;
> +};
> +
> +/*
> + *		MD1 = 1			MD1 = 0
> + *		(PLLA = 1500)		(PLLA = 1600)
> + *		(MHz)			(MHz)
> + *------------------------------------------------+--------------------
> + * clkz		1000   (2/3)		800   (1/2)
> + * clkzs	 250   (1/6)		200   (1/8)
> + * clki		 750   (1/2)		800   (1/2)
> + * clks		 250   (1/6)		200   (1/8)
> + * clks1	 125   (1/12)		100   (1/16)
> + * clks3	 187.5 (1/8)		200   (1/8)
> + * clks4	  93.7 (1/16)		100   (1/16)
> + * clkp		  62.5 (1/24)		 50   (1/32)
> + * clkg		  62.5 (1/24)		 66.6 (1/24)
> + * clkb, CLKOUT
> + * (MD2 = 0)	  62.5 (1/24)		 66.6 (1/24)
> + * (MD2 = 1)	  41.6 (1/36)		 50   (1/32)
> + */
> +
> +#define CPG_CLK_CONFIG_INDEX(md)	(((md) & (BIT(1)|BIT(2))) >> 1)
> +

The PLLA ratio is also configurable, by bits MD11 and MD12.

> +struct cpg_clk_config {
> +	unsigned int plla;
> +	unsigned int z_mult;
> +	unsigned int z;
> +	unsigned int zs_and_s;
> +	unsigned int s1;
> +	unsigned int p;
> +	unsigned int out;

Could you rename the last five fields with a _div suffix to express more 
clearly what that mean ?

> +};
> +
> +static const struct cpg_clk_config cpg_clk_configs[4] __initconst = {
> +	{ 1500000000, 1, 2, 8, 16, 32, 24 },
> +	{ 1500000000, 1, 2, 8, 16, 32, 24 },
> +	{ 1600000000, 2, 3, 6, 12, 24, 36 },
> +	{ 1600000000, 2, 3, 6, 12, 24, 32 },
> +};
> +
> +static u32 cpg_mode __initdata;
> +
> +static struct clk * __init
> +r8a7779_cpg_register_clock(struct device_node *np, struct r8a7779_cpg *cpg,
> +			   const struct cpg_clk_config *config,
> +			   const char *name)
> +{
> +	const char *parent_name = "plla";
> +	unsigned int mult = 1;
> +	unsigned int div = 1;
> +	unsigned int rate = 0;
> +
> +	if (!strcmp(name, "plla")) {
> +		parent_name = of_clk_get_parent_name(np, 0);
> +		rate = config->plla;
> +	} else if (!strcmp(name, "z")) {
> +		div = config->z;
> +		mult = config->z_mult;
> +	} else if (!strcmp(name, "zs") || !strcmp(name, "s")) {
> +		div = config->zs_and_s;
> +	} else if (!strcmp(name, "s1")) {
> +		div = config->s1;
> +	} else if (!strcmp(name, "p")) {
> +		div = config->p;
> +	} else if (!strcmp(name, "out")) {
> +		div = config->out;
> +	}
> +
> +	if (rate)
> +		return clk_register_fixed_rate(NULL, name, parent_name,
> +					       0, rate);

As far as I can tell the only fixed rate clock is the external crystal, from 
which all clocks derive. All the other clocks are fixed-factor clocks. You 
should thus register the PLLA clock as a fixed factor clock.

> +	else
> +		return clk_register_fixed_factor(NULL, name, parent_name,
> +						 0, mult, div);
> +}
> +
> +static void __init r8a7779_cpg_clocks_init(struct device_node *np)
> +{
> +	const struct cpg_clk_config *config;
> +	struct r8a7779_cpg *cpg;
> +	struct clk **clks;
> +	unsigned int i;
> +	int num_clks;
> +
> +	num_clks = of_property_count_strings(np, "clock-output-names");
> +	if (num_clks < 0) {
> +		pr_err("%s: failed to count clocks\n", __func__);
> +		return;
> +	}
> +
> +	cpg = kzalloc(sizeof *cpg, GFP_KERNEL);
> +	clks = kzalloc(CPG_NUM_CLOCKS * sizeof *clks, GFP_KERNEL);

Not my preferred style either, but the kernel coding style uses sizeof().

> +	if (cpg == NULL || clks == NULL) {
> +		/* We're leaking memory on purpose, there's no point in cleaning
> +		 * up as the system won't boot anyway.
> +		 */
> +		pr_err("%s: failed to allocate cpg\n", __func__);
> +		return;
> +	}
> +
> +	spin_lock_init(&cpg->lock);
> +
> +	cpg->data.clks = clks;
> +	cpg->data.clk_num = CPG_NUM_CLOCKS;

s/CPG_NUM_CLOCKS/num_clks/

You can then remove the CPG_NUM_CLOCKS definition above, as well as the dt-
bindings/clock/r8a7779-clock.h include.

> +
> +	cpg->reg = of_iomap(np, 0);
> +	if (WARN_ON(cpg->reg == NULL))
> +		return;
> +
> +	config = &cpg_clk_configs[CPG_CLK_CONFIG_INDEX(cpg_mode)];
> +
> +	for (i = 0; i < num_clks; ++i) {
> +		const char *name;
> +		struct clk *clk;
> +
> +		of_property_read_string_index(np, "clock-output-names", i,
> +					      &name);
> +
> +		clk = r8a7779_cpg_register_clock(np, cpg, config, name);
> +		if (IS_ERR(clk))
> +			pr_err("%s: failed to register %s %s clock (%ld)\n",
> +			       __func__, np->name, name, PTR_ERR(clk));
> +		else
> +			cpg->data.clks[i] = clk;
> +	}
> +
> +	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
> +}
> +CLK_OF_DECLARE(r8a7779_cpg_clks, "renesas,r8a7779-cpg-clocks",
> +	       r8a7779_cpg_clocks_init);
> +
> +void __init r8a7779_clocks_init(u32 mode)
> +{
> +	cpg_mode = mode;
> +
> +	of_clk_init(NULL);
> +}
> diff --git a/include/linux/clk/shmobile.h b/include/linux/clk/shmobile.h
> index f9bf080..34bb19d 100644
> --- a/include/linux/clk/shmobile.h
> +++ b/include/linux/clk/shmobile.h
> @@ -15,5 +15,6 @@
>  #include <linux/types.h>
> 
>  void rcar_gen2_clocks_init(u32 mode);
> +void r8a7779_clocks_init(u32 mode);
> 
>  #endif
-- 
Regards,

Laurent Pinchart
