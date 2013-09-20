From: balbi@ti.com (Felipe Balbi)
Date: Fri, 20 Sep 2013 08:08:53 -0500
Subject: [PATCH 36/51] DMA-API: usb: use dma_set_coherent_mask()
In-Reply-To: <E1VMmHX-0007jq-Cj@rmk-PC.arm.linux.org.uk>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMmHX-0007jq-Cj@rmk-PC.arm.linux.org.uk>
Message-ID: <20130920130853.GM26101@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 19, 2013 at 11:01:03PM +0100, Russell King wrote:
> diff --git a/drivers/usb/dwc3/dwc3-exynos.c b/drivers/usb/dwc3/dwc3-exynos.c
> index 2f2e88a..c10b324 100644
> --- a/drivers/usb/dwc3/dwc3-exynos.c
> +++ b/drivers/usb/dwc3/dwc3-exynos.c
> @@ -121,8 +121,9 @@ static int dwc3_exynos_probe(struct platform_device *pdev)
>  	 */
>  	if (!dev->dma_mask)
>  		dev->dma_mask = &dev->coherent_dma_mask;
> -	if (!dev->coherent_dma_mask)
> -		dev->coherent_dma_mask = DMA_BIT_MASK(32);
> +	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		goto err1;
>  
>  	platform_set_drvdata(pdev, exynos);
>  
> diff --git a/drivers/usb/gadget/lpc32xx_udc.c b/drivers/usb/gadget/lpc32xx_udc.c
> index 67128be..6a2a65a 100644
> --- a/drivers/usb/gadget/lpc32xx_udc.c
> +++ b/drivers/usb/gadget/lpc32xx_udc.c
> @@ -3078,7 +3078,9 @@ static int __init lpc32xx_udc_probe(struct platform_device *pdev)
>  		 udc->isp1301_i2c_client->addr);
>  
>  	pdev->dev.dma_mask = &lpc32xx_usbd_dmamask;
> -	pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +	retval = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
> +	if (retval)
> +		goto resource_fail;
>  
>  	udc->board = &lpc32xx_usbddata;
>  

for dwc3 and drivers/usb/gadget:

Acked-by: Felipe Balbi <balbi@ti.com>

pretty cool work :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130920/1f6a5e93/attachment.sig>
