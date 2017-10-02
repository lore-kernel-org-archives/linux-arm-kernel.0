From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 2 Oct 2017 14:24:35 -0700
Subject: [PATCH v2 3/5] clk: aspeed: Add platform driver and register PLLs
In-Reply-To: <20170921042641.7326-4-joel@jms.id.au>
References: <20170921042641.7326-1-joel@jms.id.au>
 <20170921042641.7326-4-joel@jms.id.au>
Message-ID: <20171002212435.GP457@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/21, Joel Stanley wrote:
> @@ -160,6 +191,104 @@ static struct clk_hw *aspeed_calc_pll(const char *name, u32 val)
>  			mult, div);
>  }
>  
> +static int __init aspeed_clk_probe(struct platform_device *pdev)

Drop __init? Should be a section mismatch with __init here.

> +{
> +	const struct aspeed_clk_soc_data *soc_data;
> +	const struct clk_div_table *mac_div_table;
> +	const struct clk_div_table *div_table;
> +	struct device *dev = &pdev->dev;
> +	struct regmap *map;
> +	struct clk_hw *hw;
> +	u32 val, rate;
> +
> +	map = syscon_node_to_regmap(dev->of_node);
> +	if (IS_ERR(map)) {
> +		dev_err(dev, "no syscon regmap\n");
> +		return PTR_ERR(map);
> +	}
> +
> +	/* SoC generations share common layouts but have different divisors */
> +	soc_data = of_device_get_match_data(&pdev->dev);

Check for soc_data being NULL.

> +	div_table = soc_data->div_table;
> +	mac_div_table = soc_data->mac_div_table;
> +
> +	/* UART clock div13 setting */
> +	regmap_read(map, ASPEED_MISC_CTRL, &val);
> +	if (val & BIT(12))

What does BIT(12) mean? #define or comment please.

> +		rate = 24000000 / 13;
> +	else
> +		rate = 24000000;
> +	/* TODO: Find the parent data for the uart clock */
> +	hw = clk_hw_register_fixed_rate(NULL, "uart", NULL, 0, rate);
> +	aspeed_clk_data->hws[ASPEED_CLK_UART] = hw;
> +
> +	/*
> +	 * Memory controller (M-PLL) PLL. This clock is configured by the
> +	 * bootloader, and is exposed to Linux as a read-only clock rate.
> +	 */
> +	regmap_read(map, ASPEED_MPLL_PARAM, &val);
> +	aspeed_clk_data->hws[ASPEED_CLK_MPLL] =	aspeed_calc_pll("mpll", val);
> +
> +	/* SD/SDIO clock divider (TODO: There's a gate too) */
> +	hw = clk_hw_register_divider_table(NULL, "sdio", "hpll", 0,

Please pass your dev pointer here from the platform device.

> +			scu_base + ASPEED_CLK_SELECTION, 12, 3, 0,
> +			div_table,
> +			&aspeed_clk_lock);

And check for errors? Perhaps use devm_clk_hw_regsiter() APIs and
construct the dividers and muxes directly instead of using the
basic type registration APIs.

> +	aspeed_clk_data->hws[ASPEED_CLK_SDIO] = hw;
> +
> +	/* MAC AHB bus clock divider */
> +	hw = clk_hw_register_divider_table(NULL, "mac", "hpll", 0,
> +			scu_base + ASPEED_CLK_SELECTION, 16, 3, 0,
> +			mac_div_table,
> +			&aspeed_clk_lock);
> +	aspeed_clk_data->hws[ASPEED_CLK_MAC] = hw;
> +
> +	/* LPC Host (LHCLK) clock divider */
> +	hw = clk_hw_register_divider_table(NULL, "lhclk", "hpll", 0,
> +			scu_base + ASPEED_CLK_SELECTION, 20, 3, 0,
> +			div_table,
> +			&aspeed_clk_lock);
> +	aspeed_clk_data->hws[ASPEED_CLK_LHCLK] = hw;
> +
> +	/* Video Engine (ECLK) mux and clock divider */
> +	hw = clk_hw_register_mux(NULL, "eclk_mux",
> +			eclk_parents, ARRAY_SIZE(eclk_parents), 0,
> +			scu_base + ASPEED_CLK_SELECTION, 2, 2,
> +			0, &aspeed_clk_lock);
> +	aspeed_clk_data->hws[ASPEED_CLK_ECLK_MUX] = hw;
> +	hw = clk_hw_register_divider_table(NULL, "eclk", "eclk_mux", 0,
> +			scu_base + ASPEED_CLK_SELECTION, 20, 3, 0,
> +			div_table,
> +			&aspeed_clk_lock);
> +	aspeed_clk_data->hws[ASPEED_CLK_ECLK] = hw;
> +
> +	/* P-Bus (BCLK) clock divider */
> +	hw = clk_hw_register_divider_table(NULL, "bclk", "hpll", 0,
> +			scu_base + ASPEED_CLK_SELECTION, 0, 2, 0,
> +			div_table,
> +			&aspeed_clk_lock);
> +	aspeed_clk_data->hws[ASPEED_CLK_BCLK] = hw;
> +
> +	return 0;
> +};
> +
> +static const struct of_device_id aspeed_clk_dt_ids[] = {
> +	{ .compatible = "aspeed,ast2400-scu", .data = &ast2400_data },
> +	{ .compatible = "aspeed,ast2500-scu", .data = &ast2500_data },
> +	{ },

           ^
Nitpick, drop the comma

> +};
> +
> +static struct platform_driver aspeed_clk_driver = {
> +	.probe  = aspeed_clk_probe,
> +	.driver = {
> +		.name = "aspeed-clk",
> +		.of_match_table = aspeed_clk_dt_ids,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +builtin_platform_driver(aspeed_clk_driver);
> +
> +

Kill a newline, save the internet.

>  static void __init aspeed_ast2400_cc(struct regmap *map)
>  {
>  	struct clk_hw *hw;
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
