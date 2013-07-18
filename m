From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 18 Jul 2013 11:50:00 -0400 (EDT)
Subject: [PATCH V3 2/6] USB: OHCI: make ohci-omap a separate driver
In-Reply-To: <1372141408-9894-3-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1307181144480.1245-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Jun 2013, Manjunath Goudar wrote:

> Separate the  TI OHCI OMAP1/2 host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> it would be nice to have in 3.11.
   
I'm sorry it took so long to review this; I have been very busy. 
    
This patch is almost right.  There are just a couple of problems 
involving the clock_power calls.

> @@ -354,12 +358,6 @@ static int usb_hcd_omap_probe (const struct hc_driver *driver,
>  		goto err2;
>  	}
>  
> -	ohci = hcd_to_ohci(hcd);
> -	ohci_hcd_init(ohci);
> -
> -	host_initialized = 0;
> -	host_enabled = 1;
> -
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
>  		retval = -ENXIO;
> @@ -369,11 +367,7 @@ static int usb_hcd_omap_probe (const struct hc_driver *driver,
>  	if (retval)
>  		goto err3;
>  
> -	host_initialized = 1;
> -
> -	if (!host_enabled)
> -		omap_ohci_clock_power(0);
> -
> +	omap_ohci_clock_power(0);

Since host_enabled was always 1 at this point, omap_ohci_clock_power()
would never be called.  You should remove it.

> @@ -402,6 +396,8 @@ err0:
>  static inline void
>  usb_hcd_omap_remove (struct usb_hcd *hcd, struct platform_device *pdev)
>  {
> +	dev_dbg(hcd->self.controller, "stopping USB Controller\n");
> +	omap_ohci_clock_power(0);
>  	usb_remove_hcd(hcd);
>  	if (!IS_ERR_OR_NULL(hcd->phy)) {
>  		(void) otg_set_host(hcd->phy->otg, 0);

omap_ohci_clock_power() should be called after usb_remove_hcd(), not
before.  This reason is simple: Until usb_remove_hcd() is called, the
controller is still running and therefore needs to have a valid clock
signal.

Alan Stern
