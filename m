From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Feb 2013 11:07:22 +0100
Subject: [PATCH 3/9] USB: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <20130214095822.GD15275@arwen.pp.htv.fi>
References: <1359984275-24646-1-git-send-email-s.hauer@pengutronix.de>
 <1359984275-24646-4-git-send-email-s.hauer@pengutronix.de>
 <87fw0zb5kk.fsf@ashishki-desk.ger.corp.intel.com>
 <511CB338.8070204@pengutronix.de>
 <20130214095822.GD15275@arwen.pp.htv.fi>
Message-ID: <20130214100722.GK1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 14, 2013 at 11:58:22AM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Thu, Feb 14, 2013 at 10:49:44AM +0100, Marc Kleine-Budde wrote:
> > >> diff --git a/drivers/usb/usb-common.c b/drivers/usb/usb-common.c
> > >> index d29503e..ad4d87d 100644
> > >> --- a/drivers/usb/usb-common.c
> > >> +++ b/drivers/usb/usb-common.c
> > >> @@ -14,6 +14,9 @@
> > >>  #include <linux/kernel.h>
> > >>  #include <linux/module.h>
> > >>  #include <linux/usb/ch9.h>
> > >> +#include <linux/of.h>
> > >> +#include <linux/usb/of.h>
> > >> +#include <linux/usb/otg.h>
> > >>  
> > >>  const char *usb_speed_string(enum usb_device_speed speed)
> > >>  {
> > >> @@ -32,4 +35,37 @@ const char *usb_speed_string(enum usb_device_speed speed)
> > >>  }
> > >>  EXPORT_SYMBOL_GPL(usb_speed_string);
> > >>  
> > >> +#ifdef CONFIG_OF
> > >> +static const char *usb_dr_modes[] = {
> > >> +	[USB_DR_MODE_UNKNOWN]		= "",
> > >> +	[USB_DR_MODE_HOST]		= "host",
> > >> +	[USB_DR_MODE_PERIPHERAL]	= "peripheral",
> > >> +	[USB_DR_MODE_OTG]		= "otg",
> > >> +};
> > > 
> > > It turns out this is a problem, especially since this is generic usb
> > > code: we have a chipidea controller (a patchset just arrived) that does
> > > both host and peripheral, but not otg. And I'm told now that dwc3
> > > controller can be synthesized like that too.
> 
> I wonder if this part is really necessary. Usually you would read it
> from HW's registers. For dwc3, it's quite recently that we allowed the
> driver to be built with host-only, device-only or DRD functionality.

We have quite some boards on which the ID pin is not wired up, so if a
core is both host and device capable there is no way to detect the
wanted mode if not given from the devicetree.

> 
> Also, this is likely to create troubles if not done correctly. Imagine
> user compiles a host-only driver and board passes dr_mode = peripheral ?

Either nothing will happen or some "you messed it up" printk should show
the user what's going on.

> 
> Maybe we can ignore dr_mode in host-only and device-only builds and only
> look at it for DRD builds ?

If something is or is not compiled in the kernel this doesn't mean the kernel
is not started on boards with a different situation.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
