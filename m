From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 15:43:19 +0100
Subject: [PATCH] ARM: common: edma: edma_pm_resume may be unused
In-Reply-To: <20141121133350.GR27002@pengutronix.de>
References: <4363971.teBOlf16kG@wuerfel>
 <20141121133350.GR27002@pengutronix.de>
Message-ID: <2597671.WV5SL4xIWh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014 14:33:50 Uwe Kleine-K?nig wrote:
> Hello Arnd,
> 
> On Fri, Nov 21, 2014 at 11:52:51AM +0100, Arnd Bergmann wrote:
> > The recently introduced resume hook in the edma driver
> > is not referenced when CONFIG_PM_SLEEP is not set, which
> > results in a compile warning in keystone_defconfig builds.
> > 
> > This adds an appropriate #ifdef.
> > 
> > Cc: Nishanth Menon <nm@ti.com>
> > Cc: Daniel Mack <zonque@gmail.com>
> > Cc: Joel Fernandes <joelf@ti.com>
> > Cc: Sekhar Nori <nsekhar@ti.com>
> > Fixes: a2b1175131: ("ARM: common: edma: add suspend resume hook")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> > I'm applying this as the obvious fixup on top of the next/drivers
> > branch.
> > 
> > diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> > index 24a2857f2285..5662a872689b 100644
> > --- a/arch/arm/common/edma.c
> > +++ b/arch/arm/common/edma.c
> > @@ -1810,6 +1810,7 @@ static int edma_probe(struct platform_device *pdev)
> >       return 0;
> >  }
> >  
> > +#ifdef CONFIG_PM_SLEEP
> >  static int edma_pm_resume(struct device *dev)
> What about
> 
> -static int edma_pm_resume(struct device *dev)
> +static int __maybe_unused edma_pm_resume(struct device *dev)
> 

That would be a little nicer, but I wouldn't go back and change my commit
now for it, since I've already committed it.

What I'd really want to see is a change to the macro to something like

#define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
        .suspend_late  = IS_ENABLED(CONFIG_PM_SLEEP) ? suspend_fn : NULL, \
        .resume_early  = IS_ENABLED(CONFIG_PM_SLEEP) ? resume_fn  : NULL, \
        .freeze_late   = IS_ENABLED(CONFIG_PM_SLEEP) ? suspend_fn : NULL, \
        .thaw_early    = IS_ENABLED(CONFIG_PM_SLEEP) ? resume_fn  : NULL, \
        .poweroff_late = IS_ENABLED(CONFIG_PM_SLEEP) ? suspend_fn : NULL, \
        .restore_early = IS_ENABLED(CONFIG_PM_SLEEP) ? resume_fn  : NULL,

so we can stop doing this for every other driver. Unfortunately we haven't
been able to come up with a way to define the macro that works unless you
remove all the existing #ifdef for the suspend functions first.

	Arnd
