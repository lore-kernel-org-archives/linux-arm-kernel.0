From: stern@rowland.harvard.edu (Alan Stern)
Date: Sat, 20 Oct 2012 22:02:21 -0400 (EDT)
Subject: [PATCH v2 1/2] USB: Update EHCI-platform driver to devicetree.
In-Reply-To: <1350771032-11527-2-git-send-email-linux@prisktech.co.nz>
Message-ID: <Pine.LNX.4.44L0.1210202155430.5948-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 21 Oct 2012, Tony Prisk wrote:

> This patch adds devicetree support to the EHCI-platform driver,
> and removes the now unneeded ehci-vt8500.c
> 
> Existing platform properties are maintained, with the exception
> the power_(on/off) and suspend function pointers.

Unfortunately this can't be accepted as is, because Florian's patches 
are ahead of yours in the queue.  You'll have to respin this after his 
stuff has been merged.

> --- a/drivers/usb/host/ehci-platform.c
> +++ b/drivers/usb/host/ehci-platform.c
> @@ -19,6 +19,7 @@
>   * Licensed under the GNU/GPL. See COPYING for details.
>   */
>  #include <linux/platform_device.h>
> +#include <linux/of.h>
>  #include <linux/usb/ehci_pdriver.h>
>  
>  static int ehci_platform_reset(struct usb_hcd *hcd)
> @@ -78,14 +79,60 @@ static const struct hc_driver ehci_platform_hc_driver = {
>  	.clear_tt_buffer_complete = ehci_clear_tt_buffer_complete,
>  };
>  
> +static u64 ehci_dma_mask = DMA_BIT_MASK(32);

Just out of curiosity...  Instead of adding this same code (which will
all have to be removed later) to millions of drivers, why doesn't
somebody add support for DMA masks into DT?

> +		 * No platform data is being passed, so initalize pdata.
> +		 * Limitation: we can't support power_on, power_off or
> +		 * power_suspend function pointers from DT.
> +		 * TODO: The missing functions could be replaced with
> +		 * power sequence handlers.
> +		 */
> +		pdata = devm_kzalloc(&dev->dev, sizeof(*pdata), GFP_KERNEL);
> +		dev->dev.platform_data = pdata;
> +
> +		if (!pdata) {
> +			pr_err("device tree platform data allocation failed\n");

Don't use pr_err; use dev_err.

> @@ -101,7 +148,7 @@ static int __devinit ehci_platform_probe(struct platform_device *dev)
>  	}
>  	res_mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
>  	if (!res_mem) {
> -		pr_err("no memory recourse provided");
> +		pr_err("no memory resource provided");

This has already been fixed in Florian's patches.

>  
> @@ -163,6 +210,7 @@ static int __devexit ehci_platform_remove(struct platform_device *dev)
>  	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
>  	usb_put_hcd(hcd);
>  	platform_set_drvdata(dev, NULL);
> +	devm_kfree(&dev->dev, pdata);

This isn't needed.  That's the whole point of the devm_* family of 
routines; the resources they allocate are automatically released when 
the device is removed.

> --- a/include/linux/usb/ehci_pdriver.h
> +++ b/include/linux/usb/ehci_pdriver.h
> @@ -41,6 +41,7 @@ struct usb_ehci_pdata {
>  	unsigned	big_endian_mmio:1;
>  	unsigned	port_power_on:1;
>  	unsigned	port_power_off:1;
> +	unsigned	no_io_watchdog:1;

This is also in Florian's patches.

Alan Stern
