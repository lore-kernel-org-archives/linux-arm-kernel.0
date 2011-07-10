From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sun, 10 Jul 2011 16:13:17 +0100
Subject: [PATCH v8 03/14] ARM: smp_twd: add support for remapped PPI
	interrupts
In-Reply-To: <20110708192734.GQ4812@n2100.arm.linux.org.uk>
References: <1309855755-6261-1-git-send-email-marc.zyngier@arm.com>
	<1309855755-6261-4-git-send-email-marc.zyngier@arm.com>
	<20110708192734.GQ4812@n2100.arm.linux.org.uk>
Message-ID: <20110710161317.40ff72a8@taxman.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Jul 2011 20:27:34 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Tue, Jul 05, 2011 at 09:49:04AM +0100, Marc Zyngier wrote:
> > @@ -43,6 +45,10 @@ static void twd_set_mode(enum clock_event_mode mode,
> >  		ctrl = TWD_TIMER_CONTROL_IT_ENABLE | TWD_TIMER_CONTROL_ONESHOT;
> >  		break;
> >  	case CLOCK_EVT_MODE_UNUSED:
> > +#ifdef CONFIG_ARM_GIC_PPI_MAP
> > +		disable_irq(clk->irq);
> > +		/* fall through */
> > +#endif
> 
> Eww, no.  This is wrong.  You can get an UNUSED event if the TWD clock
> event device gets swapped out for some other clock event device (eg,
> one with a higher preference.)
> 
> This is at best a hack around the problem.  The existing code deals with
> hot unplug via this in arch/arm/kernel/smp.c:
> 
> /*
>  * The generic clock events code purposely does not stop the local timer
>  * on CPU_DEAD/CPU_DEAD_FROZEN hotplug events, so we have to do it
>  * manually here.
>  */
> static void percpu_timer_stop(void)
> {
>         unsigned int cpu = smp_processor_id();
>         struct clock_event_device *evt = &per_cpu(percpu_clockevent, cpu);
> 
>         evt->set_mode(CLOCK_EVT_MODE_UNUSED, evt);
> }
> 
> Maybe that needs a local_timer_stop() ->twd_timer_stop() call rather
> than trying to be clever by doing this via the set_mode() method.  That
> would seem to be overall a cleaner solution.
> 

I think your suggestion to use request_irq() should solve it nicely.
No need to disable the interrupt, it will be re-enabled on the next
setup_irq() when the CPU comes back up.

	M.
-- 
I'm the slime oozin' out from your TV set...
