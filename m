From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Feb 2013 12:24:49 +0100
Subject: [PATCH 3/9] USB: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <20130214101510.GA15537@arwen.pp.htv.fi>
References: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
 <1359984275-24646-4-git-send-email-s.hauer@pengutronix.de>
 <87fw0zb5kk.fsf@ashishki-desk.ger.corp.intel.com>
 <511CB338.8070204@pengutronix.de>
 <20130214095822.GD15275@arwen.pp.htv.fi>
 <20130214100722.GK1906@pengutronix.de>
 <20130214101510.GA15537@arwen.pp.htv.fi>
Message-ID: <20130214112449.GL1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 12:15:10PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Feb 14, 2013 at 11:07:22AM +0100, Sascha Hauer wrote:
> > > > >> @@ -32,4 +35,37 @@ const char *usb_speed_string(enum usb_device_speed speed)
> > > > >>  }
> > > > >>  EXPORT_SYMBOL_GPL(usb_speed_string);
> > > > >>  
> > > > >> +#ifdef CONFIG_OF
> > > > >> +static const char *usb_dr_modes[] = {
> > > > >> +	[USB_DR_MODE_UNKNOWN]		= "",
> > > > >> +	[USB_DR_MODE_HOST]		= "host",
> > > > >> +	[USB_DR_MODE_PERIPHERAL]	= "peripheral",
> > > > >> +	[USB_DR_MODE_OTG]		= "otg",
> > > > >> +};
> > > > > 
> > > > > It turns out this is a problem, especially since this is generic usb
> > > > > code: we have a chipidea controller (a patchset just arrived) that does
> > > > > both host and peripheral, but not otg. And I'm told now that dwc3
> > > > > controller can be synthesized like that too.
> > > 
> > > I wonder if this part is really necessary. Usually you would read it
> > > from HW's registers. For dwc3, it's quite recently that we allowed the
> > > driver to be built with host-only, device-only or DRD functionality.
> > 
> > We have quite some boards on which the ID pin is not wired up, so if a
> > core is both host and device capable there is no way to detect the
> > wanted mode if not given from the devicetree.
> 
> right, that's fair. But that doesn't mean board can't work as both,
> right. The IP is still the same, just the board is wired differently ;-)

Yes, it is. Usually I run kernels with both host and device support enabled.
Consider the IP is OTG capable, the chipidea driver will initialize
both roles. Now if a board only supports one role and does not have an
ID pin, how do I make sure the driver is in the correct mode? I need to
specify it somehow. Otherwise I may end up on a host-only board with the
driver sitting in device mode, or with a device-only board with the
driver sitting in host mode.

> 
> > > Maybe we can ignore dr_mode in host-only and device-only builds and only
> > > look at it for DRD builds ?
> > 
> > If something is or is not compiled in the kernel this doesn't mean the kernel
> > is not started on boards with a different situation.
> 
> who said kernel wouldn't start ? If you request a host-only build, you
> need to force your IP into working as host, since that's all you have,
> either that or you bail out on probe().

Let me clarify, I don't want to use Kconfig to specify my boards
capabilities. If a kernel is compiled for host mode only and the
devicetree specifies a port is device-only, then yes, the driver
should bail out on probe, maybe leaving a message that it found
a device for which the suitable role is not compiled in.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
