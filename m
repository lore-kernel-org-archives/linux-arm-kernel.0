From: andrew@aj.id.au (Andrew Jeffery)
Date: Mon, 25 Sep 2017 21:32:04 +0930
Subject: [PATCH v2 2/5] clk: aspeed: Register core clocks
In-Reply-To: <20170921042641.7326-3-joel@jms.id.au>
References: <20170921042641.7326-1-joel@jms.id.au>
 <20170921042641.7326-3-joel@jms.id.au>
Message-ID: <1506340924.30138.26.camel@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2017-09-21 at 13:56 +0930, Joel Stanley wrote:
> This registers the core clocks; those which are required to calculate
> the rate of the timer periperhal so the system can load a clocksource
> driver.
>?
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> ?drivers/clk/clk-aspeed.c | 152 ++++++++++++++++++++++++++++++++++++++++++++++-
> ?1 file changed, 149 insertions(+), 3 deletions(-)
>?
> diff --git a/drivers/clk/clk-aspeed.c b/drivers/clk/clk-aspeed.c
> index 824c54767009..e614c61b82d2 100644
> --- a/drivers/clk/clk-aspeed.c
> +++ b/drivers/clk/clk-aspeed.c
> @@ -11,12 +11,12 @@
> ?
> ?#define pr_fmt(fmt) "clk-aspeed: " fmt
> ?
> -#include <linux/slab.h>
> -#include <linux/of_address.h>
> ?#include <linux/clk-provider.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_address.h>
> ?#include <linux/regmap.h>
> +#include <linux/slab.h>
> ?#include <linux/spinlock.h>
> -#include <linux/mfd/syscon.h>
> ?
> ?#include <dt-bindings/clock/aspeed-clock.h>
> ?
> @@ -28,6 +28,9 @@
> ?#define ASPEED_MISC_CTRL	0x2c
> ?#define ASPEED_STRAP		0x70
> ?
> +/* Globally visible clocks */
> +static DEFINE_SPINLOCK(aspeed_clk_lock);
> +
> ?/* Keeps track of all clocks */
> ?static struct clk_hw_onecell_data *aspeed_clk_data;
> ?
> @@ -112,9 +115,137 @@ static const struct aspeed_gate_data aspeed_gates[] __initconst = {
> ?	/* 31: reserved */
> ?};
> ?
> +static const struct clk_div_table ast2400_div_table[] = {
> +	{ 0x0, 2 },
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
> +static const struct clk_div_table ast2500_div_table[] = {
> +	{ 0x0, 4 },
> +	{ 0x1, 8 },
> +	{ 0x2, 12 },
> +	{ 0x3, 16 },
> +	{ 0x4, 20 },
> +	{ 0x5, 24 },
> +	{ 0x6, 28 },
> +	{ 0x7, 32 },
> +	{ 0 }
> +};

ast2500_div_table is unused?

> +
> +static struct clk_hw *aspeed_calc_pll(const char *name, u32 val)
> +{
> +	unsigned int mult, div;
> +
> +	if (val & BIT(20)) {
> +		/* Pass through mode */
> +		mult = div = 1;
> +	} else {
> +		/* F = clkin * [(M+1) / (N+1)] / (P + 1) */
> +		u32 p = (val >> 13) & 0x3f;
> +		u32 m = (val >> 5) & 0xff;
> +		u32 n = val & 0x1f;
> +
> +		mult = (m + 1) / (n + 1);
> +		div = p + 1;
> +	}
> +
> +	return clk_hw_register_fixed_factor(NULL, name, "clkin", 0,
> +			mult, div);
> +}
> +
> +static void __init aspeed_ast2400_cc(struct regmap *map)
> +{
> +	struct clk_hw *hw;
> +	u32 val, div, mult;
> +
> +	/*
> +	?* High-speed PLL clock derived from the crystal. This the CPU clock,
> +	?* and we assume that it is enabled
> +	?*/
> +	regmap_read(map, ASPEED_HPLL_PARAM, &val);
> +	WARN(val & BIT(18), "clock is strapped not configured");

I don't quite understand the intent of the warning - are we just trying to say
that the defaults have been assumed and they may not match reality? It's
probably not a great idea to not strap the board properly, but you could get
away with it for a given configuration (Numerator = 20, H-PLL Output Divider
set, H-PLL denominator = 1)

> +	if (val & BIT(17)) {
> +		/* Pass through mode */
> +		mult = div = 1;
> +	} else {
> +		/* F = 24Mhz * (2-OD) * [(N + 2) / (D + 1)] */
> +		u32 n = (val >> 5) & 0x3f;
> +		u32 od = (val >> 4) & 0x1;
> +		u32 d = val & 0xf;
> +
> +		mult = (2 - od) * (n + 2);
> +		div = d + 1;
> +	}
> +	hw = clk_hw_register_fixed_factor(NULL, "hpll", "clkin", 0, mult, div);
> +	aspeed_clk_data->hws[ASPEED_CLK_HPLL] = hw;
> +
> +	/*
> +	?* Strap bits 11:10 define the CPU/AHB clock frequency ratio (aka HCLK)
> +	?*???00: Select CPU:AHB = 1:1
> +	?*???01: Select CPU:AHB = 2:1
> +	?*???10: Select CPU:AHB = 4:1
> +	?*???11: Select CPU:AHB = 3:1
> +	?*/
> +	regmap_read(map, ASPEED_STRAP, &val);
> +	val = (val >> 10) & 0x3;

How do the calculations below line up with the comment above? I can't see the
connection and I feel like I've missed something.

> +	div = val + 1;

This is only a valid mapping for 0b00 and 0b01?

> +	if (div == 2)
> +		div = 3;

If (div == 2) after adding 1, then the original value was 0b01, and so div
should remain 2?

> +	else if (div == 3)
> +		div = 2;

If (div == 3) after adding 1, then the original value was 0b10, and so div
should be 4?

> +	hw = clk_hw_register_fixed_factor(NULL, "ahb", "hpll", 0, 1, div);
> +	aspeed_clk_data->hws[ASPEED_CLK_AHB] = hw;
> +
> +	/* APB clock clock selection register SCU08 (aka PCLK) */
> +	hw = clk_hw_register_divider_table(NULL, "apb", "hpll", 0,
> +			scu_base + ASPEED_CLK_SELECTION, 23, 3, 0,
> +			ast2400_div_table,
> +			&aspeed_clk_lock);
> +	aspeed_clk_data->hws[ASPEED_CLK_APB] = hw;
> +}
> +
> +static void __init aspeed_ast2500_cc(struct regmap *map)
> +{
> +	struct clk_hw *hw;
> +	u32 val, div;
> +
> +	/*
> +	?* High-speed PLL clock derived from the crystal. This the CPU clock,
> +	?* and we assume that it is enabled
> +	?*/
> +	regmap_read(map, ASPEED_HPLL_PARAM, &val);
> +	aspeed_clk_data->hws[ASPEED_CLK_HPLL] = aspeed_calc_pll("hpll", val);

Why did you extract the aspeed_calc_pll() implementation for the ast2500 but
not the ast2400?

> +
> +	/* Strap bits 11:9 define the AXI/AHB clock frequency ratio (aka HCLK)*/
> +	regmap_read(map, ASPEED_STRAP, &val);
> +	val = (val >> 9) & 0x7;
> +	WARN_ON(val == 0);

Maybe WARN() would be better here to explain what's going wrong (zero is an
undefined value)?

> +	div = 2 * (val + 1);
> +	hw = clk_hw_register_fixed_factor(NULL, "ahb", "hpll", 0, 1, div);
> +	aspeed_clk_data->hws[ASPEED_CLK_AHB] = hw;
> +
> +	/* APB clock clock selection register SCU08 (aka PCLK) */
> +	/* TODO: this is wrong! */

Why is this wrong?

> +	regmap_read(map, ASPEED_CLK_SELECTION, &val);
> +	val = (val >> 23) & 0x7;
> +	div = 4 * (val + 1);
> +	hw = clk_hw_register_fixed_factor(NULL, "apb", "hpll", 0, 1, div);
> +	aspeed_clk_data->hws[ASPEED_CLK_APB] = hw;
> +};
> +
> +
> ?static void __init aspeed_cc_init(struct device_node *np)
> ?{
> ?	struct regmap *map;
> +	unsigned long freq;
> +	struct clk_hw *hw;
> ?	u32 val;
> ?	int ret;
> ?	int i;
> @@ -153,6 +284,21 @@ static void __init aspeed_cc_init(struct device_node *np)
> ?		return;
> ?	}
> ?
> +	/* CLKIN is the crystal oscillator, 24 or 25MHz selected by strapping */
> +	if (val & BIT(23))
> +		freq = 25000000;
> +	else
> +		freq = 24000000;

This isn't true on the AST2400, where CLKIN could be 24 OR 48MHz when BIT(23) is
clear. You need to test BIT(18) as well on the AST2400 to disambiguate.

> +	hw = clk_hw_register_fixed_rate(NULL, "clkin", NULL, 0, freq);
> +	pr_debug("clkin @%lu MHz\n", freq / 1000000);
> +
> +	if (of_device_is_compatible(np, "aspeed,ast2400-scu"))
> +		aspeed_ast2400_cc(map);
> +	else if (of_device_is_compatible(np, "aspeed,ast2500-scu"))
> +		aspeed_ast2500_cc(map);
> +	else
> +		pr_err("unknown platform, failed to add clocks\n");

I'm not confident that "borrowing" the SCU compatible like this is entirely in
the spirit of its MFD nature, but maybe others can chime in.

Cheers,

Andrew

> +
> ?	aspeed_clk_data->num = ASPEED_NUM_CLKS;
> ?	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, aspeed_clk_data);
> ?	if (ret)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170925/c4f24243/attachment-0001.sig>
