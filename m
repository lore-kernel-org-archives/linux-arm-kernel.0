From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 7 Jun 2013 13:49:09 -0400 (EDT)
Subject: [RFC][PATCH 3/7] USB: OHCI: make ohci-omap3 a separate driver
In-Reply-To: <1370585013-12809-4-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306071348120.1366-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Jun 2013, Manjunath Goudar wrote:

> Separate the  TI OHCI OMAP3 host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM.

> @@ -185,7 +118,16 @@ static int ohci_hcd_omap3_probe(struct platform_device *pdev)
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  
> -	ohci_hcd_init(hcd_to_ohci(hcd));
> +	ohci = hcd_to_ohci(hcd);
> +	/*
> +	* RemoteWakeupConnected has to be set explicitly before
> +	* calling ohci_run. The reset value of RWC is 0.
> +	*/
> +	ohci->hc_control = OHCI_CTRL_RWC;
> +	writel(OHCI_CTRL_RWC, &ohci->regs->control);
> +	dev_dbg(hcd->self.controller, "starting OHCI controller\n");
> +
> +	ohci_setup(hcd);

Don't call ohci_setup().

Apart from that (and the comment format), this is okay.

Alan Stern
