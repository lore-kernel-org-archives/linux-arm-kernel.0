From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 1 Feb 2013 07:58:34 +0100
Subject: [PATCH,RFC] usb: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <20130201011153.GE14629@nchen-desktop>
References: <1359458548-25071-1-git-send-email-s.hauer@pengutronix.de>
 <87pq0omcfb.fsf@ashishki-desk.ger.corp.intel.com>
 <20130130020627.GA699@nchen-desktop>
 <20130130140015.GZ1906@pengutronix.de>
 <20130131020542.GD9777@nchen-desktop>
 <20130131102913.GA6937@pengutronix.de>
 <20130201011153.GE14629@nchen-desktop>
Message-ID: <20130201065833.GV1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 09:11:54AM +0800, Peter Chen wrote:
> On Thu, Jan 31, 2013 at 11:29:13AM +0100, Sascha Hauer wrote:
> > On Thu, Jan 31, 2013 at 10:05:44AM +0800, Peter Chen wrote:
> > > On Wed, Jan 30, 2013 at 03:00:15PM +0100, Sascha Hauer wrote:
> > > > On Wed, Jan 30, 2013 at 10:06:28AM +0800, Peter Chen wrote:
> > > > > On Tue, Jan 29, 2013 at 01:55:04PM +0200, Alexander Shishkin wrote:
> > > > > > Sascha Hauer <s.hauer@pengutronix.de> writes:
> > > > > > 
> > > > > > > From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > > > > > >
> > > > > > > This adds two little devicetree helper functions for determining the
> > > > > > > dr_mode (host, peripheral, otg) and phy_type (utmi, ulpi,...) from
> > > > > > > the devicetree.
> > > > > > >
> > > > > > > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > > > > > > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > > > > > ---
> > > > > > >
> > > > > > > The properties and their values have been taken from the fsl-mph-dr driver.
> > > > > > > This binding is also documented (though currently not used) for the tegra
> > > > > > > ehci driver (Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt).
> > > > > > > This is a first attempt to parse these bindings at a common place so that
> > > > > > > others can make use of it.
> > > > > > >
> > > > > > > Basically I want to know whether this binding is recommended for new drivers
> > > > > > > since normally the devicetree uses '-' instead of '_', and maybe there are
> > > > > > > other problems with it.
> > > > > > >
> > > > > > > I need this binding for the chipidea driver. I suspect that the fsl-mph-dr
> > > > > > > driver also really handles a chipidea core.
> > > > > > 
> > > > > > As far as I know, it is a chipidea core. Adding Peter to Cc list, he can
> > > > > > probably confirm.
> > > > > 
> > > > > The fsl-mph-dr can't be used for chipdiea as it handles three platform
> > > > > drivers for three roles (peripheral , host, otg). But chipidea only has
> > > > > two platform drivers, one is the chipidea core, the other is related
> > > > > controller wrapper.
> > > > 
> > > > What do you mean by 'three platform drivers'? That's only how the driver
> > > > is built, no? I was talking about the hardware the fsl-mph-dr driver
> > > > handles which definitely smells like chipidea.
> > > 
> > > It creates host/device/otg platform device according to dr_mode from
> > > the device tree.
> > 
> > Again, that's software specific. What I'd like to know is whether the
> > *hardware* could be handled by the chipidea driver.
> not understand u, you mean the DT information at there? Those DT information
> may not be used for i.mx hardware.

The original question was:

There is a driver in the tree called fsl-mph-dr-of.c. Does this driver
handle a hardware which is compatible to the hardware the chipidea
driver handles?

I think the answer is yes, because said driver registers a ehci device,
or fsl-usb2-udc device (the same we used on i.MX). This hardware also
has a PORTSC register. All this seems to suggest that

drivers/usb/host/fsl-mph-dr-of.c
drivers/usb/host/ehci-fsl.c
drivers/usb/otg/fsl_otg.c
drivers/usb/gadget/fsl_usb2_udc.h
drivers/usb/gadget/fsl_udc_core.c

Could be replaced by the chipidea driver.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
