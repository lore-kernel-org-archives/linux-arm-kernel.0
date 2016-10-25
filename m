From: david@lechnology.com (David Lechner)
Date: Mon, 24 Oct 2016 19:38:11 -0500
Subject: [PATCH/RFT v2 11/17] USB: OHCI: make ohci-da8xx a separate driver
In-Reply-To: <20161024164634.4330-12-ahaslam@baylibre.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-12-ahaslam@baylibre.com>
Message-ID: <403743d8-dff2-3389-105b-1082b674b0b8@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/24/2016 11:46 AM, ahaslam at baylibre.com wrote:
> From: Manjunath Goudar <manjunath.goudar@linaro.org>
>
> Separate the Davinci OHCI host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> it would be nice to have in 3.11.

No need for comment about kernel 3.11.

>
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> ---
>  drivers/usb/host/Kconfig      |   2 +-
>  drivers/usb/host/Makefile     |   1 +
>  drivers/usb/host/ohci-da8xx.c | 185 +++++++++++++++++-------------------------
>  drivers/usb/host/ohci-hcd.c   |  18 ----
>  4 files changed, 76 insertions(+), 130 deletions(-)
>
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 83b6cec..642c6fe8 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -479,7 +479,7 @@ config USB_OHCI_HCD_OMAP3
>  	  OMAP3 and later chips.
>
>  config USB_OHCI_HCD_DAVINCI
> -	bool "OHCI support for TI DaVinci DA8xx"
> +	tristate "OHCI support for TI DaVinci DA8xx"
>  	depends on ARCH_DAVINCI_DA8XX
>  	depends on USB_OHCI_HCD=y

Need to drop the "=y" here, otherwise you still can't compile this as a 
module.

>  	select PHY_DA8XX_USB
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index 6ef785b..2644537 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -61,6 +61,7 @@ obj-$(CONFIG_USB_OHCI_HCD_AT91)	+= ohci-at91.o
>  obj-$(CONFIG_USB_OHCI_HCD_S3C2410)	+= ohci-s3c2410.o
>  obj-$(CONFIG_USB_OHCI_HCD_LPC32XX)	+= ohci-nxp.o
>  obj-$(CONFIG_USB_OHCI_HCD_PXA27X)	+= ohci-pxa27x.o
> +obj-$(CONFIG_USB_OHCI_HCD_DAVINCI)	+= ohci-da8xx.o
>
>  obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
>  obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
> diff --git a/drivers/usb/host/ohci-da8xx.c b/drivers/usb/host/ohci-da8xx.c
> index e98066d..5585d9e 100644
> --- a/drivers/usb/host/ohci-da8xx.c
> +++ b/drivers/usb/host/ohci-da8xx.c
> @@ -11,16 +11,31 @@
>   * kind, whether express or implied.
>   */
>
> +#include <linux/clk.h>
> +#include <linux/io.h>
>  #include <linux/interrupt.h>
>  #include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/platform_device.h>
> -#include <linux/clk.h>
>  #include <linux/phy/phy.h>
>  #include <linux/platform_data/usb-davinci.h>
> +#include <linux/platform_device.h>

linux/platform_device.h is listed twice

> +#include <linux/usb.h>
> +#include <linux/usb/hcd.h>
> +#include <asm/unaligned.h>
>
> -#ifndef CONFIG_ARCH_DAVINCI_DA8XX
> -#error "This file is DA8xx bus glue.  Define CONFIG_ARCH_DAVINCI_DA8XX."
> -#endif
> +#include "ohci.h"
> +
> +#define DRIVER_DESC "OHCI DA8XX driver"
> +
> +static const char hcd_name[] = "ohci-da8xx";

why static const char instead of #define? This is only used one time in 
a pr_info, so it seems kind of pointless anyway.

> +
> +static struct hc_driver __read_mostly ohci_da8xx_hc_driver;
> +
> +static int (*orig_ohci_hub_control)(struct usb_hcd  *hcd, u16 typeReq,
> +			u16 wValue, u16 wIndex, char *buf, u16 wLength);
> +static int (*orig_ohci_hub_status_data)(struct usb_hcd *hcd, char *buf);
>
>  static struct clk *usb11_clk;
>  static struct phy *usb11_phy;
> @@ -73,7 +88,7 @@ static void ohci_da8xx_ocic_handler(struct da8xx_ohci_root_hub *hub)
>  		hub->set_power(0);
>  }
>
> -static int ohci_da8xx_init(struct usb_hcd *hcd)
> +static int ohci_da8xx_reset(struct usb_hcd *hcd)
>  {
>  	struct device *dev		= hcd->self.controller;
>  	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(dev);
> @@ -93,7 +108,7 @@ static int ohci_da8xx_init(struct usb_hcd *hcd)
>  	 */
>  	ohci->num_ports = 1;
>
> -	result = ohci_init(ohci);
> +	result = ohci_setup(hcd);
>  	if (result < 0) {
>  		ohci_da8xx_disable();
>  		return result;
> @@ -121,30 +136,12 @@ static int ohci_da8xx_init(struct usb_hcd *hcd)
>  	return result;
>  }
>
> -static void ohci_da8xx_stop(struct usb_hcd *hcd)
> -{
> -	ohci_stop(hcd);
> -	ohci_da8xx_disable();
> -}
> -
> -static int ohci_da8xx_start(struct usb_hcd *hcd)
> -{
> -	struct ohci_hcd	*ohci		= hcd_to_ohci(hcd);
> -	int result;
> -
> -	result = ohci_run(ohci);
> -	if (result < 0)
> -		ohci_da8xx_stop(hcd);
> -
> -	return result;
> -}
> -
>  /*
>   * Update the status data from the hub with the over-current indicator change.
>   */
>  static int ohci_da8xx_hub_status_data(struct usb_hcd *hcd, char *buf)
>  {
> -	int length		= ohci_hub_status_data(hcd, buf);
> +	int length		= orig_ohci_hub_status_data(hcd, buf);
>
>  	/* See if we have OCIC flag set */
>  	if (ocic_flag) {
> @@ -226,66 +223,13 @@ static int ohci_da8xx_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
>  		}
>  	}
>
> -	return ohci_hub_control(hcd, typeReq, wValue, wIndex, buf, wLength);
> +	return orig_ohci_hub_control(hcd, typeReq, wValue,
> +			wIndex, buf, wLength);
>  }
>
> -static const struct hc_driver ohci_da8xx_hc_driver = {
> -	.description		= hcd_name,
> -	.product_desc		= "DA8xx OHCI",
> -	.hcd_priv_size		= sizeof(struct ohci_hcd),
> -
> -	/*
> -	 * generic hardware linkage
> -	 */
> -	.irq			= ohci_irq,
> -	.flags			= HCD_USB11 | HCD_MEMORY,
> -
> -	/*
> -	 * basic lifecycle operations
> -	 */
> -	.reset			= ohci_da8xx_init,
> -	.start			= ohci_da8xx_start,
> -	.stop			= ohci_da8xx_stop,
> -	.shutdown		= ohci_shutdown,
> -
> -	/*
> -	 * managing i/o requests and associated device resources
> -	 */
> -	.urb_enqueue		= ohci_urb_enqueue,
> -	.urb_dequeue		= ohci_urb_dequeue,
> -	.endpoint_disable	= ohci_endpoint_disable,
> -
> -	/*
> -	 * scheduling support
> -	 */
> -	.get_frame_number	= ohci_get_frame,
> -
> -	/*
> -	 * root hub support
> -	 */
> -	.hub_status_data	= ohci_da8xx_hub_status_data,
> -	.hub_control		= ohci_da8xx_hub_control,
> -
> -#ifdef	CONFIG_PM
> -	.bus_suspend		= ohci_bus_suspend,
> -	.bus_resume		= ohci_bus_resume,
> -#endif
> -	.start_port_reset	= ohci_start_port_reset,
> -};
> -
>  /*-------------------------------------------------------------------------*/
>
> -
> -/**
> - * usb_hcd_da8xx_probe - initialize DA8xx-based HCDs
> - * Context: !in_interrupt()
> - *
> - * Allocates basic resources for this USB host controller, and
> - * then invokes the start() method for the HCD associated with it
> - * through the hotplug entry's driver_data.
> - */
> -static int usb_hcd_da8xx_probe(const struct hc_driver *driver,
> -			       struct platform_device *pdev)
> +static int ohci_da8xx_probe(struct platform_device *pdev)
>  {
>  	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(&pdev->dev);
>  	struct usb_hcd	*hcd;
> @@ -295,6 +239,11 @@ static int usb_hcd_da8xx_probe(const struct hc_driver *driver,
>  	if (hub == NULL)
>  		return -ENODEV;
>
> +	hcd = usb_create_hcd(&ohci_da8xx_hc_driver, &pdev->dev,
> +				dev_name(&pdev->dev));
> +	if (!hcd)
> +		return -ENOMEM;
> +

Won't this leak hdc if there is an error later?

>  	usb11_clk = devm_clk_get(&pdev->dev, "usb11");
>  	if (IS_ERR(usb11_clk)) {
>  		if (PTR_ERR(usb11_clk) != -EPROBE_DEFER)
> @@ -309,9 +258,6 @@ static int usb_hcd_da8xx_probe(const struct hc_driver *driver,
>  		return PTR_ERR(usb11_phy);
>  	}
>
> -	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
> -	if (!hcd)
> -		return -ENOMEM;

Why does this need to be moved?

>
>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	hcd->regs = devm_ioremap_resource(&pdev->dev, mem);
> @@ -323,13 +269,12 @@ static int usb_hcd_da8xx_probe(const struct hc_driver *driver,
>  	hcd->rsrc_start = mem->start;
>  	hcd->rsrc_len = resource_size(mem);
>
> -	ohci_hcd_init(hcd_to_ohci(hcd));
> -
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		error = -ENODEV;
>  		goto err;
>  	}
> +
>  	error = usb_add_hcd(hcd, irq, 0);
>  	if (error)
>  		goto err;
> @@ -348,35 +293,14 @@ static int usb_hcd_da8xx_probe(const struct hc_driver *driver,
>  	return error;
>  }
>
> -/**
> - * usb_hcd_da8xx_remove - shutdown processing for DA8xx-based HCDs
> - * @dev: USB Host Controller being removed
> - * Context: !in_interrupt()
> - *
> - * Reverses the effect of usb_hcd_da8xx_probe(), first invoking
> - * the HCD's stop() method.  It is always called from a thread
> - * context, normally "rmmod", "apmd", or something similar.
> - */
> -static inline void
> -usb_hcd_da8xx_remove(struct usb_hcd *hcd, struct platform_device *pdev)
> +static int ohci_da8xx_remove(struct platform_device *pdev)
>  {
> +	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
>  	struct da8xx_ohci_root_hub *hub	= dev_get_platdata(&pdev->dev);
>
>  	hub->ocic_notify(NULL);
>  	usb_remove_hcd(hcd);
>  	usb_put_hcd(hcd);
> -}
> -
> -static int ohci_hcd_da8xx_drv_probe(struct platform_device *dev)
> -{
> -	return usb_hcd_da8xx_probe(&ohci_da8xx_hc_driver, dev);
> -}
> -
> -static int ohci_hcd_da8xx_drv_remove(struct platform_device *dev)
> -{
> -	struct usb_hcd	*hcd = platform_get_drvdata(dev);
> -
> -	usb_hcd_da8xx_remove(hcd, dev);
>
>  	return 0;
>  }
> @@ -426,12 +350,16 @@ static int ohci_da8xx_resume(struct platform_device *dev)
>  }
>  #endif
>
> +static const struct ohci_driver_overrides da8xx_overrides __initconst = {
> +	.reset		= ohci_da8xx_reset
> +};
> +
>  /*
>   * Driver definition to register with platform structure.
>   */
>  static struct platform_driver ohci_hcd_da8xx_driver = {
> -	.probe		= ohci_hcd_da8xx_drv_probe,
> -	.remove		= ohci_hcd_da8xx_drv_remove,
> +	.probe		= ohci_da8xx_probe,
> +	.remove		= ohci_da8xx_remove,
>  	.shutdown 	= usb_hcd_platform_shutdown,
>  #ifdef	CONFIG_PM
>  	.suspend	= ohci_da8xx_suspend,

It would probably be a good idea to change the driver name here. 
Currently it is "ohci". Although this would be better in a separate 
patch if the name has to be changed to match in other files as well.

> @@ -442,4 +370,39 @@ static int ohci_da8xx_resume(struct platform_device *dev)
>  	},
>  };
>
> +static int __init ohci_da8xx_init(void)
> +{
> +
> +	if (usb_disabled())
> +		return -ENODEV;
> +
> +	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
> +	ohci_init_driver(&ohci_da8xx_hc_driver, &da8xx_overrides);
> +
> +	/*
> +	 * The Davinci da8xx HW has some unusual quirks, which require
> +	 * da8xx-specific workarounds. We override certain hc_driver
> +	 * functions here to achieve that. We explicitly do not enhance
> +	 * ohci_driver_overrides to allow this more easily, since this
> +	 * is an unusual case, and we don't want to encourage others to
> +	 * override these functions by making it too easy.
> +	 */
> +
> +	orig_ohci_hub_control = ohci_da8xx_hc_driver.hub_control;
> +	orig_ohci_hub_status_data = ohci_da8xx_hc_driver.hub_status_data;
> +
> +	ohci_da8xx_hc_driver.hub_status_data     = ohci_da8xx_hub_status_data;
> +	ohci_da8xx_hc_driver.hub_control         = ohci_da8xx_hub_control;
> +
> +	return platform_driver_register(&ohci_hcd_da8xx_driver);
> +}
> +module_init(ohci_da8xx_init);
> +
> +static void __exit ohci_da8xx_cleanup(void)

ohci_da8xx_exit would be a better name

> +{
> +	platform_driver_unregister(&ohci_hcd_da8xx_driver);
> +}
> +module_exit(ohci_da8xx_cleanup);
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:ohci");

this will need to be changed too if you change the driver name

> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
> index 1700908..8de174a 100644
> --- a/drivers/usb/host/ohci-hcd.c
> +++ b/drivers/usb/host/ohci-hcd.c
> @@ -1219,11 +1219,6 @@ void ohci_init_driver(struct hc_driver *drv,
>  #define SA1111_DRIVER		ohci_hcd_sa1111_driver
>  #endif
>
> -#ifdef CONFIG_USB_OHCI_HCD_DAVINCI
> -#include "ohci-da8xx.c"
> -#define DAVINCI_PLATFORM_DRIVER	ohci_hcd_da8xx_driver
> -#endif
> -
>  #ifdef CONFIG_USB_OHCI_HCD_PPC_OF
>  #include "ohci-ppc-of.c"
>  #define OF_PLATFORM_DRIVER	ohci_hcd_ppc_of_driver
> @@ -1303,19 +1298,9 @@ static int __init ohci_hcd_mod_init(void)
>  		goto error_tmio;
>  #endif
>
> -#ifdef DAVINCI_PLATFORM_DRIVER
> -	retval = platform_driver_register(&DAVINCI_PLATFORM_DRIVER);
> -	if (retval < 0)
> -		goto error_davinci;
> -#endif
> -
>  	return retval;
>
>  	/* Error path */
> -#ifdef DAVINCI_PLATFORM_DRIVER
> -	platform_driver_unregister(&DAVINCI_PLATFORM_DRIVER);
> - error_davinci:
> -#endif
>  #ifdef TMIO_OHCI_DRIVER
>  	platform_driver_unregister(&TMIO_OHCI_DRIVER);
>   error_tmio:
> @@ -1351,9 +1336,6 @@ static int __init ohci_hcd_mod_init(void)
>
>  static void __exit ohci_hcd_mod_exit(void)
>  {
> -#ifdef DAVINCI_PLATFORM_DRIVER
> -	platform_driver_unregister(&DAVINCI_PLATFORM_DRIVER);
> -#endif
>  #ifdef TMIO_OHCI_DRIVER
>  	platform_driver_unregister(&TMIO_OHCI_DRIVER);
>  #endif
>
