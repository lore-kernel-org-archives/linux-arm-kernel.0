From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 May 2011 11:15:21 +0100
Subject: [RFC PATCH v2 08/12] ARM: msm: use remapped PPI interrupts for
	local timer
In-Reply-To: <4DCC41CB.3050802@codeaurora.org>
References: <1304677997-26947-1-git-send-email-marc.zyngier@arm.com>
	<1304677997-26947-9-git-send-email-marc.zyngier@arm.com>
	<4DCC41CB.3050802@codeaurora.org>
Message-ID: <1305800121.27474.39.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-05-12 at 13:23 -0700, Stephen Boyd wrote:
> On 5/6/2011 3:33 AM, Marc Zyngier wrote:
> > diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
> > index 38b95e9..f063860 100644
> > --- a/arch/arm/mach-msm/timer.c
> > +++ b/arch/arm/mach-msm/timer.c
> > @@ -83,18 +85,7 @@ enum {
> >  
> >  
> >  static struct msm_clock msm_clocks[];
> > -static struct clock_event_device *local_clock_event;
> > -
> > -static irqreturn_t msm_timer_interrupt(int irq, void *dev_id)
> > -{
> > -	struct clock_event_device *evt = dev_id;
> > -	if (smp_processor_id() != 0)
> > -		evt = local_clock_event;
> > -	if (evt->event_handler == NULL)
> > -		return IRQ_HANDLED;
> 
> We just lost this important line. This prevents spurious interrupts from
> crashing the system.

Is this something you actually see on a real system, or just a guard in
case something goes horribly wrong?

> > -	evt->event_handler(evt);
> > -	return IRQ_HANDLED;
> > -}
> 
> I would prefer to keep the whole interrupt function because 1) MSM
> doesn't have a local_timer_ack() to implement and 2) I want to put code
> in here to stop the timer so that the timer doesn't wrap and cause
> another interrupt (yes the patches haven't been sent yet).

I was thinking of reusing the local_timer_ack() for that, possibly
passing some useful parameters (evt, cpu...). I'd really like the
event_handler() call to become common code, and move everything else to
the local_timer_ack() method (with a possible empty default implemented
as a weak symbol).

> > +static int local_timer_inited;
> >  
> >  static cycle_t msm_read_timer_count(struct clocksource *cs)
> >  {
> > @@ -140,6 +131,8 @@ static void msm_timer_set_mode(enum clock_event_mode mode,
> >  		writel(TIMER_ENABLE_EN, clock->regbase + TIMER_ENABLE);
> >  		break;
> >  	case CLOCK_EVT_MODE_UNUSED:
> > +		free_irq(evt->irq, evt);
> 
> This is crashing because evt->irq is never assigned in the case of
> CPU0's timer.
> 
> > @@ -253,10 +235,13 @@ static void __init msm_timer_init(void)
> >  			printk(KERN_ERR "msm_timer_init: clocksource_register "
> >  			       "failed for %s\n", cs->name);
> >  
> > -		res = setup_irq(clock->irq.irq, &clock->irq);
> > +		irq = gic_ppi_to_vppi(clock->irq);
> > +		res = request_irq(irq, percpu_timer_handler,
> > +				  IRQF_TIMER | IRQF_NOBALANCING | IRQF_TRIGGER_RISING,
> > +				  ce->name, ce);
> 
> How about assigning evt->irq to gic_ppi_to_vppi() and then use that
> instead of a local variable? That would fix the free_irq() bug up above.

Indeed. Fixed.

> Also, percpu_timer_handler() is only defined in arm/kernel/smp.c which
> isn't going to be compiled in on non-SMP targets. This timer driver is
> common to all MSMs so it needs to work with SMP and non-SMP.

My plan is to move most (if not all) of the timer stuff out of smp.c, as
A15 has the same requirements as MSM (local timers are used even on
non-smp configurations). I'll introduce that earlier than expected,
then.

Expect a v3 shortly...

Thanks for reviewing,

	M.
-- 
Reality is an implementation detail.
