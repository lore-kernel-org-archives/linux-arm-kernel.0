From: B19295@freescale.com (Lin Tony-B19295)
Date: Tue, 26 Jul 2011 02:05:31 +0000
Subject: [PATCH v2 5/6] ARM: mxs: add usb phy operations
In-Reply-To: <20110725082403.GA9653@n2100.arm.linux.org.uk>
References: <1311577284-11506-1-git-send-email-tony.lin@freescale.com>
	<1311577284-11506-6-git-send-email-tony.lin@freescale.com>
	<20013.6155.531965.918650@ipc1.ka-ro>
	<20110725082403.GA9653@n2100.arm.linux.org.uk>
Message-ID: <97D3A72708D04647A5AC84A04996E5B51661DD@039-SN1MPN1-006.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Monday, July 25, 2011 4:24 PM
> To: Lothar Wa?mann
> Cc: Lin Tony-B19295; koen.beel.barco at gmail.com; linux-usb at vger.kernel.org;
> stern at rowland.harvard.edu; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 5/6] ARM: mxs: add usb phy operations
> 
> On Mon, Jul 25, 2011 at 09:15:23AM +0200, Lothar Wa?mann wrote:
> > > +	if (WARN_ON(ppriv->internal_phy_clk_already_on < 0))
> > > +		printk(KERN_ERR "please check phy clock ON/OFF sequence\n"); }
> 
> And there should be a blank line here.
> 
> > > +static int fsl_usb_host_init(struct platform_device *pdev) {
> > > +	struct mxc_usbh_platform_data *pdata = pdev->dev.platform_data;
> > > +	struct mxs_usb_private_date *ppriv = pdata->ppriv;
> > > +
> > > +	ppriv->phy_regs = ioremap(MX28_USBPHY1_BASE_ADDR, SZ_8K);
> > > +	if (ppriv->phy_regs == NULL)
> > > +		return -ENOMEM;
> > > +
> > > +	ppriv->ctrl_regs = ioremap(MX28_USBCTRL1_BASE_ADDR, SZ_8K);
> > > +	if (ppriv->ctrl_regs == NULL)
> > > +		return -ENOMEM;
> > > +
> > What about proper cleanup in the error case?
> 
> Doing something like this is probably easiest:
> 
> 	ppriv->phy_regs = ioremap(MX28_USBPHY1_BASE_ADDR, SZ_8K);
> 	ppriv->ctrl_regs = ioremap(MX28_USBCTRL1_BASE_ADDR, SZ_8K);
> 	if (!ppriv->phy_regs || !ppriv_ctrl_regs) {
> 		iounmap(ppriv->phy_regs);
> 		iounmap(ppriv->ctrl_regs);
> 		return -ENOMEM;
> 	}
> 
> As iounmap ignores NULL pointers.
 good suggestion, thank you.
