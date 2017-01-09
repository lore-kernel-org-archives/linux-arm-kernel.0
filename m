From: Wenyou.Yang@microchip.com (Wenyou.Yang at microchip.com)
Date: Mon, 9 Jan 2017 01:47:21 +0000
Subject: [PATCH 1/3] ARM: at91: flush the L2 cache before entering cpu idle
In-Reply-To: <20170106090517.txcoukisnx43cfqq@piout.net>
References: <20170106065947.30631-1-wenyou.yang@atmel.com>
 <20170106065947.30631-2-wenyou.yang@atmel.com>
 <20170106090517.txcoukisnx43cfqq@piout.net>
Message-ID: <F9F4555C4E01D7469D37975B62D0EFBB49202C@CHN-SV-EXMX07.mchp-main.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> Sent: 2017?1?6? 17:05
> To: Wenyou Yang - A41535 <Wenyou.Yang@microchip.com>
> Cc: Russell King <linux@arm.linux.org.uk>; Nicolas Ferre
> <nicolas.ferre@atmel.com>; Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; linux-kernel at vger.kernel.org; Wenyou Yang - A41535
> <Wenyou.Yang@microchip.com>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 1/3] ARM: at91: flush the L2 cache before entering cpu idle
> 
> Hi,
> 
> On 06/01/2017 at 14:59:45 +0800, Wenyou Yang wrote :
> > For the SoCs such as SAMA5D2 and SAMA5D4 which have L2 cache, flush
> > the L2 cache first before entering the cpu idle.
> >
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> >
> >  arch/arm/mach-at91/pm.c       | 19 +++++++++++++++++++
> >  drivers/memory/atmel-sdramc.c |  1 +
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c index
> > b4332b727e9c..1a60dede1a01 100644
> > --- a/arch/arm/mach-at91/pm.c
> > +++ b/arch/arm/mach-at91/pm.c
> > @@ -289,6 +289,24 @@ static void at91_ddr_standby(void)
> >  		at91_ramc_write(1, AT91_DDRSDRC_LPR, saved_lpr1);  }
> >
> > +static void at91_ddr_cache_standby(void) {
> > +	u32 saved_lpr;
> > +
> > +	flush_cache_all();
> > +	outer_disable();
> > +
> > +	saved_lpr = at91_ramc_read(0, AT91_DDRSDRC_LPR);
> > +	at91_ramc_write(0, AT91_DDRSDRC_LPR, (saved_lpr &
> > +			(~AT91_DDRSDRC_LPCB)) |
> AT91_DDRSDRC_LPCB_SELF_REFRESH);
> > +
> > +	cpu_do_idle();
> > +
> > +	at91_ramc_write(0, AT91_DDRSDRC_LPR, saved_lpr);
> > +
> > +	outer_resume();
> > +}
> > +
> 
> Seems good to me. Did you measure the added latency on sama5d3 if you add the
> cache operations in at91_ddr_standby instead of having a new function?

No, I didn't. How to measure it?


Best Regards,
Wenyou Yang
