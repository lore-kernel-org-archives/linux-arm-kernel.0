From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 7 Jun 2013 13:37:57 -0400 (EDT)
Subject: [RFC][PATCH 2/7] USB: OHCI: make ohci-omap a separate driver
In-Reply-To: <1370585013-12809-3-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306071326000.1366-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Jun 2013, Manjunath Goudar wrote:

> Separate the  TI OHCI OMAP1/2 host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM.

> @@ -71,6 +77,10 @@ static struct clk *usb_dc_ck;
>  static int host_enabled;
>  static int host_initialized;

These two variables aren't used for anything.  You should get rid of 
them.

> @@ -201,8 +211,14 @@ static int ohci_omap_init(struct usb_hcd *hcd)
>  		ohci_to_hcd(ohci)->self.otg_port = config->otg;
>  		/* default/minimum OTG power budget:  8 mA */
>  		ohci_to_hcd(ohci)->power_budget = 8;
> +		ohci->hc_control = OHCI_CTRL_RWC;
> +		writel(OHCI_CTRL_RWC, &ohci->regs->control);
>  	}
>  
> +	if (config->rwc) {
> +		ohci->hc_control = OHCI_CTRL_RWC;
> +		writel(OHCI_CTRL_RWC, &ohci->regs->control);
> +	}

It's better to have two tests.  Remove the two lines added to the
previous "if" block, and change this test to

	if (config->otg || config->rwc) {

> @@ -281,14 +298,6 @@ static int ohci_omap_init(struct usb_hcd *hcd)
>  	return 0;
>  }
>  
> -static void ohci_omap_stop(struct usb_hcd *hcd)
> -{
> -	dev_dbg(hcd->self.controller, "stopping USB Controller\n");
> -	ohci_stop(hcd);
> -	omap_ohci_clock_power(0);

This last line seems to have gotten lost.  You need to add it to 
usb_hcd_omap_remove().

> @@ -354,8 +362,7 @@ static int usb_hcd_omap_probe (const struct hc_driver *driver,
>  		goto err2;
>  	}
>  
> -	ohci = hcd_to_ohci(hcd);
> -	ohci_hcd_init(ohci);
> +	ohci_setup(hcd);

Not needed, since you call ohci_setup() from within ohci_omap_reset().

Alan Stern
