From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 Feb 2013 21:36:26 +0200
Subject: [PATCH 3/9] USB: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <20130214183026.GW1906@pengutronix.de>
References: <87fw0zb5kk.fsf@ashishki-desk.ger.corp.intel.com>
 <511CB338.8070204@pengutronix.de>
 <20130214095822.GD15275@arwen.pp.htv.fi>
 <20130214100722.GK1906@pengutronix.de>
 <20130214101510.GA15537@arwen.pp.htv.fi>
 <20130214112449.GL1906@pengutronix.de>
 <20130214131015.GB27419@arwen.pp.htv.fi>
 <20130214160655.GT1906@pengutronix.de>
 <20130214180444.GD25891@arwen.pp.htv.fi>
 <20130214183026.GW1906@pengutronix.de>
Message-ID: <20130214193626.GE26679@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 14, 2013 at 07:30:26PM +0100, Sascha Hauer wrote:
> > > > yeah, this is why I said we should ignore dr_mode (or bail out) when
> > > > !OTG.
> > > 
> > > Ok, that's what the patch effectively does. We have this in chipidea/core.c:
> > > 
> > > | 	dr_mode = ci->platdata->dr_mode;
> > > | 	if (dr_mode == USB_DR_MODE_UNKNOWN)
> > > | 		dr_mode = USB_DR_MODE_OTG;
> > > 
> > > default to otg if nothing specified.
> > 
> > you missed my point. I wanted something like:
> > 
> > dr_mode = ci->platdata->dr_mode;
> > if ((dr_mode == USB_DR_MODE_UNKNOWN) || !IS_ENABLED(CONFIG_USB_CHIPIDEA_OTG)
> > 	dr_mode = USB_DR_MODE_OTG;
> 
> So everytime the chipidea driver cannot do OTG the driver falls back to
> exactly this mode?

hehe, that was me being stupid I meant something like:

if (!IS_ENABLED(HOST) && dr_mode == HOST)

or

if (!IS_ENABLED(GADGET) && dr_mode == GADGET)

in those cases, it's best to either force OTG (then driver will work
with whatever it has) or bail out.

Thinking a bit harder, it's best to bail as you can't be sure udc.c or
host.c have been compiled in.

> > this copes with the situation where dr_mode == USB_DR_MODE_HOST but
> > kernel is gadget-only.
> 
> When I specify dr_mode = USB_DR_MODE_HOST in the devicetree indicating
> that my board is only host capable I exactly want the driver to be in
> host mode for this device, or to bail out if the kernel does not have
> host support compiled in.

right.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130214/73f94c12/attachment.sig>
