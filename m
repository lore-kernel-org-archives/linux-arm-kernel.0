From: mikpe@it.uu.se (Mikael Pettersson)
Date: Tue, 1 Sep 2009 18:34:50 +0200
Subject: [RFC/RFT 2/3] iop: clockevent support
In-Reply-To: <20090901122511.GL19719@n2100.arm.linux.org.uk>
References: <200908221205.n7MC5Trg029367@pilspetsen.it.uu.se>
	<20090901122511.GL19719@n2100.arm.linux.org.uk>
Message-ID: <19101.19754.704539.682297@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux writes:
 > On Sat, Aug 22, 2009 at 02:05:29PM +0200, Mikael Pettersson wrote:
 > > +/*
 > > + * IOP clockevents (interrupting timer 0).
 > > + */
 > > +static int iop_set_next_event(unsigned long delta,
 > > +			      struct clock_event_device *unused)
 > > +{
 > > +	u32 tmr = IOP_TMR_EN | IOP_TMR_PRIVILEGED
 > > +		| IOP_TMR_RELOAD | IOP_TMR_RATIO_1_1;
 > > +
 > > +	BUG_ON(delta == 0);
 > > +	write_tmr0(tmr & ~(IOP_TMR_EN | IOP_TMR_RELOAD));
 > > +	write_tcr0(delta);
 > > +	write_tmr0((tmr & ~IOP_TMR_RELOAD) | IOP_TMR_EN);
 > 
 > Hmm, not sure you should be clearing TMR_RELOAD here.  I thought
 > periodic clock events were initialized by a call to set_mode followed
 > by a call to set_next_event.

It's my understanding that ->set_next_event() is only used for
ONESHOT events. At least that's what I concluded after studying
other implementations like the plat-orion and mach-ixp4xx ones.

But I could be wrong. The clockevents API is very poorly documented, IMO.

 > > +static void iop_set_mode(enum clock_event_mode mode,
 > > +			 struct clock_event_device *unused)
 > > +{
 > > +	u32 tmr = IOP_TMR_EN | IOP_TMR_PRIVILEGED
 > > +		| IOP_TMR_RELOAD | IOP_TMR_RATIO_1_1;
 > > +
 > > +	switch (mode) {
 > > +	case CLOCK_EVT_MODE_PERIODIC:
 > > +		write_tmr0(tmr & ~IOP_TMR_EN);
 > > +		write_tcr0(ticks_per_jiffy - 1);
 > > +		tmr |= (IOP_TMR_RELOAD | IOP_TMR_EN);
 > > +		break;
 > > +	case CLOCK_EVT_MODE_ONESHOT:
 > > +		/* ->set_next_event sets period and enables timer */
 > > +		tmr &= ~(IOP_TMR_RELOAD | IOP_TMR_EN);
 > > +		break;
 > > +	case CLOCK_EVT_MODE_RESUME:
 > > +		tmr |= IOP_TMR_EN;
 > > +		break;
 > > +	case CLOCK_EVT_MODE_SHUTDOWN:
 > > +	case CLOCK_EVT_MODE_UNUSED:
 > > +	default:
 > > +		tmr &= ~IOP_TMR_EN;
 > 
 > Doesn't this result in the clock mode being overwritten upon
 > resume/shutdown?  tmr, being a local variable, will always be
 > initialized with IOP_TMR_RELOAD etc.

Correct. For shutdown that shouldn't be a problem. I interpreted
'resume' as resume from suspend-to-ram, which I don't think is
supported by plat-iop, so I basically ignored it.

An earlier version of the code used a read_tmr0() function, but
I replaced it with a hardcoded value to avoid having to add yet
another function to the mach implementation. Also, apart possibly
from the resume case, the value written to TMR should only depend
on the 'mode' parameter.

I'll reintroduce read_tmr0() and rewrite this function to be more
read-modify-write like.

 > > @@ -75,13 +132,12 @@ unsigned long iop_gettimeoffset(void)
 > >  static irqreturn_t
 > >  iop_timer_interrupt(int irq, void *dev_id)
 > >  {
 > > +	struct clock_event_device *evt;
 > > +
 > >  	write_tisr(1);
 > >  
 > > -	while ((signed long)(next_jiffy_time - read_tcr1())
 > > -		>= ticks_per_jiffy) {
 > > -		timer_tick();
 > > -		next_jiffy_time -= ticks_per_jiffy;
 > > -	}
 > > +	evt = &iop_clockevent;
 > 
 > You can use 'dev_id' here, and when registering the interrupt, pass
 > iop_clockevent via the dev_id field in iop_timer_irq.

The implementations I studied don't use that feature, but using the
dev_id parameter will be cleaner and faster. Thanks, I'll make that change.

/Mikael
