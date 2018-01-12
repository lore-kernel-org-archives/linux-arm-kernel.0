From: david@lechnology.com (David Lechner)
Date: Fri, 12 Jan 2018 09:25:12 -0600
Subject: [PATCH v5 02/44] clk: davinci: New driver for davinci PLL clocks
In-Reply-To: <7fc8bd35-0416-216d-8e1e-53a0ec6e8790@ti.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-3-git-send-email-david@lechnology.com>
 <7fc8bd35-0416-216d-8e1e-53a0ec6e8790@ti.com>
Message-ID: <01fbde0e-36a0-2b19-e385-e63bc4a3ae4a@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/2018 03:21 AM, Sekhar Nori wrote:
> On Monday 08 January 2018 07:47 AM, David Lechner wrote:
>> This adds a new driver for mach-davinci PLL clocks. This is porting the
>> code from arch/arm/mach-davinci/clock.c to the common clock framework.
>> Additionally, it adds device tree support for these clocks.
>>
>> The ifeq ($(CONFIG_COMMON_CLK), y) in the Makefile is needed to prevent
>> compile errors until the clock code in arch/arm/mach-davinci is removed.
>>
>> Note: although there are similar clocks for TI Keystone we are not able
>> to share the code for a few reasons. The keystone clocks are device tree
>> only and use legacy one-node-per-clock bindings. Also the register
>> layouts are a bit different, which would add even more if/else mess
>> to the keystone clocks. And the keystone PLL driver doesn't support
>> setting clock rates.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>> ---

>> +
>> +#define PLLM_MASK		0x1f
>> +#define PREDIV_RATIO_MASK	0x1f
> 
> May be use the mode modern GENMASK()?

I haven't seen that one before. Thanks.

...

>> +static unsigned long davinci_pll_clk_recalc(struct clk_hw *hw,
>> +					    unsigned long parent_rate)
>> +{
>> +	struct davinci_pll_clk *pll = to_davinci_pll_clk(hw);
>> +	unsigned long rate = parent_rate;
>> +	u32 prediv, mult, postdiv;
>> +
>> +	prediv = readl(pll->base + PREDIV) & PREDIV_RATIO_MASK;
>> +	mult = readl(pll->base + PLLM) & PLLM_MASK;
>> +	postdiv = readl(pll->base + POSTDIV) & POSTDIV_RATIO_MASK;
> 
> Shouldn't we check if the pre and post dividers are enabled before using
> them?

Indeed.

> 
>> +
>> +	rate /= prediv + 1;
>> +	rate *= mult + 1;
>> +	rate /= postdiv + 1;
>> +
>> +	return rate;
>> +}
>> +

...

> 
> PLL output on DA850 must never be below 300MHz or above 600MHz (see
> datasheet table "Allowed PLL Operating Conditions"). Does this take care
> of that? Thats one of the main reasons I recall I went with some
> specific values of prediv, pllm and post div in
> arch/arm/mach-davinci/da850.c

Apparently, I missed this requirement. It looks like I am going to have to
rework things so that there is some coordination between the PLL and the
PLLDIV clocks in order to get the < 300MHz operating points.

...

>> +
>> +	divider->reg = base + OSCDIV;
>> +	divider->width = OSCDIV_RATIO_WIDTH;
> 
> can you write OD1EN of OSCDIV here? I guess the reset default is 1 so
> you didnt need to do that. But not doing exposes us to settings that
> bootloader left us in.
> 

It looks like I am going to have to make a custom implementation for parts
of this clock anyway, so I will probably just make new enable/disable
callbacks that set both OSCDIV_OD1EN and CKEN_OBSCLK.

>> +
>> +	clk = clk_register_composite(NULL, name, parent_names, num_parents,
>> +				     &mux->hw, &clk_mux_ops,
>> +				     &divider->hw, &clk_divider_ops,
>> +				     &gate->hw, &clk_gate_ops, 0);
>> +	if (IS_ERR(clk)) {
>> +		kfree(divider);
>> +		kfree(gate);
>> +		kfree(mux);
>> +	}
>> +
>> +	return clk;
>> +}
>> +
>> +struct clk *
>> +davinci_pll_divclk_register(const struct davinci_pll_divclk_info *info,
>> +			    void __iomem *base)
>> +{
>> +	const struct clk_ops *divider_ops = &clk_divider_ops;
> 
> setting the sysclk divider requires GOSTAT handling apart from setting
> the divider value. So I think .set_rate ops above wont work. Other ops
> can be used, I guess. So we need a private structure here.
> 
> Can you port over davinci_set_sysclk_rate() too? I understand you cannot
> test it due to lack of cpufreq support in DT, but I can help testing there.
> 
> Or leave .set_rate NULL and it can be added later.

Yes, I noticed that I missed this after I submitted this series. And I
will have to rework things to coordinate with the PLL as mentioned above.

FYI, I do have cpufreq-dt working, although the LEGO EV3 has a fixed 1.2V
regulator, so I am limited in what I can test. Basically, I can only switch
between 300MHz and 375MHz according to the datasheets. The chip is technically
the 456MHz version. What would happen if I ran it faster or slower with the
wrong voltage?

...

>> +
>> +	child = of_get_child_by_name(node, "auxclk");
>> +	if (child && of_device_is_available(child)) {
>> +		char child_name[MAX_NAME_SIZE];
>> +
>> +		snprintf(child_name, MAX_NAME_SIZE, "%s_aux_clk", name);
>> +
>> +		clk = davinci_pll_aux_clk_register(child_name, parent_name, base);
>> +		if (IS_ERR(clk))
>> +			pr_warn("%s: failed to register %s (%ld)\n", __func__,
>> +				child_name, PTR_ERR(clk));
>> +		else
>> +			of_clk_add_provider(child, of_clk_src_simple_get, clk);
>> +	}
> 
> davinci_pll_obs_clk_register() should also be handled here?

I omitted it because no one is using it (same reason I left it out of the
device tree bindings). We can certainly add it, though.
