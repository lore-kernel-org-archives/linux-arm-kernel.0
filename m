From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 8 Dec 2010 17:26:56 +0000
Subject: [RFC PATCHv2] picoxcell: add support for the system timers
In-Reply-To: <20101208161411.GM9777@n2100.arm.linux.org.uk>
References: <1290506774-17895-4-git-send-email-jamie@jamieiles.com>
	<1290769876-26395-1-git-send-email-jamie@jamieiles.com>
	<20101208161411.GM9777@n2100.arm.linux.org.uk>
Message-ID: <20101208172654.GG2716@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 04:14:11PM +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 26, 2010 at 11:11:16AM +0000, Jamie Iles wrote:
> > +static irqreturn_t timer_interrupt(int irq, void *dev_id)
> > +{
> > +	struct timer_instance *timer = &timers[TIMER_ID_CLOCKEVENT];
> > +
> > +	/* If we are in oneshot mode, we need to stop receiving interrupts. */
> > +	if (CLOCK_EVT_MODE_ONESHOT == clockevent_picoxcell.mode) {
> > +		unsigned long val = readl(timer->base +
> > +					  TIMER_CONTROL_REG_OFFSET);
> > +		val |= TIMER_INTERRUPT_MASK;
> > +		writel(val, timer->base + TIMER_CONTROL_REG_OFFSET);
> > +	}
> 
> It's normal not to emulate behaviours here which the hardware doesn't
> support - that's the point of the generic clockevents/clocksource
> layers.  They're there to handle whatever the hardware can support and
> turn it into something the kernel wants.

Ok, I underestimated clockevents and how NO_HZ works and thought that we'd 
keep on receiving too many interrupts but that's not the case! I'll fix up the 
next revision to remove this hack.

> > +/*
> > + * Overwrite weak default sched_clock with something more precise.
> > + *
> > + * On picoXcell we have a RTC that clocks at 200MHz so a multiply by 5 gives
> > + * us a nanosecond count.
> > + */
> > +unsigned long long notrace sched_clock(void)
> > +{
> > +#define CYCLES_TO_NSEC_MULT	(NSEC_PER_SEC / CLOCK_TICK_RATE)
> > +	return cnt32_to_63(readl(IO_ADDRESS(PICOXCELL_RTCLK_BASE) +
> > +				 RTCLK_CCV_REG_OFFSET)) * CYCLES_TO_NSEC_MULT;
> 
> Have you read the comments in include/linux/cnt32_to_63.h, or thought
> about the '63' part of the name ?

Sadly not, this was one I'd taken from the mailing list for mach-tegra as we 
were missing a sched_clock() implementation before. Since then I've had a go 
at taking Linus' sched_clock() implementation for plat-nomadik and using that 
to increase the wrap period which I'll roll into the next revision.

Jamie
