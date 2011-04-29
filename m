From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 29 Apr 2011 17:31:44 +0200 (CEST)
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110429132613.GL5126@n2100.arm.linux.org.uk>
References: <1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421072259.GG31131@pengutronix.de>
	<alpine.LFD.2.02.1104211045220.3323@ionos>
	<20110429103723.GF5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291252080.3005@ionos>
	<20110429110610.GJ5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291344020.3005@ionos>
	<20110429132613.GL5126@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1104291620170.3005@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Apr 2011, Russell King - ARM Linux wrote:

> On Fri, Apr 29, 2011 at 02:13:06PM +0200, Thomas Gleixner wrote:
> > This are all well defined semantical problems and should be solved in
> > common code rather than having different buggy implementations in each
> > SoC clock "framework".
> 
> Why are you associating functional elements in drivers/clk with the
> SoC clock framework?
> 
> I think that's the root cause of this misunderstanding, and until you
> start realising that these building blocks are not part of the SoC
> implementation, we're going to continue arguing about this.

I'm realizing that those building blocks are separate abstractions for
the various incarnations of clk functionalities, which are just
configured per SoC.

I'm not confusing anything. I'm just looking at the status quo in the
first place. And the status quo is that every SoC has it's own
"framework".

So now you propose two things to consolidate that:

1) A common struct clk and a handful wrapper functions

2) A set of abstraction blocks which represent the various clk
   incarnations (divisors, muxes, plls etc)

And my point is that this is not going to work out really well.

There is no consolidated handling of the tree itself. The per clk
locking does what? Serialize the prepare/enable functions for a single
clock. Now, tree traversal to make sure that the parent clocks are
enabled/prepared etc as well need to take the locks nested. That works
nicely in descending down the parent chain.

Though when you need to propagate changes up the chain (e.g. rate
changes) then you need to take the locks in reverse order with trylock
and back down to the place where you started when a trylock
fails. Otherwise you run into deadlocks. With the split locks you do
that for the mutex chain first and then for the spinlock one. It's
doable, but is it worth the trouble?

If it is worth the trouble, then where are you going to implement
this?

The proposed "API" pushes the walk logic into the clkops->fn()
callbacks. Into every single one.

This is simply wrong. That's like having each filesystem providing
it's own directory traversal mechanism.

You don't want to have that logic in each callback. That's tree
management which needs to be done one level above. And it does not
matter which locking scheme you are using - global or per clk.

Lets look at a simple example (locking omitted)

clk_enable(clk) {
	if (clk->enable_count == 0) {
  	   res = clk->ops->enable(clk);
	   if (res)
	      return res;
        }
	enable_count++;
	return 0;
};   

So in each enable op you have:

*_enable(clk)
{
	res = clk_enable(clk_get_parent(clk));
	if (res)
		return res;

	res = hw_magic_enable(clk);
	if (res)
		clk_disable(clk_get_parent(clk));
	return res;
}

Instead of having at the core level:

clk_enable(clk)
{
	if (clk->enable_count == 0) {
		res = clk_enable(clk_get_parent(clk));
		if (res)
			return res;

		res = clk->ops->enable(clk);
		if (res) {
			clk_disable(clk_get_parent(clk));
			return res;
		}
	}
	clk->enable_count++;
	return 0;
}

And in each *_enable op:

*_enable(clk)
{
	return hw_magic_enable(clk);
}

Now add the locking mess (whatever variant) to that whole thing and
then tell me which solution is the proper one.

It gets worse when you look at the proposed clk_set_parent() wrapper:

clk_set_parent(clk)
{
	if (!clk->ops->set_parent)
		return -ENOSYS;

	return clk->ops->set_parent(clk);
}

So this does no locking at all for a simple reason. Because if you
change the parent then you need to lock the clocks in the upwards
direction with full trylock dance. And you have to do that because
otherwise a clk_enable/disable/prepare/unprepare call on a leaf clk
might follow down a chain which is changing under it.

So you want to do that in every possible set_parent() callback? Same
for set_rate() implementations which need to disable and/or adjust the
clocks tree upwards before they can change the rate at the bottom.

Thanks,

	tglx
