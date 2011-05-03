From: ccross@google.com (Colin Cross)
Date: Mon, 2 May 2011 23:35:25 -0700
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110430142702.GH13755@siel.b>
References: <alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421072259.GG31131@pengutronix.de>
	<alpine.LFD.2.02.1104211045220.3323@ionos>
	<20110429103723.GF5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291252080.3005@ionos>
	<20110429110610.GJ5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291344020.3005@ionos>
	<20110429132613.GL5126@n2100.arm.linux.org.uk>
	<20110430142702.GH13755@siel.b>
Message-ID: <BANLkTime=g3qmWsN3X4mMe0_VBO0SZc0qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 30, 2011 at 7:27 AM, torbenh <torbenh@gmx.de> wrote:
> On Fri, Apr 29, 2011 at 02:26:13PM +0100, Russell King - ARM Linux wrote:
>> On Fri, Apr 29, 2011 at 02:13:06PM +0200, Thomas Gleixner wrote:
>> > This are all well defined semantical problems and should be solved in
>> > common code rather than having different buggy implementations in each
>> > SoC clock "framework".
>>
>> Why are you associating functional elements in drivers/clk with the
>> SoC clock framework?
>
> i think i pretty much understand what thomas is after. but i have
> problems understanding, what you want here.
>
> until this point, it looks like you only want the driver/clk to
> model the clock endpoints inside the devices. A device itself shouldnt
> be caring for clock parents or anything. its only concern is that a
> clock pin is fed with the right frequency, or off...
>
>>
>> I think that's the root cause of this misunderstanding, and until you
>> start realising that these building blocks are not part of the SoC
>> implementation, we're going to continue arguing about this.
>
> what you say now, pretty much sounds like what thomas wants.
> these building blocks would be objects derived from the clock baseclass,
> which thomas is trying to define. he doesnt seem to be concerned about
> the second more special layer yet.
>
> i am quite puzzled, what exactly your fighting over :S

Thomas wants a core framework that handles the clock tree, with each
clock being the implementation of just the clock.  Russell thinks this
is impossible, and wants to stop at implementing building blocks for
the standard clock types, and let each SoC put them into a tree.

I don't think anybody can argue that a shared clock tree framework, if
it was possible to do well, would be a benefit.  But there are a few
problems that make abstracting the differences between SoCs very hard
at that level.

After implementing the Tegra clock tree at least 10 times to solve
different problems, there are two very hard problems to solve.

First is locking.  Per-clock locking is hard because it requires
choosing up front which way locking will go, usually locking the
child, then locking the parent, then enabling the parent, and enabling
the child.  Any operation flow that requires traversing the tree from
the parent to the child, for example changing the rate of the parent,
causes lock inversion.  Global locking is easy, but can be wasteful on
platforms that have some very slow clocks (think external i2c clocks),
and some very fast clocks (internal register writes).  This is
mitigated by the separation of clk_prepare and clk_enable locking -
clk_enable can never sleep, so it can't be blocked for long.  Locking
at the root node of the tree would be nice, but most SoCs don't have a
root node - they have a fast root clock and a slow root clock, and can
switch the all or most of clock tree over to the slow clock in some
modes.

The second problem is rate changing.  Different platforms require
wildly different strategies for changing clock rates.  On Tegra,
clk_set_rate will never change the parent, because we can generally
set up the parent clocks to the correct frequencies for all the
devices, and then device drivers can change their dividers to get the
rate they need.  The few cases where the parent needs to change
(cpufreq and display pclk), the driver manually calls clk_set_parent.
On other platforms, it is common to need to change the parent to get
the necessary rate.

Automatically selecting parents in a generic way is impossible.  If
one DEV1 calls clk_set_rate and clk_enable, and the core framework
responds by setting pll A to frequency X, and setting the parent of
DEV1 to A, what happens when DEV2 calls clk_set_rate to a frequency
that can only be satisfied by setting pll A to frequency Y?  DEV1
can't be switched to another pll, because it is already enabled, and
some platforms can't support glitchlessly changing a mux, even if the
frequency doesn't change.

I still think a common implementation of the clock tree framework
would be useful, even if not all platforms can use it.  Allow the
platforms that can to use it, providing only clock data, and maybe a
few clock implementations if the building blocks are not sufficient,
and allow those that can't to implement their own versions of the
clk_* functions on top of the clock building blocks.  Tegra already
has a fairly generic implementation of a clock tree in
arch/arm/mach-tegra/clock.c, moving it to the common clk struct and
sharing it with other platforms wouldn't be any extra code, even if no
other platforms could use it.  And I bet at least OMAP could use it,
from what I've seen.

Per-tree locking is a solvable problem, as long as a tree was
considered as an ordered graph - two root nodes that feed into the
same clocks would be considered part of the same tree.  The core
framework could look at all possible parents of a clock to determine
what clock trees were truly independent, which would result in a
single global lock on most platforms, but multiple locks on platforms
that really had independent clock trees.  Dynamically added clocks
would cause problems with this solution.

I think automatic clock parent and rate setting would need to be
delegated to a platform-specific layer, and I'm not sure how.  Maybe
allow platforms to override the set_rate ops in the clock tree
building blocks, or a new op that can determine the new tree
structure, and call the old set_rate op to set the registers.
