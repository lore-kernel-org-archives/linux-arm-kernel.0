From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 23 Jul 2013 14:39:12 -0400 (EDT)
Subject: [PATCH 2/6] USB: OHCI: make ohci-omap a separate driver
In-Reply-To: <1374484770-24531-3-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1307231436010.1304-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Jul 2013, Manjunath Goudar wrote:

> Separate the  TI OHCI OMAP1/2 host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> it would be nice to have in 3.11.
> 
> Signed-off-by: Manjunath Goudar <manjunath.goudar@linaro.org>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg KH <greg@kroah.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: linux-usb at vger.kernel.org
> 
> V2:
>  -omap_ohci_clock_power(0) called in usb_hcd_omap_remove().
>  -Removed ohci_setup() call from usb_hcd_omap_probe().
>  -host_enabled and host_initialized variables aren't used for anything
>   thats what removed.
> 
> V3:
>  -rewritten if (config->otg || config->rwc) block statements into
>   two separate 'if blocks' to handle below scenarios
>   1. config->otg set scenario.
>   2. if any of these (config->otg, config->rwc) are set, this
>      scenario should be handled only after ohci_setup()
> 
> V4:
>  -usb_remove_hcd() function is required a valid clock that is what
>   omap_ohci_clock_power(0) is called after hcd shutdown.

> @@ -369,11 +367,6 @@ static int usb_hcd_omap_probe (const struct hc_driver *driver,
>  	if (retval)
>  		goto err3;
>  
> -	host_initialized = 1;
> -
> -	if (!host_enabled)
> -		omap_ohci_clock_power(0);
> -
>  	return 0;
>  err3:
>  	iounmap(hcd->regs);

I suspect there's a mistake here, and the omap_ohci_clock_power() call 
perhaps should be moved after the "err3:" label.  But that mistake (if 
it is a mistake) was present in the original code, and this patch 
shouldn't change it.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
