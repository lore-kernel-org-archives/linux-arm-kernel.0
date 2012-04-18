From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 18 Apr 2012 22:43:01 +0200
Subject: [PATCH 08/10] MXS: Add separate MXS EHCI HCD driver
In-Reply-To: <201204182207.30516.marex@denx.de>
References: <1334714869-19282-1-git-send-email-marex@denx.de>
 <1334771194-18688-9-git-send-email-marex@denx.de>
 <20120418195033.GA3852@pengutronix.de>
 <201204182207.30516.marex@denx.de>
Message-ID: <20120418204301.GD3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 10:07:30PM +0200, Marek Vasut wrote:
> Dear Sascha Hauer,
> 
> > On Wed, Apr 18, 2012 at 07:46:32PM +0200, Marek Vasut wrote:
> > > This driver will handle i.MX233/i.MX28 and I hope soon i.MX6Q. I tried to
> > > keep this separate from the MXC EHCI to avoid further polution of the
> > > MXC EHCI, though eventually these two might be merged.
> > > 
> > > NOTE: I still haven't figured out how to enable/disable the disconnection
> > > detector, it can't be enabled all the time, so I toggle PHY stuff from
> > > this driver, which I doubt is correct.
> > 
> > [...]
> > 
> > > +static int ehci_mxs_drv_probe(struct platform_device *pdev)
> > > +{
> > > +	struct device *dev = &pdev->dev;
> > > +	struct imx_usb *data = pdev->dev.platform_data;
> > > +	struct usb_hcd *hcd;
> > > +	struct ehci_hcd *ehci;
> > > +	struct usb_phy *phy;
> > > +	int ret;
> > > +
> > > +	dev_info(dev, "Initializing i.MX28 USB Controller\n");
> > 
> > This is not (only) i.MX28
> 
> Let's keep it like that until we get further testing on other platforms.

I see no reason for doing that. It does work on all i.MX for sure.

> > > +		ret = -ENODEV;
> > > +		goto err_phy_init;
> > > +	}
> > > +#else
> > > +	dev_info(dev, "USB_MXS_PHY must have CONFIG_USB_OTG_UTILS enabled\n");
> > > +	goto err_phy;
> > > +#endif
> > 
> > If your code does not work without CONFIG_USB_OTG_UTILS then why doesn't
> > the driver depend on this option?
> > It doesn't matter, all code inside these ifdefs should go to imx-otg.c.
> 
> Again, you mean imx-usb (the driver registering ehci host) or mxs-usb-phy? 

I mean otg/imx-usb.c (and I'll stick with the name imx-otg)

> Either way, why should it be moved there, why shouldn't it sit in this file? Can 
> you elaborate?

It's the imx-otg driver that manages the state. It's the imx-otg driver
which knows how to configure the phy

> 
> > > +
> > > +	/* Set up the PORTSCx register */
> > > +	ehci_writel(ehci, 0, &ehci->regs->port_status[0]);
> > > +
> > 
> > Should also be in imx-otg.c
> 
> This is clearly EHCI thing, why?

This is not ehci specific. This is specific to the whole USB controller.
You have to set it up for device mode aswell, grep -i for portsc in
drivers/usb/gadget.

> > > +	struct usb_phy *phy = usb_get_transceiver();
> > > +
> > > +	if (phy)
> > > +		usb_phy_shutdown(phy);
> > > +
> > > +	usb_remove_hcd(hcd);
> > 
> > usb_add_hcd is in imx-otg.c so usb_remove_hcd should be aswell.
> 
> Why would that be?

Let me try to rephrase my intention:

We have to deal with a 2-in-1 device here, a usb host and a usb device
controller. Both share some resources, namely:

- the io space
- the clocks
- the interrupt
- while being a seperate device they both share the phy

Everything that is shared should be handled by imx-otg.c. Whenever
imx-otg.c detects host mode it passes control to the ehci driver. When
imx-otg.c detects that the device is unplugged then it should remove the
host via usb_remove_hcd. device mode would be similar.
For now we don't implement device mode and do not automatically detect
host/device mode which makes things simpler. Still the calls have to be
in the right place.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
