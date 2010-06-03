From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 4 Jun 2010 00:45:54 +0100
Subject: [RFC,PATCH 1/2] Add a common struct clk
In-Reply-To: <4C081A09.1020706@bluewatersys.com>
References: <1275479804.137633.565764505843.0.gpush@pororo>
	<1275479804.138101.137592675542.1.gpush@pororo>
	<20100602120356.GQ7248@trinity.fluff.org>
	<201006031121.21896.jeremy.kerr@canonical.com>
	<20100603081354.GA4720@trinity.fluff.org>
	<4C081A09.1020706@bluewatersys.com>
Message-ID: <20100603234554.GE4720@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 04, 2010 at 09:09:29AM +1200, Ryan Mallon wrote:
> Ben Dooks wrote:
> > On Thu, Jun 03, 2010 at 11:21:19AM +0800, Jeremy Kerr wrote:
> >> Hi Ben,
> >>
> >>>> And a set of clock operations (defined per type of clock):
> >>>>
> >>>> struct clk_operations {
> >>>>
> >>>>        int             (*enable)(struct clk *);
> >>> I'd rather the enable/disable calls where simply a set
> >>> and a bool on/off, very rarelyt is the enable and disable
> >>> operartions different.
> >> I thought about merging these, but decided against it. It does work for the 
> >> simple case where we're setting a bit in a register:
> >>
> >> static int clk_foo_set_state(struct clk *_clk, int enable)
> >> {
> >> 	struct clk_foo *clk = to_clk_foo(_clk)
> >> 	u32 reg;
> >>
> >> 	reg = raw_readl(foo->some_register);
> >> 	if (enable)
> >> 		reg |= FOO_ENABLE;
> >> 	else
> >> 		reg &= ~FOO_ENABLE;
> >> 	raw_writel(foo->some_register, reg);
> >>
> >> 	return 0;
> >> }
> >>
> >> However, for anything more complex than this - for example, if there's a 
> >> parent clock - then we start getting pretty messy:
> >>
> >> static int clk_foo_set_state(struct clk *_clk, int enable)
> >> {
> >> 	struct clk_foo *clk = to_clk_foo(_clk)
> >> 	u32 reg;
> > 
> > Yuck. I think this should really be handled by the base clk_enable()
> > and clk_disable() calls. Roughly based on what is currently in the
> > plat-samsung clock implementation:
> 
> I think its a good idea to do this incrementally. The proposed patches
> don't require much code rewrite because the interface is basically the
> same. I think the best approach is to get the proposed patches applied,
> which basically just makes the common interface from

Given the latest comments by Linus on churn, it would be better to
get a well specified <linux/clk.h> decided on before it goes in so
that everyone can move over to it. We're moving to a system where
any change in functionality is going to cause problems with respect
to a wide range of systems.

If the new <linux/clk.h> is not well specified it is just goign to
cause problems down the line of people infering behaviour from other
implementations (a bad idea) and/or causing large tracts of changes.

> include/linux/clock.h generic, and _all_ of the mach implementations
> (and possibly other archs such as powerpc) converted and tested first.
> Then we can go from there to see what other common functionality can be
> moved into the generic clock framework.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
