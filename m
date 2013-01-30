From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 30 Jan 2013 10:06:28 +0800
Subject: [PATCH,RFC] usb: add devicetree helpers for determining
 dr_mode and phy_type
In-Reply-To: <87pq0omcfb.fsf@ashishki-desk.ger.corp.intel.com>
References: <1359458548-25071-1-git-send-email-s.hauer@pengutronix.de>
 <87pq0omcfb.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20130130020627.GA699@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 01:55:04PM +0200, Alexander Shishkin wrote:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> > From: Michael Grzeschik <m.grzeschik@pengutronix.de>
> >
> > This adds two little devicetree helper functions for determining the
> > dr_mode (host, peripheral, otg) and phy_type (utmi, ulpi,...) from
> > the devicetree.
> >
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > ---
> >
> > The properties and their values have been taken from the fsl-mph-dr driver.
> > This binding is also documented (though currently not used) for the tegra
> > ehci driver (Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt).
> > This is a first attempt to parse these bindings at a common place so that
> > others can make use of it.
> >
> > Basically I want to know whether this binding is recommended for new drivers
> > since normally the devicetree uses '-' instead of '_', and maybe there are
> > other problems with it.
> >
> > I need this binding for the chipidea driver. I suspect that the fsl-mph-dr
> > driver also really handles a chipidea core.
> 
> As far as I know, it is a chipidea core. Adding Peter to Cc list, he can
> probably confirm.

The fsl-mph-dr can't be used for chipdiea as it handles three platform
drivers for three roles (peripheral , host, otg). But chipidea only has
two platform drivers, one is the chipidea core, the other is related
controller wrapper.

However, two common helpers are useful, dr_mode can override controller
capability, and using user defined controller operation mode.
phy_type can be used at controller initialization to set phy's type at
controller's register, eg, for chipidea code, there is a PTS
(Parallel Transceiver Select) domain at portsc to set phy's type.

> 
> > Should we agree on this I would convert the fsl-mph-dr driver to use these
> > helpers.
> >
> > Sascha
> >
> >  drivers/usb/core/Makefile |    1 +
> >  drivers/usb/core/of.c     |   76 +++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/usb/of.h    |   22 +++++++++++++
> >  include/linux/usb/phy.h   |    9 ++++++
> >  4 files changed, 108 insertions(+)
> >  create mode 100644 drivers/usb/core/of.c
> >  create mode 100644 include/linux/usb/of.h
> >
> > diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
> > index 26059b9..5378add 100644
> > --- a/drivers/usb/core/Makefile
> > +++ b/drivers/usb/core/Makefile
> > @@ -10,5 +10,6 @@ usbcore-y += devio.o notify.o generic.o quirks.o devices.o
> >  
> >  usbcore-$(CONFIG_PCI)		+= hcd-pci.o
> >  usbcore-$(CONFIG_ACPI)		+= usb-acpi.o
> > +usbcore-$(CONFIG_OF)		+= of.o
> >  
> >  obj-$(CONFIG_USB)		+= usbcore.o
> > diff --git a/drivers/usb/core/of.c b/drivers/usb/core/of.c
> > new file mode 100644
> > index 0000000..d000d9f
> > --- /dev/null
> > +++ b/drivers/usb/core/of.c
> > @@ -0,0 +1,76 @@
> > +/*
> > + * OF helpers for usb devices.
> > + *
> > + * This file is released under the GPLv2
> > + *
> > + * Initially copied out of drivers/of/of_net.c
> > + */
> > +#include <linux/kernel.h>
> > +#include <linux/of.h>
> > +#include <linux/usb/of.h>
> > +#include <linux/usb/phy.h>
> > +#include <linux/export.h>
> > +
> > +static const char *usbphy_modes[] = {
> > +	[USBPHY_INTERFACE_MODE_NA]	= "",
> > +	[USBPHY_INTERFACE_MODE_UTMI]	= "utmi",
> > +	[USBPHY_INTERFACE_MODE_UTMIW]	= "utmi_wide",
> > +	[USBPHY_INTERFACE_MODE_ULPI]	= "ulpi",
> > +	[USBPHY_INTERFACE_MODE_SERIAL]	= "serial",
> > +	[USBPHY_INTERFACE_MODE_HSIC]	= "hsic",
> > +};
> > +
> > +/**
> > + * of_get_usbphy_mode - Get phy mode for given device_node
> > + * @np:	Pointer to the given device_node
> > + *
> > + * The function gets phy interface string from property 'phy_type',
> > + * and returns the correspondig enum usb_phy_interface
> > + */
> > +enum usb_phy_interface of_usb_get_phy_mode(struct device_node *np)
> > +{
> > +	const char *phy_type;
> > +	int err, i;
> > +
> > +	err = of_property_read_string(np, "phy_type", &phy_type);
> > +	if (err < 0)
> > +		return USBPHY_INTERFACE_MODE_NA;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(usbphy_modes); i++)
> > +		if (!strcasecmp(phy_type, usbphy_modes[i]))
> > +			return i;
> > +
> > +	return USBPHY_INTERFACE_MODE_NA;
> > +}
> > +EXPORT_SYMBOL_GPL(of_usb_get_phy_mode);
> > +
> > +static const char *usb_dr_modes[] = {
> > +	[USB_DR_MODE_UNKNOWN]		= "",
> > +	[USB_DR_MODE_HOST]		= "host",
> > +	[USB_DR_MODE_PERIPHERAL]	= "peripheral",
> > +	[USB_DR_MODE_OTG]		= "otg",
> > +};
> > +
> > +/**
> > + * of_usb_get_dr_mode - Get dual role mode for given device_node
> > + * @np:	Pointer to the given device_node
> > + *
> > + * The function gets phy interface string from property 'dr_mode',
> > + * and returns the correspondig enum usb_phy_dr_mode
> > + */
> > +enum usb_phy_dr_mode of_usb_get_dr_mode(struct device_node *np)
> > +{
> > +	const char *dr_mode;
> > +	int err, i;
> > +
> > +	err = of_property_read_string(np, "dr_mode", &dr_mode);
> > +	if (err < 0)
> > +		return USB_DR_MODE_UNKNOWN;
> > +
> > +	for (i = 0; i < ARRAY_SIZE(usb_dr_modes); i++)
> > +		if (!strcasecmp(dr_mode, usb_dr_modes[i]))
> > +			return i;
> > +
> > +	return USB_DR_MODE_UNKNOWN;
> > +}
> > +EXPORT_SYMBOL_GPL(of_usb_get_dr_mode);
> > diff --git a/include/linux/usb/of.h b/include/linux/usb/of.h
> > new file mode 100644
> > index 0000000..582ba96
> > --- /dev/null
> > +++ b/include/linux/usb/of.h
> > @@ -0,0 +1,22 @@
> > +/*
> > + * OF helpers for usb devices.
> > + *
> > + * This file is released under the GPLv2
> > + */
> > +
> > +#ifndef __LINUX_USB_OF_H
> > +#define __LINUX_USB_OF_H
> > +
> > +#include <linux/usb/phy.h>
> > +
> > +enum usb_phy_dr_mode {
> > +	USB_DR_MODE_UNKNOWN,
> > +	USB_DR_MODE_HOST,
> > +	USB_DR_MODE_PERIPHERAL,
> > +	USB_DR_MODE_OTG,
> > +};
> > +
> > +enum usb_phy_interface of_usb_get_phy_mode(struct device_node *np);
> > +enum usb_phy_dr_mode of_usb_get_dr_mode(struct device_node *np);
> > +
> > +#endif /* __LINUX_USB_OF_H */
> > diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
> > index a29ae1e..c5154cf 100644
> > --- a/include/linux/usb/phy.h
> > +++ b/include/linux/usb/phy.h
> > @@ -12,6 +12,15 @@
> >  #include <linux/notifier.h>
> >  #include <linux/usb.h>
> >  
> > +enum usb_phy_interface {
> > +	USBPHY_INTERFACE_MODE_NA,
> > +	USBPHY_INTERFACE_MODE_UTMI,
> > +	USBPHY_INTERFACE_MODE_UTMIW,
> > +	USBPHY_INTERFACE_MODE_ULPI,
> > +	USBPHY_INTERFACE_MODE_SERIAL,
> > +	USBPHY_INTERFACE_MODE_HSIC,
> > +};
> > +
> >  enum usb_phy_events {
> >  	USB_EVENT_NONE,         /* no events or cable disconnected */
> >  	USB_EVENT_VBUS,         /* vbus valid event */
> > -- 
> > 1.7.10.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Best Regards,
Peter Chen
