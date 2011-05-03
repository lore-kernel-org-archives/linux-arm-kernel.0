From: Marc.Zyngier@arm.com (Marc Zyngier)
Date: Tue, 03 May 2011 17:15:38 +0100
Subject: [RFC PATCH 08/12] ARM: msm: use remapped PPI interrupts for
	local timer
In-Reply-To: <4DB6FD50.9070907@codeaurora.org>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>
	<1303326501-15664-9-git-send-email-marc.zyngier@arm.com>
	<4DB6FD50.9070907@codeaurora.org>
Message-ID: <1304439338.27148.186.camel@e102391-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-04-26 at 10:13 -0700, Stephen Boyd wrote:

Hi Stephen,

> On 4/20/2011 12:08 PM, Marc Zyngier wrote:
> > diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
> > index 38b95e9..68eab51 100644
> > --- a/arch/arm/mach-msm/timer.c
> > +++ b/arch/arm/mach-msm/timer.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/io.h>
> >  
> >  #include <asm/mach/time.h>
> > +#include <asm/hardware/gic.h>
> >  #include <mach/msm_iomap.h>
> >  #include <mach/cpu.h>
> >  
> > @@ -67,8 +68,8 @@ enum timer_location {
> >  struct msm_clock {
> >  	struct clock_event_device   clockevent;
> >  	struct clocksource          clocksource;
> > -	struct irqaction            irq;
> >  	void __iomem                *regbase;
> > +	unsigned int		    irq;
> 
> I don't know why this moved down below regbase, but ok.
> 
> > @@ -292,7 +285,14 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
> >  
> >  	local_clock_event = evt;
> 
> I think we can get rid of this variable now. We should be able to pass
> evt to request_irq() and use that in the interrupt handler. See far below.
> 
> This patch doesn't compile for me though. I applied the below fixup:
> 
> 8<---------------
> 
> diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
> index 68eab51..38e51cc 100644
> --- a/arch/arm/mach-msm/timer.c
> +++ b/arch/arm/mach-msm/timer.c
> @@ -246,10 +246,10 @@ static void __init msm_timer_init(void)
>                 irq = gic_ppi_to_vppi(clock->irq);
>                 res = request_irq(irq, msm_timer_interrupt,
>                                   IRQF_TIMER | IRQF_NOBALANCING | IRQF_TRIGGER_RISING,
> -                                 clock->name, &clock->clockevent);
> +                                 ce->name, ce);
>                 if (res)
>                         pr_err("msm_timer_init: request_irq failed for %s\n",
> -                              clock->name);
> +                              ce->name);
>  
>                 clockevents_register_device(ce);
>         }
> @@ -258,6 +258,7 @@ static void __init msm_timer_init(void)
>  #ifdef CONFIG_SMP
>  int __cpuinit local_timer_setup(struct clock_event_device *evt)
>  {
> +       int res;
>         struct msm_clock *clock = &msm_clocks[MSM_GLOBAL_TIMER];
>  
>         /* Use existing clock_event for cpu 0 */
> @@ -271,7 +272,7 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
>                 writel(0, clock->regbase + TIMER_CLEAR);
>                 writel(~0, clock->regbase + TIMER_MATCH_VAL);
>         }
> -       evt->irq = clock->irq.irq;
> +       evt->irq = gic_ppi_to_vppi(clock->irq);
>         evt->name = "local_timer";
>         evt->features = CLOCK_EVT_FEAT_ONESHOT;
>         evt->rating = clock->clockevent.rating;
> @@ -285,13 +286,13 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
>  
>         local_clock_event = evt;
>  
> -       res = request_irq(gic_ppi_to_vppi(irq), msm_timer_interrupt,
> +       res = request_irq(evt->irq, msm_timer_interrupt,
>                           IRQF_TIMER | IRQF_NOBALANCING | IRQF_TRIGGER_RISING,
> -                         clock->name, &clock->clockevent);
> +                         clock->clockevent.name, &clock->clockevent);
>         if (res) {
>                 pr_err("local_timer_setup: request_irq failed for %s\n",
> -                      clock->name);
> -               return err;
> 
> 
> ----
> 
> And then I figured that we shouldn't be overriding the irq handler for
> the PPIs anymore in msm code so I applied this patch (not sure about
> handle_percpu_irq though, see Abhijeet's response):
> 
> 8<--------------
> 
> diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
> index 35ed594..f66e1f0 100644
> --- a/arch/arm/mach-msm/board-msm8x60.c
> +++ b/arch/arm/mach-msm/board-msm8x60.c
> @@ -42,8 +42,6 @@ static struct platform_device *devices[] __initdata = {
>  
>  static void __init msm8x60_init_irq(void)
>  {
> -       unsigned int i;
> -
>         gic_init(0, GIC_PPI_START, MSM_QGIC_DIST_BASE,
>                  (void *)MSM_QGIC_CPU_BASE);
>  
> @@ -55,15 +53,6 @@ static void __init msm8x60_init_irq(void)
>          */
>         if (!machine_is_msm8x60_sim())
>                 writel(0x0000FFFF, MSM_QGIC_DIST_BASE + GIC_DIST_ENABLE_SET);
> -
> -       /* FIXME: Not installing AVS_SVICINT and AVS_SVICINTSWDONE yet
> -        * as they are configured as level, which does not play nice with
> -        * handle_percpu_irq.
> -        */
> -       for (i = GIC_PPI_START; i < GIC_SPI_START; i++) {
> -               if (i != AVS_SVICINT && i != AVS_SVICINTSWDONE)
> -                       irq_set_handler(i, handle_percpu_irq);
> -       }
>  }
>  
> 
> ---
> 
> And then well I thought maybe we could apply this patch on top to
> actually pass the clockevent to msm_timer_interrupt() instead of
> statically limiting ourselves to one local clockevent (and only two cores):
> 
> 8<------------
> 
> diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
> index 38e51cc..009faea 100644
> --- a/arch/arm/mach-msm/timer.c
> +++ b/arch/arm/mach-msm/timer.c
> @@ -84,13 +84,10 @@ enum {
>  
> 
>  static struct msm_clock msm_clocks[];
> -static struct clock_event_device *local_clock_event;
>  
>  static irqreturn_t msm_timer_interrupt(int irq, void *dev_id)
>  {
>         struct clock_event_device *evt = dev_id;
> -       if (smp_processor_id() != 0)
> -               evt = local_clock_event;
>         if (evt->event_handler == NULL)
>                 return IRQ_HANDLED;
>         evt->event_handler(evt);
> @@ -267,11 +264,9 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
>  
>         writel(DGT_CLK_CTL_DIV_4, MSM_TMR_BASE + DGT_CLK_CTL);
>  
> -       if (!local_clock_event) {
> -               writel(0, clock->regbase  + TIMER_ENABLE);
> -               writel(0, clock->regbase + TIMER_CLEAR);
> -               writel(~0, clock->regbase + TIMER_MATCH_VAL);
> -       }
> +       writel(0, clock->regbase  + TIMER_ENABLE);
> +       writel(0, clock->regbase + TIMER_CLEAR);
> +       writel(~0, clock->regbase + TIMER_MATCH_VAL);
>         evt->irq = gic_ppi_to_vppi(clock->irq);
>         evt->name = "local_timer";
>         evt->features = CLOCK_EVT_FEAT_ONESHOT;
> @@ -284,11 +279,9 @@ int __cpuinit local_timer_setup(struct clock_event_device *evt)
>                 clockevent_delta2ns(0xf0000000 >> clock->shift, evt);
>         evt->min_delta_ns = clockevent_delta2ns(4, evt);
>  
> -       local_clock_event = evt;
> -
>         res = request_irq(evt->irq, msm_timer_interrupt,
>                           IRQF_TIMER | IRQF_NOBALANCING | IRQF_TRIGGER_RISING,
> -                         clock->clockevent.name, &clock->clockevent);
> +                         clock->clockevent.name, evt);
>         if (res) {
>                 pr_err("local_timer_setup: request_irq failed for %s\n",
>                        clock->clockevent.name);
> 
> 
> ---
> 
> So after all that it looks like it sort of works (at least it boots and
> sits at a console). I actually wanted to do something like this a few
> days ago and by coincidence you've done it. Telepathy? Perhaps.

Thanks for having a look at all of this. I think the lack of an MSM
platform shows here... Can I fold your patches into mine?

I think that this kind of cleanup crossed the mind of anyone having to
deal with local timers on more than one platform. I just got fed up
quicker... ;-)

> I found one issue. I don't quite understand it, but we call
> local_timer_setup() on each cpu hotplug add event, and thus the
> request_irq() call is going to fail the second time you hotplug add a
> cpu. Simplest fix I see is to have a flag so we don't do boot stuff more
> than once (similar to our check for !local_clock_event which I
> mistakenly dropped up there for the wrong reason!).
> 
> Why do we need to call local_timer_setup() on each CPU up though? It
> would be nice to be able to just add local timers for all possible CPUs
> at boot time and then have the clockevents core take care of enabling
> and disabling the events as appropriate without ARM code forcing the
> events to be UNUSED and then re-adding the events back on CPU up. I'm
> probably missing something really obvious here.
> 

This need to be investigated indeed. I'm seeing a nice crash on my OMAP4
while bringing a CPU back up, and I suspect it might be the same root
cause.

	M.
-- 
Reality is an implementation detail.
-- 
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
