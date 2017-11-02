From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Nov 2017 00:50:39 -0700
Subject: [PATCH V2 01/10] clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk
 support
In-Reply-To: <1499946435-7177-2-git-send-email-aisheng.dong@nxp.com>
References: <1499946435-7177-1-git-send-email-aisheng.dong@nxp.com>
 <1499946435-7177-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20171102075039.GU30645@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13, Dong Aisheng wrote:
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index 9bb472c..55f8c41 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -123,6 +123,9 @@ unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
>  	struct clk_divider *divider = to_clk_divider(hw);
>  	unsigned int div;
>  
> +	if (flags & CLK_DIVIDER_ZERO_GATE && !val)
> +		return 0;
> +
>  	div = _get_div(table, val, flags, divider->width);
>  	if (!div) {
>  		WARN(!(flags & CLK_DIVIDER_ALLOW_ZERO),
> @@ -141,8 +144,13 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
>  	struct clk_divider *divider = to_clk_divider(hw);
>  	unsigned int val;
>  
> -	val = clk_readl(divider->reg) >> divider->shift;
> -	val &= div_mask(divider->width);
> +	if ((divider->flags & CLK_DIVIDER_ZERO_GATE) &&
> +	    !clk_hw_is_enabled(hw)) {

This seems racy. Are we holding the register lock here?

> +		val = divider->cached_val;
> +	} else {
> +		val = clk_readl(divider->reg) >> divider->shift;
> +		val &= div_mask(divider->width);
> +	}
>  
>  	return divider_recalc_rate(hw, parent_rate, val, divider->table,
>  				   divider->flags);
> @@ -392,6 +400,12 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
>  	value = divider_get_val(rate, parent_rate, divider->table,
>  				divider->width, divider->flags);
>  
> +	if ((divider->flags & CLK_DIVIDER_ZERO_GATE) &&
> +	    !clk_hw_is_enabled(hw)) {

Same racy comment here.

> +		divider->cached_val = value;
> +		return 0;
> +	}
> +
>  	if (divider->lock)
>  		spin_lock_irqsave(divider->lock, flags);
>  	else
> @@ -414,10 +428,85 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
>  	return 0;
>  }
>  
> +static int clk_divider_enable(struct clk_hw *hw)
> +{
> +	struct clk_divider *divider = to_clk_divider(hw);
> +	unsigned long flags = 0;
> +	u32 val;
> +
> +	if (!(divider->flags & CLK_DIVIDER_ZERO_GATE))
> +		return 0;

This is not good. We will always jump to these functions on
enable/disable for a divider although 99.9% of all dividers that
exist won't need to run this code at all.

Can you please move this logic into your own divider
implementation? The flag can be added to the generic layer if
necessary but I'd prefer to see this logic kept in the driver
that uses it. If we get more than one driver doing the cached
divider thing then we can think about moving it to the more
generic place like here, but for now we should be able to keep
this contained away from the basic types and handled by the
quirky driver that needs it.

> +
> +	if (!divider->cached_val) {
> +		pr_err("%s: no valid preset rate\n", clk_hw_get_name(hw));
> +		return -EINVAL;
> +	}
> +
> +	if (divider->lock)
> +		spin_lock_irqsave(divider->lock, flags);
> +	else
> +		__acquire(divider->lock);
> +
> +	/* restore div val */
> +	val = clk_readl(divider->reg);
> +	val |= divider->cached_val << divider->shift;
> +	clk_writel(val, divider->reg);
> +
> +	if (divider->lock)
> +		spin_unlock_irqrestore(divider->lock, flags);
> +	else
> +		__release(divider->lock);
> +
> +	return 0;
> +}
> +
> +static void clk_divider_disable(struct clk_hw *hw)
> +{
> +	struct clk_divider *divider = to_clk_divider(hw);
> +	unsigned long flags = 0;
> +	u32 val;
> +
> +	if (!(divider->flags & CLK_DIVIDER_ZERO_GATE))
> +		return;
> +
> +	if (divider->lock)
> +		spin_lock_irqsave(divider->lock, flags);
> +	else
> +		__acquire(divider->lock);
> +
> +	/* store the current div val */
> +	val = clk_readl(divider->reg) >> divider->shift;
> +	val &= div_mask(divider->width);
> +	divider->cached_val = val;
> +	clk_writel(0, divider->reg);
> +
> +	if (divider->lock)
> +		spin_unlock_irqrestore(divider->lock, flags);
> +	else
> +		__release(divider->lock);
> +}
> +
> +static int clk_divider_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_divider *divider = to_clk_divider(hw);
> +	u32 val;
> +
> +	if (!(divider->flags & CLK_DIVIDER_ZERO_GATE))
> +		return __clk_get_enable_count(hw->clk);

The plan was to delete this API once OMAP stopped using it.
clk_hw_is_enabled() doesn't work?

> +
> +	val = clk_readl(divider->reg) >> divider->shift;
> +	val &= div_mask(divider->width);
> +
> +	return val ? 1 : 0;
> +}
> +
>  const struct clk_ops clk_divider_ops = {
>  	.recalc_rate = clk_divider_recalc_rate,
>  	.round_rate = clk_divider_round_rate,
>  	.set_rate = clk_divider_set_rate,
> +	.enable = clk_divider_enable,
> +	.disable = clk_divider_disable,
> +	.is_enabled = clk_divider_is_enabled,
>  };
>  EXPORT_SYMBOL_GPL(clk_divider_ops);
>  
> @@ -436,6 +525,7 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
>  	struct clk_divider *div;
>  	struct clk_hw *hw;
>  	struct clk_init_data init;
> +	u32 val;
>  	int ret;
>  
>  	if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {
> @@ -468,6 +558,12 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
>  	div->hw.init = &init;
>  	div->table = table;
>  
> +	if (div->flags & CLK_DIVIDER_ZERO_GATE) {
> +		val = clk_readl(reg) >> shift;
> +		val &= div_mask(width);
> +		div->cached_val = val;
> +	}

What if it isn't on? Setting cached_val to 0 is ok?

> +
>  	/* register the clock */
>  	hw = &div->hw;
>  	ret = clk_hw_register(dev, hw);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
