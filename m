From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 29 Mar 2013 15:41:41 -0400 (EDT)
Subject: [PATCH v3 3/7] USB: EHCI: make ehci-s5p a separate driver
In-Reply-To: <1364507705-22012-4-git-send-email-arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1303291534190.1467-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Mar 2013, Arnd Bergmann wrote:

> From: Manjunath Goudar <manjunath.goudar@linaro.org>
> 
> Separate the  Samsung S5P/EXYNOS host controller driver from ehci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> however, note that other changes are still needed before S5P/EXYNOS can
> be booted with a multi-platform kernel. We currently expect those
> to get merged for 3.10.
> 
> With the infrastructure added by Alan Stern in patch 3e0232039
> "USB: EHCI: prepare to make ehci-hcd a library module", we can
> avoid this problem by turning a bus glue into a separate
> module, as we do here for the s5p bus glue.
> 
> In V3:
>  -Detail commit message added here,why this patch is required.
>  -MODULE_LICENSE is GPL v2.
>  -Added .extra_priv_size to eliminate the separate allocation of the s5p_ehci_hcd structure
>   and removed .reset function pointer initialization.
>  -Arranged  #include's in alphabetical order.
>  -After using extra_priv_size initialization,struct usb_hcd *hcd is redundant that's why removed
>   from the prob function.
>  -Eliminated s5p_ehci_phy_enable,contents of statements moved into the s5p_ehci_probe
>  -Eliminated s5p_ehci_phy_disable, contents of statements moved into the s5p_ehci_remove.

And several other places as well.

Personally, I would have left these two functions the way they were and 
relied on the compiler to inline them when appropriate.  Eliminating 
them just makes the code more complicated.

...

> @@ -113,9 +76,10 @@ static u64 ehci_s5p_dma_mask = DMA_BIT_MASK(32);
>  
>  static int s5p_ehci_probe(struct platform_device *pdev)
>  {
> +	struct usb_hcd *hcd ;
>  	struct s5p_ehci_platdata *pdata = pdev->dev.platform_data;
> +	const struct hc_driver *driver = &s5p_ehci_hc_driver;
>  	struct s5p_ehci_hcd *s5p_ehci;
> -	struct usb_hcd *hcd;

What's the reason for these changes?  There's no need for the "driver" 
variable, and improper whitespace was added to the declaration of 
"hcd".

> @@ -153,16 +117,12 @@ static int s5p_ehci_probe(struct platform_device *pdev)
>  		s5p_ehci->otg = phy->otg;
>  	}
>  
> -	s5p_ehci->dev = &pdev->dev;
> -
> -	hcd = usb_create_hcd(&s5p_ehci_hc_driver, &pdev->dev,
> -					dev_name(&pdev->dev));
> +	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));

s5p_ehci is not initialized correctly.  The devm_kzalloc() call was 
left in and to_s5p_ehci() was not called.  Was anybody able to test 
this patch?

Alan Stern
