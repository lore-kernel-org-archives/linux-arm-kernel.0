From: B19295@freescale.com (Lin Tony-B19295)
Date: Fri, 22 Jul 2011 06:02:00 +0000
Subject: [PATCH 3/7] add usb phy clocks to clock tree
In-Reply-To: <20110720191034.GL26347@pengutronix.de>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
	<1311160106-4898-4-git-send-email-tony.lin@freescale.com>
	<20110720191034.GL26347@pengutronix.de>
Message-ID: <97D3A72708D04647A5AC84A04996E5B51622DF@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Thursday, July 21, 2011 3:11 AM
> To: Lin Tony-B19295
> Cc: linux-usb at vger.kernel.org; koen.beel.barco at gmail.com; balbi at ti.com;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 3/7] add usb phy clocks to clock tree
> 
> On Wed, Jul 20, 2011 at 07:08:22PM +0800, Tony Lin wrote:
> > Signed-off-by: Tony Lin <tony.lin@freescale.com>
> > ---
> >  arch/arm/mach-mxs/clock-mx28.c |   18 ++++++++++++++++++
> >  1 files changed, 18 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-mxs/clock-mx28.c
> > b/arch/arm/mach-mxs/clock-mx28.c index 5dcc59d..6fd0fe6 100644
> > --- a/arch/arm/mach-mxs/clock-mx28.c
> > +++ b/arch/arm/mach-mxs/clock-mx28.c
> > @@ -570,7 +570,23 @@ static struct clk usb1_clk = {
> >  	.disable = _raw_clk_disable,
> >  	.parent = &pll1_clk,
> >  };
> > +/* usb phy clock for usb0 */
> > +static struct clk usb_phy_clk0 = {
> > +	.parent = &pll0_clk,
> > +	.enable = _raw_clk_disable, /* EN_USB_CLKS = 1 means ON */
> > +	.disable = _raw_clk_enable,
> > +	.enable_reg = CLKCTRL_BASE_ADDR + HW_CLKCTRL_PLL0CTRL0,
> > +	.enable_shift = 18,
> > +};
> >
> > +/* usb phy clock for usb1 */
> > +static struct clk usb_phy_clk1 = {
> > +	.parent = &pll1_clk,
> > +	.enable = _raw_clk_disable,
> > +	.disable = _raw_clk_enable,
> > +	.enable_reg = CLKCTRL_BASE_ADDR + HW_CLKCTRL_PLL1CTRL0,
> > +	.enable_shift = 18,
> > +};
> >  #define _DEFINE_CLOCK(name, er, es, p)					\
> >  	static struct clk name = {					\
> >  		.enable_reg	= CLKCTRL_BASE_ADDR + HW_CLKCTRL_##er,	\
> > @@ -629,6 +645,8 @@ static struct clk_lookup lookups[] = {
> >  	_REGISTER_CLOCK("flexcan.1", NULL, can1_clk)
> >  	_REGISTER_CLOCK(NULL, "usb0", usb0_clk)
> >  	_REGISTER_CLOCK(NULL, "usb1", usb1_clk)
> > +	_REGISTER_CLOCK(NULL, "usb0_phy", usb_phy_clk0)
> > +	_REGISTER_CLOCK(NULL, "usb1_phy", usb_phy_clk1)
> 
> This looks suspicious. The phys are real devices, but this shows you do
> not intend to use them as devices. Really the phys should be drivers.
> 
> Sascha
> 
Hi Sascha:

	I didn't get it. Shouldn't I register PHY clocks here?
'_REGISTER_CLOCK("mxc-ehci.0", "usb_phy1", usb_phy1_clk)'
	This is what mx51/53 did in clock-mx51-mx53.c

BR
Tony


> >  	_REGISTER_CLOCK("mxs-pwm.0", NULL, pwm_clk)
> >  	_REGISTER_CLOCK("mxs-pwm.1", NULL, pwm_clk)
> >  	_REGISTER_CLOCK("mxs-pwm.2", NULL, pwm_clk)
> > --
> > 1.7.0.4
> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
> 
> --
> Pengutronix e.K.                           |
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0
> |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555
> |
