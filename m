From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 20 Jun 2018 12:07:00 +0200 (CEST)
Subject: [PATCH v5 2/6] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <20180620094649.GA2766@piout.net>
References: <20180619211929.22908-1-alexandre.belloni@bootlin.com>
 <20180619211929.22908-3-alexandre.belloni@bootlin.com>
 <alpine.DEB.2.21.1806201037240.10546@nanos.tec.linutronix.de>
 <20180620094649.GA2766@piout.net>
Message-ID: <alpine.DEB.2.21.1806201156510.10546@nanos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Jun 2018, Alexandre Belloni wrote:
> On 20/06/2018 11:03:40+0200, Thomas Gleixner wrote:
> > > +/*
> > > + * Clocksource and clockevent using the same channel(s)
> > > + */
> > > +static u64 tc_get_cycles(struct clocksource *cs)
> > > +{
> > > +	u32 lower, upper;
> > > +
> > > +	do {
> > > +		upper = readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[1]));
> > > +		lower = readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[0]));
> > > +	} while (upper != readl_relaxed(tc.base + ATMEL_TC_CV(tc.channels[1])));
> > > +
> > > +	return (upper << 16) | lower;
> > > +}
> > 
> > For timekeeping the win of this is dubious. With a 5Mhz clock the 32bit
> > part wraps around in ~859 seconds, which is plenty even for NOHZ.
> > 
> > So I really would avoid the double read/compare/eventually repeat magic and
> > just use the lower 32bits for performance sake. I assume the same is true
> > for sched_clock(), but I might be wrong.
> > 
> 
> Agreed, this is why this is only used with the 16 bit counters (the
> register is 32 bit wide but the counter only have 16 bits. For the 32
> bit counters, tc_get_cycles32 is used and only use one counter.

Ah, sorry. I misread the code. Missed that it's the 16bit case. 

> > > +static int tcb_clkevt_next_event(unsigned long delta,
> > > +				 struct clock_event_device *d)
> > > +{
> > > +	u32 old, next, cur;
> > > +
> > > +	old = readl(tc.base + ATMEL_TC_CV(tc.channels[0]));
> > > +	next = old + delta;
> > > +	writel(next, tc.base + ATMEL_TC_RC(tc.channels[0]));
> > > +	cur = readl(tc.base + ATMEL_TC_CV(tc.channels[0]));
> > > +
> > > +	/* check whether the delta elapsed while setting the register */
> > > +	if ((next < old && cur < old && cur > next) ||
> > > +	    (next > old && (cur < old || cur > next))) {
> > > +		/*
> > > +		 * Clear the CPCS bit in the status register to avoid
> > > +		 * generating a spurious interrupt next time a valid
> > > +		 * timer event is configured.
> > > +		 */
> > > +		old = readl(tc.base + ATMEL_TC_SR(tc.channels[0]));
> > > +		return -ETIME;
> > > +	}
> > 
> > Aarg. Doesn;t that timer block have a simple count down and fire mode?
> > These compare equal timers suck.
> 
> It only counts up...

Have you tried to play with that waveform stuff?

Thanks,

	tglx
