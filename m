From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 18 Dec 2014 18:22:10 +0100
Subject: [PATCH 2/2] USB: gadget: udc: atmel: fix possible IN hang issue
In-Reply-To: <1418807929-31952-2-git-send-email-voice.shen@atmel.com>
References: <1418807929-31952-1-git-send-email-voice.shen@atmel.com>
 <1418807929-31952-2-git-send-email-voice.shen@atmel.com>
Message-ID: <54930D42.2010306@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 17/12/2014 10:18, Bo Shen a ?crit :
> When receive data, the RXRDY in status register set by hardware
> after a new packet has been stored in the endpoint FIFO. When it
> is copied from FIFO, this bit is cleared which make the FIFO can
> be accessed again.
> 
> In the receive_data() function, this bit RXRDY has been cleared.
> So, after the receive_data() function return, this bit should
> not be cleared again, or else it may cause the accessing FIFO
> corrupt, which will make the data loss.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>


Seems okay:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Like the former one:

Fixes: 914a3f3b3754 (USB: add atmel_usba_udc driver)
Cc: stable at vger.kernel.org # always been there...

> ---
> 
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 63e90f5..93328ea 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -1563,7 +1563,6 @@ static void usba_ep_irq(struct usba_udc *udc, struct usba_ep *ep)
>  	if ((epstatus & epctrl) & USBA_RX_BK_RDY) {
>  		DBG(DBG_BUS, "%s: RX data ready\n", ep->ep.name);
>  		receive_data(ep);
> -		usba_ep_writel(ep, CLR_STA, USBA_RX_BK_RDY);
>  	}
>  }
>  
> 


-- 
Nicolas Ferre
