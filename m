From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 22 Apr 2011 11:51:37 +0200 (CEST)
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <BANLkTikU9RLy9VR+tOPMt0u6zJp-bW5_Cw@mail.gmail.com>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421074214.GE15233@pengutronix.de>
	<alpine.LFD.2.02.1104211113030.3323@ionos>
	<20110421120656.GF15233@pengutronix.de>
	<alpine.LFD.2.02.1104211632240.3323@ionos>
	<BANLkTikU9RLy9VR+tOPMt0u6zJp-bW5_Cw@mail.gmail.com>
Message-ID: <alpine.LFD.2.02.1104221124270.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 21 Apr 2011, Colin Cross wrote:
> On Thu, Apr 21, 2011 at 8:38 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > There is no way around that. Everything else is going to be the
> > locking hell and racy all over the place.
> 
> Per clock locks are useful if you have some very slow clocks and some
> very fast clocks.  PLLs may take 20 ms to lock, and preventing any
> other call to clk_prepare for that long could be problematic.  The
> problem was worse before the clk_enable/clk_prepare split, maybe it's
> not necessary at all any more.
> 
> For Tegra, I solved my clock locking problems by (almost) always
> locking from child to parent, the normal case for
> clk_enable/clk_prepare. In general, you only need to lock parent and
> then child if you store the rate of the child in the child's clk
> struct and need to update it when the parent changes, or when
> traversing the tree for debugging output.  I solved the first problem
> by storing the relation between the child and the parent in the child
> struct and locking from child to parent on clk_get_rate calls to
> calculate the rate, and the second by using a trylock loop over the
> list of clocks (see arch/arm/mach-tegra/clock.c).

Yes, and that's exaclty what we don't want to have. You still need a
global lock for doing the full tree acquisition and the only advantage
which is left is that you can do parallel prepare/unprepare and
everything else (parent settings, rate propagations) will need to do
the locking dance.

And the bad thing about your approach is that it requires a full tree
lock acquisition all the time, while the real operation might be just
affecting 3 clocks out of 50. To avoid that you'd need to do the
trylock dance over the child list.

I doubt it's worth the trouble, really.

> Now that clk_prepare and clk_enable are split, the long-held locks
> (for plls, maybe dvfs?) are separated from the short-held locks for
> clk_enable/clk_disable, and the cost of global serialization is much
> more acceptable.

Right. And that's how we start. Simple. If it turns out to be a real
issue, then we can revisit the fine grained locking approach, but I
really want to avoid it as far as possible.

Another thing I'm pondering is to provide the ability to maintain
separate clk trees. So you can have individual domains which have
their per clk tree locking. Would that make sense ?

Thanks,

	tglx
