From: rogerq@ti.com (Roger Quadros)
Date: Tue, 21 Jan 2014 15:53:09 +0200
Subject: [PATCH 1/2] usb: dwc3: core: continue probing if usb phy library
 returns -ENODEV/-ENXIO
In-Reply-To: <1390299099-14764-1-git-send-email-kishon@ti.com>
References: <1385373690-12170-1-git-send-email-kishon@ti.com>
 <1390299099-14764-1-git-send-email-kishon@ti.com>
Message-ID: <52DE7BC5.90001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/21/2014 12:11 PM, Kishon Vijay Abraham I wrote:
> Since PHYs for dwc3 is optional (not all SoCs that have DWC3 use PHYs),
> do not return from probe if the USB PHY library returns -ENODEV as that
> indicates the platform does not have PHY.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Reviewed-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

> ---
>  drivers/usb/dwc3/core.c |   34 ++++++++++++++--------------------
>  1 file changed, 14 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index a49217a..e009d4e 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -411,32 +411,26 @@ static int dwc3_probe(struct platform_device *pdev)
>  
>  	if (IS_ERR(dwc->usb2_phy)) {
>  		ret = PTR_ERR(dwc->usb2_phy);
> -
> -		/*
> -		 * if -ENXIO is returned, it means PHY layer wasn't
> -		 * enabled, so it makes no sense to return -EPROBE_DEFER
> -		 * in that case, since no PHY driver will ever probe.
> -		 */
> -		if (ret == -ENXIO)
> +		if (ret == -ENXIO || ret == -ENODEV) {
> +			dwc->usb2_phy = NULL;
> +		} else if (ret == -EPROBE_DEFER) {
>  			return ret;
> -
> -		dev_err(dev, "no usb2 phy configured\n");
> -		return -EPROBE_DEFER;
> +		} else {
> +			dev_err(dev, "no usb2 phy configured\n");
> +			return ret;
> +		}
>  	}
>  
>  	if (IS_ERR(dwc->usb3_phy)) {
>  		ret = PTR_ERR(dwc->usb3_phy);
> -
> -		/*
> -		 * if -ENXIO is returned, it means PHY layer wasn't
> -		 * enabled, so it makes no sense to return -EPROBE_DEFER
> -		 * in that case, since no PHY driver will ever probe.
> -		 */
> -		if (ret == -ENXIO)
> +		if (ret == -ENXIO || ret == -ENODEV) {
> +			dwc->usb3_phy = NULL;
> +		} else if (ret == -EPROBE_DEFER) {
>  			return ret;
> -
> -		dev_err(dev, "no usb3 phy configured\n");
> -		return -EPROBE_DEFER;
> +		} else {
> +			dev_err(dev, "no usb3 phy configured\n");
> +			return ret;
> +		}
>  	}
>  
>  	dwc->xhci_resources[0].start = res->start;
> 
