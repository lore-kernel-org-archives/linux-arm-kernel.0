From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 18 Jun 2013 14:13:03 -0400 (EDT)
Subject: [PATCH V2 2/6] USB: OHCI: make ohci-omap a separate driver
In-Reply-To: <1371052442-14541-3-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306181410380.1157-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jun 2013, Manjunath Goudar wrote:

> Separate the  TI OHCI OMAP1/2 host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> it would be nice to have in 3.11.
> 
> V2:
>  -omap_ohci_clock_power(0) called in usb_hcd_omap_remove().
>  -Removed ohci_setup() call from usb_hcd_omap_probe() and ohci_omap_reset().
>  -host_enabled and host_initialized variables aren't used for anything
>   thats what removed.

There's one more thing I just noticed.


> @@ -188,21 +195,21 @@ static void start_hnp(struct ohci_hcd *ohci)
>  
>  /*-------------------------------------------------------------------------*/
>  
> -static int ohci_omap_init(struct usb_hcd *hcd)
> +static int ohci_omap_reset(struct usb_hcd *hcd)
>  {
>  	struct ohci_hcd		*ohci = hcd_to_ohci(hcd);
>  	struct omap_usb_config	*config = hcd->self.controller->platform_data;
>  	int			need_transceiver = (config->otg != 0);
> -	int			ret;
>  
>  	dev_dbg(hcd->self.controller, "starting USB Controller\n");
>  
> -	if (config->otg) {
> +	if (config->otg || config->rwc) {
>  		ohci_to_hcd(ohci)->self.otg_port = config->otg;
>  		/* default/minimum OTG power budget:  8 mA */
>  		ohci_to_hcd(ohci)->power_budget = 8;
> +		ohci->hc_control = OHCI_CTRL_RWC;
> +		writel(OHCI_CTRL_RWC, &ohci->regs->control);

This last line must not appear here, because ohci->regs doesn't get set
until ohci_setup() calls ohci_init().  Removing it entirely is safe
because ohci_run() does the same thing later on.  Or you can move both 
of these last two lines after the call to ohci_setup().

Alan Stern
