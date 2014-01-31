From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 31 Jan 2014 09:35:41 -0500
Subject: [PATCH] usb: dwc3: keystone: switch to use runtime pm
In-Reply-To: <1391174426-13773-1-git-send-email-grygorii.strashko@ti.com>
References: <1391174426-13773-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <52EBB4BD.8070808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 January 2014 08:20 AM, Grygorii Strashko wrote:
> The Keystone PM management layer has been implemented using PM bus for
> power management clocks. As result, most of Keystone drivers don't need
> to manage clocks directly. They just need to enable runtime PM and use it
> to handle their PM state and clocks.
> 
> Hence, remove clock management code and switch to use runtime PM.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
Please capture why now it allowes us to remove the clock code.
Commit 8a6720e {PM / clock_ops: fix up clk prepare/unprepare count}

Without that information, the change log will be miss-leading

>  drivers/usb/dwc3/dwc3-keystone.c |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
> index 1fad161..a810b41 100644
> --- a/drivers/usb/dwc3/dwc3-keystone.c
> +++ b/drivers/usb/dwc3/dwc3-keystone.c
> @@ -23,6 +23,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/io.h>
>  #include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
>  
>  /* USBSS register offsets */
>  #define USBSS_REVISION		0x0000
> @@ -116,12 +117,10 @@ static int kdwc3_probe(struct platform_device *pdev)
>  	kdwc3_dma_mask = dma_get_mask(dev);
>  	dev->dma_mask = &kdwc3_dma_mask;
>  
> -	kdwc->clk = devm_clk_get(kdwc->dev, "usb");
> -
> -	error = clk_prepare_enable(kdwc->clk);
> +	pm_runtime_enable(dev);
> +	error = pm_runtime_get_sync(dev);
>  	if (error < 0) {
> -		dev_dbg(kdwc->dev, "unable to enable usb clock, err %d\n",
> -			error);
> +		dev_dbg(dev, "unable to enable usb dev, err %d\n", error);
>  		return error;
>  	}
>  
> @@ -152,7 +151,8 @@ static int kdwc3_probe(struct platform_device *pdev)
>  err_core:
>  	kdwc3_disable_irqs(kdwc);
>  err_irq:
> -	clk_disable_unprepare(kdwc->clk);
> +	pm_runtime_put_sync(dev);
> +	pm_runtime_disable(dev);
>  
>  	return error;
>  }
> @@ -172,7 +172,8 @@ static int kdwc3_remove(struct platform_device *pdev)
>  
>  	kdwc3_disable_irqs(kdwc);
>  	device_for_each_child(&pdev->dev, NULL, kdwc3_remove_core);
> -	clk_disable_unprepare(kdwc->clk);
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
>  	platform_set_drvdata(pdev, NULL);
>  
>  	return 0;
> 
