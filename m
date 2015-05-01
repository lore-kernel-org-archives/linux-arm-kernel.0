From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 30 Apr 2015 18:09:38 -0700
Subject: [PATCH RFC v1 4/5] clk: core: add CLK_SET_PARENT_ON flags to
 support clocks require parent on
In-Reply-To: <1429107999-24413-5-git-send-email-aisheng.dong@freescale.com>
References: <1429107999-24413-1-git-send-email-aisheng.dong@freescale.com>
 <1429107999-24413-5-git-send-email-aisheng.dong@freescale.com>
Message-ID: <20150501010938.GE32407@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15, Dong Aisheng wrote:
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 7af553d..f2470e5 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -43,6 +43,11 @@ static int clk_core_get_phase(struct clk_core *clk);
>  static bool clk_core_is_prepared(struct clk_core *clk);
>  static bool clk_core_is_enabled(struct clk_core *clk);
>  static struct clk_core *clk_core_lookup(const char *name);
> +static struct clk *clk_core_get_parent(struct clk_core *clk);
> +static int clk_core_prepare(struct clk_core *clk);
> +static void clk_core_unprepare(struct clk_core *clk);
> +static int clk_core_enable(struct clk_core *clk);
> +static void clk_core_disable(struct clk_core *clk);

Let's avoid adding more here if we can.

>  
>  /***    private data structures    ***/
>  
> @@ -508,6 +513,7 @@ static void clk_unprepare_unused_subtree(struct clk_core *clk)
>  static void clk_disable_unused_subtree(struct clk_core *clk)
>  {
>  	struct clk_core *child;
> +	struct clk *parent = clk_core_get_parent(clk);
>  	unsigned long flags;
>  
>  	lockdep_assert_held(&prepare_lock);
> @@ -515,6 +521,13 @@ static void clk_disable_unused_subtree(struct clk_core *clk)
>  	hlist_for_each_entry(child, &clk->children, child_node)
>  		clk_disable_unused_subtree(child);
>  
> +	if (clk->flags & CLK_SET_PARENT_ON && parent) {
> +		clk_core_prepare(parent->core);
> +		flags = clk_enable_lock();
> +		clk_core_enable(parent->core);
> +		clk_enable_unlock(flags);
> +	}

If there's a parent and this clock is on, why wouldn't the parent
also be on? It doesn't seem right to have a clock that's on
without it's parent on that we're trying to turn off. Put another
way, how is this fixing anything?

> +
>  	flags = clk_enable_lock();
>  
>  	if (clk->enable_count)
> @@ -608,6 +627,14 @@ struct clk *__clk_get_parent(struct clk *clk)
>  }
>  EXPORT_SYMBOL_GPL(__clk_get_parent);
>  
> +static struct clk *clk_core_get_parent(struct clk_core *clk)
> +{
> +	if (!clk)
> +		return NULL;
> +
> +	return !clk->parent ? NULL : clk->parent->hw->clk;
> +}

s/clk/core/ in this function

> +
>  static struct clk_core *clk_core_get_parent_by_index(struct clk_core *clk,
>  							 u8 index)
>  {
> @@ -1456,13 +1483,27 @@ static struct clk_core *__clk_set_parent_before(struct clk_core *clk,
>  	 * hardware and software states.
>  	 *
>  	 * See also: Comment for clk_set_parent() below.
> +	 *
> +	 * 2. enable two parents clock for .set_parent() operation if finding
> +	 * flag CLK_SET_PARENT_ON
>  	 */
> -	if (clk->prepare_count) {
> +	if (clk->prepare_count || clk->flags & CLK_SET_PARENT_ON) {
>  		clk_core_prepare(parent);
>  		flags = clk_enable_lock();
>  		clk_core_enable(parent);
> -		clk_core_enable(clk);
>  		clk_enable_unlock(flags);
> +
> +		if (clk->prepare_count) {
> +			flags = clk_enable_lock();
> +			clk_core_enable(clk);
> +			clk_enable_unlock(flags);
> +		} else {
> +
> +			clk_core_prepare(old_parent);
> +			flags = clk_enable_lock();
> +			clk_core_enable(old_parent);
> +			clk_enable_unlock(flags);
> +		}
>  	}
>  
>  	/* update the clk tree topology */
> @@ -1483,12 +1524,22 @@ static void __clk_set_parent_after(struct clk_core *clk,
>  	 * Finish the migration of prepare state and undo the changes done
>  	 * for preventing a race with clk_enable().
>  	 */
> -	if (clk->prepare_count) {
> +	if (clk->prepare_count || clk->flags & CLK_SET_PARENT_ON) {
>  		flags = clk_enable_lock();
> -		clk_core_disable(clk);
>  		clk_core_disable(old_parent);
>  		clk_enable_unlock(flags);
>  		clk_core_unprepare(old_parent);
> +
> +		if (clk->prepare_count) {
> +			flags = clk_enable_lock();
> +			clk_core_disable(clk);
> +			clk_enable_unlock(flags);
> +		} else {
> +			flags = clk_enable_lock();
> +			clk_core_disable(parent);
> +			clk_enable_unlock(flags);
> +			clk_core_unprepare(parent);
> +		}

Is there a reason why the clk itself can't be on when we switch
parents? It seems that if the clk was on during the parent
switch, then it should be possible to just add a flag check on
both these if conditions and be done. It may be possible to
change the behavior here and not enable the clk in hardware, just
up the count and turn on both the parents. I'm trying to recall
why we enable the clk itself across the switch.

>  	}
>  }
>  
> @@ -1514,12 +1565,23 @@ static int __clk_set_parent(struct clk_core *clk, struct clk_core *parent,
>  		clk_reparent(clk, old_parent);
>  		clk_enable_unlock(flags);
>  
> -		if (clk->prepare_count) {
> +		if (clk->prepare_count || clk->flags & CLK_SET_PARENT_ON) {
>  			flags = clk_enable_lock();
> -			clk_core_disable(clk);
>  			clk_core_disable(parent);
>  			clk_enable_unlock(flags);
>  			clk_core_unprepare(parent);
> +
> +			if (clk->prepare_count) {
> +				flags = clk_enable_lock();
> +				clk_core_disable(clk);
> +				clk_enable_unlock(flags);
> +			} else {
> +				flags = clk_enable_lock();
> +				clk_core_disable(old_parent);
> +				clk_enable_unlock(flags);
> +				clk_core_unprepare(old_parent);
> +			}
> +

Hmmm... if __clk_set_parent_after() actually used the second
argument then we could put this duplicate logic in there and call
it with a different order of arguments in the success vs. error
paths in this function. Unless I missed something.

>  		}
>  		return ret;
>  	}
> @@ -1735,13 +1797,18 @@ static void clk_change_rate(struct clk_core *clk)
>  	unsigned long best_parent_rate = 0;
>  	bool skip_set_rate = false;
>  	struct clk_core *old_parent;
> +	struct clk_core *parent = NULL;
> +	unsigned long flags;
>  
>  	old_rate = clk->rate;
>  
> -	if (clk->new_parent)
> +	if (clk->new_parent) {
> +		parent = clk->new_parent;
>  		best_parent_rate = clk->new_parent->rate;
> -	else if (clk->parent)
> +	} else if (clk->parent) {
> +		parent = clk->parent;
>  		best_parent_rate = clk->parent->rate;
> +	}
>  
>  	if (clk->new_parent && clk->new_parent != clk->parent) {
>  		old_parent = __clk_set_parent_before(clk, clk->new_parent);
> @@ -1762,6 +1829,13 @@ static void clk_change_rate(struct clk_core *clk)
>  
>  	trace_clk_set_rate(clk, clk->new_rate);
>  
> +	if (clk->flags & CLK_SET_PARENT_ON && parent) {
> +		clk_core_prepare(parent);
> +		flags = clk_enable_lock();
> +		clk_core_enable(parent);
> +		clk_enable_unlock(flags);
> +	}

I can understand the case where clk_set_parent() can't switch the
mux because it needs the source and destination parents to be
clocking. I have that hardware design on my desk. But to change
the rate of a clock? The name of the flag, CLK_SET_PARENT_ON,
leads me to believe we don't really need to do this if we're
changing the rate, unless we're also switching the parents. Care
to explain why the hardware requires this?

If we actually do need to keep the parent clock on when the rate
is switching the name of the flag could be better and not have
"set parent" in the name.

> +
>  	if (!skip_set_rate && clk->ops->set_rate)
>  		clk->ops->set_rate(clk->hw, clk->new_rate, best_parent_rate);
>  
> @@ -1769,6 +1843,13 @@ static void clk_change_rate(struct clk_core *clk)
>  
>  	clk->rate = clk_recalc(clk, best_parent_rate);
>  
> +	if (clk->flags & CLK_SET_PARENT_ON && parent) {
> +		flags = clk_enable_lock();
> +		clk_core_disable(parent);
> +		clk_enable_unlock(flags);
> +		clk_core_unprepare(parent);
> +	}

Why not just call clk_prepare_enable()? Or add a clk_core
specific function, clk_core_prepare_enable() that we can call
here. We could put the parent pointer check in there too so that
it's just

 if (clk->flags & CLK_SET_PARENT_ON)
 	clk_core_prepare_enable(parent);

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
