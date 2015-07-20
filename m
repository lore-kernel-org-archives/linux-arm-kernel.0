From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 20 Jul 2015 11:04:30 +0200 (CEST)
Subject: [PATCH 1/3] clocksource: atmel-st: Remove irq handler when clock
 event is unused
In-Reply-To: <20150718222308.GA30489@piout.net>
References: <1437161608-26782-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1437161608-26782-2-git-send-email-alexandre.belloni@free-electrons.com>
 <alpine.DEB.2.11.1507180942360.18576@nanos>
 <20150718222308.GA30489@piout.net>
Message-ID: <alpine.DEB.2.11.1507201103550.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 19 Jul 2015, Alexandre Belloni wrote:
> On 18/07/2015 at 10:12:03 +0200, Thomas Gleixner wrote :
> > On Fri, 17 Jul 2015, Alexandre Belloni wrote:
> > > +static int atmel_st_request_irq(struct clock_event_device *dev)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (clockevent_state_periodic(dev) || clockevent_state_oneshot(dev))
> > > +		return 0;
> > > +
> > > +	ret = request_irq(irq, at91rm9200_timer_interrupt,
> > > +			  IRQF_SHARED | IRQF_TIMER | IRQF_IRQPOLL,
> > > +			  "at91_tick", regmap_st);
> > > +	if (ret) {
> > > +		pr_alert("Unable to setup IRQ\n");
> > > +		return ret;
> > > +	}
> > > +
> > >  	return 0;
> > >  }
> > >  
> > >  static int clkevt32k_set_oneshot(struct clock_event_device *dev)
> > >  {
> > > +	int ret;
> > > +
> > >  	clkdev32k_disable_and_flush_irq();
> > >  
> > >  	/*
> > >  	 * ALM for oneshot irqs, set by next_event()
> > >  	 * before 32 seconds have passed.
> > >  	 */
> > > +	ret = atmel_st_request_irq(dev);
> > 
> > You cannot call request_irq() from interrupt disabled context. It
> > works during early boot because might_sleep() is not active then, but
> > if that happens during normal runtime it wont work.
> > 
> 
> Indeed, clockevents_switch_state() has to be called with interrupts
> disabled. So I'm not sure anymore how we should go about this change
> (obviously, the same applies to the pit change). Do you have an idea?

That's why I used setup/remove_irq() in the stale RT changes.

Thanks,

	tglx
