From: dongas86@gmail.com (Dong Aisheng)
Date: Wed, 17 Jan 2018 11:00:48 +0800
Subject: [PATCH V2 01/10] clk: clk-divider: add CLK_DIVIDER_ZERO_GATE clk
 support
In-Reply-To: <20171222012401.GB7997@codeaurora.org>
References: <1499946435-7177-1-git-send-email-aisheng.dong@nxp.com>
 <1499946435-7177-2-git-send-email-aisheng.dong@nxp.com>
 <20171102075039.GU30645@codeaurora.org>
 <20171220142757.GB30461@b29396-OptiPlex-7040>
 <20171222012401.GB7997@codeaurora.org>
Message-ID: <20180117030047.GB7760@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 05:24:01PM -0800, Stephen Boyd wrote:
> On 12/20, Dong Aisheng wrote:
> > On Thu, Nov 02, 2017 at 12:50:39AM -0700, Stephen Boyd wrote:
> > > On 07/13, Dong Aisheng wrote:
> > > > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > > > index 9bb472c..55f8c41 100644
> > > > --- a/drivers/clk/clk-divider.c
> > > > +++ b/drivers/clk/clk-divider.c
> > > > @@ -123,6 +123,9 @@ unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
> > > >  	struct clk_divider *divider = to_clk_divider(hw);
> > > >  	unsigned int div;
> > > >  
> > > > +	if (flags & CLK_DIVIDER_ZERO_GATE && !val)
> > > > +		return 0;
> > > > +
> > > >  	div = _get_div(table, val, flags, divider->width);
> > > >  	if (!div) {
> > > >  		WARN(!(flags & CLK_DIVIDER_ALLOW_ZERO),
> > > > @@ -141,8 +144,13 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
> > > >  	struct clk_divider *divider = to_clk_divider(hw);
> > > >  	unsigned int val;
> > > >  
> > > > -	val = clk_readl(divider->reg) >> divider->shift;
> > > > -	val &= div_mask(divider->width);
> > > > +	if ((divider->flags & CLK_DIVIDER_ZERO_GATE) &&
> > > > +	    !clk_hw_is_enabled(hw)) {
> > > 
> > > This seems racy. Are we holding the register lock here?
> > > 
> > 
> > Would you please clarify what type of racy you mean?
> 
> I mean a race between clk_enable() and clk_set_rate(). A
> clk_enable() can happen while a rate change is going on, and then
> the clk_hw_is_enabled() check here would be racing, unless this
> driver specifically tries to prevent that from happening by
> holding a spinlock somewhere.
> 

I understand your point now.
Thanks for the careful and professional review.

Will take care of it in the next version.

Thanks

Regards
Dong Aisheng

> > 
> > Currently it only protects register write between set_rate and enable/disable,
> > and other register read are not protected.
> > e.g. in recalc_rate and is_enabled.
> 
> If you're holding some lock that is used to protect the register
> writes and also the clk from getting enabled/disabled during a
> rate change then it's fine.
> 
> > 
> > And i did see similar users, e.g.
> > drivers/clk/sunxi-ng/ccu_mult.c
> 
> Sure. Those could also be broken. I'm not sure.
> 
> > 
> > Should we still need protect them here?
> > 
> > > > +		val = divider->cached_val;
> > > > +	} else {
> > > > +		val = clk_readl(divider->reg) >> divider->shift;
> > > > +		val &= div_mask(divider->width);
> > > > +	}
> > > >  
> > > >  	return divider_recalc_rate(hw, parent_rate, val, divider->table,
> > > >  				   divider->flags);
> > > > @@ -392,6 +400,12 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
> > > >  	value = divider_get_val(rate, parent_rate, divider->table,
> > > >  				divider->width, divider->flags);
> > > >  
> > > > +	if ((divider->flags & CLK_DIVIDER_ZERO_GATE) &&
> > > > +	    !clk_hw_is_enabled(hw)) {
> > > 
> > > Same racy comment here.
> > > 
> > > > +		divider->cached_val = value;
> > > > +		return 0;
> > > > +	}
> > > > +
> > > >  	if (divider->lock)
> > > >  		spin_lock_irqsave(divider->lock, flags);
> > > >  	else
> > > > @@ -414,10 +428,85 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +static int clk_divider_enable(struct clk_hw *hw)
> > > > +{
> > > > +	struct clk_divider *divider = to_clk_divider(hw);
> > > > +	unsigned long flags = 0;
> > > > +	u32 val;
> > > > +
> > > > +	if (!(divider->flags & CLK_DIVIDER_ZERO_GATE))
> > > > +		return 0;
> > > 
> > > This is not good. We will always jump to these functions on
> > > enable/disable for a divider although 99.9% of all dividers that
> > > exist won't need to run this code at all.
> > > 
> > 
> > I absolutely understand this concern.
> > 
> > > Can you please move this logic into your own divider
> > > implementation? The flag can be added to the generic layer if
> > > necessary but I'd prefer to see this logic kept in the driver
> > > that uses it. If we get more than one driver doing the cached
> > > divider thing then we can think about moving it to the more
> > > generic place like here, but for now we should be able to keep
> > > this contained away from the basic types and handled by the
> > > quirky driver that needs it.
> > > 
> > 
> > If only for above issue, how about invent a clk_divider_gate_ops
> > to separate the users of normal divider and zero gate divider:
> > 
> > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > index 4ed516c..b51f3f9 100644
> > --- a/drivers/clk/clk-divider.c
> > +++ b/drivers/clk/clk-divider.c
> > @@ -125,6 +125,9 @@ unsigned long divider_recalc_rate(struct clk_hw *hw, unsigned long parent_rate,
> >  
> >  	div = _get_div(table, val, flags, divider->width);
> >  	if (!div) {
> > +		if (flags & CLK_DIVIDER_ZERO_GATE)
> > +			return 0;
> > +
> >  		WARN(!(flags & CLK_DIVIDER_ALLOW_ZERO),
> >  			"%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set\n",
> >  			clk_hw_get_name(hw));
> > @@ -148,6 +151,23 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
> >  				   divider->flags);
> >  }
> >  
> > +static unsigned long clk_divider_gate_recalc_rate(struct clk_hw *hw,
> > +						  unsigned long parent_rate)
> > +{
> > +	struct clk_divider *divider = to_clk_divider(hw);
> > +	unsigned int val;
> > +
> > +	if (!clk_hw_is_enabled(hw)) {
> > +		val = divider->cached_val;
> > +	} else {
> > +		val = clk_readl(divider->reg) >> divider->shift;
> > +		val &= div_mask(divider->width);
> > +	}
> > +
> > +	return divider_recalc_rate(hw, parent_rate, val, divider->table,
> > +				   divider->flags);
> > +}
> > +
> >  static bool _is_valid_table_div(const struct clk_div_table *table,
> >  							 unsigned int div)
> >  {
> > @@ -416,6 +436,89 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
> >  	return 0;
> >  }
> >  
> > +static int clk_divider_gate_set_rate(struct clk_hw *hw, unsigned long rate,
> > +				unsigned long parent_rate)
> > +{
> > +	struct clk_divider *divider = to_clk_divider(hw);
> > +	int value;
> > +
> > +	if (!clk_hw_is_enabled(hw)) {
> > +		value = divider_get_val(rate, parent_rate, divider->table,
> > +					divider->width, divider->flags);
> > +		if (value < 0)
> > +			return value;
> > +
> > +		divider->cached_val = value;
> > +
> > +		return 0;
> > +	}
> > +
> > +	return clk_divider_set_rate(hw, rate, parent_rate);
> > +}
> > +
> > +static int clk_divider_enable(struct clk_hw *hw)
> > +{
> > +	struct clk_divider *divider = to_clk_divider(hw);
> > +	unsigned long uninitialized_var(flags);
> > +	u32 val;
> > +
> > +	if (!divider->cached_val) {
> > +		pr_err("%s: no valid preset rate\n", clk_hw_get_name(hw));
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (divider->lock)
> > +		spin_lock_irqsave(divider->lock, flags);
> > +	else
> > +		__acquire(divider->lock);
> > +
> > +	/* restore div val */
> > +	val = clk_readl(divider->reg);
> > +	val |= divider->cached_val << divider->shift;
> > +	clk_writel(val, divider->reg);
> > +
> > +	if (divider->lock)
> > +		spin_unlock_irqrestore(divider->lock, flags);
> > +	else
> > +		__release(divider->lock);
> > +
> > +	return 0;
> > +}
> > +
> > +static void clk_divider_disable(struct clk_hw *hw)
> > +{
> > +	struct clk_divider *divider = to_clk_divider(hw);
> > +	unsigned long uninitialized_var(flags);
> > +	u32 val;
> > +
> > +	if (divider->lock)
> > +		spin_lock_irqsave(divider->lock, flags);
> > +	else
> > +		__acquire(divider->lock);
> > +
> > +	/* store the current div val */
> > +	val = clk_readl(divider->reg) >> divider->shift;
> > +	val &= div_mask(divider->width);
> > +	divider->cached_val = val;
> > +	clk_writel(0, divider->reg);
> > +
> > +	if (divider->lock)
> > +		spin_unlock_irqrestore(divider->lock, flags);
> > +	else
> > +		__release(divider->lock);
> > +}
> > +
> > +static int clk_divider_is_enabled(struct clk_hw *hw)
> > +{
> > +	struct clk_divider *divider = to_clk_divider(hw);
> > +	u32 val;
> > +
> > +	val = clk_readl(divider->reg) >> divider->shift;
> > +	val &= div_mask(divider->width);
> > +
> > +	return val ? 1 : 0;
> > +}
> > +
> >  const struct clk_ops clk_divider_ops = {
> >  	.recalc_rate = clk_divider_recalc_rate,
> >  	.round_rate = clk_divider_round_rate,
> > @@ -423,6 +526,16 @@ const struct clk_ops clk_divider_ops = {
> >  };
> >  EXPORT_SYMBOL_GPL(clk_divider_ops);
> >  
> > +const struct clk_ops clk_divider_gate_ops = {
> > +	.recalc_rate = clk_divider_gate_recalc_rate,
> > +	.round_rate = clk_divider_round_rate,
> > +	.set_rate = clk_divider_gate_set_rate,
> > +	.enable = clk_divider_enable,
> > +	.disable = clk_divider_disable,
> > +	.is_enabled = clk_divider_is_enabled,
> > +};
> > +EXPORT_SYMBOL_GPL(clk_divider_gate_ops);
> > +
> >  const struct clk_ops clk_divider_ro_ops = {
> >  	.recalc_rate = clk_divider_recalc_rate,
> >  	.round_rate = clk_divider_round_rate,
> > @@ -438,6 +551,7 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
> >  	struct clk_divider *div;
> >  	struct clk_hw *hw;
> >  	struct clk_init_data init;
> > +	u32 val;
> >  	int ret;
> >  
> >  	if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {
> > @@ -455,6 +569,8 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
> >  	init.name = name;
> >  	if (clk_divider_flags & CLK_DIVIDER_READ_ONLY)
> >  		init.ops = &clk_divider_ro_ops;
> > +	else if (clk_divider_flags & CLK_DIVIDER_ZERO_GATE)
> > +		init.ops = &clk_divider_gate_ops;
> >  	else
> >  		init.ops = &clk_divider_ops;
> >  	init.flags = flags | CLK_IS_BASIC;
> > @@ -470,6 +586,12 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
> >  	div->hw.init = &init;
> >  	div->table = table;
> >  
> > +	if (div->flags & CLK_DIVIDER_ZERO_GATE) {
> > +		val = clk_readl(reg) >> shift;
> > +		val &= div_mask(width);
> > +		div->cached_val = val;
> > +	}
> > +
> >  	/* register the clock */
> >  	hw = &div->hw;
> >  	ret = clk_hw_register(dev, hw);
> > diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> > index 7c925e6..5f33b73 100644
> > --- a/include/linux/clk-provider.h
> > +++ b/include/linux/clk-provider.h
> > @@ -358,6 +358,7 @@ struct clk_div_table {
> >   * @shift:	shift to the divider bit field
> >   * @width:	width of the divider bit field
> >   * @table:	array of value/divider pairs, last entry should have div = 0
> > + * @cached_val: cached div hw value used for CLK_DIVIDER_ZERO_GATE
> >   * @lock:	register lock
> >   *
> >   * Clock with an adjustable divider affecting its output frequency.  Implements
> > @@ -386,6 +387,12 @@ struct clk_div_table {
> >   * CLK_DIVIDER_MAX_AT_ZERO - For dividers which are like CLK_DIVIDER_ONE_BASED
> >   *	except when the value read from the register is zero, the divisor is
> >   *	2^width of the field.
> > + * CLK_DIVIDER_ZERO_GATE - For dividers which are like CLK_DIVIDER_ONE_BASED
> > + *	when the value read from the register is zero, it means the divisor
> > + *	is gated. For this case, the cached_val will be used to store the
> > + *	intermediate div for the normal rate operation, like set_rate/get_rate/
> > + *	recalc_rate. When the divider is ungated, the driver will actually
> > + *	program the hardware to have the requested divider value.
> >   */
> >  struct clk_divider {
> >  	struct clk_hw	hw;
> > @@ -394,6 +401,7 @@ struct clk_divider {
> >  	u8		width;
> >  	u8		flags;
> >  	const struct clk_div_table	*table;
> > +	u32		cached_val;
> >  	spinlock_t	*lock;
> >  };
> >  
> > @@ -406,6 +414,7 @@ struct clk_divider {
> >  #define CLK_DIVIDER_ROUND_CLOSEST	BIT(4)
> >  #define CLK_DIVIDER_READ_ONLY		BIT(5)
> >  #define CLK_DIVIDER_MAX_AT_ZERO		BIT(6)
> > +#define CLK_DIVIDER_ZERO_GATE		BIT(7)
> >  
> >  extern const struct clk_ops clk_divider_ops;
> >  extern const struct clk_ops clk_divider_ro_ops;
> > 
> > Anyway, if you still think it's not proper, i can put it in platform
> > driver as you wish, just in the cost of a few duplicated codes.
> 
> Ok. Keeping it in the basic types but split into different ops
> path looks good.
> 
> > 
> > > > +
> > > > +	if (!divider->cached_val) {
> > > > +		pr_err("%s: no valid preset rate\n", clk_hw_get_name(hw));
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	if (divider->lock)
> > > > +		spin_lock_irqsave(divider->lock, flags);
> > > > +	else
> > > > +		__acquire(divider->lock);
> > > > +
> > > > +	/* restore div val */
> > > > +	val = clk_readl(divider->reg);
> > > > +	val |= divider->cached_val << divider->shift;
> > > > +	clk_writel(val, divider->reg);
> > > > +
> > > > +	if (divider->lock)
> > > > +		spin_unlock_irqrestore(divider->lock, flags);
> > > > +	else
> > > > +		__release(divider->lock);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static void clk_divider_disable(struct clk_hw *hw)
> > > > +{
> > > > +	struct clk_divider *divider = to_clk_divider(hw);
> > > > +	unsigned long flags = 0;
> > > > +	u32 val;
> > > > +
> > > > +	if (!(divider->flags & CLK_DIVIDER_ZERO_GATE))
> > > > +		return;
> > > > +
> > > > +	if (divider->lock)
> > > > +		spin_lock_irqsave(divider->lock, flags);
> > > > +	else
> > > > +		__acquire(divider->lock);
> > > > +
> > > > +	/* store the current div val */
> > > > +	val = clk_readl(divider->reg) >> divider->shift;
> > > > +	val &= div_mask(divider->width);
> > > > +	divider->cached_val = val;
> > > > +	clk_writel(0, divider->reg);
> > > > +
> > > > +	if (divider->lock)
> > > > +		spin_unlock_irqrestore(divider->lock, flags);
> > > > +	else
> > > > +		__release(divider->lock);
> > > > +}
> > > > +
> > > > +static int clk_divider_is_enabled(struct clk_hw *hw)
> > > > +{
> > > > +	struct clk_divider *divider = to_clk_divider(hw);
> > > > +	u32 val;
> > > > +
> > > > +	if (!(divider->flags & CLK_DIVIDER_ZERO_GATE))
> > > > +		return __clk_get_enable_count(hw->clk);
> > > 
> > > The plan was to delete this API once OMAP stopped using it.
> > > clk_hw_is_enabled() doesn't work?
> > 
> > No, it did not work before because clk_hw_is_enabled will result
> > in the dead loop by calling .is_enabled() callback again.
> > 
> > That's why __clk_get_enable_count is used instead.
> > 
> > However, with above new patch method, this issue was gone.
> 
> Great!
> 
> > 
> > > 
> > > > +
> > > > +	val = clk_readl(divider->reg) >> divider->shift;
> > > > +	val &= div_mask(divider->width);
> > > > +
> > > > +	return val ? 1 : 0;
> > > > +}
> > > > +
> > > >  const struct clk_ops clk_divider_ops = {
> > > >  	.recalc_rate = clk_divider_recalc_rate,
> > > >  	.round_rate = clk_divider_round_rate,
> > > >  	.set_rate = clk_divider_set_rate,
> > > > +	.enable = clk_divider_enable,
> > > > +	.disable = clk_divider_disable,
> > > > +	.is_enabled = clk_divider_is_enabled,
> > > >  };
> > > >  EXPORT_SYMBOL_GPL(clk_divider_ops);
> > > >  
> > > > @@ -436,6 +525,7 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
> > > >  	struct clk_divider *div;
> > > >  	struct clk_hw *hw;
> > > >  	struct clk_init_data init;
> > > > +	u32 val;
> > > >  	int ret;
> > > >  
> > > >  	if (clk_divider_flags & CLK_DIVIDER_HIWORD_MASK) {
> > > > @@ -468,6 +558,12 @@ static struct clk_hw *_register_divider(struct device *dev, const char *name,
> > > >  	div->hw.init = &init;
> > > >  	div->table = table;
> > > >  
> > > > +	if (div->flags & CLK_DIVIDER_ZERO_GATE) {
> > > > +		val = clk_readl(reg) >> shift;
> > > > +		val &= div_mask(width);
> > > > +		div->cached_val = val;
> > > > +	}
> > > 
> > > What if it isn't on? Setting cached_val to 0 is ok?
> > > 
> > 
> > If it isn't on, then the cache_val should be 0.
> > And recalc_rate will catch this case and return 0 as there's
> > no proper pre-set rate.
> > 
> 
> Ok.
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
