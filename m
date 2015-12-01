From: tony@atomide.com (Tony Lindgren)
Date: Tue, 1 Dec 2015 07:47:05 -0800
Subject: [PATCH 1/2] ARM: OMAP2+: Initialize timers later with
 late_time_init
In-Reply-To: <565DA609.2020204@ti.com>
References: <1448900789-4034-1-git-send-email-tony@atomide.com>
 <1448900789-4034-2-git-send-email-tony@atomide.com>
 <565DA609.2020204@ti.com>
Message-ID: <20151201154705.GP23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [151201 05:53]:
> On 11/30/2015 06:26 PM, Tony Lindgren wrote:
> > We don't need timers right away and initializing them later gives us few
> > nice things like interrupts and kmalloc. As the timers have a dependency
> > to the clock framework, we're better off initializing things later rather
> > than early if things go wrong. And this allows us to make the mux clock
> > driver needed for system timers into early_platform drivers.
> > 
> > Note that smp_prepare_cpus() will get called later on during the init so
> > we just need to local_irq_enable/disable for clocksource_probe().
> > 
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Tero Kristo <t-kristo@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >   arch/arm/mach-omap2/timer.c | 46 +++++++++++++++++++++++++++++++++++++++------
> >   1 file changed, 40 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> > index b18ebbe..68bf482 100644
> > --- a/arch/arm/mach-omap2/timer.c
> > +++ b/arch/arm/mach-omap2/timer.c
> > @@ -478,36 +478,56 @@ static void __init __omap_sync32k_timer_init(int clkev_nr, const char *clkev_src
> >   	omap2_gp_clockevent_init(clkev_nr, clkev_src, clkev_prop);
> >   
> >   	/* Enable the use of clocksource="gp_timer" kernel parameter */
> > +	local_irq_disable();
> >   	if (use_gptimer_clksrc || gptimer)
> >   		omap2_gptimer_clocksource_init(clksrc_nr, clksrc_src,
> >   						clksrc_prop);
> >   	else
> >   		omap2_sync32k_clocksource_init();
> > +	local_irq_enable();
> 
> So, this will be called now after sched_clock_postinit() and to W/A warnings
> you've added local_irq_disable()/local_irq_enable(). Am I right?
> 
> Are you sure this is safe?

Hmm good point, update_sched_clock() is never called again and so it's
running on jiffies. We could separate out the sched_clock when the 32k
source or a local timer is used. But that does allow initializing the
gptimer later on. Anyways, clearly this needs more work.

Regards,

Tony
