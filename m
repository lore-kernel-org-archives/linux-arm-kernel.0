From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 18 Apr 2012 09:02:23 +0200
Subject: [RFC PATCH 0/8] MXS: Add i.MX28 USB Host driver
In-Reply-To: <201204172229.22062.marex@denx.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
 <201204171345.07851.marex@denx.de>
 <20120417121800.GB3852@pengutronix.de>
 <201204172229.22062.marex@denx.de>
Message-ID: <20120418070223.GJ3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 10:29:21PM +0200, Marek Vasut wrote:
> > > 
> > > So the PHY actually registers the EHCI driver (plat_bus->phy->ehci)?
> > > That's slightly weird, don't you think?
> > 
> > Your hardware device is a device consisting of a ehci core and a USB device
> > core. Currently we register the child devices independently which leads
> > to the mentioned problems. Instead we should register the USB core as a
> > whole and pass the resources to either the client or the host driver.
> 
> Ok, giving it a second thought -- you mean to create "stub" driver, which claims 
> and toggles the clock _and_ registers both the EHCI host driver and PHY driver 
> under itself in the hierarchy. Is that correct?

No, the registration of the phy is fine the way it is. The stub driver
should only register the ehci and the usb device. Maybe some pseudo code
helps describing what I mean:

arch/arm/mach-mxs:

	mx28_register_usbphy0();
	mx28_register_usb0();

drivers/usb/otg/mxs-otg.c:

	probe() {
		clk_get();
		clk_prepare_enable();

		usb_get_phy(&pdev->dev);

		if (pdata->mode == USB_OTG_MODE_HOST)
			usb_add_hcd(priv->host);
		else
			usb_gadget_vbus_connect(priv->gadget);
	}

	module_platform_driver(mxs_otg_driver);

drivers/usb/otg/mxs-otg-phy.c:

	probe() {
		clk_get();
		clk_prepare_enable();
		usb_register_phy(phy, "mxs-otg.0");
	}

	module_platform_driver(mxs_otg_phy_driver);


The mxs-otg part can be reused on i.MX aswell, whereas mxs-otg-phy is
mxs (and i.MX6 how we just learned) specific.
What currently is missing is a usb_get_phy() with a device argument to
get the phy specific to a device. That's a problem, but you currently
have it aswell with your current approach

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
