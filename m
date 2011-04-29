From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2011 12:06:10 +0100
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <alpine.LFD.2.02.1104291252080.3005@ionos>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421072259.GG31131@pengutronix.de>
	<alpine.LFD.2.02.1104211045220.3323@ionos>
	<20110429103723.GF5126@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1104291252080.3005@ionos>
Message-ID: <20110429110610.GJ5126@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 01:01:58PM +0200, Thomas Gleixner wrote:
> On Fri, 29 Apr 2011, Russell King - ARM Linux wrote:
> 
> > On Thu, Apr 21, 2011 at 11:12:36AM +0200, Thomas Gleixner wrote:
> > > On Thu, 21 Apr 2011, Uwe Kleine-K?nig wrote:
> > > > > Which is a complete failure to begin with. Why the heck do you need a
> > > > > callback to figure that out?
> > > > > 
> > > > > Because someone claimed, that you need a callback to make it safe from
> > > > > changing? Or what's the reason for this?
> > > > If there were a pointer tracking the parent you still needed to program
> > > > out the get_parent function anyhow to set the pointer initially. But I
> > > > agree that in other situations having a pointer is more comfortable and
> > > > saves ugly error handling e.g. in set_parent.
> > > 
> > > That's nonsense. Why do you want a get_parent() function at all?
> > > parent is set up when the clock is established in the clock tree. And
> > > that's not done by some random driver. That's a property of the clock.
> > 
> > It's *not* a fixed property of the clock.  It's a runtime property.
> 
> I know that stuff can change and needs to be changed runtime. But this
> has to be done at the framework level and not at some random place in
> some random clk->ops->fn() implementation.

Look, how do you _not_ do it at the clk->ops->fn() level when you have
clocks which are pure muxes, and so are selected by a bitfield in a
register vs other clocks which are muxes _and_ dividers combined which
can't be separated.  Do you _really_ want to teach the core clock
framework about every type of platform quirk like that?

That's the direction you're heading for by demanding that the core clk
code does all this kind of crap.  Crap in the core clock code, rather
than a set of compartmentalized clock implementations for fixed rate
clocks, muxes, dividers, dividers with muxes, plls, etc.
