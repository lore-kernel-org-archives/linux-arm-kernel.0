From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 7 Jun 2013 13:20:43 -0400 (EDT)
Subject: [RFC][PATCH 1/7] USB: OHCI: make ohci-exynos a separate driver
In-Reply-To: <1370585013-12809-2-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306071304420.1366-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Jun 2013, Manjunath Goudar wrote:

> Separate the  Samsung OHCI EXYNOS host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM.

> -static void exynos_ohci_phy_enable(struct exynos_ohci_hcd *exynos_ohci)
> +static void exynos_ohci_phy_enable(struct platform_device *pdev)
>  {
> -	struct platform_device *pdev = to_platform_device(exynos_ohci->dev);
> +	struct exynos_ohci_hcd *exynos_ohci = platform_get_drvdata(pdev);

This is wrong.  platform_get_drvdata() will return the hcd, not the 
exynos_ohci_hcd structure.

> @@ -37,9 +51,9 @@ static void exynos_ohci_phy_enable(struct exynos_ohci_hcd *exynos_ohci)
>  		exynos_ohci->pdata->phy_init(pdev, USB_PHY_TYPE_HOST);
>  }
>  
> -static void exynos_ohci_phy_disable(struct exynos_ohci_hcd *exynos_ohci)
> +static void exynos_ohci_phy_disable(struct platform_device *pdev)
>  {
> -	struct platform_device *pdev = to_platform_device(exynos_ohci->dev);
> +	struct exynos_ohci_hcd *exynos_ohci = platform_get_drvdata(pdev);

Same problem here.

> @@ -121,15 +83,18 @@ static int exynos_ohci_probe(struct platform_device *pdev)
>  	if (!pdev->dev.coherent_dma_mask)
>  		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>  
> -	exynos_ohci = devm_kzalloc(&pdev->dev, sizeof(struct exynos_ohci_hcd),
> -					GFP_KERNEL);
> -	if (!exynos_ohci)
> +	hcd = usb_create_hcd(&exynos_ohci_hc_driver,
> +				&pdev->dev, dev_name(&pdev->dev));
> +	if (!hcd) {
> +		dev_err(&pdev->dev, "Unable to create HCD\n");
>  		return -ENOMEM;
>  
>  	if (of_device_is_compatible(pdev->dev.of_node,
>  					"samsung,exynos5440-ohci"))
>  		goto skip_phy;
>  
> +	}

This close brace belongs with the previous "if" statement.

> @@ -146,7 +111,6 @@ static int exynos_ohci_probe(struct platform_device *pdev)
>  
>  skip_phy:
>  
> -	exynos_ohci->dev = &pdev->dev;
>  
>  	hcd = usb_create_hcd(&exynos_ohci_hc_driver, &pdev->dev,
>  					dev_name(&pdev->dev));

This needs to be deleted, because it was done already.

Manjunath, I have already asked you to proof-read your patches before 
posting them.  Please do so.  New patches should _not_ have this kind 
of error.

> @@ -192,13 +155,11 @@ skip_phy:
>  	}
>  
>  	if (exynos_ohci->otg)
> -		exynos_ohci->otg->set_host(exynos_ohci->otg,
> -					&exynos_ohci->hcd->self);
> +		exynos_ohci->otg->set_host(exynos_ohci->otg, &hcd->self);
>  
> -	exynos_ohci_phy_enable(exynos_ohci);
> +	exynos_ohci_phy_enable(pdev);

This call will not work, because you don't set pdev's platform_data
until later.  The call to platform_set_drvdata() must be moved before
this line.

>  
> -	ohci = hcd_to_ohci(hcd);
> -	ohci_hcd_init(ohci);
> +	ohci_setup(hcd);

There's no need to call ohci_setup(), because it will get called anyway
as the .reset member of the ohci_hc_driver structure.

Alan Stern
