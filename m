From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Sep 2015 16:22:07 +0200
Subject: [PATCH linux-next] usb: gadget: atmel_usba_udc: add ep
 capabilities support on device tree binding
In-Reply-To: <1441657171-15362-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1441657171-15362-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <55FC1E0F.4070807@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 07/09/2015 22:19, Sylvain Rochet a ?crit :
> The recently added endpoint capabilities flags verification breaks Atmel
> USBA because the endpoint configuration was only added when the driver
> is bound using the legacy pdata interface.
> 
> Convert endpoint configuration to new capabilities model when driver is
> bound to a device tree as well.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

With this additional tag:
Fixes: 47bef3865115 ("usb: gadget: atmel_usba_udc: add ep capabilities support")

Felipe, Greg,

It is considered as a fix for 4.3. Can you please queue it for the "4.3-rc" phase?

Thanks, bye.

> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 2cbbb46..c2ea5e1 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -2002,6 +2002,17 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
>  		ep->udc = udc;
>  		INIT_LIST_HEAD(&ep->queue);
>  
> +		if (ep->index == 0) {
> +			ep->ep.caps.type_control = true;
> +		} else {
> +			ep->ep.caps.type_iso = ep->can_isoc;
> +			ep->ep.caps.type_bulk = true;
> +			ep->ep.caps.type_int = true;
> +		}
> +
> +		ep->ep.caps.dir_in = true;
> +		ep->ep.caps.dir_out = true;
> +
>  		if (i)
>  			list_add_tail(&ep->ep.ep_list, &udc->gadget.ep_list);
>  
> 


-- 
Nicolas Ferre
