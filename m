From: andrew@aj.id.au (Andrew Jeffery)
Date: Mon, 25 Sep 2017 22:10:55 +0930
Subject: [PATCH v2 3/5] clk: aspeed: Add platform driver and register PLLs
In-Reply-To: <20170921042641.7326-4-joel@jms.id.au>
References: <20170921042641.7326-1-joel@jms.id.au>
 <20170921042641.7326-4-joel@jms.id.au>
Message-ID: <1506343255.30138.29.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-09-21 at 13:56 +0930, Joel Stanley wrote:
> This registers a platform driver to set up all of the non-core clocks.
>?
> The clocks that have configurable rates are now registered.
>?
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> ?drivers/clk/clk-aspeed.c | 129 +++++++++++++++++++++++++++++++++++++++++++++++
> ?1 file changed, 129 insertions(+)
>?
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index e614c61b82d2..19531798e040 100644
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
> @@ -115,6 +117,20 @@ static const struct aspeed_gate_data aspeed_gates[] __initconst = {
> ?	/* 31: reserved */
> ?};
> ?
> +static const char * const eclk_parents[] = {"d1pll", "hpll", "mpll"};
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
> @@ -139,6 +155,21 @@ static const struct clk_div_table ast2500_div_table[] = {
> ?	{ 0 }
> ?};
> ?
> +struct aspeed_clk_soc_data {
> +	const struct clk_div_table *div_table;
> +	const struct clk_div_table *mac_div_table;
> +};
> +
> +static const struct aspeed_clk_soc_data ast2500_data = {
> +	.div_table = ast2500_div_table,
> +	.mac_div_table = ast2500_mac_div_table,
> +};
> +
> +static const struct aspeed_clk_soc_data ast2400_data = {
> +	.div_table = ast2400_div_table,
> +	.mac_div_table = ast2400_div_table,
> +};
> +
> ?static struct clk_hw *aspeed_calc_pll(const char *name, u32 val)
> ?{
> ?	unsigned int mult, div;
> @@ -160,6 +191,104 @@ static struct clk_hw *aspeed_calc_pll(const char *name, u32 val)
> ?			mult, div);
> ?}
> ?
> +static int __init aspeed_clk_probe(struct platform_device *pdev)
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
> +	div_table = soc_data->div_table;
> +	mac_div_table = soc_data->mac_div_table;
> +
> +	/* UART clock div13 setting */
> +	regmap_read(map, ASPEED_MISC_CTRL, &val);
> +	if (val & BIT(12))
> +		rate = 24000000 / 13;
> +	else
> +		rate = 24000000;
> +	/* TODO: Find the parent data for the uart clock */
> +	hw = clk_hw_register_fixed_rate(NULL, "uart", NULL, 0, rate);
> +	aspeed_clk_data->hws[ASPEED_CLK_UART] = hw;
> +
> +	/*
> +	?* Memory controller (M-PLL) PLL. This clock is configured by the
> +	?* bootloader, and is exposed to Linux as a read-only clock rate.
> +	?*/
> +	regmap_read(map, ASPEED_MPLL_PARAM, &val);
> +	aspeed_clk_data->hws[ASPEED_CLK_MPLL] =	aspeed_calc_pll("mpll", val);

IIRC the calculation in aspeed_calc_pll() is appropriate for the AST2500, but
not the AST2400.

> +
> +	/* SD/SDIO clock divider (TODO: There's a gate too) */
> +	hw = clk_hw_register_divider_table(NULL, "sdio", "hpll", 0,
> +			scu_base + ASPEED_CLK_SELECTION, 12, 3, 0,
> +			div_table,
> +			&aspeed_clk_lock);
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

On the AST2500 it looks like this should start at bit 28 for 3 bits, not bit
20. Separately, I'm not sure how to interpret the AST2400 datasheet here -
maybe it's similar but with different wording ("clock slow down" rather than
"divisor"?).

> +			div_table,

This doesn't seem to be correct. There's the problem of 0b000 and 0b001 mapping
the same value of 2 for the AST2500, whose table then increments in steps of 1.
The AST2400 mapping on the otherhand is multiples of 2 starting at 2, with no
inconsistency for 0b000 vs 0b001.

> +			&aspeed_clk_lock);
> +	aspeed_clk_data->hws[ASPEED_CLK_ECLK] = hw;
> +
> +	/* P-Bus (BCLK) clock divider */
> +	hw = clk_hw_register_divider_table(NULL, "bclk", "hpll", 0,
> +			scu_base + ASPEED_CLK_SELECTION, 0, 2, 0,

Bit 0 in SCU08 is a 1-bit field "CPU/AHB clock dynamic slow down enable". BCLK
is actually in SCU*D*8, but (perhaps confusingly) documented immediately below
SCU*0*8.

Cheers,

Andrew

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
> +
> ?static void __init aspeed_ast2400_cc(struct regmap *map)
> ?{
> ?	struct clk_hw *hw;
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170925/dc5ae955/attachment.sig>
