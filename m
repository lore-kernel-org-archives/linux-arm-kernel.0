From: balbi@ti.com (Felipe Balbi)
Date: Thu, 12 Dec 2013 15:43:06 -0600
Subject: [PATCH 1/7] usb: dwc3: keystone: add basic PM support
In-Reply-To: <1386884325-11440-2-git-send-email-balbi@ti.com>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
 <1386884325-11440-2-git-send-email-balbi@ti.com>
Message-ID: <20131212214306.GS1939@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 03:38:39PM -0600, Felipe Balbi wrote:
> A bare-minimum PM implementation which will
> server as building block for more complex
> PM implementation in the future.
> 
> At the least will not leave clocks on unnecessarily
> when e.g.  a user write mem to /sys/power/state.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/usb/dwc3/dwc3-keystone.c | 97 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 94 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
> index 1fad161..361437f 100644
> --- a/drivers/usb/dwc3/dwc3-keystone.c
> +++ b/drivers/usb/dwc3/dwc3-keystone.c
> @@ -21,6 +21,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/io.h>
>  #include <linux/of_platform.h>
>  
> @@ -118,13 +119,23 @@ static int kdwc3_probe(struct platform_device *pdev)
>  
>  	kdwc->clk = devm_clk_get(kdwc->dev, "usb");
>  
> -	error = clk_prepare_enable(kdwc->clk);
> +	error = clk_prepare(kdwc->clk);
>  	if (error < 0) {
>  		dev_dbg(kdwc->dev, "unable to enable usb clock, err %d\n",
>  			error);
>  		return error;
>  	}
>  
> +	pm_runtime_enable(dev);
> +
> +	error = pm_runtime_get_sync(dev);
> +	if (error < 0) {
> +		dev_dbg(dev, "unable to pm_runtime_get_sync(), err %d\n",
> +				error);
> +		pm_runtime_put_sync(dev);

I can move this pm_runtime_sync() to error path, will refresh this
patch.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/48ff909e/attachment.sig>
