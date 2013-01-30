From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 30 Jan 2013 11:11:02 +0100
Subject: [PATCH,RFC] usb: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <5108B4E7.4020505@ti.com>
References: <1359458548-25071-1-git-send-email-s.hauer@pengutronix.de>
 <5107D253.5030400@ti.com> <20130129203050.GT1906@pengutronix.de>
 <5108B4E7.4020505@ti.com>
Message-ID: <20130130101102.GV1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 11:21:35AM +0530, kishon wrote:
> On Wednesday 30 January 2013 02:00 AM, Sascha Hauer wrote:
> >On Tue, Jan 29, 2013 at 07:14:51PM +0530, kishon wrote:
> >>Hi,
> >>
> >>On Tuesday 29 January 2013 04:52 PM, Sascha Hauer wrote:
> >>>From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> >>>
> >>>This adds two little devicetree helper functions for determining the
> >>>dr_mode (host, peripheral, otg) and phy_type (utmi, ulpi,...) from
> >>>the devicetree.
> >>>
> >>>Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> >>>Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >>>---
> >>>
> >>>The properties and their values have been taken from the fsl-mph-dr driver.
> >>>This binding is also documented (though currently not used) for the tegra
> >>>ehci driver (Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt).
> >>>This is a first attempt to parse these bindings at a common place so that
> >>>others can make use of it.
> >>>
> >>>Basically I want to know whether this binding is recommended for new drivers
> >>>since normally the devicetree uses '-' instead of '_', and maybe there are
> >>>other problems with it.
> >>>
> >>>I need this binding for the chipidea driver. I suspect that the fsl-mph-dr
> >>>driver also really handles a chipidea core.
> >>>
> >>>Should we agree on this I would convert the fsl-mph-dr driver to use these
> >>>helpers.
> >>>
> >>>Sascha
> >>>
> >>>  drivers/usb/core/Makefile |    1 +
> >>>  drivers/usb/core/of.c     |   76 +++++++++++++++++++++++++++++++++++++++++++++
> >>
> >>This file should ideally go into drivers/usb/phy/.
> >
> >I originally wanted to do that, but the host/peripheral/otg property is
> >not phy specific. DO you still want to move it there?
> 
> I think then you can just move of_usb_get_phy_mode() to phy/of.c.
> Then we can also move some functions defined in otg.c (specific to
> PHY and dt) to phy/of.c.

The phy specific stuff in otg.c can't easily be moved as all functions
operate on a static list and spinlock. Also nothing in otg/otg.c is
currently of specific.

What about the dr_mode helper? Moving it to otg/ would mean that all
users which want to use it would have to select USB_OTG_UTILS. At least
the fsl mph driver currently does not need USB_OTG_UTILS.

ATM I'm feeling like killing USB_OTG_UTILS completely, that would make
things easier.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
