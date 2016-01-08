From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 8 Jan 2016 17:50:13 -0500 (EST)
Subject: [RFC PATCH 1/2] USB: core: let USB device know device node
In-Reply-To: <1452231864-11171-2-git-send-email-peter.chen@freescale.com>
Message-ID: <Pine.LNX.4.44L0.1601081746080.21467-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 8 Jan 2016, Peter Chen wrote:

> Although most of USB devices are hot-plug's, there are still some devices
> are hard wired on the board, eg, for HSIC and SSIC interface USB devices.
> If these kinds of USB devices are multiple functions, and they can supply
> other interfaces like i2c, gpios for other devices, we may need to
> descirbe these at device tree.
> 
> In this commit, it uses "reg" in dts as port number to match the port
> number decided by USB core, if they are the same, then the device node
> is for the device we are creating for USB core.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---

> +#include <linux/module.h>
> +#include <linux/moduleparam.h>

Do you need those two #include's?

> +#include <linux/of.h>
> +
> +/**
> + * usb_of_find_node - Find the device node match port number
> + * @dev: the parent device node

The parameter is actually named "parent".

> + * @portnum: the port number which device is connecting 
> + *
> + * Find the node from device tree according to its port number.
> + *
> + * Return: On success, a pointer to the device node, %NULL on failure.
> + */
> +struct device_node *usb_of_find_node(struct device_node *parent, int portnum)
> +{
> +	struct device_node *node;
> +	u32 port;
> +
> +	for_each_child_of_node(parent, node) {
> +		if (!of_property_read_u32(node, "reg", &port)) {
> +			if (port == portnum)
> +				return node;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(usb_of_find_node);
> +

> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 89533ba..a3a0b07 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -21,6 +21,7 @@
>  #include <linux/sched.h>	/* for current && schedule_timeout */
>  #include <linux/mutex.h>	/* for struct mutex */
>  #include <linux/pm_runtime.h>	/* for runtime PM */
> +#include <linux/of.h>		/* for device tree */

I think you don't need this line.  You can simply write:

	struct device_node;

just like the two lines below.

>  struct usb_device;
>  struct usb_driver;
> @@ -616,6 +617,7 @@ struct usb_device {
>  	struct usb3_lpm_parameters u1_params;
>  	struct usb3_lpm_parameters u2_params;
>  	unsigned lpm_disable_count;
> +	struct device_node	*of_node; /* associated device tree node */
>  };
>  #define	to_usb_device(d) container_of(d, struct usb_device, dev)

Alan Stern
