From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 7 Jun 2013 14:52:34 -0400 (EDT)
Subject: [RFC][PATCH 6/7] USB: OHCI: make ohci-at91 a separate driver
In-Reply-To: <1370585013-12809-7-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306071448280.1366-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Jun 2013, Manjunath Goudar wrote:

> Separate the  TI OHCI Atmel host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM.

> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -411,6 +411,14 @@ config USB_OHCI_HCD_SPEAR
>            Enables support for the on-chip OHCI controller on
>            ST SPEAr chips.
>  
> +config USB_OHCI_HCD_AT91
> +        tristate  "Support for Atmel on-chip OHCI USB controller"
> +        depends on USB_OHCI_HCD && ARCH_AT91
> +        default y
> +        ---help---
> +          Enables support for the on-chip OHCI controller on
> +          Atmel chips.

Notice the "depends on" line you added here?

> diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
> index a0cb44f..b4a88a6 100644
> --- a/drivers/usb/host/ohci-at91.c
> +++ b/drivers/usb/host/ohci-at91.c
> @@ -13,16 +13,25 @@
...
>  #ifndef CONFIG_ARCH_AT91
>  #error "CONFIG_ARCH_AT91 must be defined."
>  #endif

As a result of the "depends on" line, this test will never succeed.  
You can remove these three lines.

> @@ -111,6 +126,8 @@ static void usb_hcd_at91_remove (struct usb_hcd *, struct platform_device *);
>  static int usb_hcd_at91_probe(const struct hc_driver *driver,
>  			struct platform_device *pdev)
>  {
> +	struct at91_usbh_data	*board;

Tab character where it should be a space.

> +	struct ohci_hcd	*ohci;
>  	int retval;
>  	struct usb_hcd *hcd = NULL;
>  
> @@ -163,8 +180,11 @@ static int usb_hcd_at91_probe(const struct hc_driver *driver,
>  		goto err5;
>  	}
>  
> +	board = hcd->self.controller->platform_data;
> +	ohci = hcd_to_ohci(hcd);
> +	ohci->num_ports = board->ports;
>  	at91_start_hc(pdev);
> -	ohci_hcd_init(hcd_to_ohci(hcd));
> +	ohci_setup(hcd);

Don't call ohci_setup().

> @@ -727,3 +672,37 @@ static struct platform_driver ohci_hcd_at91_driver = {
>  		.of_match_table	= of_match_ptr(at91_ohci_dt_ids),
>  	},
>  };
> +
> +static int __init ohci_at91_init(void)
> +{
> +	if (usb_disabled())
> +		return -ENODEV;
> +
> +	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
> +	ohci_init_driver(&ohci_at91_hc_driver, NULL);
> +
> +	/*
> +	* The Atmel HW has some unusual quirks, which require Atmel-specific
> +	* workarounds. We override certain hc_driver functions here to
> +	* achieve that. We explicitly do not enhance ohci_driver_overrides to
> +	* allow this more easily, since this is an unusual case, and we don't
> +	* want to encourage others to override these functions by making it
> +	* too easy.
> +	*/
> +
> +	ohci_at91_hc_driver.hub_status_data	= ohci_at91_hub_status_data;
> +	ohci_at91_hc_driver.hub_control		= ohci_at91_hub_control;

Since the hub_status_data and hub_control routines aren't going to be
exported, you can't do it like this.  Instead, save the values of
ohci_at91_hc_driver.hub_status_data and ohci_at91_hc_driver.hub_control
before overwriting them.

Alan Stern
