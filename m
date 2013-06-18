From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 18 Jun 2013 14:16:46 -0400 (EDT)
Subject: [PATCH V2 3/6] USB: OHCI: make ohci-omap3 a separate driver
In-Reply-To: <1371052442-14541-4-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306181414280.1157-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jun 2013, Manjunath Goudar wrote:

> Separate the  TI OHCI OMAP3 host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> it would be nice to have in 3.11.
> 
> V2:
>  -ohci_setup() removed because it is called in .reset member
>   of the ohci_hc_driver structure.
>  -The improper multi-line commenting style written in proper way.
>   ('*' characters aligned in vertically).

Generally okay, just one problem...

> @@ -185,7 +118,14 @@ static int ohci_hcd_omap3_probe(struct platform_device *pdev)
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  
> -	ohci_hcd_init(hcd_to_ohci(hcd));
> +	ohci = hcd_to_ohci(hcd);
> +	/*
> +	 * RemoteWakeupConnected has to be set explicitly before
> +	 * calling ohci_run. The reset value of RWC is 0.
> +	 */
> +	ohci->hc_control = OHCI_CTRL_RWC;
> +	writel(OHCI_CTRL_RWC, &ohci->regs->control);

ohci->regs doesn't get set until usb_add_hcd, so this line must not 
appear here.  You can simply remove it.

> +	dev_dbg(hcd->self.controller, "starting OHCI controller\n");
>  
>  	ret = usb_add_hcd(hcd, irq, 0);
>  	if (ret) {

Alan Stern
