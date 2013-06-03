From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 4 Jun 2013 00:18:32 +0200
Subject: [PATCH RFC 3/3] clk: dt: binding for basic divider clock
In-Reply-To: <1370281990-15090-4-git-send-email-mturquette@linaro.org>
References: <1370281990-15090-1-git-send-email-mturquette@linaro.org>
 <1370281990-15090-4-git-send-email-mturquette@linaro.org>
Message-ID: <201306040018.33236.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 3. Juni 2013, 19:53:10 schrieb Mike Turquette:
> Devicetree binding for the basic clock divider, plus the setup function
> to register the clock.  Based on the existing fixed-clock binding.
> 
> Signed-off-by: Mike Turquette <mturquette@linaro.org>
> ---

[...]

> +/**
> + * of_div_clk_setup() - Setup function for simple div rate clock
> + */
> +void of_divider_clk_setup(struct device_node *node)
> +{
> +	struct clk *clk;
> +	const char *clk_name = node->name;
> +	void __iomem *reg;
> +	const char *parent_name;
> +	u8 clk_divider_flags = 0;
> +	u8 mask = 0;
> +	u8 shift = 0;

in the mux-clock these 3 are unsigned long and u32 types ... what is correct?


> +	struct clk_div_table *table;
> +
> +	of_property_read_string(node, "clock-output-names", &clk_name);
> +
> +	parent_name = of_clk_get_parent_name(node, 0);
> +
> +	reg = of_iomap(node, 0);
> +
> +	if (of_property_read_u8(node, "mask", &mask)) {
> +		pr_err("%s: missing mask property for %s\n", __func__, node->name);
> +		return;
> +	}
> +
> +	if (of_property_read_u8(node, "shift", &shift))
> +		pr_debug("%s: missing shift property defaults to zero for %s\n",
> +				__func__, node->name);

same here ... mux reads u32

> +	if (of_property_read_bool(node, "index_one"))
> +		clk_divider_flags |= CLK_DIVIDER_ONE_BASED;
> +
> +	if (of_property_read_bool(node, "index_power_of_two"))
> +		clk_divider_flags |= CLK_DIVIDER_POWER_OF_TWO;
> +
> +	if (of_property_read_bool(node, "index_allow_zero"))
> +		clk_divider_flags |= CLK_DIVIDER_ALLOW_ZERO;
> +
> +	table = of_clk_get_div_table(node);
> +	if (IS_ERR(table))
> +		return;
> +
> +	clk = clk_register_divider_table(NULL, clk_name,
> +			parent_name, 0,
> +			reg, shift, mask,
> +			clk_divider_flags, table,
> +			NULL);

this causes trouble, as the divider clock code above still requires a width 
instead of a mask. I remember talk about this going to change separately, but 
couldn't find anything of the sort in linux-next.



> +
> +	if (!IS_ERR(clk))
> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +}
> +EXPORT_SYMBOL_GPL(of_divider_clk_setup);
> +CLK_OF_DECLARE(divider_clk, "divider-clock", of_divider_clk_setup);
> +#endif
