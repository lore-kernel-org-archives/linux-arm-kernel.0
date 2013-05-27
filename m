From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 27 May 2013 10:54:18 -0400 (EDT)
Subject: [RFC V7 PATCH 1/3] USB: OHCI: prepare to make ohci-hcd a library
 module
In-Reply-To: <1369657550-24101-2-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1305271050320.21231-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 May 2013, Manjunath Goudar wrote:

> This patch prepares ohci-hcd for being split up into a core
> library and separate platform driver modules.  A generic
> ohci_hc_driver structure is created, containing all the "standard"
> values, and a new mechanism is added whereby a driver module can
> specify a set of overrides to those values.  In addition the
> ohci_restart(),ohci_suspend() and ohci_resume() routines need
> to be EXPORTed for use by the drivers.
> 
> Added ohci_setip(() and ohci_start() routine for to start the generic
> controller rather than each having its own idiosyncratic approach.
> This allow to clean duplicated code in most of SOC driver
> 
> In V2:
>  -ohci_hcd_init() ohci_run() and ohci_stop() are not made non-static.
>  -Adds the ohci_setup() and ohci_start() routine.

There's one thing we forgot about:

> +/* ohci_setup routine for generic controller initialization */
> +
> +int ohci_setup(struct usb_hcd *hcd)
> +{
> +	struct ohci_hcd		*ohci = hcd_to_ohci(hcd);
> +
> +	return ohci_init(ohci);
> +}
> +EXPORT_SYMBOL_GPL(ohci_setup);

This routine needs to call ohci_hcd_init() before ohci_init().

Alan Stern
