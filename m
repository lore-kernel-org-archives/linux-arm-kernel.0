From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Jan 2017 11:18:15 +0000
Subject: [PATCH 1/3] ARM: at91: flush the L2 cache before entering cpu idle
In-Reply-To: <CACh+v5M3tU4WHMqAX0zm2H=zzwc0+XChyG1tnH2aHxaacm6C=A@mail.gmail.com>
References: <20170106065947.30631-1-wenyou.yang@atmel.com>
 <20170106065947.30631-2-wenyou.yang@atmel.com>
 <20170110161821.vp673jyfqx6s76pg@piout.net>
 <CACh+v5NX9Da__zXtnVGgbO9wYAzEJy-8rjVPHdQx_F6QDk+xZg@mail.gmail.com>
 <F9F4555C4E01D7469D37975B62D0EFBB496BE4@CHN-SV-EXMX07.mchp-main.com>
 <CACh+v5M3tU4WHMqAX0zm2H=zzwc0+XChyG1tnH2aHxaacm6C=A@mail.gmail.com>
Message-ID: <20170111111814.GJ14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 12:05:05PM +0100, Jean-Jacques Hiblot wrote:
> 2017-01-11 9:15 GMT+01:00  <Wenyou.Yang@microchip.com>:
> > Hi Jean-Jacques,
> >
> >> -----Original Message-----
> >> From: Jean-Jacques Hiblot [mailto:jjhiblot at gmail.com]
> >> Sent: 2017?1?11? 0:51
> >> To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >> Cc: Wenyou Yang - A41535 <Wenyou.Yang@microchip.com>; Mark Rutland
> >> <mark.rutland@arm.com>; devicetree <devicetree@vger.kernel.org>; Russell
> >> King <linux@arm.linux.org.uk>; Wenyou Yang - A41535
> >> <Wenyou.Yang@microchip.com>; Nicolas Ferre <nicolas.ferre@atmel.com>;
> >> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Rob Herring
> >> <robh+dt@kernel.org>; linux-arm-kernel at lists.infradead.org
> >> Subject: Re: [PATCH 1/3] ARM: at91: flush the L2 cache before entering cpu idle
> >>
> >> 2017-01-10 17:18 GMT+01:00 Alexandre Belloni
> >> <alexandre.belloni@free-electrons.com>:
> >> > I though a bit more about it, and I don't really like the new
> >> > compatible string. I don't feel this should be necessary.
> >> >
> >> > What about the following:
> >> >
> >> > diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c index
> >> > b4332b727e9c..0333aca63e44 100644
> >> > --- a/arch/arm/mach-at91/pm.c
> >> > +++ b/arch/arm/mach-at91/pm.c
> >> > @@ -53,6 +53,7 @@ extern void at91_pinctrl_gpio_resume(void);  static
> >> > struct {
> >> >         unsigned long uhp_udp_mask;
> >> >         int memctrl;
> >> > +       bool has_l2_cache;
> >> >  } at91_pm_data;
> >> >
> >> >  void __iomem *at91_ramc_base[2];
> >> > @@ -267,6 +268,11 @@ static void at91_ddr_standby(void)
> >> >         u32 lpr0, lpr1 = 0;
> >> >         u32 saved_lpr0, saved_lpr1 = 0;
> >> >
> >>
> >> > +       if (at91_pm_data.has_l2_cache) {
> >> > +               flush_cache_all();
> >> what is the point of calling flush_cache_all() here ? Do we really care that dirty
> >> data in L1 is written to DDR ? I may be missing something but to me it's just extra
> >> latency.
> >
> > Are you mean use outer_flush_all() to flush all cache lines in the outer cache only?
> 
> Yes that's what I meant. You see, you don't flush the cache for
> sama5d3 so it shouldn't be required either for sam5d4. You should be
> able to test it quickly and see if L1 flush is indeed required by
> replacing  flush_cache_all() with outer_flush_all(). BTW is highly
> probable that L2 cache flush is done in outer_disable() so calling
> outer_flush_all() is probably no required.

Please don't.  Read the comments in the code, and understand the APIs
that you're suggesting people use _before_ making the suggestion:

/**
 * outer_flush_all - clean and invalidate all cache lines in the outer cache
 *
 * Note: depending on implementation, this may not be atomic - it must
 * only be called with interrupts disabled and no other active outer
 * cache masters.
 *
 * It is intended that this function is only used by implementations
 * needing to override the outer_cache.disable() method due to security.
 * (Some implementations perform this as a clean followed by an invalidate.)
 */

So, outer_flush_all() should not be called except from L2 cache code
implementing the outer_disable() function - it's not intended for
platforms to use.

There are, however, sadly three users of outer_flush_all() which have
crept in through arm-soc, that should be outer_disable() instead.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
