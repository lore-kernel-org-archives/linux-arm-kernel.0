From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 29 Jan 2013 21:30:50 +0100
Subject: [PATCH,RFC] usb: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <5107D253.5030400@ti.com>
References: <1359458548-25071-1-git-send-email-s.hauer@pengutronix.de>
 <5107D253.5030400@ti.com>
Message-ID: <20130129203050.GT1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 07:14:51PM +0530, kishon wrote:
> Hi,
> 
> On Tuesday 29 January 2013 04:52 PM, Sascha Hauer wrote:
> >From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> >
> >This adds two little devicetree helper functions for determining the
> >dr_mode (host, peripheral, otg) and phy_type (utmi, ulpi,...) from
> >the devicetree.
> >
> >Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> >Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> >---
> >
> >The properties and their values have been taken from the fsl-mph-dr driver.
> >This binding is also documented (though currently not used) for the tegra
> >ehci driver (Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt).
> >This is a first attempt to parse these bindings at a common place so that
> >others can make use of it.
> >
> >Basically I want to know whether this binding is recommended for new drivers
> >since normally the devicetree uses '-' instead of '_', and maybe there are
> >other problems with it.
> >
> >I need this binding for the chipidea driver. I suspect that the fsl-mph-dr
> >driver also really handles a chipidea core.
> >
> >Should we agree on this I would convert the fsl-mph-dr driver to use these
> >helpers.
> >
> >Sascha
> >
> >  drivers/usb/core/Makefile |    1 +
> >  drivers/usb/core/of.c     |   76 +++++++++++++++++++++++++++++++++++++++++++++
> 
> This file should ideally go into drivers/usb/phy/.

I originally wanted to do that, but the host/peripheral/otg property is
not phy specific. DO you still want to move it there?

> >  include/linux/usb/of.h    |   22 +++++++++++++
> >  include/linux/usb/phy.h   |    9 ++++++
> >  4 files changed, 108 insertions(+)
> >  create mode 100644 drivers/usb/core/of.c
> >  create mode 100644 include/linux/usb/of.h
> >
> >diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
> >index 26059b9..5378add 100644
> >--- a/drivers/usb/core/Makefile
> >+++ b/drivers/usb/core/Makefile
> >@@ -10,5 +10,6 @@ usbcore-y += devio.o notify.o generic.o quirks.o devices.o
> >
> >  usbcore-$(CONFIG_PCI)		+= hcd-pci.o
> >  usbcore-$(CONFIG_ACPI)		+= usb-acpi.o
> >+usbcore-$(CONFIG_OF)		+= of.o
> 
> No Kconfig? Shouldn't this file be compiled only when some one is
> going to use the PHY?

Yes. Just skipped that for the first shot.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
