From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 21 Jul 2017 15:20:29 -0700
Subject: [PATCH v3 3/9] clk: at91: add audio pll clock drivers
In-Reply-To: <20170713074927.10882-4-quentin.schulz@free-electrons.com>
References: <20170713074927.10882-1-quentin.schulz@free-electrons.com>
 <20170713074927.10882-4-quentin.schulz@free-electrons.com>
Message-ID: <20170721222029.GO19878@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13, Quentin Schulz wrote:
> diff --git a/drivers/clk/at91/clk-audio-pll-pad.c b/drivers/clk/at91/clk-audio-pll-pad.c
> new file mode 100644
> index 000000000000..10dd6d625696
> --- /dev/null
> +++ b/drivers/clk/at91/clk-audio-pll-pad.c
> @@ -0,0 +1,206 @@
> +/*
> + *  Copyright (C) 2016 Atmel Corporation,
> + *                     Nicolas Ferre <nicolas.ferre@atmel.com>
> + *  Copyright (C) 2017 Free Electrons,
> + *		       Quentin Schulz <quentin.schulz@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>

Used?

> +#include <linux/clk/at91_pmc.h>
> +#include <linux/of.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +
> +#include "pmc.h"
> +
> +/*
> + * DOC: PAD output for fractional PLL clock for audio
> + *
> + * Traits of this clock:
> + * enable - clk_enable writes divisors and enables PAD output
> + * rate - rate is adjustable.
> + *        clk->rate = parent->rate / (qdaudio * div))
> + * parent - fixed parent.  No clk_set_parent support
> + */
> +
> +#define AUDIO_PLL_QDPAD(qd, div)	((AT91_PMC_AUDIO_PLL_QDPAD_EXTDIV(qd) & \
> +					  AT91_PMC_AUDIO_PLL_QDPAD_EXTDIV_MASK) | \
> +					 (AT91_PMC_AUDIO_PLL_QDPAD_DIV(div) & \
> +					  AT91_PMC_AUDIO_PLL_QDPAD_DIV_MASK))
> +
> +struct clk_audio_pad {
> +	struct clk_hw hw;
> +	struct regmap *regmap;
> +	u8 qdaudio;
> +	u8 div;
> +};
> +
> +#define to_clk_audio_pad(hw) container_of(hw, struct clk_audio_pad, hw)
> +
> +static int clk_audio_pll_pad_enable(struct clk_hw *hw)
> +{
> +	struct clk_audio_pad *apad_ck = to_clk_audio_pad(hw);
> +
> +	regmap_update_bits(apad_ck->regmap, AT91_PMC_AUDIO_PLL1,
> +			   AT91_PMC_AUDIO_PLL_QDPAD_MASK,
> +			   AUDIO_PLL_QDPAD(apad_ck->qdaudio, apad_ck->div));
> +	regmap_update_bits(apad_ck->regmap, AT91_PMC_AUDIO_PLL0,
> +			   AT91_PMC_AUDIO_PLL_PADEN, AT91_PMC_AUDIO_PLL_PADEN);
> +
> +	return 0;
> +}
> +
> +static void clk_audio_pll_pad_disable(struct clk_hw *hw)
> +{
> +	struct clk_audio_pad *apad_ck = to_clk_audio_pad(hw);
> +
> +	regmap_update_bits(apad_ck->regmap, AT91_PMC_AUDIO_PLL0,
> +			   AT91_PMC_AUDIO_PLL_PADEN, 0);
> +}
> +
> +static unsigned long clk_audio_pll_pad_recalc_rate(struct clk_hw *hw,
> +						   unsigned long parent_rate)
> +{
> +	struct clk_audio_pad *apad_ck = to_clk_audio_pad(hw);
> +	unsigned long apad_rate = 0;
> +
> +	if (apad_ck->qdaudio && apad_ck->div)
> +		apad_rate = parent_rate / (apad_ck->qdaudio * apad_ck->div);
> +
> +	pr_debug("A PLL/PAD: %s, apad_rate = %lu (div = %u, qdaudio = %u)\n",
> +		 __func__, apad_rate, apad_ck->div, apad_ck->qdaudio);
> +
> +	return apad_rate;
> +}
> +
> +static long clk_audio_pll_pad_round_rate(struct clk_hw *hw, unsigned long rate,
> +					 unsigned long *parent_rate)
> +{
> +	struct clk_hw *pclk = clk_hw_get_parent(hw);
> +	long best_rate = -EINVAL;
> +	unsigned long best_parent_rate;
> +	unsigned long tmp_qd;
> +	u32 div;
> +	long tmp_rate;
> +	int tmp_diff;
> +	int best_diff = -1;
> +
> +	pr_debug("A PLL/PAD: %s, rate = %lu (parent_rate = %lu)\n", __func__,
> +		 rate, *parent_rate);
> +
> +	/*
> +	 * Rate divisor is actually made of two different divisors, multiplied
> +	 * between themselves before dividing the rate.
> +	 * tmp_qd goes from 1 to 31 and div is either 2 or 3.
> +	 * In order to avoid testing twice the rate divisor (e.g. divisor 12 can
> +	 * be found with (tmp_qd, div) = (2, 6) or (3, 4)), we remove any loop
> +	 * for a rate divisor when div is 2 and tmp_qd is a multiple of 3.
> +	 * We cannot inverse it (condition div is 3 and tmp_qd is even) or we
> +	 * would miss some rate divisor that aren't reachable with div being 2
> +	 * (e.g. rate divisor 90 is made with div = 3 and tmp_qd = 30, thus
> +	 * tmp_qd is even so we skip it because we think div 2 could make this
> +	 * rate divisor which isn't possible since tmp_qd has to be <= 31).
> +	 */
> +	for (tmp_qd = 1; tmp_qd < AT91_PMC_AUDIO_PLL_QDPAD_EXTDIV_MAX; tmp_qd++)
> +		for (div = 2; div <= 3; div++) {
> +			if (div == 2 && tmp_qd % 3 == 0)
> +				continue;
> +
> +			best_parent_rate = clk_hw_round_rate(pclk,
> +							rate * tmp_qd * div);
> +			tmp_rate = best_parent_rate / (div * tmp_qd);
> +			tmp_diff = abs(rate - tmp_rate);
> +
> +			if (best_diff < 0 || best_diff > tmp_diff) {
> +				*parent_rate = best_parent_rate;
> +				best_rate = tmp_rate;
> +				best_diff = tmp_diff;
> +			}
> +		}
> +
> +	pr_debug("A PLL/PAD: %s, best_rate = %ld, best_parent_rate = %lu\n",
> +		 __func__, best_rate, best_parent_rate);
> +
> +	return best_rate;
> +}
> +
> +static int clk_audio_pll_pad_set_rate(struct clk_hw *hw, unsigned long rate,
> +				      unsigned long parent_rate)
> +{
> +	struct clk_audio_pad *apad_ck = to_clk_audio_pad(hw);
> +	u8 tmp_div;
> +
> +	pr_debug("A PLL/PAD: %s, rate = %lu (parent_rate = %lu)\n", __func__,
> +		 rate, parent_rate);
> +
> +	if (!rate)
> +		return -EINVAL;

This happens?

> +
> +	tmp_div = parent_rate / rate;
> +	if (tmp_div % 3 == 0) {
> +		apad_ck->qdaudio = tmp_div / 3;
> +		apad_ck->div = 3;
> +	} else {
> +		apad_ck->qdaudio = tmp_div / 2;
> +		apad_ck->div = 2;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops audio_pll_pad_ops = {
> +	.enable = clk_audio_pll_pad_enable,
> +	.disable = clk_audio_pll_pad_disable,
> +	.recalc_rate = clk_audio_pll_pad_recalc_rate,
> +	.round_rate = clk_audio_pll_pad_round_rate,
> +	.set_rate = clk_audio_pll_pad_set_rate,
> +};
> +
> +static void __init of_sama5d2_clk_audio_pll_pad_setup(struct device_node *np)
> +{
> +	struct clk_audio_pad *apad_ck;
> +	struct clk_init_data init;

Best to initialize to { } just in case we add something later.

> +	struct regmap *regmap;
> +	const char *parent_name;
> +	const char *name = np->name;
> +	int ret;
> +
> +	parent_name = of_clk_get_parent_name(np, 0);
> +
> +	of_property_read_string(np, "clock-output-names", &name);
> +
> +	regmap = syscon_node_to_regmap(of_get_parent(np));
> +	if (IS_ERR(regmap))
> +		return;
> +
> +	apad_ck = kzalloc(sizeof(*apad_ck), GFP_KERNEL);
> +	if (!apad_ck)
> +		return;
> +
> +	init.name = name;
> +	init.ops = &audio_pll_pad_ops;
> +	init.parent_names = (parent_name ? &parent_name : NULL);

Use of_clk_parent_fill()?

> +	init.num_parents = 1;
> +	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
> +		CLK_SET_RATE_PARENT;
> +
> +	apad_ck->hw.init = &init;
> +	apad_ck->regmap = regmap;
> +
> +	ret = clk_hw_register(NULL, &apad_ck->hw);
> +	if (ret)
> +		kfree(apad_ck);
> +	else
> +		of_clk_add_hw_provider(np, of_clk_hw_simple_get, &apad_ck->hw);

Maybe we should make this register sequence a helper function.
Seems common.

> +}
> +
> +CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_pad_setup,
> +	       "atmel,sama5d2-clk-audio-pll-pad",
> +	       of_sama5d2_clk_audio_pll_pad_setup);

We can't have a device driver for this?

> diff --git a/drivers/clk/at91/clk-audio-pll-pmc.c b/drivers/clk/at91/clk-audio-pll-pmc.c
> new file mode 100644
> index 000000000000..7b0847ed7a4b
> --- /dev/null
> +++ b/drivers/clk/at91/clk-audio-pll-pmc.c
> @@ -0,0 +1,174 @@
> +/*
> + *  Copyright (C) 2016 Atmel Corporation,
> + *                     Nicolas Ferre <nicolas.ferre@atmel.com>
> + *  Copyright (C) 2017 Free Electrons,
> + *		       Quentin Schulz <quentin.schulz@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>

Used?

> +#include <linux/clk/at91_pmc.h>
> +#include <linux/of.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +
> +#include "pmc.h"
> +
> +/*
> + * DOC: PMC output for fractional PLL clock for audio
> + *
> + * Traits of this clock:
> + * enable - clk_enable writes qdpmc, and enables PMC output
> + * rate - rate is adjustable.
> + *        clk->rate = parent->rate / (qdpmc + 1)
> + * parent - fixed parent.  No clk_set_parent support
> + */
> +
> +#define AUDIO_PLL_QDPMC_MAX		(AT91_PMC_AUDIO_PLL_QDPMC_MASK >> \
> +						AT91_PMC_AUDIO_PLL_QDPMC_OFFSET)
> +struct clk_audio_pmc {
> +	struct clk_hw hw;
> +	struct regmap *regmap;
> +	u8 qdpmc;
> +};
> +
> +#define to_clk_audio_pmc(hw) container_of(hw, struct clk_audio_pmc, hw)
> +
> +static int clk_audio_pll_pmc_enable(struct clk_hw *hw)
> +{
> +	struct clk_audio_pmc *apmc_ck = to_clk_audio_pmc(hw);
> +
> +	regmap_update_bits(apmc_ck->regmap, AT91_PMC_AUDIO_PLL0,
> +			   AT91_PMC_AUDIO_PLL_PMCEN |
> +			   AT91_PMC_AUDIO_PLL_QDPMC_MASK,
> +			   AT91_PMC_AUDIO_PLL_PMCEN |
> +			   AT91_PMC_AUDIO_PLL_QDPMC(apmc_ck->qdpmc));
> +	return 0;
> +}
> +
> +static void clk_audio_pll_pmc_disable(struct clk_hw *hw)
> +{
> +	struct clk_audio_pmc *apmc_ck = to_clk_audio_pmc(hw);
> +
> +	regmap_update_bits(apmc_ck->regmap, AT91_PMC_AUDIO_PLL0,
> +			   AT91_PMC_AUDIO_PLL_PMCEN, 0);
> +}
> +
> +static unsigned long clk_audio_pll_pmc_recalc_rate(struct clk_hw *hw,
> +						   unsigned long parent_rate)
> +{
> +	struct clk_audio_pmc *apmc_ck = to_clk_audio_pmc(hw);
> +	unsigned long apmc_rate = 0;
> +
> +	apmc_rate = parent_rate / (apmc_ck->qdpmc + 1);
> +
> +	pr_debug("A PLL/PMC: %s, apmc_rate = %lu (qdpmc = %u)\n", __func__,
> +		 apmc_rate, apmc_ck->qdpmc);
> +
> +	return apmc_rate;
> +}
> +
> +static long clk_audio_pll_pmc_round_rate(struct clk_hw *hw, unsigned long rate,
> +					 unsigned long *parent_rate)
> +{
> +	struct clk_hw *pclk = clk_hw_get_parent(hw);
> +	long best_rate = -EINVAL;
> +	unsigned long best_parent_rate = 0;
> +	u32 tmp_qd = 0, div;
> +	long tmp_rate;
> +	int tmp_diff;
> +	int best_diff = -1;
> +
> +	pr_debug("A PLL/PMC: %s, rate = %lu (parent_rate = %lu)\n", __func__,
> +		 rate, *parent_rate);
> +
> +	for (div = 1; div <= AUDIO_PLL_QDPMC_MAX; div++) {
> +		best_parent_rate = clk_round_rate(pclk->clk, rate * div);
> +		tmp_rate = best_parent_rate / div;
> +		tmp_diff = abs(rate - tmp_rate);
> +
> +		if (best_diff < 0 || best_diff > tmp_diff) {
> +			*parent_rate = best_parent_rate;
> +			best_rate = tmp_rate;
> +			best_diff = tmp_diff;
> +			tmp_qd = div;
> +		}
> +	}
> +
> +	pr_debug("A PLL/PMC: %s, best_rate = %ld, best_parent_rate = %lu (qd = %d)\n",
> +		 __func__, best_rate, *parent_rate, tmp_qd - 1);
> +
> +	return best_rate;
> +}
> +
> +static int clk_audio_pll_pmc_set_rate(struct clk_hw *hw, unsigned long rate,
> +				      unsigned long parent_rate)
> +{
> +	struct clk_audio_pmc *apmc_ck = to_clk_audio_pmc(hw);
> +
> +	if (!rate)
> +		return -EINVAL;
> +
> +	pr_debug("A PLL/PMC: %s, rate = %lu (parent_rate = %lu)\n", __func__,
> +		 rate, parent_rate);
> +
> +	apmc_ck->qdpmc = parent_rate / rate - 1;

Hopefully rate isn't 1 or that goes undefined.

> +
> +	return 0;
> +}
> +
> +static const struct clk_ops audio_pll_pmc_ops = {
> +	.enable = clk_audio_pll_pmc_enable,
> +	.disable = clk_audio_pll_pmc_disable,
> +	.recalc_rate = clk_audio_pll_pmc_recalc_rate,
> +	.round_rate = clk_audio_pll_pmc_round_rate,
> +	.set_rate = clk_audio_pll_pmc_set_rate,
> +};
> +
> +static void __init of_sama5d2_clk_audio_pll_pmc_setup(struct device_node *np)
> +{
> +	struct clk_audio_pmc *apmc_ck;
> +	struct clk_init_data init;
> +	struct regmap *regmap;
> +	const char *parent_name;
> +	const char *name = np->name;
> +	int ret;
> +
> +	parent_name = of_clk_get_parent_name(np, 0);
> +
> +	of_property_read_string(np, "clock-output-names", &name);
> +
> +	regmap = syscon_node_to_regmap(of_get_parent(np));
> +	if (IS_ERR(regmap))
> +		return;
> +
> +	apmc_ck = kzalloc(sizeof(*apmc_ck), GFP_KERNEL);
> +	if (!apmc_ck)
> +		return;
> +
> +	init.name = name;
> +	init.ops = &audio_pll_pmc_ops;
> +	init.parent_names = (parent_name ? &parent_name : NULL);

This feels repetitive.

> +	init.num_parents = 1;
> +	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
> +		CLK_SET_RATE_PARENT;
> +
> +	apmc_ck->hw.init = &init;
> +	apmc_ck->regmap = regmap;
> +
> +	ret = clk_hw_register(NULL, &apmc_ck->hw);
> +	if (ret)
> +		kfree(apmc_ck);
> +	else
> +		of_clk_add_hw_provider(np, of_clk_hw_simple_get, &apmc_ck->hw);
> +}
> +
> +CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_pmc_setup,
> +	       "atmel,sama5d2-clk-audio-pll-pmc",
> +	       of_sama5d2_clk_audio_pll_pmc_setup);

Very

> diff --git a/drivers/clk/at91/clk-audio-pll.c b/drivers/clk/at91/clk-audio-pll.c
> new file mode 100644
> index 000000000000..efc2cb58da85
> --- /dev/null
> +++ b/drivers/clk/at91/clk-audio-pll.c
> @@ -0,0 +1,239 @@
> +/*
> + *  Copyright (C) 2016 Atmel Corporation,
> + *		       Songjun Wu <songjun.wu@atmel.com>,
> + *                     Nicolas Ferre <nicolas.ferre@atmel.com>
> + *  Copyright (C) 2017 Free Electrons,
> + *		       Quentin Schulz <quentin.schulz@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +#include <linux/clk-provider.h>
> +#include <linux/clkdev.h>

Used?

> +#include <linux/clk/at91_pmc.h>
> +#include <linux/of.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
> +
> +#include "pmc.h"
> +
> +/*
> + * DOC: Fractional PLL clock for audio
> + *
> + * Traits of this clock:
> + * prepare - clk_prepare puts audio PLL in reset state
> + * enable - clk_enable writes nd, fracr parameters and enables PLL
> + * rate - rate is adjustable.
> + *        clk->rate = parent->rate * ((nd + 1) + (fracr / 2^22))
> + * parent - fixed parent.  No clk_set_parent support
> + */
> +
> +#define AUDIO_PLL_DIV_FRAC	BIT(22)
> +#define AUDIO_PLL_ND_MAX	(AT91_PMC_AUDIO_PLL_ND_MASK >> \
> +					AT91_PMC_AUDIO_PLL_ND_OFFSET)
> +
> +#define AUDIO_PLL_FOUT_MIN	620000000
> +#define AUDIO_PLL_FOUT_MAX	700000000
> +
> +struct clk_audio_frac {
> +	struct clk_hw hw;
> +	struct regmap *regmap;
> +	u32 fracr;
> +	u8 nd;
> +};
> +
> +#define to_clk_audio_frac(hw) container_of(hw, struct clk_audio_frac, hw)
> +
> +static int clk_audio_pll_enable(struct clk_hw *hw)
> +{
> +	struct clk_audio_frac *fck = to_clk_audio_frac(hw);
> +
> +	regmap_update_bits(fck->regmap, AT91_PMC_AUDIO_PLL0,
> +			   AT91_PMC_AUDIO_PLL_RESETN, 0);
> +	regmap_update_bits(fck->regmap, AT91_PMC_AUDIO_PLL0,
> +			   AT91_PMC_AUDIO_PLL_RESETN,
> +			   AT91_PMC_AUDIO_PLL_RESETN);
> +	regmap_update_bits(fck->regmap, AT91_PMC_AUDIO_PLL1,
> +			   AT91_PMC_AUDIO_PLL_FRACR_MASK, fck->fracr);
> +
> +	/*
> +	 * reset and enable have to be done in 2 separated writes
> +	 * for AT91_PMC_AUDIO_PLL0
> +	 */
> +	regmap_update_bits(fck->regmap, AT91_PMC_AUDIO_PLL0,
> +			   AT91_PMC_AUDIO_PLL_PLLEN |
> +			   AT91_PMC_AUDIO_PLL_ND_MASK,
> +			   AT91_PMC_AUDIO_PLL_PLLEN |
> +			   AT91_PMC_AUDIO_PLL_ND(fck->nd));
> +
> +	return 0;
> +}
> +
> +static void clk_audio_pll_disable(struct clk_hw *hw)
> +{
> +	struct clk_audio_frac *fck = to_clk_audio_frac(hw);
> +
> +	regmap_update_bits(fck->regmap, AT91_PMC_AUDIO_PLL0,
> +			   AT91_PMC_AUDIO_PLL_PLLEN, 0);
> +	/* do it in 2 separated writes */
> +	regmap_update_bits(fck->regmap, AT91_PMC_AUDIO_PLL0,
> +			   AT91_PMC_AUDIO_PLL_RESETN, 0);
> +}
> +
> +static unsigned long clk_audio_pll_fout(unsigned long parent_rate,
> +					unsigned long nd, unsigned long fracr)
> +{
> +	unsigned long long fr = (unsigned long long)parent_rate *
> +						(unsigned long long)fracr;

We only need one cast here?

> +
> +	pr_debug("A PLL: %s, fr = %llu\n", __func__, fr);
> +
> +	fr = DIV_ROUND_CLOSEST_ULL(fr, AUDIO_PLL_DIV_FRAC);
> +
> +	pr_debug("A PLL: %s, fr = %llu\n", __func__, fr);
> +
> +	return parent_rate * (nd + 1) + fr;
> +}
> +
> +static unsigned long clk_audio_pll_recalc_rate(struct clk_hw *hw,
> +					       unsigned long parent_rate)
> +{
> +	struct clk_audio_frac *fck = to_clk_audio_frac(hw);
> +	unsigned long fout;
> +
> +	fout = clk_audio_pll_fout(parent_rate, fck->nd, fck->fracr);
> +
> +	pr_debug("A PLL: %s, fout = %lu (nd = %u, fracr = %lu)\n", __func__,
> +		 fout, fck->nd, (unsigned long)fck->fracr);
> +
> +	return fout;
> +}
> +
> +static int clk_audio_pll_compute_frac(unsigned long rate,
> +				      unsigned long parent_rate,
> +				      unsigned long *nd, unsigned long *fracr)
> +{
> +	unsigned long long tmp, rem;
> +
> +	if (!rate)
> +		return -EINVAL;

This happens?

> +
> +	tmp = rate;
> +	rem = do_div(tmp, parent_rate);
> +	if (!tmp || tmp >= AUDIO_PLL_ND_MAX)
> +		return -EINVAL;
> +
> +	*nd = tmp - 1;
> +
> +	tmp = rem * AUDIO_PLL_DIV_FRAC;
> +	tmp = DIV_ROUND_CLOSEST_ULL(tmp, parent_rate);
> +	if (tmp > AT91_PMC_AUDIO_PLL_FRACR_MASK)
> +		return -EINVAL;
> +
> +	/* we can cast here as we verified the bounds just above */
> +	*fracr = (unsigned long)tmp;
> +
> +	return 0;
> +}
> +
> +static long clk_audio_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +				     unsigned long *parent_rate)
> +{
> +	long best_rate = -EINVAL;
> +	unsigned long fracr, nd;
> +	int ret;
> +
> +	pr_debug("A PLL: %s, rate = %lu (parent_rate = %lu)\n", __func__, rate,
> +		 *parent_rate);
> +
> +	if (rate < AUDIO_PLL_FOUT_MIN)
> +		rate = AUDIO_PLL_FOUT_MIN;
> +	else if (rate > AUDIO_PLL_FOUT_MAX)
> +		rate = AUDIO_PLL_FOUT_MAX;

Use clamp. Also, did you want to use determine_rate callback and
clamp the requested rate range?

> +
> +	ret = clk_audio_pll_compute_frac(rate, *parent_rate, &nd, &fracr);
> +	if (ret)
> +		return ret;
> +
> +	best_rate = clk_audio_pll_fout(*parent_rate, nd, fracr);
> +
> +	pr_debug("A PLL: %s, best_rate = %lu (nd = %lu, fracr = %lu)\n",
> +		 __func__, best_rate, nd, fracr);
> +
> +	return best_rate;
> +}
> +
> +static int clk_audio_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +				  unsigned long parent_rate)
> +{
> +	struct clk_audio_frac *fck = to_clk_audio_frac(hw);
> +	unsigned long fracr, nd;
> +	int ret;
> +
> +	pr_debug("A PLL: %s, rate = %lu (parent_rate = %lu)\n", __func__, rate,
> +		 parent_rate);
> +
> +	if (rate < AUDIO_PLL_FOUT_MIN || rate > AUDIO_PLL_FOUT_MAX)
> +		return -EINVAL;
> +
> +	ret = clk_audio_pll_compute_frac(rate, parent_rate, &nd, &fracr);
> +	if (ret)
> +		return ret;
> +
> +	fck->nd = nd;
> +	fck->fracr = fracr;
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops audio_pll_ops = {
> +	.enable = clk_audio_pll_enable,
> +	.disable = clk_audio_pll_disable,
> +	.recalc_rate = clk_audio_pll_recalc_rate,
> +	.round_rate = clk_audio_pll_round_rate,
> +	.set_rate = clk_audio_pll_set_rate,
> +};
> +
> +static void __init of_sama5d2_clk_audio_pll_setup(struct device_node *np)
> +{
> +	struct clk_audio_frac *fck;
> +	struct clk_init_data init;
> +	struct regmap *regmap;
> +	const char *parent_name;
> +	const char *name = np->name;
> +	int ret;
> +
> +	parent_name = of_clk_get_parent_name(np, 0);
> +
> +	of_property_read_string(np, "clock-output-names", &name);

Any way to not rely on clock-output-names?

> +
> +	regmap = syscon_node_to_regmap(of_get_parent(np));
> +	if (IS_ERR(regmap))
> +		return;
> +
> +	fck = kzalloc(sizeof(*fck), GFP_KERNEL);

This variable name looks like f*ck, perhaps name it something
else. frac?

> +	if (!fck)
> +		return;
> +
> +	init.name = name;
> +	init.ops = &audio_pll_ops;
> +	init.parent_names = (parent_name ? &parent_name : NULL);
> +	init.num_parents = 1;
> +	init.flags = CLK_SET_RATE_GATE;
> +
> +	fck->hw.init = &init;
> +	fck->regmap = regmap;
> +
> +	ret = clk_hw_register(NULL, &fck->hw);
> +	if (ret)
> +		kfree(fck);
> +	else
> +		of_clk_add_hw_provider(np, of_clk_hw_simple_get, &fck->hw);
> +}
> +
> +CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_setup,
> +	       "atmel,sama5d2-clk-audio-pll-frac",
> +	       of_sama5d2_clk_audio_pll_setup);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
