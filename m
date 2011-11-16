From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Wed, 16 Nov 2011 13:35:04 +0000
Subject: [PATCH] arm: mx28: check for gated clocks when setting saif
 divider
In-Reply-To: <20111116132222.GD2596@pengutronix.de>
References: <1315650583-4793-1-git-send-email-w.sang@pengutronix.de>
 <20111116132222.GD2596@pengutronix.de>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7722D4E65@039-SN1MPN1-002.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> Sent: Wednesday, November 16, 2011 9:22 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Sascha Hauer; Guo Shawn-R65073; Dong Aisheng-B29396
> Subject: Re: [PATCH] arm: mx28: check for gated clocks when setting saif
> divider
> 
> On Sat, Sep 10, 2011 at 12:29:43PM +0200, Wolfram Sang wrote:
> > Like with all other clocks, the divider for the SAIF devices should
> > not be altered when the clock is gated. Bail out when this is the case
> > like the other clocks do.
> >
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Shawn Guo <shawn.guo@freescale.com>
> > Cc: Dong Aisheng-B29396 <B29396@freescale.com>
> > ---
> >
> > Aisheng: I think this is the correct solution for clock-mx28.c. If
> > setting the rate of the saif clocks hit the error path, it should be
> fixed in the driver?
> 
> Ping. Trying to catch up, has this been resolved meanwhile?
> 
Sorry, I missed this patch.

If I understand right, the convention way is to clk_set_rate() then
clk_enable().I f that, is it reasonable for driver to do something like:
Clk_enable -> clk_set_rate->clk_disable to set a proper rate,
then when needs the clock on, do clk_enable again?


> >
> >  arch/arm/mach-mxs/clock-mx28.c |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-mxs/clock-mx28.c
> > b/arch/arm/mach-mxs/clock-mx28.c index 63d6117..c9482b5 100644
> > --- a/arch/arm/mach-mxs/clock-mx28.c
> > +++ b/arch/arm/mach-mxs/clock-mx28.c
> > @@ -457,6 +457,10 @@ static int name##_set_rate(struct clk *clk,
> unsigned long rate)		\
> >  	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
> >  	reg &= ~BM_CLKCTRL_##rs##_DIV;					\
> >  	reg |= div << BP_CLKCTRL_##rs##_DIV;				\
> > +	if (reg & (1 << clk->enable_shift)) {				\
> > +		pr_err("%s: clock is gated\n", __func__);		\
> > +		return -EINVAL;						\
> > +	}								\
> >  	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_##rs);		\
> >  									\
> >  	for (i = 10000; i; i--)						\
> > --
> > 1.7.5.4
> >
> 
> --
> Pengutronix e.K.                           | Wolfram Sang
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
