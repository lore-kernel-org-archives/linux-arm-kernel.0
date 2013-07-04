From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 4 Jul 2013 16:16:11 -0400 (EDT)
Subject: [PATCH 1/2] USB: OHCI: make ohci-ep93xx a separate driver
In-Reply-To: <1372958187-4039-2-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1307041615150.26847-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 4 Jul 2013, Manjunath Goudar wrote:

> Separate the OHCI EP93XX host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM.

> @@ -79,7 +93,10 @@ static int usb_hcd_ep93xx_probe(const struct hc_driver *driver,
>  
>  	ep93xx_start_hc(&pdev->dev);
>  
> -	ohci_hcd_init(hcd_to_ohci(hcd));
> +	ohci = hcd_to_ohci(hcd);
> +	ohci->next_statechange = jiffies;
> +	spin_lock_init(&ohci->lock);
> +	INIT_LIST_HEAD(&ohci->pending);
>  
>  	retval = usb_add_hcd(hcd, pdev->resource[1].start, 0);
>  	if (retval == 0)

Why did you add these lines?

Alan Stern
