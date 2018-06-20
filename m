From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 Jun 2018 12:58:01 +0200 (CEST)
Subject: [PATCH v5 2/6] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <20180620103259.GA7737@piout.net>
References: <20180619211929.22908-1-alexandre.belloni@bootlin.com>
 <20180619211929.22908-3-alexandre.belloni@bootlin.com>
 <alpine.DEB.2.21.1806201037240.10546@nanos.tec.linutronix.de>
 <20180620094649.GA2766@piout.net>
 <alpine.DEB.2.21.1806201156510.10546@nanos.tec.linutronix.de>
 <20180620103259.GA7737@piout.net>
Message-ID: <alpine.DEB.2.21.1806201244110.10546@nanos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Jun 2018, Alexandre Belloni wrote:

> On 20/06/2018 12:07:00+0200, Thomas Gleixner wrote:
> > > > > +static int tcb_clkevt_next_event(unsigned long delta,
> > > > > +				 struct clock_event_device *d)
> > > > > +{
> > > > > +	u32 old, next, cur;
> > > > > +
> > > > > +	old = readl(tc.base + ATMEL_TC_CV(tc.channels[0]));
> > > > > +	next = old + delta;
> > > > > +	writel(next, tc.base + ATMEL_TC_RC(tc.channels[0]));
> > > > > +	cur = readl(tc.base + ATMEL_TC_CV(tc.channels[0]));
> > > > > +
> > > > > +	/* check whether the delta elapsed while setting the register */
> > > > > +	if ((next < old && cur < old && cur > next) ||
> > > > > +	    (next > old && (cur < old || cur > next))) {
> > > > > +		/*
> > > > > +		 * Clear the CPCS bit in the status register to avoid
> > > > > +		 * generating a spurious interrupt next time a valid
> > > > > +		 * timer event is configured.
> > > > > +		 */
> > > > > +		old = readl(tc.base + ATMEL_TC_SR(tc.channels[0]));
> > > > > +		return -ETIME;
> > > > > +	}
> > > > 
> > > > Aarg. Doesn;t that timer block have a simple count down and fire mode?
> > > > These compare equal timers suck.
> > > 
> > > It only counts up...
> > 
> > Have you tried to play with that waveform stuff?
> > 
> 
> There are only a count up and count up then down modes. As the counter
> value is in a read only register, the only configurable starting value
> is 0 so it will always start by counting up. I'm pretty sure the up/down
> mode will not help us.

Hmm, fair enough.

Though the manual says:

     A trigger resets the counter and starts the counter clock. Three types
     of triggers are common to both modes, and a fourth external trigger is
     available to each mode.

     ...

     Software Trigger: Each channel has a software trigger, available by
     setting SWTRG in TC_CCR.

So the question is whether you can't do the following:

     stop_counter()
     issue_sw_trigger()  ---> resets the counter to zero
     write_compare()
     start_counter()

So that should avoid all te mess with comparing to the free running counter
as long as you have two blocks of counters, but then one of them will be
16bit only assumed that there are always 3 counter channels in the TC.

Just a thought, but the code you have should work as well.

Thanks,

	tglx
