From: B19295@freescale.com (Lin Tony-B19295)
Date: Fri, 22 Jul 2011 02:16:38 +0000
Subject: [PATCH 2/7] enable usb1 phy power supply
In-Reply-To: <20110720114100.GB2377@pengutronix.de>
References: <1311160106-4898-1-git-send-email-tony.lin@freescale.com>
	<1311160106-4898-3-git-send-email-tony.lin@freescale.com>
	<20110720114100.GB2377@pengutronix.de>
Message-ID: <97D3A72708D04647A5AC84A04996E5B5162112@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> Sent: Wednesday, July 20, 2011 7:41 PM
> To: Lin Tony-B19295
> Cc: linux-usb at vger.kernel.org; koen.beel.barco at gmail.com; balbi at ti.com;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 2/7] enable usb1 phy power supply
> 
> On Wed, Jul 20, 2011 at 07:08:21PM +0800, Tony Lin wrote:
> > configure usb1 phy power enable gpio and enable usb1 phy power
> >
> > Signed-off-by: Tony Lin <tony.lin@freescale.com>
> > ---
> >  arch/arm/mach-mxs/mach-mx28evk.c |    9 +++++++++
> >  1 files changed, 9 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-mxs/mach-mx28evk.c
> > b/arch/arm/mach-mxs/mach-mx28evk.c
> > index eaaf6ff..6934867 100644
> > --- a/arch/arm/mach-mxs/mach-mx28evk.c
> > +++ b/arch/arm/mach-mxs/mach-mx28evk.c
> > @@ -34,6 +34,7 @@
> >  #define MX28EVK_BL_ENABLE	MXS_GPIO_NR(3, 18)
> >  #define MX28EVK_LCD_ENABLE	MXS_GPIO_NR(3, 30)
> >  #define MX28EVK_FEC_PHY_RESET	MXS_GPIO_NR(4, 13)
> > +#define MX28EVK_USB1_PWR_EN	MXS_GPIO_NR(3, 8)
> >
> >  #define MX28EVK_MMC0_WRITE_PROTECT	MXS_GPIO_NR(2, 12)
> >  #define MX28EVK_MMC1_WRITE_PROTECT	MXS_GPIO_NR(0, 28)
> > @@ -183,6 +184,8 @@ static const iomux_cfg_t mx28evk_pads[]
> > __initconst = {
> >
> >  	/* led */
> >  	MX28_PAD_AUART1_TX__GPIO_3_5 | MXS_PAD_CTRL,
> > +	/* usb1 */
> 
> /* usb1 power enable */
> 
> > +	MX28_PAD_AUART2_RX__GPIO_3_8 | MXS_PAD_CTRL,
> >  };
> >
> >  /* led */
> > @@ -405,6 +408,12 @@ static void __init mx28evk_init(void)
> >  		pr_warn("failed to request gpio mmc1-slot-power: %d\n", ret);
> >  	mx28_add_mxs_mmc(1, &mx28evk_mmc_pdata[1]);
> >
> > +	ret = gpio_request_one(MX28EVK_USB1_PWR_EN, GPIOF_DIR_OUT,
> 
> use GPIOF_OUT_INIT_HIGH here to save the set_value below and have less
> glitch on the line
Ok, thanks for your advice. 

> 
> > +			       "usb1-power-en");
> > +	if (ret)
> > +		pr_warn("failed to request gpio usb1-power-en %d\n", ret);
> > +	else
> > +		gpio_set_value(MX28EVK_USB1_PWR_EN, 1);
> >  	gpio_led_register_device(0, &mx28evk_led_data);  }
> >
> > --
> > 1.7.0.4
> >
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> --
> Pengutronix e.K.                           | Wolfram Sang
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
