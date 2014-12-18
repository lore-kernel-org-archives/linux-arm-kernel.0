From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Dec 2014 18:20:39 +0100
Subject: [PATCH 1/2] USB: gadget: udc: atmel: change setting for DMA
In-Reply-To: <1418807929-31952-1-git-send-email-voice.shen@atmel.com>
References: <1418807929-31952-1-git-send-email-voice.shen@atmel.com>
Message-ID: <54930CE7.50008@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 17/12/2014 10:18, Bo Shen a ?crit :
> According to the datasheet, when transfer using DMA, the control
> setting for IN packet only need END_BUF_EN, END_BUF_IE, CH_EN,
> while for OUT packet, need more two bits END_TR_EN and END_TR_IE
> to be configured.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Seems okay, even if I am not used to these aspects:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I would also add a "stable" tag to these patches, something like this:

Fixes: 914a3f3b3754 (USB: add atmel_usba_udc driver)
Cc: stable at vger.kernel.org # always been there...


Felipe,

Can you take both of these patches as fixes?

> ---
> 
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index ce88237..63e90f5 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -716,10 +716,10 @@ static int queue_dma(struct usba_udc *udc, struct usba_ep *ep,
>  	req->using_dma = 1;
>  	req->ctrl = USBA_BF(DMA_BUF_LEN, req->req.length)
>  			| USBA_DMA_CH_EN | USBA_DMA_END_BUF_IE
> -			| USBA_DMA_END_TR_EN | USBA_DMA_END_TR_IE;
> +			| USBA_DMA_END_BUF_EN;
>  
> -	if (ep->is_in)
> -		req->ctrl |= USBA_DMA_END_BUF_EN;
> +	if (!ep->is_in)
> +		req->ctrl |= USBA_DMA_END_TR_EN | USBA_DMA_END_TR_IE;
>  
>  	/*
>  	 * Add this request to the queue and submit for DMA if
> 


-- 
Nicolas Ferre
