From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 7 Jun 2013 14:54:27 -0400 (EDT)
Subject: [RFC][PATCH 7/7] USB: OHCI: make ohci-s3c2410 a separate driver
In-Reply-To: <1370585013-12809-8-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306071453310.1366-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 7 Jun 2013, Manjunath Goudar wrote:

> Separate the Samsung OHCI S3CXXXX host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM.

> @@ -371,10 +384,9 @@ static int usb_hcd_s3c2410_probe(const struct hc_driver *driver,
>  		goto err_put;
>  	}
>  
> +	ohci_setup(hcd);

Don't call ohci_setup().

> @@ -532,4 +480,36 @@ static struct platform_driver ohci_hcd_s3c2410_driver = {
>  	},
>  };
>  
> +static int __init ohci_s3cxxxx_init(void)
> +{
> +	if (usb_disabled())
> +		return -ENODEV;
> +
> +	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
> +	ohci_init_driver(&ohci_s3c2410_hc_driver, NULL);
> +
> +	/*
> +	* The Samsung HW has some unusual quirks, which require Sumsung-specific
> +	* workarounds. We override certain hc_driver functions here to
> +	* achieve that. We explicitly do not enhance ohci_driver_overrides to
> +	* allow this more easily, since this is an unusual case, and we don't
> +	* want to encourage others to override these functions by making it
> +	* too easy.
> +	*/
> +
> +	ohci_s3c2410_hc_driver.hub_status_data	= ohci_s3c2410_hub_status_data;
> +	ohci_s3c2410_hc_driver.hub_control	= ohci_s3c2410_hub_control;

Like in ohci-at91, save the pointers before overwriting them.

Alan Stern
