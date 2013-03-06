From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Mar 2013 17:09:53 -0800
Subject: [PATCH 6/9] [media] ir-rx51: fix clock API related build issues
In-Reply-To: <20130305212351.4993d8c6@redhat.com>
References: <1362521809-22989-1-git-send-email-arnd@arndb.de>
 <1362521809-22989-7-git-send-email-arnd@arndb.de>
 <20130305212351.4993d8c6@redhat.com>
Message-ID: <20130306010952.GJ11806@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mauro Carvalho Chehab <mchehab@redhat.com> [130305 16:28]:
> Em Tue,  5 Mar 2013 23:16:46 +0100
> Arnd Bergmann <arnd@arndb.de> escreveu:
> 
> > OMAP1 no longer provides its own clock interfaces since patch
> > a135eaae52 "ARM: OMAP: remove plat/clock.h". This is great, but
> > we now have to convert the ir-rx51 driver to use the generic
> > interface from linux/clk.h.
> > 
> > The driver also uses the omap_dm_timer_get_fclk() function,
> > which is not exported for OMAP1, so we have to move the
> > definition out of the OMAP2 specific section.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> 
> From my side:
> Acked-by: Mauro Carvalho Chehab <mchehab@redhat.com>

There's just one issue, this driver most likely only needed on
rx51 board.. So I suggest we just mark the driver depends on
ARCH_OMAP2PLUS and let's drop this patch.

This driver is already disabled for ARCH_MULTIPLATFORM
as we need to move dmtimer.c to drivers and have some minimal
include/linux/timer-omap.h for it.
 
> > --- a/arch/arm/plat-omap/dmtimer.c
> > +++ b/arch/arm/plat-omap/dmtimer.c
> > @@ -333,6 +333,14 @@ int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
> >  }
> >  EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
> >  
> > +struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
> > +{
> > +	if (timer)
> > +		return timer->fclk;
> > +	return NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(omap_dm_timer_get_fclk);
> > +
> >  #if defined(CONFIG_ARCH_OMAP1)
> >  #include <mach/hardware.h>
> >  /**
> > @@ -371,14 +379,6 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
> >  
> >  #else
> >  
> > -struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
> > -{
> > -	if (timer)
> > -		return timer->fclk;
> > -	return NULL;
> > -}
> > -EXPORT_SYMBOL_GPL(omap_dm_timer_get_fclk);
> > -
> >  __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
> >  {
> >  	BUG();

Then omap_dm_timer_get_fclk() won't work on omap1 as there's no
separate functional clock. We probably should not even export
this function eventually when things are fixed up.

Regards,

Tony
