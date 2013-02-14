From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Feb 2013 19:30:26 +0100
Subject: [PATCH 3/9] USB: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <20130214180444.GD25891@arwen.pp.htv.fi>
References: <1359984275-24646-4-git-send-email-s.hauer@pengutronix.de>
 <87fw0zb5kk.fsf@ashishki-desk.ger.corp.intel.com>
 <511CB338.8070204@pengutronix.de>
 <20130214095822.GD15275@arwen.pp.htv.fi>
 <20130214100722.GK1906@pengutronix.de>
 <20130214101510.GA15537@arwen.pp.htv.fi>
 <20130214112449.GL1906@pengutronix.de>
 <20130214131015.GB27419@arwen.pp.htv.fi>
 <20130214160655.GT1906@pengutronix.de>
 <20130214180444.GD25891@arwen.pp.htv.fi>
Message-ID: <20130214183026.GW1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 08:04:44PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Feb 14, 2013 at 05:06:55PM +0100, Sascha Hauer wrote:
> > > > > > > Maybe we can ignore dr_mode in host-only and device-only builds and only
> > > > > > > look at it for DRD builds ?
> > > > > > 
> > > > > > If something is or is not compiled in the kernel this doesn't mean the kernel
> > > > > > is not started on boards with a different situation.
> > > > > 
> > > > > who said kernel wouldn't start ? If you request a host-only build, you
> > > > > need to force your IP into working as host, since that's all you have,
> > > > > either that or you bail out on probe().
> > > > 
> > > > Let me clarify, I don't want to use Kconfig to specify my boards
> > > > capabilities. If a kernel is compiled for host mode only and the
> > > > devicetree specifies a port is device-only, then yes, the driver
> > > > should bail out on probe, maybe leaving a message that it found
> > > > a device for which the suitable role is not compiled in.
> > > 
> > > yeah, this is why I said we should ignore dr_mode (or bail out) when
> > > !OTG.
> > 
> > Ok, that's what the patch effectively does. We have this in chipidea/core.c:
> > 
> > | 	dr_mode = ci->platdata->dr_mode;
> > | 	if (dr_mode == USB_DR_MODE_UNKNOWN)
> > | 		dr_mode = USB_DR_MODE_OTG;
> > 
> > default to otg if nothing specified.
> 
> you missed my point. I wanted something like:
> 
> dr_mode = ci->platdata->dr_mode;
> if ((dr_mode == USB_DR_MODE_UNKNOWN) || !IS_ENABLED(CONFIG_USB_CHIPIDEA_OTG)
> 	dr_mode = USB_DR_MODE_OTG;

So everytime the chipidea driver cannot do OTG the driver falls back to
exactly this mode?

> 
> this copes with the situation where dr_mode == USB_DR_MODE_HOST but
> kernel is gadget-only.

When I specify dr_mode = USB_DR_MODE_HOST in the devicetree indicating
that my board is only host capable I exactly want the driver to be in
host mode for this device, or to bail out if the kernel does not have
host support compiled in.

Sorry, I still don't get it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
