From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 29 Mar 2013 13:59:09 -0400 (EDT)
Subject: [PATCH v3 2/7] USB: EHCI: make ehci-spear a separate driver
In-Reply-To: <1364507705-22012-3-git-send-email-arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1303291353210.1467-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Mar 2013, Arnd Bergmann wrote:

> From: Manjunath Goudar <manjunath.goudar@linaro.org>
> 
> Separate the SPEAr host controller driver from ehci-hcd host code
> so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> however, note that other changes are still needed before SPEAr can be
> booted with a multi-platform kernel, but they are queued in the
> arm-soc tree for 3.10.
> 
> With the infrastructure added by Alan Stern in patch 3e0232039
> "USB: EHCI: prepare to make ehci-hcd a library module", we can
> avoid this problem by turning a bus glue into a separate
> module, as we do here for the SPEAr bus glue.
> 
> In V3:
>  -Detailed commit message added here about why this patch is required.
>  -Eliminated ehci_spear_setup routine beacuse hcd registers
>   directly setting in spear_ehci_hcd_drv_probe function.

Fix the grammar, please.

>  -spear_overrides struct initialized.
>  -Eliminate struct ehci_hcd ehci from struct spear_ehci,to enable SPEAr clock
>   uses directly usb_hcd *hcd in spear_start_ehci function.
>  -to_spear_ehci() macro modified for spear_ehci.
> 
> In V2:
> Replaced spear as SPEAr everywhere, leaving functions/variables/config options.

...

> @@ -34,49 +45,7 @@ static void spear_stop_ehci(struct spear_ehci *ehci)
>  	clk_disable_unprepare(ehci->clk);
>  }
>  
> -static int ehci_spear_setup(struct usb_hcd *hcd)
> -{
> -	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
> -
> -	/* registers start at offset 0x0 */
> -	ehci->caps = hcd->regs;

This line never got moved into spear_ehci_hcd_drv_probe().

> @@ -161,7 +130,7 @@ static int spear_ehci_hcd_drv_probe(struct platform_device *pdev)
>  		goto err_put_hcd;
>  	}
>  
> -	ehci = (struct spear_ehci *)hcd_to_ehci(hcd);
> +	ehci = to_spear_ehci(hcd);
>  	ehci->clk = usbh_clk;

I strongly believe that the name "ehci" should be reserved for
variables of type struct ehci_hcd.  Here and in the start, stop, and
remove routines, please use "spear_ehci" as the name for a variable of
type struct spear_ehci.  Or whatever else you want -- just don't call
it "ehci" or "ehci_p".

Alan Stern
