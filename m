From: stern@rowland.harvard.edu (Alan Stern)
Date: Thu, 18 Jul 2013 16:38:57 -0400 (EDT)
Subject: [PATCH V3 6/6] USB: OHCI: make ohci-s3c2410 a separate driver
In-Reply-To: <1372141408-9894-7-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <Pine.LNX.4.44L0.1307181634380.1245-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Jun 2013, Manjunath Goudar wrote:

> Separate the Samsung OHCI S3CXXXX host controller driver from ohci-hcd
> host code so that it can be built as a separate driver module.
> This work is part of enabling multi-platform kernels on ARM;
> it would be nice to have in 3.11.

This patch looks very good.  I have only two very small nits:

> diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
> index e125770..b0f6644 100644
> --- a/drivers/usb/host/ohci-s3c2410.c
> +++ b/drivers/usb/host/ohci-s3c2410.c
> @@ -19,17 +19,34 @@
>   * This file is licenced under the GPL.
>  */
>  
> -#include <linux/platform_device.h>
>  #include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
>  #include <linux/platform_data/usb-ohci-s3c2410.h>
> +#include <linux/usb.h>
> +#include <linux/usb/hcd.h>
> +
> +#include "ohci.h"
> +
>  
>  #define valid_port(idx) ((idx) == 1 || (idx) == 2)
>  
>  /* clock device associated with the hcd */
>  
> +
> +#define DRIVER_DESC "OHCI S3CXXXX driver"
> +
> +static const char hcd_name[] = "ohci-s3cxxxx";
> +
>  static struct clk *clk;
>  static struct clk *usb_clk;
>  
> +static int (*orig_ohci_hub_control)(struct usb_hcd  *hcd, u16 typeReq,
> +			u16 wValue, u16 wIndex, char *buf, u16 wLength);
> +static int (*orig_ohci_hub_status_data)(struct usb_hcd *hcd, char *buf);
> +
>  /* forward definitions */

Do you understand what "forward definitions" means?  It refers to 
declarations of functions whose actual code is given later.  In other 
words, your declarations of orig_ohci_hub_control and 
orig_ohci_hub_status_data belong just after this comment, not just 
before it.

> @@ -93,7 +110,7 @@ ohci_s3c2410_hub_status_data(struct usb_hcd *hcd, char *buf)
>  	int orig;
>  	int portno;
>  
> -	orig  = ohci_hub_status_data(hcd, buf);
> +	orig  = orig_ohci_hub_status_data(hcd, buf);

Since you're changing the line anyway, you should get rid of the extra
space before the '='.

After you make those two changes, you can add my Acked-by.

Alan Stern
