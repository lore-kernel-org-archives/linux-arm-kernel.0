From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 18 Jun 2013 13:30:11 -0400 (EDT)
Subject: [PATCH V2 1/6] USB: OHCI: make ohci-exynos a separate driver
In-Reply-To: <1371052442-14541-2-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1306181329070.1157-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jun 2013, Manjunath Goudar wrote:

> Separate the  Samsung OHCI EXYNOS host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> it would be nice to have in 3.11.
> 
> V2:
>  -exynos_ohci_hcd structure assignment error fixed.
>  -Removed multiple usb_create_hcd() from prob funtion.
>  -platform_set_drvdata() called before exynos_ohci_phy_enable().
>  -ohci_setup() removed because it is called in .reset member
>   of the ohci_hc_driver structure

> --- a/drivers/usb/host/ohci-exynos.c
> +++ b/drivers/usb/host/ohci-exynos.c
> @@ -12,24 +12,39 @@
>   */
>  
>  #include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/usb-ohci-exynos.h>
>  #include <linux/usb/phy.h>
>  #include <linux/usb/samsung_usb_phy.h>
> +#include <linux/usb.h>
> +#include <linux/usb/hcd.h>
> +#include <linux/usb/otg.h>
> +
> +#include "ohci.h"
> +
> +#define DRIVER_DESC "OHCI exynos driver"

I think the word "EXYNOS" is supposed to be in all capital letters.  
Apart from that,

Acked-by: Alan Stern <stern@rowland.harvard.edu>
