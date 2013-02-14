From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Feb 2013 12:15:10 +0200
Subject: [PATCH 3/9] USB: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <20130214100722.GK1906@pengutronix.de>
References: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
 <1359984275-24646-4-git-send-email-s.hauer@pengutronix.de>
 <87fw0zb5kk.fsf@ashishki-desk.ger.corp.intel.com>
 <511CB338.8070204@pengutronix.de>
 <20130214095822.GD15275@arwen.pp.htv.fi>
 <20130214100722.GK1906@pengutronix.de>
Message-ID: <20130214101510.GA15537@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 14, 2013 at 11:07:22AM +0100, Sascha Hauer wrote:
> > > >> @@ -32,4 +35,37 @@ const char *usb_speed_string(enum usb_device_speed speed)
> > > >>  }
> > > >>  EXPORT_SYMBOL_GPL(usb_speed_string);
> > > >>  
> > > >> +#ifdef CONFIG_OF
> > > >> +static const char *usb_dr_modes[] = {
> > > >> +	[USB_DR_MODE_UNKNOWN]		= "",
> > > >> +	[USB_DR_MODE_HOST]		= "host",
> > > >> +	[USB_DR_MODE_PERIPHERAL]	= "peripheral",
> > > >> +	[USB_DR_MODE_OTG]		= "otg",
> > > >> +};
> > > > 
> > > > It turns out this is a problem, especially since this is generic usb
> > > > code: we have a chipidea controller (a patchset just arrived) that does
> > > > both host and peripheral, but not otg. And I'm told now that dwc3
> > > > controller can be synthesized like that too.
> > 
> > I wonder if this part is really necessary. Usually you would read it
> > from HW's registers. For dwc3, it's quite recently that we allowed the
> > driver to be built with host-only, device-only or DRD functionality.
> 
> We have quite some boards on which the ID pin is not wired up, so if a
> core is both host and device capable there is no way to detect the
> wanted mode if not given from the devicetree.

right, that's fair. But that doesn't mean board can't work as both,
right. The IP is still the same, just the board is wired differently ;-)

> > Maybe we can ignore dr_mode in host-only and device-only builds and only
> > look at it for DRD builds ?
> 
> If something is or is not compiled in the kernel this doesn't mean the kernel
> is not started on boards with a different situation.

who said kernel wouldn't start ? If you request a host-only build, you
need to force your IP into working as host, since that's all you have,
either that or you bail out on probe().

If board wants to work as a device, well tough luck, go figure how to
setup Kconfig properly.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130214/dd70023d/attachment.sig>
