From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 29 Apr 2011 13:01:58 +0200 (CEST)
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110429103723.GF5126@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421072259.GG31131@pengutronix.de>
	<alpine.LFD.2.02.1104211045220.3323@ionos>
	<20110429103723.GF5126@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1104291252080.3005@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Apr 2011, Russell King - ARM Linux wrote:

> On Thu, Apr 21, 2011 at 11:12:36AM +0200, Thomas Gleixner wrote:
> > On Thu, 21 Apr 2011, Uwe Kleine-K?nig wrote:
> > > > Which is a complete failure to begin with. Why the heck do you need a
> > > > callback to figure that out?
> > > > 
> > > > Because someone claimed, that you need a callback to make it safe from
> > > > changing? Or what's the reason for this?
> > > If there were a pointer tracking the parent you still needed to program
> > > out the get_parent function anyhow to set the pointer initially. But I
> > > agree that in other situations having a pointer is more comfortable and
> > > saves ugly error handling e.g. in set_parent.
> > 
> > That's nonsense. Why do you want a get_parent() function at all?
> > parent is set up when the clock is established in the clock tree. And
> > that's not done by some random driver. That's a property of the clock.
> 
> It's *not* a fixed property of the clock.  It's a runtime property.

I know that stuff can change and needs to be changed runtime. But this
has to be done at the framework level and not at some random place in
some random clk->ops->fn() implementation.
 
> If you change the rate of a clock, you may need to change its parent.

If you have a proper description of properties like possible parents,
then you can figure out at the framework level that you need to change
the parent in order to get the requested rate. It's not a SoC specific
problem, it's a problem which can be described pretty well for the
most common cases.

> If you change the operating point of the device, (eg, sleep mode where
> the main system PLL gets turned off) you may need to change its parent
> to a slower clock to ensure wakeup timers continue to run but at a lower
> resolution.

Again. That's a problem to be solved at the framework level. If the
sleep code decides to shut down the main pll then the framework can
walk the tree and figure out which clocks need to be moved to a
different parent, as long as the affected clocks are marked "keep me
always alive" or whatever property is chosen to make such decisions.
 
> Sure the API doesn't handle the runtime cases at all well, but that's
> not a reason to enforce a fixed tree structure on something which isn't
> a fixed tree structure.

I don't want to enforce a fixed tree structure. I want proper tree
handling - which includes runtime changes to the tree - at the
framework level and not encoded in 10 different bogus ways in every
other SoC implementation.

Thanks,

	tglx
