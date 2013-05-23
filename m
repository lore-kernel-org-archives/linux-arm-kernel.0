From: balbi@ti.com (Felipe Balbi)
Date: Thu, 23 May 2013 21:46:56 +0300
Subject: [PATCH 2/7] USB: gadget: atmel_usba: allow multi instance
In-Reply-To: <1369067160-3230-2-git-send-email-plagnioj@jcrosoft.com>
References: <20130520162149.GC9937@game.jcrosoft.org>
 <1369067160-3230-1-git-send-email-plagnioj@jcrosoft.com>
 <1369067160-3230-2-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20130523184656.GD19834@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 06:25:55PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> drop static struct usba_udc the_udc
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: linux-usb at vger.kernel.org

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/usb/gadget/atmel_usba_udc.c |   36 +++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/usb/gadget/atmel_usba_udc.c b/drivers/usb/gadget/atmel_usba_udc.c
> index d2ffd04..eea57a3 100644
> --- a/drivers/usb/gadget/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/atmel_usba_udc.c
> @@ -27,9 +27,6 @@
>  
>  #include "atmel_usba_udc.h"
>  
> -
> -static struct usba_udc the_udc;
> -
>  #ifdef CONFIG_USB_GADGET_DEBUG_FS
>  #include <linux/debugfs.h>
>  #include <linux/uaccess.h>
> @@ -1013,16 +1010,13 @@ static void nop_release(struct device *dev)
>  
>  }
>  
> -static struct usba_udc the_udc = {
> -	.gadget	= {
> -		.ops		= &usba_udc_ops,
> -		.ep_list	= LIST_HEAD_INIT(the_udc.gadget.ep_list),
> -		.max_speed	= USB_SPEED_HIGH,
> -		.name		= "atmel_usba_udc",
> -		.dev	= {
> -			.init_name	= "gadget",
> -			.release	= nop_release,
> -		},
> +struct usb_gadget usba_gadget_template = {
> +	.ops		= &usba_udc_ops,
> +	.max_speed	= USB_SPEED_HIGH,
> +	.name		= "atmel_usba_udc",
> +	.dev	= {
> +		.init_name	= "gadget",
> +		.release	= nop_release,
>  	},
>  };
>  
> @@ -1839,10 +1833,17 @@ static int __init usba_udc_probe(struct platform_device *pdev)
>  	struct usba_platform_data *pdata = pdev->dev.platform_data;
>  	struct resource *regs, *fifo;
>  	struct clk *pclk, *hclk;
> -	struct usba_udc *udc = &the_udc;
> +	struct usba_udc *udc;
>  	static struct usba_ep *usba_ep;
>  	int irq, ret, i;
>  
> +	udc = devm_kzalloc(&pdev->dev, sizeof(*udc), GFP_KERNEL);
> +	if (!udc)
> +		return -ENOMEM;
> +
> +	udc->gadget = usba_gadget_template;
> +	INIT_LIST_HEAD(&udc->gadget.ep_list);
> +
>  	regs = platform_get_resource(pdev, IORESOURCE_MEM, CTRL_IOMEM_ID);
>  	fifo = platform_get_resource(pdev, IORESOURCE_MEM, FIFO_IOMEM_ID);
>  	if (!regs || !fifo || !pdata)
> @@ -1897,8 +1898,7 @@ static int __init usba_udc_probe(struct platform_device *pdev)
>  		goto err_alloc_ep;
>  
>  	udc->usba_ep = usba_ep;
> -
> -	the_udc.gadget.ep0 = &usba_ep[0].ep;
> +	udc->gadget.ep0 = &usba_ep[0].ep;
>  
>  	INIT_LIST_HEAD(&usba_ep[0].ep.ep_list);
>  	usba_ep[0].ep_regs = udc->regs + USBA_EPT_BASE(0);
> @@ -1907,7 +1907,7 @@ static int __init usba_udc_probe(struct platform_device *pdev)
>  	usba_ep[0].ep.ops = &usba_ep_ops;
>  	usba_ep[0].ep.name = pdata->ep[0].name;
>  	usba_ep[0].ep.maxpacket = pdata->ep[0].fifo_size;
> -	usba_ep[0].udc = &the_udc;
> +	usba_ep[0].udc = udc;
>  	INIT_LIST_HEAD(&usba_ep[0].queue);
>  	usba_ep[0].fifo_size = pdata->ep[0].fifo_size;
>  	usba_ep[0].nr_banks = pdata->ep[0].nr_banks;
> @@ -1924,7 +1924,7 @@ static int __init usba_udc_probe(struct platform_device *pdev)
>  		ep->ep.ops = &usba_ep_ops;
>  		ep->ep.name = pdata->ep[i].name;
>  		ep->ep.maxpacket = pdata->ep[i].fifo_size;
> -		ep->udc = &the_udc;
> +		ep->udc = udc;
>  		INIT_LIST_HEAD(&ep->queue);
>  		ep->fifo_size = pdata->ep[i].fifo_size;
>  		ep->nr_banks = pdata->ep[i].nr_banks;
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130523/4d1de033/attachment-0001.sig>
