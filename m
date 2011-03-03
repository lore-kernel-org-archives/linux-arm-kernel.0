From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 3 Mar 2011 22:04:27 +0530
Subject: [PATCH 12/17] omap4: pm-debug: Add wakeup timer and debug counters
In-Reply-To: <87hbbl2l1y.fsf@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-13-git-send-email-santosh.shilimkar@ti.com>
	<87hbbl2l1y.fsf@ti.com>
Message-ID: <ff69224b634bfd89405d29a720755b64@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at ti.com]
> Sent: Thursday, March 03, 2011 4:21 AM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 12/17] omap4: pm-debug: Add wakeup timer and
> debug counters
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> > This patch adds configurable wakeup timer support in suspend. Also
> > for statistics pm counter support is added.
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Reviewed-by: Kevin Hilman <khilman@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap4-mpuss-lowpower.c |    8 ++++++++
> >  arch/arm/mach-omap2/pm-debug.c             |    6 ++++--
> >  arch/arm/mach-omap2/pm44xx.c               |    5 +++++
> >  3 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
> b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
> > index ab2e101..5e0141e 100644
> > --- a/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
> > +++ b/arch/arm/mach-omap2/omap4-mpuss-lowpower.c
> > @@ -287,6 +287,10 @@ int omap4_enter_lowpower(unsigned int cpu,
> unsigned int power_state)
> >  	if (cpu)
> >  		goto cpu_prepare;
> >
> > +#ifdef CONFIG_PM_DEBUG
> > +	pwrdm_pre_transition();
> > +#endif
>
> Why the #ifdef?
>
Because these stats updates are quite expensive
in low power code and for the production kernel
you don't need this extra penalty.


> >  	/*
> >  	 * Check MPUSS next state and save GIC if needed
> >  	 * GIC lost during MPU OFF and OSWR
> > @@ -332,6 +336,10 @@ cpu_prepare:
> >  		gic_dist_set(CPU0_ID, 1);
> >  	}
> >
> > +#ifdef CONFIG_PM_DEBUG
> > +	pwrdm_post_transition();
> > +#endif
> > +
> >  ret:
> >  	return 0;
> >  }
> > diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-
> omap2/pm-debug.c
> > index 9b46b3e..7d6dd5b 100644
> > --- a/arch/arm/mach-omap2/pm-debug.c
> > +++ b/arch/arm/mach-omap2/pm-debug.c
> > @@ -606,9 +606,11 @@ static int __init pm_dbg_init(void)
> >  	if (pm_dbg_init_done)
> >  		return 0;
> >
> > -	if (cpu_is_omap34xx())
> > +	if (cpu_is_omap34xx()) {
> >  		pm_dbg_reg_modules = omap3_pm_reg_modules;
> > -	else {
> > +	} else if (cpu_is_omap44xx()) {
> > +		/* Allow pm_dbg_init on OMAP4. */
>
> Doing this will cause crashes if the 'registers/*' debugfs file is
> accessed.
>
> Since there are no 'reg_modules' created, you should also prevent
> the creation of the 'registers' debugfs entries.
>
Will do
