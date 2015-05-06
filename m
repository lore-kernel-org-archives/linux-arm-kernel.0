From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 6 May 2015 16:34:47 -0700
Subject: [PATCH RFC v1 4/5] clk: core: add CLK_SET_PARENT_ON flags to
 support clocks require parent on
In-Reply-To: <20150504103647.GD4082@shlinux1.ap.freescale.net>
References: <1429107999-24413-1-git-send-email-aisheng.dong@freescale.com>
 <1429107999-24413-5-git-send-email-aisheng.dong@freescale.com>
 <20150501010938.GE32407@codeaurora.org>
 <20150504103647.GD4082@shlinux1.ap.freescale.net>
Message-ID: <20150506233447.GC21794@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/04, Dong Aisheng wrote:
> On Thu, Apr 30, 2015 at 06:09:38PM -0700, Stephen Boyd wrote:
> > On 04/15, Dong Aisheng wrote:
> > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > index 7af553d..f2470e5 100644
> > > --- a/drivers/clk/clk.c
> > > +++ b/drivers/clk/clk.c
> > > @@ -43,6 +43,11 @@ static int clk_core_get_phase(struct clk_core *clk);
> > >  static bool clk_core_is_prepared(struct clk_core *clk);
> > >  static bool clk_core_is_enabled(struct clk_core *clk);
> > >  static struct clk_core *clk_core_lookup(const char *name);
> > > +static struct clk *clk_core_get_parent(struct clk_core *clk);
> > > +static int clk_core_prepare(struct clk_core *clk);
> > > +static void clk_core_unprepare(struct clk_core *clk);
> > > +static int clk_core_enable(struct clk_core *clk);
> > > +static void clk_core_disable(struct clk_core *clk);
> > 
> > Let's avoid adding more here if we can.
> > 
> 
> Yes, also don't want to add these pre-declarations, but needed by the following
> changes...
> 
> > >  
> > >  /***    private data structures    ***/
> > >  
> > > @@ -508,6 +513,7 @@ static void clk_unprepare_unused_subtree(struct clk_core *clk)
> > >  static void clk_disable_unused_subtree(struct clk_core *clk)
> > >  {
> > >  	struct clk_core *child;
> > > +	struct clk *parent = clk_core_get_parent(clk);
> > >  	unsigned long flags;
> > >  
> > >  	lockdep_assert_held(&prepare_lock);
> > > @@ -515,6 +521,13 @@ static void clk_disable_unused_subtree(struct clk_core *clk)
> > >  	hlist_for_each_entry(child, &clk->children, child_node)
> > >  		clk_disable_unused_subtree(child);
> > >  
> > > +	if (clk->flags & CLK_SET_PARENT_ON && parent) {
> > > +		clk_core_prepare(parent->core);
> > > +		flags = clk_enable_lock();
> > > +		clk_core_enable(parent->core);
> > > +		clk_enable_unlock(flags);
> > > +	}
> > 
> > If there's a parent and this clock is on, why wouldn't the parent
> > also be on? It doesn't seem right to have a clock that's on
> > without it's parent on that we're trying to turn off. Put another
> > way, how is this fixing anything?
> > 
> 
> Well, this is caused by a state mis-align between HW and SW in clock tree
> during booting.
> Usually in uboot, we may enable all clocks in HW by default.
> And during kernel booting time, the parent clock could be disabled in its driver
> probe due to calling clk_prepare_enable and clk_disable_unprepare.
> Because it's child clock is only enabled in HW while its SW usecount in
> clock tree is still 0, so clk_disable of parent clock will gate the parent clock
> in both HW and SW usecount ultimately.
> Then there will be a clock is on in HW while its parent is disabled.
> 
> Later when clock core does clk_disable_unused, this clock disable
> will cause system hang due to the limitation of operation requiring its parent
> clock on.
> 

Very good. Now we understand the real problem; the framework
doesn't keep parent clocks on for child clocks that are already
on in the bootloader when those child clocks haven't been
acquired by a driver. How about we solve that problem?

> > > @@ -1483,12 +1524,22 @@ static void __clk_set_parent_after(struct clk_core *clk,
> > >  	 * Finish the migration of prepare state and undo the changes done
> > >  	 * for preventing a race with clk_enable().
> > >  	 */
> > > -	if (clk->prepare_count) {
> > > +	if (clk->prepare_count || clk->flags & CLK_SET_PARENT_ON) {
> > >  		flags = clk_enable_lock();
> > > -		clk_core_disable(clk);
> > >  		clk_core_disable(old_parent);
> > >  		clk_enable_unlock(flags);
> > >  		clk_core_unprepare(old_parent);
> > > +
> > > +		if (clk->prepare_count) {
> > > +			flags = clk_enable_lock();
> > > +			clk_core_disable(clk);
> > > +			clk_enable_unlock(flags);
> > > +		} else {
> > > +			flags = clk_enable_lock();
> > > +			clk_core_disable(parent);
> > > +			clk_enable_unlock(flags);
> > > +			clk_core_unprepare(parent);
> > > +		}
> > 
> > Is there a reason why the clk itself can't be on when we switch
> > parents? 
> 
> The CLK_SET_PARENT_ON only indicates that it's parent clocks should
> be on, not itself clock.
> And we don't want to break CLK_SET_PARENT_GATE clocks.
> So if the clk is not prepared before, we only enable its old parent,
> not including itself.
> 
> > It seems that if the clk was on during the parent
> > switch, then it should be possible to just add a flag check on
> > both these if conditions and be done. It may be possible to
> > change the behavior here and not enable the clk in hardware, just
> > up the count and turn on both the parents. I'm trying to recall
> > why we enable the clk itself across the switch.
> > 
> 
> Seems it's needed by this fix:
> commit f8aa0b clk: Fix race condition between clk_set_parent and clk_enable()

I'm saying I don't recall why that commit needed to turn on the
clock itself. It certainly doesn't seem to be required at first
glance. I hope we can get away with just upping the count on the
clock and enable both parents to avoid the race condition so that
we don't have to worry about CLK_SET_PARENT_GATE.

> 
> > >  		}
> > >  		return ret;
> > >  	}
> > > @@ -1735,13 +1797,18 @@ static void clk_change_rate(struct clk_core *clk)
> > >  	unsigned long best_parent_rate = 0;
> > >  	bool skip_set_rate = false;
> > >  	struct clk_core *old_parent;
> > > +	struct clk_core *parent = NULL;
> > > +	unsigned long flags;
> > >  
> > >  	old_rate = clk->rate;
> > >  
> > > -	if (clk->new_parent)
> > > +	if (clk->new_parent) {
> > > +		parent = clk->new_parent;
> > >  		best_parent_rate = clk->new_parent->rate;
> > > -	else if (clk->parent)
> > > +	} else if (clk->parent) {
> > > +		parent = clk->parent;
> > >  		best_parent_rate = clk->parent->rate;
> > > +	}
> > >  
> > >  	if (clk->new_parent && clk->new_parent != clk->parent) {
> > >  		old_parent = __clk_set_parent_before(clk, clk->new_parent);
> > > @@ -1762,6 +1829,13 @@ static void clk_change_rate(struct clk_core *clk)
> > >  
> > >  	trace_clk_set_rate(clk, clk->new_rate);
> > >  
> > > +	if (clk->flags & CLK_SET_PARENT_ON && parent) {
> > > +		clk_core_prepare(parent);
> > > +		flags = clk_enable_lock();
> > > +		clk_core_enable(parent);
> > > +		clk_enable_unlock(flags);
> > > +	}
> > 
> > I can understand the case where clk_set_parent() can't switch the
> > mux because it needs the source and destination parents to be
> > clocking. I have that hardware design on my desk. But to change
> > the rate of a clock? The name of the flag, CLK_SET_PARENT_ON,
> > leads me to believe we don't really need to do this if we're
> > changing the rate, unless we're also switching the parents. Care
> > to explain why the hardware requires this?
> > 
> 
> What i know is that it's designed for eliminate glitch internally.
> Will find more information for you.

On my hardware we need to have both parents on to switch the mux
in a glitch free manner. Using the .set_rate_and_parent op we can
change the mux value and the rate (i.e. divider) at the same time
with one register write. And we only need to worry about having
both parents on if the clock itself is on, which the framework
handles for us today.

> 
> > If we actually do need to keep the parent clock on when the rate
> > is switching the name of the flag could be better and not have
> > "set parent" in the name.
> > 
> 
> Actually it's meaning is the clock set(e.g. rate, gate/ungate)
> needs its parent clocks on, not set parent...
> But Yes, i fully agree the naming is a bit misleading.
> 
> It just follows the exist CLK_SET_X convention..
> Seems not easy find a better name.
> What's your suggestion?
> 
> How about CLK_OPS_PARENT_ON?

Sure.

> 
> > > +
> > >  	if (!skip_set_rate && clk->ops->set_rate)
> > >  		clk->ops->set_rate(clk->hw, clk->new_rate, best_parent_rate);
> > >  
> > > @@ -1769,6 +1843,13 @@ static void clk_change_rate(struct clk_core *clk)
> > >  
> > >  	clk->rate = clk_recalc(clk, best_parent_rate);
> > >  
> > > +	if (clk->flags & CLK_SET_PARENT_ON && parent) {
> > > +		flags = clk_enable_lock();
> > > +		clk_core_disable(parent);
> > > +		clk_enable_unlock(flags);
> > > +		clk_core_unprepare(parent);
> > > +	}
> > 
> > Why not just call clk_prepare_enable()?
> 
> Caused by two reasons initially:
> 1) no one uses clk_prepare_enable in clk core, so i guess it may be better
> not use it :-)
> 2) clk_prepare_enable includes one more unneeded prepare lock acquire,
> lines exchange efficiency.
> 
> > Or add a clk_core
> > specific function, clk_core_prepare_enable() that we can call
> > here. We could put the parent pointer check in there too so that
> > it's just
> > 
> >  if (clk->flags & CLK_SET_PARENT_ON)
> >  	clk_core_prepare_enable(parent);
> 
> I'm ok if you like this. :)
> 

Yes the helper is better than calling clk_prepare_enable()
directly.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
