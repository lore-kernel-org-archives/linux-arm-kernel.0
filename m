From: kishon@ti.com (kishon)
Date: Tue, 29 Jan 2013 19:14:51 +0530
Subject: [PATCH,RFC] usb: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <1359458548-25071-1-git-send-email-s.hauer@pengutronix.de>
References: <1359458548-25071-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <5107D253.5030400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 29 January 2013 04:52 PM, Sascha Hauer wrote:
> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
>
> This adds two little devicetree helper functions for determining the
> dr_mode (host, peripheral, otg) and phy_type (utmi, ulpi,...) from
> the devicetree.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>
> The properties and their values have been taken from the fsl-mph-dr driver.
> This binding is also documented (though currently not used) for the tegra
> ehci driver (Documentation/devicetree/bindings/usb/nvidia,tegra20-ehci.txt).
> This is a first attempt to parse these bindings at a common place so that
> others can make use of it.
>
> Basically I want to know whether this binding is recommended for new drivers
> since normally the devicetree uses '-' instead of '_', and maybe there are
> other problems with it.
>
> I need this binding for the chipidea driver. I suspect that the fsl-mph-dr
> driver also really handles a chipidea core.
>
> Should we agree on this I would convert the fsl-mph-dr driver to use these
> helpers.
>
> Sascha
>
>   drivers/usb/core/Makefile |    1 +
>   drivers/usb/core/of.c     |   76 +++++++++++++++++++++++++++++++++++++++++++++

This file should ideally go into drivers/usb/phy/.
>   include/linux/usb/of.h    |   22 +++++++++++++
>   include/linux/usb/phy.h   |    9 ++++++
>   4 files changed, 108 insertions(+)
>   create mode 100644 drivers/usb/core/of.c
>   create mode 100644 include/linux/usb/of.h
>
> diff --git a/drivers/usb/core/Makefile b/drivers/usb/core/Makefile
> index 26059b9..5378add 100644
> --- a/drivers/usb/core/Makefile
> +++ b/drivers/usb/core/Makefile
> @@ -10,5 +10,6 @@ usbcore-y += devio.o notify.o generic.o quirks.o devices.o
>
>   usbcore-$(CONFIG_PCI)		+= hcd-pci.o
>   usbcore-$(CONFIG_ACPI)		+= usb-acpi.o
> +usbcore-$(CONFIG_OF)		+= of.o

No Kconfig? Shouldn't this file be compiled only when some one is going 
to use the PHY?
>
>   obj-$(CONFIG_USB)		+= usbcore.o
> diff --git a/drivers/usb/core/of.c b/drivers/usb/core/of.c
> new file mode 100644
> index 0000000..d000d9f
> --- /dev/null
> +++ b/drivers/usb/core/of.c
> @@ -0,0 +1,76 @@
> +/*
> + * OF helpers for usb devices.
> + *
> + * This file is released under the GPLv2
> + *
> + * Initially copied out of drivers/of/of_net.c
> + */
> +#include <linux/kernel.h>
> +#include <linux/of.h>
> +#include <linux/usb/of.h>
> +#include <linux/usb/phy.h>
> +#include <linux/export.h>
> +
> +static const char *usbphy_modes[] = {
> +	[USBPHY_INTERFACE_MODE_NA]	= "",
> +	[USBPHY_INTERFACE_MODE_UTMI]	= "utmi",
> +	[USBPHY_INTERFACE_MODE_UTMIW]	= "utmi_wide",
> +	[USBPHY_INTERFACE_MODE_ULPI]	= "ulpi",
> +	[USBPHY_INTERFACE_MODE_SERIAL]	= "serial",
> +	[USBPHY_INTERFACE_MODE_HSIC]	= "hsic",
> +};
> +
> +/**
> + * of_get_usbphy_mode - Get phy mode for given device_node
> + * @np:	Pointer to the given device_node
> + *
> + * The function gets phy interface string from property 'phy_type',
> + * and returns the correspondig enum usb_phy_interface
> + */
> +enum usb_phy_interface of_usb_get_phy_mode(struct device_node *np)
> +{
> +	const char *phy_type;
> +	int err, i;
> +
> +	err = of_property_read_string(np, "phy_type", &phy_type);
> +	if (err < 0)
> +		return USBPHY_INTERFACE_MODE_NA;

Why don't we use a u32 property type for the *phy-type*? IMHO we should 
use string property only when the property should be absolutely 
unambiguous (e.g., compatible property should be string).

> +
> +	for (i = 0; i < ARRAY_SIZE(usbphy_modes); i++)
> +		if (!strcasecmp(phy_type, usbphy_modes[i]))
> +			return i;
> +
> +	return USBPHY_INTERFACE_MODE_NA;
> +}
> +EXPORT_SYMBOL_GPL(of_usb_get_phy_mode);
> +
> +static const char *usb_dr_modes[] = {
> +	[USB_DR_MODE_UNKNOWN]		= "",
> +	[USB_DR_MODE_HOST]		= "host",
> +	[USB_DR_MODE_PERIPHERAL]	= "peripheral",
> +	[USB_DR_MODE_OTG]		= "otg",
> +};
> +
> +/**
> + * of_usb_get_dr_mode - Get dual role mode for given device_node
> + * @np:	Pointer to the given device_node
> + *
> + * The function gets phy interface string from property 'dr_mode',
> + * and returns the correspondig enum usb_phy_dr_mode
> + */
> +enum usb_phy_dr_mode of_usb_get_dr_mode(struct device_node *np)
> +{
> +	const char *dr_mode;
> +	int err, i;
> +
> +	err = of_property_read_string(np, "dr_mode", &dr_mode);
> +	if (err < 0)
> +		return USB_DR_MODE_UNKNOWN;
> +
> +	for (i = 0; i < ARRAY_SIZE(usb_dr_modes); i++)
> +		if (!strcasecmp(dr_mode, usb_dr_modes[i]))
> +			return i;

Same comment applies here too.

Thanks
Kishon
