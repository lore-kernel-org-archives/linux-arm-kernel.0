From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Thu, 31 Aug 2017 12:02:59 +0200
Subject: [PATCH] clk: at91: utmi: Support configurable multipliers
In-Reply-To: <20170710122409.3017-1-inguin@gmx.de>
References: <20170710122409.3017-1-inguin@gmx.de>
Message-ID: <20170831100259.qj4cisnu2il6mo5y@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ingo,

I did a similar patch, and I was told that you sent something similar.
I missed your patch since I have not subscribed to the linux-clk mailing
list. If it's related to at91, you should send it to linux-arm mailing list
too.

On Mon, Jul 10, 2017 at 02:24:09PM +0200, Ingo van Lil wrote:
> The AT91 UTMI clock is a PLL generating the 480 MHz USB clock.
> Originally, this PLL always had a fixed x40 multiplier, thus requiring
> a 12 MHz input clock. Recent SOCs (sama5d2 and sama5d3) have a special
> function register for configuring this multiplier, allowing to use
> different main clock frequencies.
> 
> Signed-off-by: Ingo van Lil <inguin@gmx.de>

Unfortunately, replacing my patch by yours, it no longer works. More
precisely, USB stuff is broken: utmi rate is weird.

> ---
>  drivers/clk/at91/clk-utmi.c  | 105 +++++++++++++++++++++++++++++++++++++++++--
>  include/soc/at91/atmel-sfr.h |   2 +
>  2 files changed, 104 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/at91/clk-utmi.c b/drivers/clk/at91/clk-utmi.c
> index aadabd9..d41c38b 100644
> --- a/drivers/clk/at91/clk-utmi.c
> +++ b/drivers/clk/at91/clk-utmi.c
> @@ -14,14 +14,29 @@
>  #include <linux/of.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
> +#include <soc/at91/atmel-sfr.h>
>  
>  #include "pmc.h"
>  
> +/* default multiplier for SOCs that do not allow configuration via SFR */
>  #define UTMI_FIXED_MUL		40
>  
> +/* supported multiplier settings for SOCs that allow configuration via SFR */
> +struct utmi_multipliers {
> +	const char *sfr_compatible_name;
> +	u8 multipliers[4];
> +};
> +
> +static const struct utmi_multipliers utmi_multipliers[] = {
> +	{ "atmel,sama5d2-sfr", { 40, 30, 20, 40 } },
> +	{ "atmel,sama5d3-sfr", { 40, 30, 20, 10 } },
> +};
> +

I will see if there is no mistake in the datasheet. On my side, I deal
only with '40, 30, 20, 10' case, I am not sure we have to take care of
'40, 30, 20, 40' even if it's not a mistake in the datasheet.

>  struct clk_utmi {
>  	struct clk_hw hw;
>  	struct regmap *regmap;
> +	struct regmap *sfr_regmap;
> +	const u8 *multipliers;
>  };
>  
>  #define to_clk_utmi(hw) container_of(hw, struct clk_utmi, hw)
> @@ -66,8 +81,67 @@ static void clk_utmi_unprepare(struct clk_hw *hw)
>  static unsigned long clk_utmi_recalc_rate(struct clk_hw *hw,
>  					  unsigned long parent_rate)
>  {
> -	/* UTMI clk is a fixed clk multiplier */
> -	return parent_rate * UTMI_FIXED_MUL;
> +	struct clk_utmi *utmi = to_clk_utmi(hw);
> +	u8 mul = UTMI_FIXED_MUL;
> +
> +	if (utmi->sfr_regmap && utmi->multipliers) {
> +		u32 regval;
> +		regmap_read(utmi->sfr_regmap, AT91_SFR_UTMICKTRIM, &regval);
> +		mul = utmi->multipliers[regval & AT91_UTMICKTRIM_FREQ_MASK];
> +	}
> +
> +	return parent_rate * mul;
> +}
> +
> +static long clk_utmi_round_rate(struct clk_hw *hw, unsigned long rate,
> +				unsigned long *parent_rate)
> +{
> +	struct clk_utmi *utmi = to_clk_utmi(hw);
> +	unsigned long bestrate = 0;
> +	int bestdiff = -1;
> +	int i;
> +
> +	if (!utmi->sfr_regmap || !utmi->multipliers)
> +		return *parent_rate * UTMI_FIXED_MUL;
> +
> +	for (i = 0; i < ARRAY_SIZE(utmi_multipliers); i++) {
> +		unsigned long tmprate = *parent_rate * utmi->multipliers[i];
> +		int tmpdiff;
> +
> +		if (tmprate < rate)
> +			continue;
> +
> +		tmpdiff = tmprate - rate;
> +		if (bestdiff < 0 || bestdiff > tmpdiff) {
> +			bestrate = tmprate;
> +			bestdiff = tmpdiff;
> +		}
> +
> +		if (!bestdiff)
> +			break;
> +	}
> +
> +	return bestrate;
> +}
> +
> +static int clk_utmi_set_rate(struct clk_hw *hw, unsigned long rate,
> +			     unsigned long parent_rate)
> +{
> +	struct clk_utmi *utmi = to_clk_utmi(hw);
> +	int i;
> +
> +	if (!utmi->sfr_regmap || !utmi->multipliers)
> +		return rate == parent_rate * UTMI_FIXED_MUL ? 0 : -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(utmi_multipliers); i++) {
> +		if (rate == parent_rate * utmi->multipliers[i]) {
> +			regmap_update_bits(utmi->sfr_regmap, AT91_SFR_UTMICKTRIM,
> +					   AT91_UTMICKTRIM_FREQ_MASK, i);
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
>  }

What's the purpose of this addition? Who should set the rate of the utmi
clock? I mean you have no choice, the rate is 480 MHz.

>  
>  static const struct clk_ops utmi_ops = {
> @@ -75,10 +149,13 @@ static const struct clk_ops utmi_ops = {
>  	.unprepare = clk_utmi_unprepare,
>  	.is_prepared = clk_utmi_is_prepared,
>  	.recalc_rate = clk_utmi_recalc_rate,
> +	.round_rate = clk_utmi_round_rate,
> +	.set_rate = clk_utmi_set_rate,
>  };
>  
>  static struct clk_hw * __init
>  at91_clk_register_utmi(struct regmap *regmap,
> +		       struct regmap *sfr_regmap, const u8 *multipliers,
>  		       const char *name, const char *parent_name)
>  {
>  	struct clk_utmi *utmi;
> @@ -98,6 +175,8 @@ at91_clk_register_utmi(struct regmap *regmap,
>  
>  	utmi->hw.init = &init;
>  	utmi->regmap = regmap;
> +	utmi->sfr_regmap = sfr_regmap;
> +	utmi->multipliers = multipliers;
>  
>  	hw = &utmi->hw;
>  	ret = clk_hw_register(NULL, &utmi->hw);
> @@ -115,6 +194,9 @@ static void __init of_at91sam9x5_clk_utmi_setup(struct device_node *np)
>  	const char *parent_name;
>  	const char *name = np->name;
>  	struct regmap *regmap;
> +	struct regmap *sfr_regmap;
> +	const u8 *multipliers = NULL;
> +	size_t i;
>  
>  	parent_name = of_clk_get_parent_name(np, 0);
>  
> @@ -124,7 +206,24 @@ static void __init of_at91sam9x5_clk_utmi_setup(struct device_node *np)
>  	if (IS_ERR(regmap))
>  		return;
>  
> -	hw = at91_clk_register_utmi(regmap, name, parent_name);
> +	for (i = 0; i < ARRAY_SIZE(utmi_multipliers); i++) {
> +		sfr_regmap = syscon_regmap_lookup_by_compatible(
> +			utmi_multipliers[i].sfr_compatible_name);
> +		if (!IS_ERR(sfr_regmap)) {
> +			pr_debug("clk-utmi: found sfr node: %s\n",
> +				 utmi_multipliers[i].sfr_compatible_name);
> +			multipliers = utmi_multipliers[i].multipliers;
> +			break;
> +		}
> +	}
> +
> +	if (IS_ERR(sfr_regmap)) {
> +		pr_debug("clk-utmi: failed to find sfr node\n");
> +		sfr_regmap = NULL;
> +	}
> +
> +	hw = at91_clk_register_utmi(regmap, sfr_regmap, multipliers,
> +				    name, parent_name);
>  	if (IS_ERR(hw))
>  		return;
>  
> diff --git a/include/soc/at91/atmel-sfr.h b/include/soc/at91/atmel-sfr.h
> index 506ea8f..763948e 100644
> --- a/include/soc/at91/atmel-sfr.h
> +++ b/include/soc/at91/atmel-sfr.h
> @@ -17,6 +17,7 @@
>  /* 0x08 ~ 0x0c: Reserved */
>  #define AT91_SFR_OHCIICR	0x10	/* OHCI INT Configuration Register */
>  #define AT91_SFR_OHCIISR	0x14	/* OHCI INT Status Register */
> +#define AT91_SFR_UTMICKTRIM	0x30	/* UTMI Clock Trimming Register */
>  #define AT91_SFR_I2SCLKSEL	0x90	/* I2SC Register */
>  
>  /* Field definitions */
> @@ -28,5 +29,6 @@
>  					 AT91_OHCIICR_SUSPEND_B | \
>  					 AT91_OHCIICR_SUSPEND_C)
>  
> +#define AT91_UTMICKTRIM_FREQ_MASK	0x03

You can use GENMASK here.

>  
>  #endif /* _LINUX_MFD_SYSCON_ATMEL_SFR_H */

I have attached the patch I did.

Regards

Ludovic
-------------- next part --------------
A non-text attachment was scrubbed...
Name: utmi.patch
Type: text/x-diff
Size: 4972 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170831/a0aeff3f/attachment.bin>
