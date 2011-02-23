From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Wed, 23 Feb 2011 17:18:40 +0530
Subject: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
	hwmodright before timer init
In-Reply-To: <581270b49665fcf8227a96065dbbc584@mail.gmail.com>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
	<20110223071153.5874.58923.stgit@twilight.localdomain>
	<581270b49665fcf8227a96065dbbc584@mail.gmail.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A09552D@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Shilimkar, Santosh
> Sent: Wednesday, February 23, 2011 2:23 PM
> To: Paul Walmsley; linux-omap at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Cc: Tony Lindgren; Hilman, Kevin; Cousson, Benoit
> Subject: RE: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER clockevent
> hwmodright before timer init
> 
> Paul,
> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul at pwsan.com]
> > Sent: Wednesday, February 23, 2011 12:42 PM
> > To: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> > Cc: Tony Lindgren; Kevin Hilman; Santosh Shilimkar; Beno?t Cousson
> > Subject: [PATCH 8/8] OMAP2+: clockevent: late-init GPTIMER
> > clockevent hwmodright before timer init
> >
> > Late-initialize the GPTIMER hwmod used for the clockevent source
> > immediately
> > before it is used.  This avoids the need to late-initialize all of
> > the hwmods
> > until the boot process is further along.  (In general, we want to
> > defer
> > as much as possible until late in the boot process.)
> >
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > Cc: Beno?t Cousson <b-cousson@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  arch/arm/mach-omap2/timer-gp.c |    8 +++++++-
> >  1 files changed, 7 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-
> > omap2/timer-gp.c
> > index 0fc550e..a4e51a2 100644
> > --- a/arch/arm/mach-omap2/timer-gp.c
> > +++ b/arch/arm/mach-omap2/timer-gp.c
> > @@ -40,10 +40,11 @@
> >  #include <plat/dmtimer.h>
> >  #include <asm/localtimer.h>
> >  #include <asm/sched_clock.h>
> > +#include <plat/common.h>
> >
> >  #include "timer-gp.h"
> > +#include <plat/omap_hwmod.h>
> >
> > -#include <plat/common.h>
> >
> >  /* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
> >  #define MAX_GPTIMER_ID		12
> > @@ -133,9 +134,13 @@ static void __init
> > omap2_gp_clockevent_init(void)
> >  {
> >  	u32 tick_rate;
> >  	int src;
> > +	const char *clockevent_hwmod_name;
> >
> >  	inited = 1;
> >
> > +	clockevent_hwmod_name = (gptimer_id == 12) ? "timer12" :
> > "timer1";
> > +	omap_hwmod_late_init_one(clockevent_hwmod_name);
> > +
> 
> Do we need above hard-coding ? This takes away flexibility of
> choosing system timer from board files, right ?
> 
> Am I missing something here?
Currently, omap_4430sdp_init_early() and omap3_beagle_init_irq() calls
omap2_gp_clockevent_set_gptimer(id) to set it to 1 and 12 respectively.
For OMAP24xx, the default settings of gptimer_id=1 is taken.
In summary, we are losing the flexibility.
Instead we could have something like:
sscanf(clockevent_hwmod_name, "timer%2d", &gptimer_id);
--
Tarun
> 
> 
> 
> >  	gptimer = omap_dm_timer_request_specific(gptimer_id);
> >  	BUG_ON(gptimer == NULL);
> >  	gptimer_wakeup = gptimer;
> > @@ -250,6 +255,7 @@ static void __init omap2_gp_timer_init(void)
> >  		BUG_ON(!twd_base);
> >  	}
> >  #endif
> > +
> >  	omap_dm_timer_init();
> >
> >  	omap2_gp_clockevent_init();
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
