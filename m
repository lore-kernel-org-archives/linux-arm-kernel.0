From: andrew@aj.id.au (Andrew Jeffery)
Date: Thu, 05 Oct 2017 17:52:31 +1030
Subject: [PATCH v4 3/5] clk: aspeed: Add platform driver and register PLLs
In-Reply-To: <20171003065540.11722-4-joel@jms.id.au>
References: <20171003065540.11722-1-joel@jms.id.au>
 <20171003065540.11722-4-joel@jms.id.au>
Message-ID: <1507188151.5452.65.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-10-03 at 17:25 +1030, Joel Stanley wrote:
> This registers a platform driver to set up all of the non-core clocks.
>?
> The clocks that have configurable rates are now registered.
>?
> Signed-off-by: Joel Stanley <joel@jms.id.au>
>?
> --
> v4:
> ?- Add eclk div table to fix ast2500 calculation
> ?- Add defines to document the BIT() macros
> ?- Pass dev where we can when registering clocks
> ?- Check for errors when registering clk_hws
> v3:
> ?- Fix bclk and eclk calculation
> ?- Seperate out ast2400 and ast25000 for pll calculation
>?
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> ?drivers/clk/clk-aspeed.c | 163 +++++++++++++++++++++++++++++++++++++++++++++++
> ?1 file changed, 163 insertions(+)
>?
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index d39cf51a5114..adb295292189 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -14,6 +14,8 @@
> ?#include <linux/clk-provider.h>
> ?#include <linux/mfd/syscon.h>
> ?#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> ?#include <linux/regmap.h>
> ?#include <linux/slab.h>
> ?#include <linux/spinlock.h>
> @@ -114,6 +116,32 @@ static const struct aspeed_gate_data aspeed_gates[] __initconst = {
> ?	[ASPEED_CLK_GATE_LHCCLK] =	{ 28, -1, "lhclk-gate",		"lhclk", 0 }, /* LPC master/LPC+ */
> ?};
> ?
> +static const char * const eclk_parents[] = {"d1pll", "hpll", "mpll"};

Hate to throw a spanner in the works, but I think we need some extra bits here
for handling the AST2400. ECLK with M-PLL as the parent divides the clock rate
by 2, there are four cases to handle where the last two cases are inverted, and
d1pll isn't a valid parent.

Also this table looks to be in reverse order to the field defined in the
datasheet.

> +
> +static const struct clk_div_table ast2500_eclk_div_table[] = {
> +	{ 0x0, 2 },
> +	{ 0x1, 2 },
> +	{ 0x2, 3 },
> +	{ 0x3, 4 },
> +	{ 0x4, 5 },
> +	{ 0x5, 6 },
> +	{ 0x6, 7 },
> +	{ 0x7, 8 },
> +	{ 0 }
> +};
> +
> +static const struct clk_div_table ast2500_mac_div_table[] = {
> +	{ 0x0, 4 }, /* Yep, really. Aspeed confirmed this is correct */
> +	{ 0x1, 4 },
> +	{ 0x2, 6 },
> +	{ 0x3, 8 },
> +	{ 0x4, 10 },
> +	{ 0x5, 12 },
> +	{ 0x6, 14 },
> +	{ 0x7, 16 },
> +	{ 0 }
> +};
> +
> ?static const struct clk_div_table ast2400_div_table[] = {
> ?	{ 0x0, 2 },
> ?	{ 0x1, 4 },
> @@ -179,6 +207,141 @@ static struct clk_hw *aspeed_ast2500_calc_pll(const char *name, u32 val)
> ?			mult, div);
> ?}
> ?
> +struct aspeed_clk_soc_data {
> +	const struct clk_div_table *div_table;
> +	const struct clk_div_table *mac_div_table;
> +	const struct clk_div_table *eclk_div_table;
> +	struct clk_hw *(*calc_pll)(const char *name, u32 val);

As a note, I just discovered the D-PLL (and D2-PLL where applicable) frequency
function is slightly different to M-PLL and H-PLL on both the AST2400 and
AST2500. I don't think that is significant yet, but it's something to watch out
for. The point is this callback isn't a general-purpose "calculate a PLL
frequency" function, so the name might be inappropriate.

> +};
> +
> +static const struct aspeed_clk_soc_data ast2500_data = {
> +	.div_table = ast2500_div_table,
> +	.mac_div_table = ast2500_mac_div_table,
> +	.eclk_div_table = ast2500_eclk_div_table,
> +	.calc_pll = aspeed_ast2500_calc_pll,
> +};
> +
> +static const struct aspeed_clk_soc_data ast2400_data = {
> +	.div_table = ast2400_div_table,
> +	.mac_div_table = ast2400_div_table,
> +	.eclk_div_table = ast2400_div_table,
> +	.calc_pll = aspeed_ast2400_calc_pll,
> +};
> +
> +static int aspeed_clk_probe(struct platform_device *pdev)
> +{
> +	const struct aspeed_clk_soc_data *soc_data;
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
> +	soc_data = of_device_get_match_data(dev);
> +	if (!soc_data) {
> +		dev_err(dev, "no match data for platform\n");
> +		return -EINVAL;
> +	}
> +
> +	/* UART clock div13 setting */
> +	regmap_read(map, ASPEED_MISC_CTRL, &val);
> +	if (val & UART_DIV13_EN)
> +		rate = 24000000 / 13;
> +	else
> +		rate = 24000000;
> +	/* TODO: Find the parent data for the uart clock */
> +	hw = clk_hw_register_fixed_rate(dev, "uart", NULL, 0, rate);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +	aspeed_clk_data->hws[ASPEED_CLK_UART] = hw;
> +
> +	/*
> +	?* Memory controller (M-PLL) PLL. This clock is configured by the
> +	?* bootloader, and is exposed to Linux as a read-only clock rate.
> +	?*/
> +	regmap_read(map, ASPEED_MPLL_PARAM, &val);
> +	hw = soc_data->calc_pll("mpll", val);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +	aspeed_clk_data->hws[ASPEED_CLK_MPLL] =	hw;
> +
> +	/* SD/SDIO clock divider (TODO: There's a gate too) */

That sneaky gate bit!

> +	hw = clk_hw_register_divider_table(dev, "sdio", "hpll", 0,
> +			scu_base + ASPEED_CLK_SELECTION, 12, 3, 0,
> +			soc_data->div_table,
> +			&aspeed_clk_lock);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +	aspeed_clk_data->hws[ASPEED_CLK_SDIO] = hw;
> +
> +	/* MAC AHB bus clock divider */
> +	hw = clk_hw_register_divider_table(dev, "mac", "hpll", 0,
> +			scu_base + ASPEED_CLK_SELECTION, 16, 3, 0,
> +			soc_data->mac_div_table,
> +			&aspeed_clk_lock);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +	aspeed_clk_data->hws[ASPEED_CLK_MAC] = hw;
> +
> +	/* LPC Host (LHCLK) clock divider */
> +	hw = clk_hw_register_divider_table(dev, "lhclk", "hpll", 0,
> +			scu_base + ASPEED_CLK_SELECTION, 20, 3, 0,
> +			soc_data->div_table,
> +			&aspeed_clk_lock);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +	aspeed_clk_data->hws[ASPEED_CLK_LHCLK] = hw;
> +
> +	/* Video Engine (ECLK) mux and clock divider */
> +	hw = clk_hw_register_mux(dev, "eclk_mux",
> +			eclk_parents, ARRAY_SIZE(eclk_parents), 0,
> +			scu_base + ASPEED_CLK_SELECTION, 2, 2,
> +			0, &aspeed_clk_lock);

See my comment on the eclk_parents table above.

> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +	aspeed_clk_data->hws[ASPEED_CLK_ECLK_MUX] = hw;
> +	hw = clk_hw_register_divider_table(dev, "eclk", "eclk_mux", 0,
> +			scu_base + ASPEED_CLK_SELECTION, 28, 3, 0,
> +			soc_data->eclk_div_table,
> +			&aspeed_clk_lock);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +	aspeed_clk_data->hws[ASPEED_CLK_ECLK] = hw;
> +
> +	/* P-Bus (BCLK) clock divider */
> +	hw = clk_hw_register_divider_table(dev, "bclk", "hpll", 0,
> +			scu_base + ASPEED_CLK_SELECTION_2, 0, 2, 0,
> +			soc_data->div_table,
> +			&aspeed_clk_lock);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +	aspeed_clk_data->hws[ASPEED_CLK_BCLK] = hw;
> +
> +	return 0;
> +};
> +
> +static const struct of_device_id aspeed_clk_dt_ids[] = {
> +	{ .compatible = "aspeed,ast2400-scu", .data = &ast2400_data },
> +	{ .compatible = "aspeed,ast2500-scu", .data = &ast2500_data },
> +	{ }
> +};
> +
> +static struct platform_driver aspeed_clk_driver = {
> +	.probe??= aspeed_clk_probe,
> +	.driver = {
> +		.name = "aspeed-clk",
> +		.of_match_table = aspeed_clk_dt_ids,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +builtin_platform_driver(aspeed_clk_driver);
> +
> ?static void __init aspeed_ast2400_cc(struct regmap *map)
> ?{
> ?	struct clk_hw *hw;

Cheers,

Andrew
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171005/82c465d9/attachment.sig>
