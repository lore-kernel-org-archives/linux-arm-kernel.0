From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 2 Oct 2015 13:43:08 -0700
Subject: [PATCH v3 1/5] clk: Add a basic multiplier clock
In-Reply-To: <1443512353-28073-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1443512353-28073-1-git-send-email-maxime.ripard@free-electrons.com>
 <1443512353-28073-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20151002204308.GY12338@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/29, Maxime Ripard wrote:
> diff --git a/drivers/clk/clk-multiplier.c b/drivers/clk/clk-multiplier.c
> new file mode 100644
> index 000000000000..61097e365d55
> --- /dev/null
> +++ b/drivers/clk/clk-multiplier.c
> @@ -0,0 +1,176 @@
> +/*
> + * Copyright (C) 2015 Maxime Ripard <maxime.ripard@free-electrons.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include <linux/module.h>

Maybe export.h is more appropriate?

> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +
> +#define to_clk_multiplier(_hw) container_of(_hw, struct clk_multiplier, hw)
> +
> +static unsigned long __get_mult(struct clk_multiplier *mult,
> +				unsigned long rate,
> +				unsigned long parent_rate)
> +{
> +	if (mult->flags & CLK_MULTIPLIER_ROUND_CLOSEST)
> +		return DIV_ROUND_CLOSEST(rate, parent_rate);

We should include kernel.h for this macro.

> +
> +	return rate / parent_rate;
> +}
> +
> +static unsigned long clk_multiplier_recalc_rate(struct clk_hw *hw,
> +						unsigned long parent_rate)
> +{
> +	struct clk_multiplier *mult = to_clk_multiplier(hw);
> +	unsigned long val;
> +	
> +	val = clk_readl(mult->reg) >> mult->shift;
> +	val &= GENMASK(mult->width, 0);

and bitops.h for GENMASK

> +
> +	if (!val && mult->flags & CLK_MULTIPLIER_ZERO_BYPASS)
> +		val = 1;
> +	
> +	return parent_rate * val;
> +}
> +
> +static bool __is_best_rate(unsigned long rate, unsigned long new,
> +			   unsigned long best, unsigned long flags)
> +{
> +	if (flags & CLK_MULTIPLIER_ROUND_CLOSEST)

Is the only difference in this function vs the divider one that
flag? Maybe we should make this function generic to the framework
and pass a flag indicating closest or not.

> +		return abs(rate - new) < abs(rate - best);
> +
> +	return new >= rate && new < best;
> +}
> +
> +static unsigned long __bestmult(struct clk_hw *hw, unsigned long rate,
> +				unsigned long *best_parent_rate,
> +				u8 width, unsigned long flags)
> +{
> +	unsigned long orig_parent_rate = *best_parent_rate;
> +	unsigned long parent_rate, current_rate, best_rate = ~0;
> +	unsigned int i, bestmult = 0;
> +
> +	if (!(__clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT))

Please use clk_hw_get_flags. I'd *really* like to kill
__clk_get_flags() but we still have one user in omap code.

> +		return rate / *best_parent_rate;
> +
> +	for (i = 1; i < ((1 << width) - 1); i++) {
> +		if (rate * i == orig_parent_rate) {
> +			/*
> +			 * This is the best case for us if we have a
> +			 * perfect match without changing the parent
> +			 * rate.
> +			 */
> +			*best_parent_rate = orig_parent_rate;
> +			return i;
> +		}
> +
> +		parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw),
> +						rate / i);
> +		current_rate = parent_rate * i;
> +
> +		if (__is_best_rate(rate, current_rate, best_rate, flags)) {
> +			bestmult = i;
> +			best_rate = current_rate;
> +			*best_parent_rate = parent_rate;
> +		}
> +	}
> +
> +	return bestmult;
> +}
> +
> +static int clk_multiplier_set_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long parent_rate)
> +{
> +	struct clk_multiplier *mult = to_clk_multiplier(hw);
> +	unsigned long factor = __get_mult(mult, rate, parent_rate);
> +	unsigned long uninitialized_var(flags);

hmmm ok. We set it to 0 in other drivers.

> +	unsigned long val;
> +
> +	if (mult->lock)
> +		spin_lock_irqsave(mult->lock, flags);

This needs the same "trick" that we did in the generic clock
types to avoid sparse warnings.

> +
> +	val = clk_readl(mult->reg);
> +	val &= ~GENMASK(mult->width + mult->shift, mult->shift);
> +	val |= factor << mult->shift;
> +	clk_writel(val, mult->reg);
> +
> +	if (mult->lock)
> +		spin_unlock_irqrestore(mult->lock, flags);
> +
> +	return 0;
> +}
> +
> +struct clk *clk_register_multiplier(struct device *dev, const char *name,
> +				    const char *parent_name,
> +				    unsigned long flags,
> +				    void __iomem *reg, u8 shift, u8 width,
> +				    u8 clk_mult_flags, spinlock_t *lock)
> +{
> +	struct clk_init_data init;
> +	struct clk_multiplier *mult;
> +	struct clk *clk;
> +
> +	mult = kmalloc(sizeof(*mult), GFP_KERNEL);
> +	if (!mult) {
> +		pr_err("%s: could not allocate multiplier clk\n", __func__);

We don't need allocation error messages.

> +		return ERR_PTR(-ENOMEM);
> +	}

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
