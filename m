From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 29 Apr 2011 13:11:25 +0200 (CEST)
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110429104951.GG5126@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421074214.GE15233@pengutronix.de>
	<alpine.LFD.2.02.1104211113030.3323@ionos>
	<20110421115050.GC16776@sirena.org.uk>
	<alpine.LFD.2.02.1104211403130.3323@ionos>
	<20110429104951.GG5126@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1104291302420.3005@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Apr 2011, Russell King - ARM Linux wrote:
> On Thu, Apr 21, 2011 at 02:20:22PM +0200, Thomas Gleixner wrote:
> > Just in about 100 variations of the theme. Which is basically the same
> > as we have in irq chip implementations. And I showed how much of these
> > things can be factored out when done right. And even if a particular
> > clock does not implement enable/disable calls, then having
> > regs.enable_reg around is not a problem.
> 
> And you haven't noticed that with how things stand with what Jeremy's
> proposed, we _can_ abstract this kind of stuff.
> 
> Having read a number of your messages, I think you don't like it because
> you haven't been involved in creating it - I don't think there's anything
> much more specific than that to your protestations about it.
> 
> We _can_ (and I hope we do) factor out the 100 "clock gate" implementations
> into one instance - and I believe we can do that with Jeremy's proposal.
> 
> For those clocks which have an clock gate and a clock mux, we can create
> two clk structures, one being the clock gate container and one being the
> clock mux container, even if they're accessing the same register.
> 
> Shoving the enable crap into the core framework enforces that every clock
> has an gate attached to it, which is soo far departed from reality I've
> got to ask what universe you're living in.

Not at all. If a clk has clk->ops->enable() == NULL then you still
need to do proper refcounting and descending down the parent tree to
make sure, that the parent clocks are enabled.
 
> };
> 
> If you start saying "a clock struct should contain enable bit, register
> address" then you're well on the path to creating a horrid mess like the
> above.  And this is something we _must_ avoid.

I already have dumped that idea in course of the discussion and yes,
we can implement something as a container like I did for the generic
irq chip.
 
> So, Jeremy's done the right thing and created a base struct clk which
> is very much like a kobject, along with a set of methods to operate on
> it.  Around that can be built things like fixed rate clocks, MUXes,
> gates, PLLs, and everything else which is required with minimal expense
> - and all provided by core clk code.  And we avoid crappy bloated
> structures like the thing above.

I tend to disagree. Yes, he created the minimal common level for a
struct clk and the ops around it. But does that change anything about
the status quo of duplicated functions walking the tree, duplicated
functions to validate and round clock rates? The whole approach will
keep the whole code mess in the SoCs the same as it is now and just
enforce a common data structure and a dozen wrapper "API" functions
around it.

So omap will simply have their bloat in a struct omap_clk() and every
other SoC will do the same. The duplicated code, the locking mess
etc. will all remain in totally incompatible ways. So what's the win?

I looked at a few new SoC trees and guess what comes along ? Another
few copies of existing clock implementations hacked into submission so
the thing works on that new hardware.

Thanks,

	tglx
