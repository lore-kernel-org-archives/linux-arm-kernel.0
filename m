From: balbi@ti.com (Felipe Balbi)
Date: Fri, 28 Sep 2012 15:58:41 +0300
Subject: [PATCH 2/6] usb: dwc3-omap: use runtime API's to enable clocks
In-Reply-To: <1348836795-4783-3-git-send-email-kishon@ti.com>
References: <1348836795-4783-1-git-send-email-kishon@ti.com>
 <1348836795-4783-3-git-send-email-kishon@ti.com>
Message-ID: <20120928125840.GL31006@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 28, 2012 at 06:23:11PM +0530, Kishon Vijay Abraham I wrote:
> Before accessing any register, runtime API's should be invoked to enable
> the clocks. runtime API's are added here to prevent abort during register
> access.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/usb/dwc3/dwc3-omap.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> index 34578de..6a0e17f 100644
> --- a/drivers/usb/dwc3/dwc3-omap.c
> +++ b/drivers/usb/dwc3/dwc3-omap.c
> @@ -43,6 +43,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/platform_device.h>
>  #include <linux/platform_data/dwc3-omap.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/ioport.h>
>  #include <linux/io.h>
> @@ -281,6 +282,13 @@ static int __devinit dwc3_omap_probe(struct platform_device *pdev)
>  	omap->irq	= irq;
>  	omap->base	= base;
>  
> +	pm_runtime_enable(dev);
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "get_sync failed with err %d\n", ret);
> +			goto err1;
> +	}
> +
>  	reg = dwc3_omap_readl(omap->base, USBOTGSS_UTMI_OTG_STATUS);
>  
>  	utmi_mode = of_get_property(node, "utmi-mode", &size);
> @@ -354,6 +362,8 @@ err1:
>  static int __devexit dwc3_omap_remove(struct platform_device *pdev)
>  {
>  	device_for_each_child(&pdev->dev, NULL, dwc3_remove_core);
> +	pm_runtime_put(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);

You're going to disable pm_runtime here, so it's better to use
pm_runtime_put_sync(), I guess ??

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120928/b821abd0/attachment.sig>
