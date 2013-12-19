From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 18 Dec 2013 20:59:05 -0800
Subject: [PATCH v2 05/11] clk: sunxi: add PLL5 and PLL6 support
In-Reply-To: <1387327503-15651-6-git-send-email-emilio@elopez.com.ar>
References: <1387327503-15651-1-git-send-email-emilio@elopez.com.ar>
 <1387327503-15651-6-git-send-email-emilio@elopez.com.ar>
Message-ID: <20131219045905.23538.99955@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Emilio L?pez (2013-12-17 16:44:57)
> +/**
> + * sunxi_divs_clk_setup() - Setup function for leaf divisors on clocks
> + *
> + * These clocks look something like this
> + *            ________________________
> + *           |         ___divisor 1---|----> to consumer
> + * parent >--|  pll___/___divisor 2---|----> to consumer
> + *           |        \_______________|____> to consumer
> + *           |________________________|
> + */

+1 for ASCII art.

> +
> +static void __init sunxi_divs_clk_setup(struct device_node *node,
> +                                       struct divs_data *data)
> +{
> +       struct clk_onecell_data *clk_data;
> +       const char *parent  = node->name;
> +       const char *clk_name;
> +       struct clk **clks, *pclk;
> +       struct clk_hw *gate_hw, *rate_hw;
> +       const struct clk_ops *rate_ops;
> +       struct clk_gate *gate = NULL;
> +       struct clk_fixed_factor *fix_factor;
> +       struct clk_divider *divider;
> +       void *reg;
> +       int i = 0;
> +       int flags, clkflags;
> +
> +       /* Set up factor clock that we will be dividing */
> +       pclk = sunxi_factors_clk_setup(node, data->factors);
> +
> +       reg = of_iomap(node, 0);
> +
> +       clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
> +       if (!clk_data)
> +               return;
> +
> +       clks = kzalloc(SUNXI_DIVS_MAX_QTY * sizeof(struct clk *), GFP_KERNEL);
> +       if (!clks)
> +               goto free_clkdata;
> +
> +       clk_data->clks = clks;
> +
> +       /* It's not a good idea to have automatic reparenting changing
> +        * our RAM clock! */
> +       clkflags = !strcmp("pll5", parent) ? 0 : CLK_SET_RATE_PARENT;

Just out of curiosity, did you hit this problem in testing?

Acked-by: Mike Turquette <mturquette@linaro.org>

> +
> +       for (i = 0; i < SUNXI_DIVS_MAX_QTY; i++) {
> +               if (of_property_read_string_index(node, "clock-output-names",
> +                                                 i, &clk_name) != 0)
> +                       break;
> +
> +               gate_hw = NULL;
> +               rate_hw = NULL;
> +               rate_ops = NULL;
> +
> +               /* If this leaf clock can be gated, create a gate */
> +               if (data->div[i].gate) {
> +                       gate = kzalloc(sizeof(*gate), GFP_KERNEL);
> +                       if (!gate)
> +                               goto free_clks;
> +
> +                       gate->reg = reg;
> +                       gate->bit_idx = data->div[i].gate;
> +                       gate->lock = &clk_lock;
> +
> +                       gate_hw = &gate->hw;
> +               }
> +
> +               /* Leaves can be fixed or configurable divisors */
> +               if (data->div[i].fixed) {
> +                       fix_factor = kzalloc(sizeof(*fix_factor), GFP_KERNEL);
> +                       if (!fix_factor)
> +                               goto free_gate;
> +
> +                       fix_factor->mult = 1;
> +                       fix_factor->div = data->div[i].fixed;
> +
> +                       rate_hw = &fix_factor->hw;
> +                       rate_ops = &clk_fixed_factor_ops;
> +               } else {
> +                       divider = kzalloc(sizeof(*divider), GFP_KERNEL);
> +                       if (!divider)
> +                               goto free_gate;
> +
> +                       flags = data->div[i].pow ? CLK_DIVIDER_POWER_OF_TWO : 0;
> +
> +                       divider->reg = reg;
> +                       divider->shift = data->div[i].shift;
> +                       divider->width = SUNXI_DIVISOR_WIDTH;
> +                       divider->flags = flags;
> +                       divider->lock = &clk_lock;
> +                       divider->table = data->div[i].table;
> +
> +                       rate_hw = &divider->hw;
> +                       rate_ops = &clk_divider_ops;
> +               }
> +
> +               /* Wrap the (potential) gate and the divisor on a composite
> +                * clock to unify them */
> +               clks[i] = clk_register_composite(NULL, clk_name, &parent, 1,
> +                                                NULL, NULL,
> +                                                rate_hw, rate_ops,
> +                                                gate_hw, &clk_gate_ops,
> +                                                clkflags);
> +
> +               WARN_ON(IS_ERR(clk_data->clks[i]));
> +               clk_register_clkdev(clks[i], clk_name, NULL);
> +       }
> +
> +       /* The last clock available on the getter is the parent */
> +       clks[i++] = pclk;
> +
> +       /* Adjust to the real max */
> +       clk_data->clk_num = i;
> +
> +       of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
> +
> +       return;
> +
> +free_gate:
> +       kfree(gate);
> +free_clks:
> +       kfree(clks);
> +free_clkdata:
> +       kfree(clk_data);
> +}
> +
> +
> +
>  /* Matches for factors clocks */
>  static const struct of_device_id clk_factors_match[] __initconst = {
>         {.compatible = "allwinner,sun4i-pll1-clk", .data = &sun4i_pll1_data,},
> @@ -637,6 +857,13 @@ static const struct of_device_id clk_div_match[] __initconst = {
>         {}
>  };
>  
> +/* Matches for divided outputs */
> +static const struct of_device_id clk_divs_match[] __initconst = {
> +       {.compatible = "allwinner,sun4i-pll5-clk", .data = &pll5_divs_data,},
> +       {.compatible = "allwinner,sun4i-pll6-clk", .data = &pll6_divs_data,},
> +       {}
> +};
> +
>  /* Matches for mux clocks */
>  static const struct of_device_id clk_mux_match[] __initconst = {
>         {.compatible = "allwinner,sun4i-cpu-clk", .data = &sun4i_cpu_mux_data,},
> @@ -714,6 +941,9 @@ static void __init sunxi_init_clocks(struct device_node *np)
>         /* Register divider clocks */
>         of_sunxi_table_clock_setup(clk_div_match, sunxi_divider_clk_setup);
>  
> +       /* Register divided output clocks */
> +       of_sunxi_table_clock_setup(clk_divs_match, sunxi_divs_clk_setup);
> +
>         /* Register mux clocks */
>         of_sunxi_table_clock_setup(clk_mux_match, sunxi_mux_clk_setup);
>  
> -- 
> 1.8.5.1
> 
