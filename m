From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 18 Jun 2013 13:47:11 -0400 (EDT)
Subject: [PATCH V2 2/6] USB: OHCI: make ohci-omap a separate driver
In-Reply-To: <1371052442-14541-3-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306181336500.1157-100000@iolanthe.rowland.org>
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

You were supposed to remove the call from usb_hcd_omap_probe but leave 
in the call from ohci_omap_reset.

>  -host_enabled and host_initialized variables aren't used for anything
>   thats what removed.


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

These three lines are supposed to run only when config->otg is set, not
when config->rwc is set.  The next two lines can run when either one is
set.

Also, "ohci_to_hcd(ohci)" should be replaced by "hcd".

> +		ohci->hc_control = OHCI_CTRL_RWC;
> +		writel(OHCI_CTRL_RWC, &ohci->regs->control);
>  	}
> -

Don't remove this blank line.

>  	/* boards can use OTG transceivers in non-OTG modes */
>  	need_transceiver = need_transceiver
>  			|| machine_is_omap_h2() || machine_is_omap_h3();
> @@ -238,9 +245,6 @@ static int ohci_omap_init(struct usb_hcd *hcd)
>  		omap_1510_local_bus_init();
>  	}
>  
> -	if ((ret = ohci_init(ohci)) < 0)
> -		return ret;
> -

This should call ohci_setup instead of ohci_init.

Alan Stern
