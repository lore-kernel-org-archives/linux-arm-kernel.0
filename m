From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 28 Jun 2013 22:51:33 +0100
Subject: armada_drm clock selection
In-Reply-To: <20130628211848.GJ4283@n2100.arm.linux.org.uk>
References: <20130628201133.1D6D2FAAD5@dev.laptop.org>
 <20130628211848.GJ4283@n2100.arm.linux.org.uk>
Message-ID: <20130628215133.GL4283@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 10:18:48PM +0100, Russell King - ARM Linux wrote:
> On Fri, Jun 28, 2013 at 04:11:32PM -0400, Daniel Drake wrote:
> > +int armada_drm_find_best_clock(struct armada_private *priv, long needed_rate)
> > +{
> > +	int i;
> > +
> > +	/* check if any clock can meet this rate directly */
> > +	for (i = 0; i < ARMADA_MAX_CLOCK; i++) {
> > +		struct clk *clk = priv->clk[i];
> > +		long ref;
> > +
> > +		if (!clk)
> > +			continue;
> > +
> > +		clk_set_rate(clk, needed_rate);
> > +		ref = clk_get_rate(clk);
> > +
> > +		if (ref % needed_rate == 0)
> > +			return i;
> > +	}
> > +
> > +	/* fallback: return first available clock */
> > +	for (i = 0; i < ARMADA_MAX_CLOCK; i++) {
> > +		struct clk *clk = priv->clk[i];
> > +		if (clk)
> > +			return i;
> > +	}
> > +
> > +	return -ENOENT;
> > +}
> 
> This can be a library function called by the compute_clock implementation.
> However, it's buggy.  It's not returning the best clock.  If we're going
> to go to the expense of potentially causing the clock tree to recalculate
> for every clock connected to this device, then we'd better do a good job
> here.
> 
> That is - compute the source clock which can give us the _best_
> approximation to the required clock.  We're almost doing that with the
> "ref % needed_rate" line, so if we're already doing that calculation,
> let's track for each iteration whether the clock gives us a better match
> than our previous one - and return the best approximation.
> 
> And why use clk_set_rate()/clk_get_rate()?  (a) what if clk_set_rate()
> fails (the API allows it to.)  (b) what's wrong with clk_round_rate()?

There's a more fundamental point here.

The AXI and PLL clocks are shared between the two LCD controllers in
the 510.  If one LCD controller is using one clock, what happens when
we call clk_set_rate() on that clock due to a change on the other LCD
controller.

That might result in the PLL dividers being modified and changing the
clock input to the other LCD controller.  Moreover, we might find that
the rate isn't suitable for us, so we've just disrupted a clock for
no gain what so ever.  That's even more reason to use the clk_round_rate(),
but it also opens the bigger question: if we're going to dynamically
select the clock input, we need to take notice of _both_ LCD controller
requirements.

Moreover, the AXI bus clock (yes, it's the actual bus clock) is one
available input to the LCD controller pixel clock.  We certainly do
not want to go fiddling with that clock rate without good reason to
(iow, we're pretty sure we want to reprogram its rate _and_ use it,
and disrupt the clock rate that the AXI bus sees.)  That will have
a direct impact on the throughput of all masters on the AXI bus -
which includes the CPU and memory.
