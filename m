From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 25 Jul 2017 17:20:16 -0700
Subject: [PATCH v3 3/9] clk: at91: add audio pll clock drivers
In-Reply-To: <859d2f48-a987-afda-1e9d-02930e4fad7d@free-electrons.com>
References: <20170713074927.10882-1-quentin.schulz@free-electrons.com>
 <20170713074927.10882-4-quentin.schulz@free-electrons.com>
 <20170721222029.GO19878@codeaurora.org>
 <859d2f48-a987-afda-1e9d-02930e4fad7d@free-electrons.com>
Message-ID: <20170726002016.GE2146@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24, Quentin Schulz wrote:
> Hi Stephen,
> 
> On 22/07/2017 00:20, Stephen Boyd wrote:
> > On 07/13, Quentin Schulz wrote:
> >> diff --git a/drivers/clk/at91/clk-audio-pll-pad.c b/drivers/clk/at91/clk-audio-pll-pad.c
> >> new file mode 100644
> >> index 000000000000..10dd6d625696
> >> --- /dev/null
> >> +++ b/drivers/clk/at91/clk-audio-pll-pad.c
> >> +	struct regmap *regmap;
> >> +	const char *parent_name;
> >> +	const char *name = np->name;
> >> +	int ret;
> >> +
> >> +	parent_name = of_clk_get_parent_name(np, 0);
> >> +
> >> +	of_property_read_string(np, "clock-output-names", &name);
> >> +
> >> +	regmap = syscon_node_to_regmap(of_get_parent(np));
> >> +	if (IS_ERR(regmap))
> >> +		return;
> >> +
> >> +	apad_ck = kzalloc(sizeof(*apad_ck), GFP_KERNEL);
> >> +	if (!apad_ck)
> >> +		return;
> >> +
> >> +	init.name = name;
> >> +	init.ops = &audio_pll_pad_ops;
> >> +	init.parent_names = (parent_name ? &parent_name : NULL);
> > 
> > Use of_clk_parent_fill()?
> > 
> 
> [Deleting `parent_name = of_clk_get_parent_name(np, 0);`]
> [Deleting `init.parent_names = (parent_name ? &parent_name : NULL);`]
> 
> + const char *parent_names[1];
> [...]
> + of_clk_parent_fill(np, parent_names, 1);
> + init.parent_names = parent_names;
> 
> Is it what you're asking?
> 

Yes.

> >> +	init.num_parents = 1;
> >> +	init.flags = CLK_SET_RATE_GATE | CLK_SET_PARENT_GATE |
> >> +		CLK_SET_RATE_PARENT;
> >> +
> >> +	apad_ck->hw.init = &init;
> >> +	apad_ck->regmap = regmap;
> >> +
> >> +	ret = clk_hw_register(NULL, &apad_ck->hw);
> >> +	if (ret)
> >> +		kfree(apad_ck);
> >> +	else
> >> +		of_clk_add_hw_provider(np, of_clk_hw_simple_get, &apad_ck->hw);
> > 
> > Maybe we should make this register sequence a helper function.
> > Seems common.
> > 
> 
> I can put such an helper in an header if this is what you meant.

No big deal either way.

> [...]
> >> +static long clk_audio_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> >> +				     unsigned long *parent_rate)
> >> +{
> >> +	long best_rate = -EINVAL;
> >> +	unsigned long fracr, nd;
> >> +	int ret;
> >> +
> >> +	pr_debug("A PLL: %s, rate = %lu (parent_rate = %lu)\n", __func__, rate,
> >> +		 *parent_rate);
> >> +
> >> +	if (rate < AUDIO_PLL_FOUT_MIN)
> >> +		rate = AUDIO_PLL_FOUT_MIN;
> >> +	else if (rate > AUDIO_PLL_FOUT_MAX)
> >> +		rate = AUDIO_PLL_FOUT_MAX;
> > 
> > Use clamp. Also, did you want to use determine_rate callback and
> > clamp the requested rate range?
> > 
> 
> Didn't know this one, thanks!
> 
> I want determine_rate to return a valid rate for the pll so I clamp the
> requested rate range in this one. In set_rate, I just tell the user that
> any requested rate outside of the valid range is invalid. Does that
> answer your question?

I meant to use the determine rate op here instead of round_rate.
That way, the min/max ranges can be updated here and the core
should figure out that something went out of range. Of course,
the rounded rate needs to be clamped still, but the ranges could
be expressed back as well.

> 
> [...]
> >> +static void __init of_sama5d2_clk_audio_pll_setup(struct device_node *np)
> >> +{
> >> +	struct clk_audio_frac *fck;
> >> +	struct clk_init_data init;
> >> +	struct regmap *regmap;
> >> +	const char *parent_name;
> >> +	const char *name = np->name;
> >> +	int ret;
> >> +
> >> +	parent_name = of_clk_get_parent_name(np, 0);
> >> +
> >> +	of_property_read_string(np, "clock-output-names", &name);
> > 
> > Any way to not rely on clock-output-names?
> > 
> 
> I guess we could use the name of the DT node (as it's done in the
> variable initialization block above) and not override it by
> clock-output-names?

If that works, sure.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
