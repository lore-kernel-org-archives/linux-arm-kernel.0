From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 05 Jun 2015 10:36:27 +0100
Subject: [RFC PATCH 2/3] clk: stm32: Add clock driver for STM32F4[23]xxx
 devices
In-Reply-To: <20150604220725.GT676@codeaurora.org>
References: <1432327273-6810-1-git-send-email-daniel.thompson@linaro.org>
 <1432327273-6810-3-git-send-email-daniel.thompson@linaro.org>
 <20150604220725.GT676@codeaurora.org>
Message-ID: <55716D9B.4040209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06/15 23:07, Stephen Boyd wrote:
> On 05/22, Daniel Thompson wrote:
>> +
>> +#include <linux/clk.h>
>
> Are you using this include?
>
>> +#include <linux/clkdev.h>
>
> Are you using this include?

Not very much?

Turns out I was relying on these to get kzalloc() defined but there are 
better headers for me to use for that!

>
>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +
>> +#include <linux/debugfs.h>
>
> Are you using this include?

No (this is already gone in v2).


>> +static long clk_apb_mul_round_rate(struct clk_hw *hw, unsigned long rate,
>> +				   unsigned long *prate)
>> +{
>> +	struct clk_apb_mul *am = to_clk_apb_mul(hw);
>> +	unsigned long mult = 1;
>> +
>> +	if (readl(base + STM32F4_RCC_CFGR) & BIT(am->bit_idx))
>> +		mult *= 2;
>
> Isn't this the same as mult = 2? I guess we could rely on the
> compiler to figure out this one.

I'll fix this.


>> +
>> +	if (__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT) {
>> +		unsigned long best_parent = rate / mult;
>> +
>> +		*prate =
>> +		    __clk_round_rate(__clk_get_parent(hw->clk), best_parent);
>> +	}
>> +
>> +	return *prate * mult;
>> +}
>> +
>> +static int clk_apb_mul_set_rate(struct clk_hw *hw, unsigned long rate,
>> +				 unsigned long parent_rate)
>> +{
>
> Why don't we need to do anything here?

This clock cannot change its own rate. It is very nearly a fixed factor 
clock but with the additional quirk that the "fixed" factor changes 
depending upon the rate of the parent clock.

This is the same implementation as clk-fixed-factor. I concluded that it 
returns success because round rate should always result in the set rate 
for this clock being a nop.


>> +	return 0;
>> +}
>> +
>> +static struct clk_ops clk_apb_mul_factor_ops = {
>
> const?

Makes sense...

You want a patch for clk-fixed-factor too?


>> +struct clk *clk_register_apb_mul(struct device *dev, const char *name,
>> +				 const char *parent_name, unsigned long flags,
>> +				 u8 bit_idx)
>> +{
>> +	struct clk_apb_mul *am;
>> +	struct clk_init_data init;
>> +	struct clk *clk;
>> +
>> +	am = kzalloc(sizeof(*am), GFP_KERNEL);
>> +	if (!am)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	am->bit_idx = bit_idx;
>> +	am->hw.init = &init;
>> +
>> +	init.name = name;
>> +	init.ops = &clk_apb_mul_factor_ops;
>> +	init.flags = flags | CLK_IS_BASIC;
>
> Is it basic?

Tough question.

The absence of this flag appears grants arch code permission to use 
secret backdoors to do "weird stuff" but making special assumptions 
about the type of the clock. This clock keeps its implementation private 
so noone outside the compilation unit can usefully cast it.

However, it also looks like only omap2 is the only platform that makes 
these special assumptions so when this code is run on STM32 there is 
nothing to actually consume the CLK_IS_BASIC flag at runtime.

In other words the flag is useless but, I think, also correctly applied.

I'd be happy to remove it if anyone disagrees with the guesswork above.

Alternatively, I could write a patch to *invert* CLK_IS_BASIC and rename 
it CLK_CASTABLE on the grounds that only the people doing "weird stuff" 
should have to care about this flag at all. Any interest in that?


>> +	init.parent_names = &parent_name;
>> +	init.num_parents = 1;
>> +
>> +	clk = clk_register(dev, &am->hw);
>> +
>> +	if (IS_ERR(clk))
>> +		kfree(am);
>> +
>> +	return clk;
>> +}
>> +
>> +static const char __initdata *sys_parents[] =   { "hsi", NULL, "pll" };
>
> __initdata goes after the []

Thanks. I'll fix this.
