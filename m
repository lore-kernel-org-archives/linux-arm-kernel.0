From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Tue, 05 Nov 2013 00:52:29 -0800 (PST)
Subject: [PATCH 3/3] clk: shmobile: Add R8A7790 clocks support
In-Reply-To: <1383058511-26046-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383058511-26046-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <87r4avnsc6.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Laurent

> +Required Properties:
> +
> +  - compatible: Must be "renesas,r8a7790-cpg-clocks"
> +  - reg: Base address and length of the memory resource used by the CPG
> +  - clocks: Reference to the parent clock
> +  - #clock-cells: Must be 1
> +  - clock-output-names: The name of the clocks, must be "main", "pll1",
> +    "pll3", "lb", "qspi", "sdh", "sd0", "sd1".
(snip)
> +	for (i = 0; i < CPG_NUM_CLOCKS; ++i) {
> +		const struct clk_div_table *table = NULL;
> +		const char *parent_name = "main";
> +		const char *name;
> +		unsigned int shift;
> +		unsigned int mult = 1;
> +		unsigned int div = 1;
> +		struct clk *clk;
> +
> +		of_property_read_string_index(np, "clock-output-names", i,
> +					      &name);
> +
> +		switch (i) {
> +		case R8A7790_CLK_MAIN:
> +			parent_name = of_clk_get_parent_name(np, 0);
> +			div = config->extal_div;
> +			break;
> +		case R8A7790_CLK_PLL1:
> +			mult = config->pll1_mult / 2;
> +			break;
> +		case R8A7790_CLK_PLL3:
> +			mult = config->pll3_mult;
> +			break;
> +		case R8A7790_CLK_LB:
> +			div = cpg_mode & BIT(18) ? 36 : 24;
> +			break;
> +		case R8A7790_CLK_QSPI:
> +			div = (cpg_mode & (BIT(3) | BIT(2) | BIT(1))) == BIT(2)
> +			    ? 16 : 20;
> +			break;
> +		case R8A7790_CLK_SDH:
> +			table = cpg_sdh_div_table;
> +			shift = 8;
> +			break;
> +		case R8A7790_CLK_SD0:
> +			table = cpg_sd01_div_table;
> +			shift = 4;
> +			break;
> +		case R8A7790_CLK_SD1:
> +			table = cpg_sd01_div_table;
> +			shift = 0;
> +			break;
> +		}

Is this clock-output-names realy "Required" property ?
The "name" and "order" seem fixed, then,
I guess it can simply use "name array" ?

> +static void __init r8a7790_cpg_clocks_init(struct device_node *np)
> +{
> +	const struct cpg_pll_config *config;
> +	struct r8a7790_cpg *cpg;
> +	struct clk **clks;
> +	unsigned int i;
> +
> +	cpg = kzalloc(sizeof(*cpg), GFP_KERNEL);
> +	clks = kzalloc(CPG_NUM_CLOCKS * sizeof(*clks), GFP_KERNEL);
> +	if (cpg == NULL || clks == NULL) {
> +		kfree(clks);
> +		kfree(cpg);
> +		pr_err("%s: failed to allocate cpg\n", __func__);
> +		return;
> +	}
> +
> +	spin_lock_init(&cpg->lock);
> +
> +	cpg->data.clks = clks;
> +	cpg->data.clk_num = CPG_NUM_CLOCKS;
> +
> +	cpg->reg = of_iomap(np, 0);
> +	if (WARN_ON(cpg->reg == NULL)) {
> +		kfree(cpg->data.clks);
> +		kfree(cpg);
> +		return;
> +	}

Above 2 error cases are doing same thing.
If can use goto xxx_error.

Best regards
---
Kuninori Morimoto
