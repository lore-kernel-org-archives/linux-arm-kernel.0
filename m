From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 7 Sep 2012 12:23:56 +0300
Subject: [PATCHv4 2/8] ARM: OMAP3+: voltage/pwrdm/clkdm/clock add
 recursive usecount tracking
In-Reply-To: <87ipcv4myp.fsf@ti.com>
References: <1342189185-5306-1-git-send-email-t-kristo@ti.com>
 <1342189185-5306-3-git-send-email-t-kristo@ti.com>  <87ipcv4myp.fsf@ti.com>
Message-ID: <1347009836.10702.92.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-08-06 at 16:31 -0700, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > This patch fixes the usecount tracking for omap3+, previously the
> > usecount numbers were rather bogus and were not really useful for
> > any purpose. Now usecount numbers track the number of really active
> > clients on each domain. This patch also adds support for usecount
> > tracking on powerdomain level and autoidle flag for clocks that
> > are hardware controlled and should be skipped in usecount
> > calculations.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> 
> [...]
> 
> >  /* Clock control for DPLL outputs */
> > diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> > index 9611490..68bdf36 100644
> > --- a/arch/arm/mach-omap2/powerdomain.c
> > +++ b/arch/arm/mach-omap2/powerdomain.c
> > @@ -981,6 +981,41 @@ int pwrdm_state_switch(struct powerdomain *pwrdm)
> >  	return ret;
> >  }
> >  
> > +/**
> > + * pwrdm_clkdm_enable - increment powerdomain usecount
> > + * @pwrdm: struct powerdomain *
> > + *
> > + * Increases the usecount for a powerdomain. Called from clockdomain
> > + * code once a clockdomain's usecount reaches zero, i.e. it is ready
> > + * to idle.
> > + */
> 
> I think the comment here is wrong.
> 
> > +void pwrdm_clkdm_enable(struct powerdomain *pwrdm)
> > +{
> > +	if (!pwrdm)
> > +		return;
> > +
> > +	atomic_inc(&pwrdm->usecount);
> > +}
> > +
> > +/**
> > + * pwrdm_clkdm_disable - decrease powerdomain usecount
> > + * @pwrdm: struct powerdomain *
> > + *
> > + * Decreases the usecount for a powerdomain. Called from clockdomain
> > + * code once a clockdomain becomes active.
> > + */
> 
> Looks like these two comments need to be swapped?

Ooops, that is true yes. Again my laziness in writing proper comments
bites me.

-Tero
