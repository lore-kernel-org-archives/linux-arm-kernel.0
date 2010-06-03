From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 3 Jun 2010 09:13:54 +0100
Subject: [RFC,PATCH 1/2] Add a common struct clk
In-Reply-To: <201006031121.21896.jeremy.kerr@canonical.com>
References: <1275479804.137633.565764505843.0.gpush@pororo>
	<1275479804.138101.137592675542.1.gpush@pororo>
	<20100602120356.GQ7248@trinity.fluff.org>
	<201006031121.21896.jeremy.kerr@canonical.com>
Message-ID: <20100603081354.GA4720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 03, 2010 at 11:21:19AM +0800, Jeremy Kerr wrote:
> Hi Ben,
> 
> > > And a set of clock operations (defined per type of clock):
> > > 
> > > struct clk_operations {
> > > 
> > >        int             (*enable)(struct clk *);
> > 
> > I'd rather the enable/disable calls where simply a set
> > and a bool on/off, very rarelyt is the enable and disable
> > operartions different.
> 
> I thought about merging these, but decided against it. It does work for the 
> simple case where we're setting a bit in a register:
> 
> static int clk_foo_set_state(struct clk *_clk, int enable)
> {
> 	struct clk_foo *clk = to_clk_foo(_clk)
> 	u32 reg;
> 
> 	reg = raw_readl(foo->some_register);
> 	if (enable)
> 		reg |= FOO_ENABLE;
> 	else
> 		reg &= ~FOO_ENABLE;
> 	raw_writel(foo->some_register, reg);
> 
> 	return 0;
> }
> 
> However, for anything more complex than this - for example, if there's a 
> parent clock - then we start getting pretty messy:
> 
> static int clk_foo_set_state(struct clk *_clk, int enable)
> {
> 	struct clk_foo *clk = to_clk_foo(_clk)
> 	u32 reg;

Yuck. I think this should really be handled by the base clk_enable()
and clk_disable() calls. Roughly based on what is currently in the
plat-samsung clock implementation:

clk_enable(struct clk *clk)
{
	if (clk->parent)
		clk_enable(clk->parent)
	...
}

clk_disable(struct clk *clk)
{
	...
	if (clk->parent)
		clk_disable(clk->parent)
}

I think it is a really bad idea for each implementation to have to worry
about this. It sounds like a recipie for people to get wrong, especially
if we have a number of these implementations kicking around.

> 	if (enable) {
> 		int ret = clk_enable(clk->parent);
> 		if (ret)
> 			return ret;
> 	}
> 
> 	reg = raw_readl(foo->some_register);
> 	if (enable)
> 		reg |= FOO_ENABLE;
> 	else
> 		reg &= ~FOO_ENABLE;
> 
> 	raw_writel(foo->some_register, reg);
> 
> 	if (!enable)
> 		clk_disable(clk->parent);
> 
> 	return 0;
> }
> 
> - where most of the function becomes surrounded by "if (enable)" statements. 
> 
> I'm aware that we can turn this into a conditional call of clk_foo_enable or 
> clk_foo_disable, but then we're back to square 1. I also think that the simple 
> case is clearer (if a little more verbose) with separate functions.

If we do decided to move the parent control functionality to the clock
core, then I would prefer to see the change to a single enable/disable
callback. Especially as it fits my current implementations well.

As a note, I also left the enable callback in the 'struct clk' instead
of in the ops, enable/disable is the most used case of these clock
functions, and as such should probably be the easiest to get to.

Also, wheras plat-samsung has very few sets of clk_ops sitting about,
there are more enable/disable calls, and adding more fields to the
clocks to deal with this would add extra space to the kernel.

> Also, enable and disable in the external clock API have different return 
> types.

does that really matter?
 
> > an aside, you might want to just clal these clk_ops to get into the
> > spirit of the original naming.
> 
> Either is fine with me - looks like 'ops' is more commonly used:

My pref. is for less typing.
 
> $ git grep -E '^struct \w*operations\s*\{' include/ | wc -l
> 30
> 
> $ git grep -E '^struct \w*ops\s*{' include/ | wc -l
> 138
> 
> Cheers,
> 
> 
> Jeremy

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
