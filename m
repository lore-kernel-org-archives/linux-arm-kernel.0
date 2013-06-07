From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 7 Jun 2013 14:34:52 -0400 (EDT)
Subject: [RFC][PATCH 4/7] USB: OHCI: make ohci-spear a separate driver
In-Reply-To: <1370585013-12809-5-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306071355170.1366-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Jun 2013, Manjunath Goudar wrote:

> Separate the  TI OHCI SPEAr host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM.

> @@ -151,16 +98,24 @@ static int spear_ohci_hcd_drv_probe(struct platform_device *pdev)
>  		goto err_put_hcd;
>  	}
>  
> -	ohci_p = (struct spear_ohci *)hcd_to_ohci(hcd);
> -	ohci_p->clk = usbh_clk;
> -	spear_start_ohci(ohci_p);
> -	ohci_hcd_init(hcd_to_ohci(hcd));
> +	sohci_p = to_spear_ohci(hcd);
> +	sohci_p->clk = usbh_clk;
> +	hcd_to_ohci(hcd)->regs = hcd->regs;

This line isn't needed.  It is one of the first things that ohci_init() 
does.

> +
> +	ohci_setup(hcd);

Don't call ohci_setup().

> +	clk_prepare_enable(sohci_p->clk);
> +
> +	ohci = hcd_to_ohci(hcd);
> +
> +#ifdef DEBUG
> +	ohci_dump(ohci, 1);
> +#endif

I suspect this debugging stuff isn't needed any more.  You can get rid 
of it.

> @@ -188,13 +143,13 @@ static int spear_ohci_hcd_drv_suspend(struct platform_device *dev,
>  {
>  	struct usb_hcd *hcd = platform_get_drvdata(dev);
>  	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
> -	struct spear_ohci *ohci_p = to_spear_ohci(hcd);
> +	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
>  
>  	if (time_before(jiffies, ohci->next_statechange))
>  		msleep(5);
>  	ohci->next_statechange = jiffies;
>  
> -	spear_stop_ohci(ohci_p);
> +	clk_disable_unprepare(sohci_p->clk);
>  	return 0;
>  }

This routine needs to call ohci_suspend() just before the 
clk_disable_unprepare().  I don't know how that got left out, but it 
looks like the same problem exists in several of the ohci glue files.  
I guess they should all be fixed at once, in a separate patch.

>  
> @@ -202,13 +157,13 @@ static int spear_ohci_hcd_drv_resume(struct platform_device *dev)
>  {
>  	struct usb_hcd *hcd = platform_get_drvdata(dev);
>  	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
> -	struct spear_ohci *ohci_p = to_spear_ohci(hcd);
> +	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
>  
>  	if (time_before(jiffies, ohci->next_statechange))
>  		msleep(5);
>  	ohci->next_statechange = jiffies;
>  
> -	spear_start_ohci(ohci_p);
> +	 clk_prepare_enable(sohci_p->clk);

You got an extra space character after the tab.

Alan Stern
