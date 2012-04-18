From: marex@denx.de (Marek Vasut)
Date: Wed, 18 Apr 2012 22:07:30 +0200
Subject: [PATCH 08/10] MXS: Add separate MXS EHCI HCD driver
In-Reply-To: <20120418195033.GA3852@pengutronix.de>
References: <1334714869-19282-1-git-send-email-marex@denx.de>
 <1334771194-18688-9-git-send-email-marex@denx.de>
 <20120418195033.GA3852@pengutronix.de>
Message-ID: <201204182207.30516.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sascha Hauer,

> On Wed, Apr 18, 2012 at 07:46:32PM +0200, Marek Vasut wrote:
> > This driver will handle i.MX233/i.MX28 and I hope soon i.MX6Q. I tried to
> > keep this separate from the MXC EHCI to avoid further polution of the
> > MXC EHCI, though eventually these two might be merged.
> > 
> > NOTE: I still haven't figured out how to enable/disable the disconnection
> > detector, it can't be enabled all the time, so I toggle PHY stuff from
> > this driver, which I doubt is correct.
> 
> [...]
> 
> > +static int ehci_mxs_drv_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct imx_usb *data = pdev->dev.platform_data;
> > +	struct usb_hcd *hcd;
> > +	struct ehci_hcd *ehci;
> > +	struct usb_phy *phy;
> > +	int ret;
> > +
> > +	dev_info(dev, "Initializing i.MX28 USB Controller\n");
> 
> This is not (only) i.MX28

Let's keep it like that until we get further testing on other platforms.

> 
> > +
> > +	if (!data) {
> > +		dev_err(dev, "USB Host platform data missing!\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	/* Create HCD controller instance. */
> > +	hcd = usb_create_hcd(&ehci_mxs_hc_driver, dev, dev_name(dev));
> > +	if (!hcd) {
> > +		dev_err(dev, "Failed to create HCD instance!\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	hcd->rsrc_start = data->mem_res->start;
> > +	hcd->rsrc_len = resource_size(data->mem_res);
> > +	hcd->regs = data->mem;
> > +	hcd->irq = data->irq;
> > +
> > +	clk_enable(data->clk);
> 
> The clock shouldn't be here. move this to imx-otg.c

I see.

> 
> > +
> > +	/* Wait for the controller to stabilize. */
> > +	mdelay(10);
> > +
> > +	ehci = hcd_to_ehci(hcd);
> > +
> > +	/* EHCI registers start at offset 0x100 */
> > +	ehci->caps = hcd->regs + 0x100;
> > +	ehci->regs = hcd->regs + 0x100 +
> > +		HC_LENGTH(ehci, ehci_readl(ehci, &ehci->caps->hc_capbase));
> > +
> > +	platform_set_drvdata(pdev, hcd);
> > +
> > +	/* Initialize the transceiver */
> > +#ifdef CONFIG_USB_OTG_UTILS
> > +	phy = usb_get_transceiver();
> > +	if (!phy) {
> > +		dev_err(dev, "Unable to find transceiver.\n");
> > +		ret = -ENODEV;
> > +		goto err_phy;
> > +	}
> > +
> > +	ret = otg_set_host(phy->otg, &hcd->self);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Unable to set transceiver host\n");
> > +		ret = -ENODEV;
> > +		goto err_phy_set_host;
> > +	}
> > +
> > +	ret = usb_phy_init(phy);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Unable init transceiver\n");
> > +		ret = -ENODEV;
> > +		goto err_phy_init;
> > +	}
> > +#else
> > +	dev_info(dev, "USB_MXS_PHY must have CONFIG_USB_OTG_UTILS enabled\n");
> > +	goto err_phy;
> > +#endif
> 
> If your code does not work without CONFIG_USB_OTG_UTILS then why doesn't
> the driver depend on this option?
> It doesn't matter, all code inside these ifdefs should go to imx-otg.c.

Again, you mean imx-usb (the driver registering ehci host) or mxs-usb-phy? 
Either way, why should it be moved there, why shouldn't it sit in this file? Can 
you elaborate?

> > +
> > +	/* Set up the PORTSCx register */
> > +	ehci_writel(ehci, 0, &ehci->regs->port_status[0]);
> > +
> 
> Should also be in imx-otg.c

This is clearly EHCI thing, why?

> > +err_phy_init:
> > +err_phy_set_host:
> > +#ifdef CONFIG_USB_OTG_UTILS
> > +	if (phy)
> > +		usb_put_transceiver(phy);
> > +#endif
> > +err_phy:
> > +	clk_disable(data->clk);
> > +	usb_put_hcd(hcd);
> > +	return ret;
> > +}
> > +
> > +static int __exit ehci_mxs_drv_remove(struct platform_device *pdev)
> > +{
> > +	struct imx_usb *data = pdev->dev.platform_data;
> > +	struct usb_hcd *hcd = platform_get_drvdata(pdev);
> > +	struct usb_phy *phy = usb_get_transceiver();
> > +
> > +	if (phy)
> > +		usb_phy_shutdown(phy);
> > +
> > +	usb_remove_hcd(hcd);
> 
> usb_add_hcd is in imx-otg.c so usb_remove_hcd should be aswell.

Why would that be?

> Sascha

Best regards,
Marek Vasut
