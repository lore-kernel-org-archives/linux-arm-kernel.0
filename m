From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 27 Jan 2017 12:04:36 -0800
Subject: [PATCH 2/2] drm/vc4: Add DSI driver
In-Reply-To: <20170124003853.16418-3-eric@anholt.net>
References: <20170124003853.16418-1-eric@anholt.net>
 <20170124003853.16418-3-eric@anholt.net>
Message-ID: <20170127200436.GI8801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23, Eric Anholt wrote:
> +static int
> +vc4_dsi_init_phy_clocks(struct vc4_dsi *dsi)
> +{
> +	struct device *dev = &dsi->pdev->dev;
> +	const char *parent_name = __clk_get_name(dsi->pll_phy_clock);
> +	static const struct {
> +		const char *dsi0_name, *dsi1_name;
> +		int div;
> +	} phy_clocks[] = {
> +		{ "dsi0_byte", "dsi1_byte", 8 },
> +		{ "dsi0_ddr2", "dsi1_ddr2", 4 },
> +		{ "dsi0_ddr", "dsi1_ddr", 2 },
> +	};
> +	int i;
> +
> +	dsi->clk_onecell.clk_num = ARRAY_SIZE(phy_clocks);
> +	dsi->clk_onecell.clks = devm_kcalloc(dev,
> +					     dsi->clk_onecell.clk_num,
> +					     sizeof(*dsi->clk_onecell.clks),
> +					     GFP_KERNEL);
> +	if (!dsi->clk_onecell.clks)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < ARRAY_SIZE(phy_clocks); i++) {
> +		struct clk_fixed_factor *fix = &dsi->phy_clocks[i];
> +		struct clk_init_data init;
> +		struct clk *clk;
> +
> +		/* We just use core fixed factor clock ops for the PHY
> +		 * clocks.  The clocks are actually gated by the
> +		 * PHY_AFEC0_DDRCLK_EN bits, which we should be
> +		 * setting if we use the DDR/DDR2 clocks.  However,
> +		 * vc4_dsi_encoder_enable() is setting up both AFEC0,
> +		 * setting both our parent DSI PLL's rate and this
> +		 * clock's rate, so it knows if DDR/DDR2 are going to
> +		 * be used and could enable the gates itself.
> +		 */
> +		fix->mult = 1;
> +		fix->div = phy_clocks[i].div;
> +		fix->hw.init = &init;
> +
> +		memset(&init, 0, sizeof(init));
> +		init.parent_names = &parent_name;
> +		init.num_parents = 1;
> +		if (dsi->port == 1)
> +			init.name = phy_clocks[i].dsi1_name;
> +		else
> +			init.name = phy_clocks[i].dsi0_name;
> +		init.ops = &clk_fixed_factor_ops;
> +		init.flags = CLK_IS_BASIC;

Please don't use this flag unless you need it for something.

> +
> +		clk = devm_clk_register(dev, &fix->hw);

Can you use devm_clk_hw_register() instead please?

> +		if (IS_ERR(clk))
> +			return PTR_ERR(clk);
> +
> +		dsi->clk_onecell.clks[i] = clk;
> +	}
> +
> +	return of_clk_add_provider(dev->of_node,

And the of_clk_add_hw_provider() API too.

> +				   of_clk_src_onecell_get,
> +				   &dsi->clk_onecell);
> +}
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
