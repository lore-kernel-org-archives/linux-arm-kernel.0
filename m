From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 15 Feb 2013 11:54:10 +0100
Subject: [PATCH 3/9] USB: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <20130214193626.GE26679@arwen.pp.htv.fi>
References: <511CB338.8070204@pengutronix.de>
 <20130214095822.GD15275@arwen.pp.htv.fi>
 <20130214100722.GK1906@pengutronix.de>
 <20130214101510.GA15537@arwen.pp.htv.fi>
 <20130214112449.GL1906@pengutronix.de>
 <20130214131015.GB27419@arwen.pp.htv.fi>
 <20130214160655.GT1906@pengutronix.de>
 <20130214180444.GD25891@arwen.pp.htv.fi>
 <20130214183026.GW1906@pengutronix.de>
 <20130214193626.GE26679@arwen.pp.htv.fi>
Message-ID: <20130215105410.GN1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 09:36:26PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Feb 14, 2013 at 07:30:26PM +0100, Sascha Hauer wrote:
> > > > > yeah, this is why I said we should ignore dr_mode (or bail out) when
> > > > > !OTG.
> > > > 
> > > > Ok, that's what the patch effectively does. We have this in chipidea/core.c:
> > > > 
> > > > | 	dr_mode = ci->platdata->dr_mode;
> > > > | 	if (dr_mode == USB_DR_MODE_UNKNOWN)
> > > > | 		dr_mode = USB_DR_MODE_OTG;
> > > > 
> > > > default to otg if nothing specified.
> > > 
> > > you missed my point. I wanted something like:
> > > 
> > > dr_mode = ci->platdata->dr_mode;
> > > if ((dr_mode == USB_DR_MODE_UNKNOWN) || !IS_ENABLED(CONFIG_USB_CHIPIDEA_OTG)
> > > 	dr_mode = USB_DR_MODE_OTG;
> > 
> > So everytime the chipidea driver cannot do OTG the driver falls back to
> > exactly this mode?
> 
> hehe, that was me being stupid I meant something like:
> 
> if (!IS_ENABLED(HOST) && dr_mode == HOST)
> 
> or
> 
> if (!IS_ENABLED(GADGET) && dr_mode == GADGET)
> 
> in those cases, it's best to either force OTG (then driver will work
> with whatever it has) or bail out.
> 
> Thinking a bit harder, it's best to bail as you can't be sure udc.c or
> host.c have been compiled in.

Look again, that's what the current code does. Maybe it's not coded as
explicit as you describe above.

| 	/* initialize role(s) before the interrupt is requested */
| 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
| 		ret = ci_hdrc_host_init(ci);
| 		if (ret)
| 			dev_info(dev, "doesn't support host\n");
| 	}

if IS_ENABLED(HOST), then ci_hdrc_host_init() will set
ci->roles[CI_ROLE_HOST] in case it manages to initialize the host driver.

if !IS_ENABLED(HOST), then ci_hdrc_host_init() will be a static inline
noop function, so ci->roles[CI_ROLE_HOST] ends up being NULL.

| 
| 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
| 		ret = ci_hdrc_gadget_init(ci);
| 		if (ret)
| 			dev_info(dev, "doesn't support gadget\n");
| 	}

Same applies for gadget.

| 
| 	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
| 		dev_err(dev, "no supported roles\n");
| 		ret = -ENODEV;
| 		goto rm_wq;
| 	}

At this point (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET])
means that the intersection of what is requested and what we are able to
do is empty. The reasons could be That the requested mode is not compiled
into the kernel, or the requested role failed to initialize.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
