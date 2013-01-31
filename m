From: kishon@ti.com (kishon)
Date: Thu, 31 Jan 2013 11:44:21 +0530
Subject: [PATCH 2/6] usb: add devicetree helpers for determining dr_mode
 and phy_type
In-Reply-To: <1359559782-14552-3-git-send-email-s.hauer@pengutronix.de>
References: <1359559782-14552-1-git-send-email-s.hauer@pengutronix.de>
 <1359559782-14552-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <510A0BBD.6090209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 30 January 2013 08:59 PM, Sascha Hauer wrote:
> From: Michael Grzeschik <m.grzeschik@pengutronix.de>
>
> This adds two little devicetree helper functions for determining the
> dr_mode (host, peripheral, otg) and phy_type (utmi, ulpi,...) from
> the devicetree.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>   drivers/usb/usb-common.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/usb/of.h   |   27 ++++++++++++++++++
>   include/linux/usb/otg.h  |    7 +++++
>   include/linux/usb/phy.h  |    9 ++++++
>   4 files changed, 112 insertions(+)
>   create mode 100644 include/linux/usb/of.h
>
> diff --git a/drivers/usb/usb-common.c b/drivers/usb/usb-common.c
> index d29503e..1c0292c 100644
> --- a/drivers/usb/usb-common.c
> +++ b/drivers/usb/usb-common.c
> @@ -14,6 +14,9 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/usb/ch9.h>
> +#include <linux/of.h>
> +#include <linux/usb/of.h>
> +#include <linux/usb/otg.h>
>
>   const char *usb_speed_string(enum usb_device_speed speed)
>   {
> @@ -32,4 +35,70 @@ const char *usb_speed_string(enum usb_device_speed speed)
>   }
>   EXPORT_SYMBOL_GPL(usb_speed_string);
>
> +#ifdef CONFIG_OF
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
> +
> +	return USB_DR_MODE_UNKNOWN;
> +}
> +EXPORT_SYMBOL_GPL(of_usb_get_dr_mode);
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

%s/of_get_usbphy_mode/of_usb_get_phy_mode
> + * @np:	Pointer to the given device_node
> + *
> + * The function gets phy interface string from property 'phy_type',
> + * and returns the correspondig enum usb_phy_interface
> + */
> +enum usb_phy_interface of_usb_get_phy_mode(struct device_node *np)
> +{

You agreed to move this function inside usb/phy.. no?

Thanks
Kishon
