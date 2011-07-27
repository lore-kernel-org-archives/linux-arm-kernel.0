From: B19295@freescale.com (Lin Tony-B19295)
Date: Wed, 27 Jul 2011 08:16:34 +0000
Subject: [PATCH v3 5/6] ARM: mxs: add usb phy operations
In-Reply-To: <20110727080315.GN20587@pengutronix.de>
References: <1311744574-3610-1-git-send-email-tony.lin@freescale.com>
	<1311744574-3610-6-git-send-email-tony.lin@freescale.com>
	<20110727080315.GN20587@pengutronix.de>
Message-ID: <97D3A72708D04647A5AC84A04996E5B5166A4B@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Sascha Hauer [mailto:s.hauer at pengutronix.de]
> Sent: Wednesday, July 27, 2011 4:03 PM
> To: Lin Tony-B19295
> Cc: linux-usb at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> stern at rowland.harvard.edu; koen.beel.barco at gmail.com
> Subject: Re: [PATCH v3 5/6] ARM: mxs: add usb phy operations
> 
> On Wed, Jul 27, 2011 at 01:29:33PM +0800, Tony Lin wrote:
> > add usb phy register definitions and functions usb host driver will
> > use these callback functions to initialize usb phy and change working
> > mode
> >
> > Signed-off-by: Tony Lin <tony.lin@freescale.com>
> > ---
> >  arch/arm/mach-mxs/Kconfig           |    1 +
> >  arch/arm/mach-mxs/Makefile          |    1 +
> >  arch/arm/mach-mxs/mxs_usb.c         |  288
> +++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-mxs/regs-usbphy-mxs.h |  240
> > +++++++++++++++++++++++++++++
> >  4 files changed, 530 insertions(+), 0 deletions(-)
> >
> > +}
> > +static int fsl_usb_host_init(struct platform_device *pdev) {
> > +	struct mxc_usbh_platform_data *pdata = pdev->dev.platform_data;
> > +	struct mxs_usb_private_date *ppriv = pdata->ppriv;
> > +
> > +	ppriv->phy_regs = ioremap(MX28_USBPHY1_BASE_ADDR, SZ_8K);
> > +	ppriv->ctrl_regs = ioremap(MX28_USBCTRL1_BASE_ADDR, SZ_8K);
> 
> Did I mention that the i.MX28 has *two* USB controllers?
> 
Yes, i.MX28 has two USB, one is pure USB host, another is USB OTG.
I hard code USB1 here just because we want another USB OTG to be a pure USB device.
Anyway, I could make it more flexible in later patch. thanks

> > +	if (!ppriv->phy_regs || !ppriv->ctrl_regs) {
> > +		iounmap(ppriv->phy_regs);
> > +		iounmap(ppriv->ctrl_regs);
> > +		return -ENOMEM;
> > +	}
> 
> So you call iounmap(0) here.
> 
Yes, iounmap will ignore NULL pointers, right?

> > +	ppriv->usb_clk = clk_get(&pdev->dev, "usb1");
> > +	if (IS_ERR(ppriv->usb_clk)) {
> > +		iounmap(ppriv->phy_regs);
> > +		iounmap(ppriv->ctrl_regs);
> > +		return PTR_ERR(ppriv->usb_clk);
> 
> In the kernel community we are not afraid of 'goto'.
> 
Ok. Will change it.

> > +	}
> > +	clk_enable(ppriv->usb_clk);
> > +
> > +	ppriv->usb_phy_clk = clk_get(&pdev->dev, "usb1_phy");
> > +	if (IS_ERR(ppriv->usb_phy_clk)) {
> > +		clk_disable(ppriv->usb_clk);
> > +		clk_put(ppriv->usb_clk);
> > +		iounmap(ppriv->phy_regs);
> > +		iounmap(ppriv->ctrl_regs);
> > +		return PTR_ERR(ppriv->usb_phy_clk);
> > +	}
> > +	clk_enable(ppriv->usb_phy_clk);
> > +
> > +	phy_clock_gate(ppriv, true);
> > +	return fsl_usbh_init(pdev);
> > +}
> > +
> > +static int fsl_usb_host_uninit(struct platform_device *pdev) {
> > +	struct mxc_usbh_platform_data *pdata = pdev->dev.platform_data;
> > +	struct mxs_usb_private_date *ppriv = pdata->ppriv;
> > +
> > +	phy_clock_gate(ppriv, false);
> > +	clk_disable(ppriv->usb_phy_clk);
> > +	clk_put(ppriv->usb_phy_clk);
> > +	clk_disable(ppriv->usb_clk);
> > +	clk_put(ppriv->usb_clk);
> > +	iounmap(ppriv->phy_regs);
> > +	iounmap(ppriv->ctrl_regs);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct mxs_usb_private_date usbh_private = {
> > +	.internal_phy_clk_already_on = 0,
> > +};
> 
> unitialized fields in static initializers are zero anyway.
> Remove all this ppriv crap. clk_enable/disable will do the reference
> counting for you.
>
Ok. Accepted. Thanks Sascha.
 
> Sascha
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
