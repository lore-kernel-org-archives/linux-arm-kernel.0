From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 10 Jan 2017 18:22:28 +0100
Subject: [PATCH 1/3] ARM: at91: flush the L2 cache before entering cpu idle
In-Reply-To: <CACh+v5NX9Da__zXtnVGgbO9wYAzEJy-8rjVPHdQx_F6QDk+xZg@mail.gmail.com>
References: <20170106065947.30631-1-wenyou.yang@atmel.com>
 <20170106065947.30631-2-wenyou.yang@atmel.com>
 <20170110161821.vp673jyfqx6s76pg@piout.net>
 <CACh+v5NX9Da__zXtnVGgbO9wYAzEJy-8rjVPHdQx_F6QDk+xZg@mail.gmail.com>
Message-ID: <20170110172228.lh5ahy4peuwmurr6@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01/2017 at 17:50:58 +0100, Jean-Jacques Hiblot wrote :
> 2017-01-10 17:18 GMT+01:00 Alexandre Belloni
> <alexandre.belloni@free-electrons.com>:
> > I though a bit more about it, and I don't really like the new compatible
> > string. I don't feel this should be necessary.
> >
> > What about the following:
> >
> > diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> > index b4332b727e9c..0333aca63e44 100644
> > --- a/arch/arm/mach-at91/pm.c
> > +++ b/arch/arm/mach-at91/pm.c
> > @@ -53,6 +53,7 @@ extern void at91_pinctrl_gpio_resume(void);
> >  static struct {
> >         unsigned long uhp_udp_mask;
> >         int memctrl;
> > +       bool has_l2_cache;
> >  } at91_pm_data;
> >
> >  void __iomem *at91_ramc_base[2];
> > @@ -267,6 +268,11 @@ static void at91_ddr_standby(void)
> >         u32 lpr0, lpr1 = 0;
> >         u32 saved_lpr0, saved_lpr1 = 0;
> >
> 
> > +       if (at91_pm_data.has_l2_cache) {
> > +               flush_cache_all();
> what is the point of calling flush_cache_all() here ? Do we really
> care that dirty data in L1 is written to DDR ? I may be missing
> something but to me it's just extra latency.

I agree that this one is the main problem.

> > +               outer_disable();
> It seems to me that if there's no L2 cache, then outer_disable()  is a
> no-op. It could be called unconditionally.

It is not on sama5, it will jump to outer_disable which will at least
save the context and restore it

> > +       }
> > +
> >         if (at91_ramc_base[1]) {
> >                 saved_lpr1 = at91_ramc_read(1, AT91_DDRSDRC_LPR);
> >                 lpr1 = saved_lpr1 & ~AT91_DDRSDRC_LPCB;
> > @@ -287,6 +293,9 @@ static void at91_ddr_standby(void)
> >         at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr0);
> >         if (at91_ramc_base[1])
> >                 at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);
> > +
> > +       if (at91_pm_data.has_l2_cache)
> > +               outer_resume();
> 
> same remark as for outer_disable()

It is not either but this is a macro and I admit testing has_l2_cache is
superfluous.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
