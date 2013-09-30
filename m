From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 Sep 2013 19:21:37 +0200
Subject: [PATCH 04/10] clk: sunxi: add PLL5 and PLL6 support
In-Reply-To: <1380426579-32458-5-git-send-email-emilio@elopez.com.ar>
References: <1380426579-32458-1-git-send-email-emilio@elopez.com.ar>
 <1380426579-32458-5-git-send-email-emilio@elopez.com.ar>
Message-ID: <20130930172137.GE5287@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Sun, Sep 29, 2013 at 12:49:33AM -0300, Emilio L?pez wrote:
> This commit implements PLL5 and PLL6 support on the sunxi clock driver.
> These PLLs use a similar factor clock, but differ on their outputs.
> 
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
> ---
>  Documentation/devicetree/bindings/clock/sunxi.txt |   2 +
>  drivers/clk/sunxi/clk-sunxi.c                     | 182 +++++++++++++++++++++-
>  2 files changed, 177 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> index 7d9245f..773f3ae 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> @@ -9,6 +9,8 @@ Required properties:
>  	"allwinner,sun4i-osc-clk" - for a gatable oscillator
>  	"allwinner,sun4i-pll1-clk" - for the main PLL clock and PLL4
>  	"allwinner,sun6i-a31-pll1-clk" - for the main PLL clock on A31
> +	"allwinner,sun4i-pll5-clk" - for the PLL5 clock
> +	"allwinner,sun4i-pll6-clk" - for the PLL6 clock
>  	"allwinner,sun4i-cpu-clk" - for the CPU multiplexer clock
>  	"allwinner,sun4i-axi-clk" - for the AXI clock
>  	"allwinner,sun4i-axi-gates-clk" - for the AXI gates
> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> index 77b9f57..b1210f3 100644
> --- a/drivers/clk/sunxi/clk-sunxi.c
> +++ b/drivers/clk/sunxi/clk-sunxi.c
> @@ -210,6 +210,40 @@ static void sun6i_a31_get_pll1_factors(u32 *freq, u32 parent_rate,
>  }
>  
>  /**
> + * sun4i_get_pll5_factors() - calculates n, k factors for PLL5
> + * PLL5 rate is calculated as follows
> + * rate = parent_rate * n * (k + 1)
> + * parent_rate is always 24Mhz
> + */
> +
> +static void sun4i_get_pll5_factors(u32 *freq, u32 parent_rate,
> +				   u8 *n, u8 *k, u8 *m, u8 *p)
> +{
> +	u8 div;
> +
> +	/* Normalize value to a 24M multiple */
> +	div = *freq / 24000000;
> +	*freq = 24000000 * div;

parent_rate here maybe ?

> +
> +	/* we were called to round the frequency, we can now return */
> +	if (n == NULL)
> +		return;
> +
> +	if (div < 31)
> +		*k = 0;
> +	else if (div / 2 < 31)
> +		*k = 1;
> +	else if (div / 3 < 31)
> +		*k = 2;
> +	else
> +		*k = 3;
> +
> +	*n = DIV_ROUND_UP(div, (*k+1));
> +}
> +
> +
> +
> +/**
>   * sun4i_get_apb1_factors() - calculates m, p factors for APB1
>   * APB1 rate is calculated as follows
>   * rate = (parent_rate >> p) / (m + 1);
> @@ -285,6 +319,13 @@ static struct clk_factors_config sun6i_a31_pll1_config = {
>  	.mwidth = 2,
>  };
>  
> +static struct clk_factors_config sun4i_pll5_config = {
> +	.nshift = 8,
> +	.nwidth = 5,
> +	.kshift = 4,
> +	.kwidth = 2,
> +};
> +

The spacing between your functions and structures looks odd. You were
using 3 newlines the change just above, and now just one?

>  static struct clk_factors_config sun4i_apb1_config = {
>  	.mshift = 0,
>  	.mwidth = 5,
> @@ -304,13 +345,19 @@ static const struct factors_data sun6i_a31_pll1_data __initconst = {
>  	.getter = sun6i_a31_get_pll1_factors,
>  };
>  
> +static const struct factors_data sun4i_pll5_data __initconst = {
> +	.enable = 31,
> +	.table = &sun4i_pll5_config,
> +	.getter = sun4i_get_pll5_factors,
> +};
> +
>  static const struct factors_data sun4i_apb1_data __initconst = {
>  	.table = &sun4i_apb1_config,
>  	.getter = sun4i_get_apb1_factors,
>  };
>  
> -static void __init sunxi_factors_clk_setup(struct device_node *node,
> -					   struct factors_data *data)
> +static struct clk * __init sunxi_factors_clk_setup(struct device_node *node,
> +						const struct factors_data *data)

While this change is probably useful, I don't see how it relates to the
change described in your commit log. Either split these patches, or
explain why it's needed.

>  {
>  	struct clk *clk;
>  	struct clk_factors *factors;
> @@ -321,6 +368,7 @@ static void __init sunxi_factors_clk_setup(struct device_node *node,
>  	const char *clk_name = node->name;
>  	const char *parents[5];
>  	void *reg;
> +	unsigned long flags;
>  	int i = 0;
>  
>  	reg = of_iomap(node, 0);
> @@ -331,14 +379,14 @@ static void __init sunxi_factors_clk_setup(struct device_node *node,
>  
>  	factors = kzalloc(sizeof(struct clk_factors), GFP_KERNEL);
>  	if (!factors)
> -		return;
> +		return NULL;
>  
>  	/* Add a gate if this factor clock can be gated */
>  	if (data->enable) {
>  		gate = kzalloc(sizeof(struct clk_gate), GFP_KERNEL);
>  		if (!gate) {
>  			kfree(factors);
> -			return;
> +			return NULL;
>  		}
>  
>  		/* set up gate properties */
> @@ -354,7 +402,7 @@ static void __init sunxi_factors_clk_setup(struct device_node *node,
>  		if (!mux) {
>  			kfree(factors);
>  			kfree(gate);
> -			return;
> +			return NULL;
>  		}
>  
>  		/* set up gate properties */
> @@ -371,17 +419,21 @@ static void __init sunxi_factors_clk_setup(struct device_node *node,
>  	factors->get_factors = data->getter;
>  	factors->lock = &clk_lock;
>  
> +	/* We should not disable pll5, it powers the RAM */
> +	flags = !strcmp("pll5", clk_name) ? CLK_IGNORE_UNUSED : 0;
> +
>  	clk = clk_register_composite(NULL, clk_name,
>  			parents, i,
>  			mux_hw, &clk_mux_ops,
>  			&factors->hw, &clk_factors_ops,
> -			gate_hw, &clk_gate_ops,
> -			i ? 0 : CLK_IS_ROOT);
> +			gate_hw, &clk_gate_ops, flags);
>  
>  	if (!IS_ERR(clk)) {
>  		of_clk_add_provider(node, of_clk_src_simple_get, clk);
>  		clk_register_clkdev(clk, clk_name, NULL);
>  	}
> +
> +	return clk;
>  }
>  
>  
> @@ -616,6 +668,112 @@ static void __init sunxi_gates_clk_setup(struct device_node *node,
>  	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
>  }
>  
> +
> +
> +/**
> + * sunxi_divs_clk_setup() - Setup function for leaf divisors on clocks
> + */

This comment doesn't seem to be at the right place in your code.

> +#define SUNXI_DIVS_MAX_QTY	2
> +#define SUNXI_DIVISOR_WIDTH	2
> +
> +struct divs_data {
> +	const struct factors_data *factors; /* data for the factor clock */
> +	struct {
> +		u8 fixed; /* is it a fixed divisor? if not... */
> +		struct clk_div_table *table; /* is it a table based divisor? */
> +		u8 shift; /* otherwise it's a normal divisor with this shift */
> +		u8 pow;   /* is it power-of-two based? */
> +	} div[SUNXI_DIVS_MAX_QTY];
> +};
> +
> +static struct clk_div_table pll6_sata_table[] = {
> +	{ .val = 0, .div = 6, },
> +	{ .val = 1, .div = 12, },
> +	{ .val = 2, .div = 18, },
> +	{ .val = 3, .div = 24, },
> +	{ } /* sentinel */
> +};
> +
> +static const struct divs_data pll5_divs_data __initconst = {
> +	.factors = &sun4i_pll5_data,
> +	.div = {
> +		{ .shift = 0, .pow = 0, }, /* M, DDR */
> +		{ .shift = 16, .pow = 1, }, /* P, other */
> +	}
> +};
> +
> +static const struct divs_data pll6_divs_data __initconst = {
> +	.factors = &sun4i_pll5_data,
> +	.div = {
> +		{ .shift = 0, .table = pll6_sata_table }, /* M, SATA */
> +		{ .fixed = 2 }, /* P, other */
> +	}
> +};
> +
> +static void __init sunxi_divs_clk_setup(struct device_node *node,
> +					struct divs_data *data)
> +{
> +	struct clk_onecell_data *clk_data;
> +	const char *parent  = node->name;
> +	const char *clk_name;
> +	struct clk **clks, *pclk;
> +	void *reg;
> +	int i = 0;
> +	int flags, clkflags;
> +
> +	/* Set up factor clock that we will be dividing */
> +	pclk = sunxi_factors_clk_setup(node, data->factors);
> +
> +	reg = of_iomap(node, 0);
> +
> +	clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
> +	if (!clk_data)
> +		return;

An extra newline would be great here.

> +	clks = kzalloc(SUNXI_DIVS_MAX_QTY * sizeof(struct clk *), GFP_KERNEL);
> +	if (!clks) {
> +		kfree(clk_data);
> +		return;
> +	}
> +	clk_data->clks = clks;
> +
> +	/* It's not a good idea to have automatic reparenting changing
> +	 * our RAM clock! */
> +	clkflags = !strcmp("pll5", parent) ? 0 : CLK_SET_RATE_PARENT;
> +
> +	for (i = 0; i < SUNXI_DIVS_MAX_QTY; i++) {
> +		if (of_property_read_string_index(node, "clock-output-names",
> +						  i, &clk_name) != 0)
> +			break;
> +
> +		if (data->div[i].fixed) {
> +			clks[i] = clk_register_fixed_factor(NULL, clk_name,
> +						parent, clkflags,
> +						1, data->div[i].fixed);
> +		} else {
> +			flags = data->div[i].pow ? CLK_DIVIDER_POWER_OF_TWO : 0;
> +			clks[i] = clk_register_divider_table(NULL, clk_name,
> +						parent, clkflags, reg,
> +						data->div[i].shift,
> +						SUNXI_DIVISOR_WIDTH, flags,
> +						data->div[i].table, &clk_lock);
> +		}

Hmmm, I don't get why you were calling sunxi_clk_factors_setup
unconditionally, and now you put a condition on the registration?

(Plus, your indentation here looks a bit odd.)

> +
> +		WARN_ON(IS_ERR(clk_data->clks[i]));
> +		clk_register_clkdev(clks[i], clk_name, NULL);
> +	}
> +
> +	/* The last clock available on the getter is the parent */
> +	clks[i++] = pclk;
> +
> +	/* Adjust to the real max */
> +	clk_data->clk_num = i;
> +
> +	of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +}
> +
> +
> +
>  /* Matches for factors clocks */
>  static const struct of_device_id clk_factors_match[] __initconst = {
>  	{.compatible = "allwinner,sun4i-pll1-clk", .data = &sun4i_pll1_data,},
> @@ -633,6 +791,13 @@ static const struct of_device_id clk_div_match[] __initconst = {
>  	{}
>  };
>  
> +/* Matches for divided outputs */
> +static const struct of_device_id clk_divs_match[] __initconst = {
> +	{.compatible = "allwinner,sun4i-pll5-clk", .data = &pll5_divs_data,},
> +	{.compatible = "allwinner,sun4i-pll6-clk", .data = &pll6_divs_data,},
> +	{}
> +};
> +
>  /* Matches for mux clocks */
>  static const struct of_device_id clk_mux_match[] __initconst = {
>  	{.compatible = "allwinner,sun4i-cpu-clk", .data = &sun4i_cpu_mux_data,},
> @@ -713,6 +878,9 @@ void __init sunxi_init_clocks(void)
>  	/* Register divider clocks */
>  	of_sunxi_table_clock_setup(clk_div_match, sunxi_divider_clk_setup);
>  
> +	/* Register divided output clocks */
> +	of_sunxi_table_clock_setup(clk_divs_match, sunxi_divs_clk_setup);
> +
>  	/* Register mux clocks */
>  	of_sunxi_table_clock_setup(clk_mux_match, sunxi_mux_clk_setup);
>  
> -- 
> 1.8.4
> 

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130930/389134af/attachment-0001.sig>
