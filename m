From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 24 Jul 2017 10:37:33 +0200
Subject: [PATCH v3 3/9] clk: at91: add audio pll clock drivers
In-Reply-To: <20170721222029.GO19878@codeaurora.org>
References: <20170713074927.10882-1-quentin.schulz@free-electrons.com>
 <20170713074927.10882-4-quentin.schulz@free-electrons.com>
 <20170721222029.GO19878@codeaurora.org>
Message-ID: <859d2f48-a987-afda-1e9d-02930e4fad7d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 22/07/2017 00:20, Stephen Boyd wrote:
> On 07/13, Quentin Schulz wrote:
>> diff --git a/drivers/clk/at91/clk-audio-pll-pad.c b/drivers/clk/at91/clk-audio-pll-pad.c
>> new file mode 100644
>> index 000000000000..10dd6d625696
>> --- /dev/null
>> +++ b/drivers/clk/at91/clk-audio-pll-pad.c
>> @@ -0,0 +1,206 @@
>> +/*
>> + *  Copyright (C) 2016 Atmel Corporation,
>> + *                     Nicolas Ferre <nicolas.ferre@atmel.com>
>> + *  Copyright (C) 2017 Free Electrons,
>> + *		       Quentin Schulz <quentin.schulz@free-electrons.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + */
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/clkdev.h>
> 
> Used?
> 

Not really, I need slab.h for kzalloc tough which was included by clkdev.

[...]
>> +static int clk_audio_pll_pad_set_rate(struct clk_hw *hw, unsigned long rate,
>> +				      unsigned long parent_rate)
>> +{
>> +	struct clk_audio_pad *apad_ck = to_clk_audio_pad(hw);
>> +	u8 tmp_div;
>> +
>> +	pr_debug("A PLL/PAD: %s, rate = %lu (parent_rate = %lu)\n", __func__,
>> +		 rate, parent_rate);
>> +
>> +	if (!rate)
>> +		return -EINVAL;
> 
> This happens?
> 

I don't know, but it's better to do this quick check rather than being
exposed to a division by zero IMHO. Nothing in clk_ops states that the
rate given to set_rate is non-zero, so I made sure this can't happen.

>> +
>> +	tmp_div = parent_rate / rate;
>> +	if (tmp_div % 3 == 0) {
>> +		apad_ck->qdaudio = tmp_div / 3;
>> +		apad_ck->div = 3;
>> +	} else {
>> +		apad_ck->qdaudio = tmp_div / 2;
>> +		apad_ck->div = 2;
>> +	}[...]
>> +static void __init of_sama5d2_clk_audio_pll_pad_setup(struct device_node *np)
>> +{
>> +	struct clk_audio_pad *apad_ck;
>> +	struct clk_init_data init;
> 
> Best to initialize to { } just in case we add something later.
> 

ACK.

>> +	struct regmap *regmap;
>> +	const char *parent_name;
>> +	const char *name = np->name;
>> +	int ret;
>> +
>> +	parent_name = of_clk_get_parent_name(np, 0);
>> +
>> +	of_property_read_string(np, "clock-output-names", &name);
>> +
>> +	regmap = syscon_node_to_regmap(of_get_parent(np));
>> +	if (IS_ERR(regmap))
>> +		return;
>> +
>> +	apad_ck = kzalloc(sizeof(*apad_ck), GFP_KERNEL);
>> +	if (!apad_ck)
>> +		return;
>> +
>> +	init.name = name;
>> +	init.ops = &audio_pll_pad_ops;
>> +	init.parent_names = (parent_name ? &parent_name : NULL);
> 
> Use of_clk_parent_fill()?
> 

[Deleting `parent_name = of_clk_get_parent_name(np, 0);`]
[Deleting `init.parent_names = (parent_name ? &parent_name : NULL);`]

+ const char *parent_names[1];
[...]
+ of_clk_parent_fill(np, parent_names, 1);
+ init.parent_names = parent_names;

Is it what you're asking?

>> +	init.num_parents = 1;
>> +	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
>> +		CLK_SET_RATE_PARENT;
>> +
>> +	apad_ck->hw.init = &init;
>> +	apad_ck->regmap = regmap;
>> +
>> +	ret = clk_hw_register(NULL, &apad_ck->hw);
>> +	if (ret)
>> +		kfree(apad_ck);
>> +	else
>> +		of_clk_add_hw_provider(np, of_clk_hw_simple_get, &apad_ck->hw);
> 
> Maybe we should make this register sequence a helper function.
> Seems common.
> 

I can put such an helper in an header if this is what you meant.

>> +}
>> +
>> +CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_pad_setup,
>> +	       "atmel,sama5d2-clk-audio-pll-pad",
>> +	       of_sama5d2_clk_audio_pll_pad_setup);
> 
> We can't have a device driver for this?
> 

Could you elaborate please?

>> diff --git a/drivers/clk/at91/clk-audio-pll-pmc.c b/drivers/clk/at91/clk-audio-pll-pmc.c
>> new file mode 100644
>> index 000000000000..7b0847ed7a4b
>> --- /dev/null
>> +++ b/drivers/clk/at91/clk-audio-pll-pmc.c
[...]
>> +static int clk_audio_pll_pmc_set_rate(struct clk_hw *hw, unsigned long rate,
>> +				      unsigned long parent_rate)
>> +{
>> +	struct clk_audio_pmc *apmc_ck = to_clk_audio_pmc(hw);
>> +
>> +	if (!rate)
>> +		return -EINVAL;
>> +
>> +	pr_debug("A PLL/PMC: %s, rate = %lu (parent_rate = %lu)\n", __func__,
>> +		 rate, parent_rate);
>> +
>> +	apmc_ck->qdpmc = parent_rate / rate - 1;
> 
> Hopefully rate isn't 1 or that goes undefined.
> 

Thanks to operator precedence, the only check to do is rate != 0 (done
few lines above). Division has precedence over substraction.

[...]
>> +static void __init of_sama5d2_clk_audio_pll_pmc_setup(struct device_node *np)
>> +{
>> +	struct clk_audio_pmc *apmc_ck;
>> +	struct clk_init_data init;
>> +	struct regmap *regmap;
>> +	const char *parent_name;
>> +	const char *name = np->name;
>> +	int ret;
>> +
>> +	parent_name = of_clk_get_parent_name(np, 0);
>> +
>> +	of_property_read_string(np, "clock-output-names", &name);
>> +
>> +	regmap = syscon_node_to_regmap(of_get_parent(np));
>> +	if (IS_ERR(regmap))
>> +		return;
>> +
>> +	apmc_ck = kzalloc(sizeof(*apmc_ck), GFP_KERNEL);
>> +	if (!apmc_ck)
>> +		return;
>> +
>> +	init.name = name;
>> +	init.ops = &audio_pll_pmc_ops;
>> +	init.parent_names = (parent_name ? &parent_name : NULL);
> 
> This feels repetitive.
> 
>> +	init.num_parents = 1;
>> +	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
>> +		CLK_SET_RATE_PARENT;
>> +
>> +	apmc_ck->hw.init = &init;
>> +	apmc_ck->regmap = regmap;
>> +
>> +	ret = clk_hw_register(NULL, &apmc_ck->hw);
>> +	if (ret)
>> +		kfree(apmc_ck);
>> +	else
>> +		of_clk_add_hw_provider(np, of_clk_hw_simple_get, &apmc_ck->hw);
>> +}
>> +
>> +CLK_OF_DECLARE(of_sama5d2_clk_audio_pll_pmc_setup,
>> +	       "atmel,sama5d2-clk-audio-pll-pmc",
>> +	       of_sama5d2_clk_audio_pll_pmc_setup);
> 
> Very
> 

Basically, both share almost the same code but have different formulae
for the rate.

>> diff --git a/drivers/clk/at91/clk-audio-pll.c b/drivers/clk/at91/clk-audio-pll.c
>> new file mode 100644
>> index 000000000000..efc2cb58da85
>> --- /dev/null
>> +++ b/drivers/clk/at91/clk-audio-pll.c
[...]
>> +static unsigned long clk_audio_pll_fout(unsigned long parent_rate,
>> +					unsigned long nd, unsigned long fracr)
>> +{
>> +	unsigned long long fr = (unsigned long long)parent_rate *
>> +						(unsigned long long)fracr;
> 
> We only need one cast here?
> 

Indeed, I'll remove the casting of fracr.

[...]
>> +static long clk_audio_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>> +				     unsigned long *parent_rate)
>> +{
>> +	long best_rate = -EINVAL;
>> +	unsigned long fracr, nd;
>> +	int ret;
>> +
>> +	pr_debug("A PLL: %s, rate = %lu (parent_rate = %lu)\n", __func__, rate,
>> +		 *parent_rate);
>> +
>> +	if (rate < AUDIO_PLL_FOUT_MIN)
>> +		rate = AUDIO_PLL_FOUT_MIN;
>> +	else if (rate > AUDIO_PLL_FOUT_MAX)
>> +		rate = AUDIO_PLL_FOUT_MAX;
> 
> Use clamp. Also, did you want to use determine_rate callback and
> clamp the requested rate range?
> 

Didn't know this one, thanks!

I want determine_rate to return a valid rate for the pll so I clamp the
requested rate range in this one. In set_rate, I just tell the user that
any requested rate outside of the valid range is invalid. Does that
answer your question?

[...]
>> +static void __init of_sama5d2_clk_audio_pll_setup(struct device_node *np)
>> +{
>> +	struct clk_audio_frac *fck;
>> +	struct clk_init_data init;
>> +	struct regmap *regmap;
>> +	const char *parent_name;
>> +	const char *name = np->name;
>> +	int ret;
>> +
>> +	parent_name = of_clk_get_parent_name(np, 0);
>> +
>> +	of_property_read_string(np, "clock-output-names", &name);
> 
> Any way to not rely on clock-output-names?
> 

I guess we could use the name of the DT node (as it's done in the
variable initialization block above) and not override it by
clock-output-names?

>> +
>> +	regmap = syscon_node_to_regmap(of_get_parent(np));
>> +	if (IS_ERR(regmap))
>> +		return;
>> +
>> +	fck = kzalloc(sizeof(*fck), GFP_KERNEL);
> 
> This variable name looks like f*ck, perhaps name it something
> else. frac?

Sure.

[...]

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
