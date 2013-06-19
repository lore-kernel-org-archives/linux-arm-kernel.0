From: stern@rowland.harvard.edu (Alan Stern)
Date: Wed, 19 Jun 2013 16:38:37 -0400 (EDT)
Subject: [PATCH V2 6/6] USB: OHCI: make ohci-s3c2410 a separate driver
In-Reply-To: <1371052442-14541-7-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306191634420.877-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jun 2013, Manjunath Goudar wrote:

> Separate the Samsung OHCI S3CXXXX host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> it would be nice to have in 3.11.
> 
> V2:
>  -Set non-standard fields in ohci_s3c2410_hc_driver manually, rather than
>   relying on an expanded struct ohci_driver_overrides.
>  -Save orig_ohci_hub_control and orig_ohci_hub_status_data rather than
>   relying on ohci_hub_control and hub_status_data being exported.
>  -ohci_setup() has been removed because it is called in .reset member
>   of the ohci_hc_driver structure.

> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index e4dc9ab..0b7b0f7 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -390,6 +390,14 @@ config USB_OHCI_HCD_SPEAR
>            Enables support for the on-chip OHCI controller on
>            ST SPEAr chips.
>  
> +config USB_OHCI_HCD_S3CXXXX
> +        tristate "Support for S3CXXXX on-chip OHCI USB controller"
> +        depends on USB_OHCI_HCD && (ARCH_S3C24XX) || (ARCH_S3C64XX)

The use of parentheses here is wrong.

> +static int (*orig_ohci_hub_control)(struct usb_hcd  *hcd, u16 typeReq, u16 wValue,
> +                        u16 wIndex, char *buf, u16 wLength);

Avoid having more than 80 columns in a line.

> @@ -371,10 +388,9 @@ static int usb_hcd_s3c2410_probe(const struct hc_driver *driver,
>  		goto err_put;
>  	}
>  
> +	ohci_setup(hcd);
>  	s3c2410_start_hc(dev, hcd);

I thought this patch was supposed to get rid of the call to
ohci_setup()?

Alan Stern
