From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 28 Aug 2017 13:18:50 -0500
Subject: [PATCH V2] usb: dwc3: Initialize DMA ops/mask for xhci-hcd
In-Reply-To: <1503938110-23712-1-git-send-email-awallis@codeaurora.org>
References: <1503938110-23712-1-git-send-email-awallis@codeaurora.org>
Message-ID: <5e764550-5104-e132-5b68-8f91a1ad6f33@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 08/28/2017 11:35 AM, Adam Wallis wrote:
> The dma ops from the parent DWC device are not getting passed to the
> child xhci-hcd device. This patch makes use of
> platform_device_register_full to set the DMA ops. For the DT/OF case,
> dma_ops were still null after the the device register, so
> of_dma_configure is called in only the OF case.

1) And how this is different form
https://patchwork.kernel.org/patch/8931771/
which was not accepted and which is actually my solution.

2) How platform_device_register_full can help with DMA setting?

3) I've did some search and provided you with links not for fun
but to provide you with useful information, so you can find out that 
xhci-hcd device is not expected to be used for dma, but sysdev is.
And if xhci-hcd is not working for you it means current code has
some issue with sysdev initialization or some part of USB code not updated 
properly to use sysydev.

NACK

> 
> Signed-off-by: Adam Wallis <awallis@codeaurora.org>
> ---
>   drivers/usb/dwc3/host.c | 39 +++++++++++++++++----------------------
>   1 file changed, 17 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index 76f0b0d..c289da1 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -16,6 +16,7 @@
>    */
>   
>   #include <linux/platform_device.h>
> +#include <linux/of_platform.h>
>   
>   #include "core.h"
>   
> @@ -56,6 +57,7 @@ int dwc3_host_init(struct dwc3 *dwc)
>   {
>   	struct property_entry	props[3];
>   	struct platform_device	*xhci;
> +	struct platform_device_info dwc_plat_info = {};
>   	int			ret, irq;
>   	struct resource		*res;
>   	struct platform_device	*dwc3_pdev = to_platform_device(dwc->dev);
> @@ -79,22 +81,22 @@ int dwc3_host_init(struct dwc3 *dwc)
>   	dwc->xhci_resources[1].flags = res->flags;
>   	dwc->xhci_resources[1].name = res->name;
>   
> -	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
> -	if (!xhci) {
> -		dev_err(dwc->dev, "couldn't allocate xHCI device\n");
> -		return -ENOMEM;
> -	}
> +	dwc_plat_info.name = "xhci-hcd";
> +	dwc_plat_info.parent = dwc->sysdev;
> +	dwc_plat_info.res = dwc->xhci_resources;
> +	dwc_plat_info.num_res = DWC3_XHCI_RESOURCES_NUM;
> +	dwc_plat_info.fwnode = dwc->sysdev->fwnode;
> +	dwc_plat_info.dma_mask = *dwc->sysdev->dma_mask;
>   
> -	xhci->dev.parent	= dwc->dev;
> +	xhci = platform_device_register_full(&dwc_plat_info);
> +	if (IS_ERR(xhci)) {
> +		dev_err(dwc->dev, "failed to register xHCI device\n");
> +		return PTR_ERR(xhci);
> +	}
>   
>   	dwc->xhci = xhci;
> -
> -	ret = platform_device_add_resources(xhci, dwc->xhci_resources,
> -						DWC3_XHCI_RESOURCES_NUM);
> -	if (ret) {
> -		dev_err(dwc->dev, "couldn't add resources to xHCI device\n");
> -		goto err1;
> -	}
> +	if (dwc->sysdev->of_node)
> +		of_dma_configure(&xhci->dev, dwc->sysdev->of_node);
>   
>   	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
>   
> @@ -117,7 +119,7 @@ int dwc3_host_init(struct dwc3 *dwc)
>   		ret = platform_device_add_properties(xhci, props);
>   		if (ret) {
>   			dev_err(dwc->dev, "failed to add properties to xHCI\n");
> -			goto err1;
> +			goto err;
>   		}
>   	}
>   
> @@ -126,19 +128,12 @@ int dwc3_host_init(struct dwc3 *dwc)
>   	phy_create_lookup(dwc->usb3_generic_phy, "usb3-phy",
>   			  dev_name(dwc->dev));
>   
> -	ret = platform_device_add(xhci);
> -	if (ret) {
> -		dev_err(dwc->dev, "failed to register xHCI device\n");
> -		goto err2;
> -	}
> -
>   	return 0;
> -err2:
> +err:
>   	phy_remove_lookup(dwc->usb2_generic_phy, "usb2-phy",
>   			  dev_name(dwc->dev));
>   	phy_remove_lookup(dwc->usb3_generic_phy, "usb3-phy",
>   			  dev_name(dwc->dev));
> -err1:
>   	platform_device_put(xhci);
>   	return ret;
>   }
> 

-- 
regards,
-grygorii
