From: balbi@ti.com (Felipe Balbi)
Date: Tue, 23 Dec 2014 10:24:19 -0600
Subject: [PATCH] USB: gadget: udc: atmel: fix possible oops when
 unloading module
In-Reply-To: <1419240374-12179-1-git-send-email-songjun.wu@atmel.com>
References: <1419240374-12179-1-git-send-email-songjun.wu@atmel.com>
Message-ID: <20141223162419.GB9147@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 22, 2014 at 05:26:14PM +0800, Songjun Wu wrote:
> When unloading the module, the urb request will be dequeued
> and the completion routine will be excuted.
> If no urb packet, the urb request will not be added to the endpoint queue
> and the completion routine pointer in urb request is NULL.
> Accessing to the NULL function pointer will cause the oops issue.
> Add the code to check the urb request is in the endpoint queue or not.
> If the urb request is not in the endpoint queue, a negative error code
> will be returned.

have you triggered the NULL pointer oops ? Care to add it to the commit
log.

Also, which commit is this fixing ? Does this need to be backported ?
When was the bug introduced ?

> Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index ce88237..48629cc 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -828,7 +828,7 @@ static int usba_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  {
>  	struct usba_ep *ep = to_usba_ep(_ep);
>  	struct usba_udc *udc = ep->udc;
> -	struct usba_request *req = to_usba_req(_req);
> +	struct usba_request *req;
>  	unsigned long flags;
>  	u32 status;
>  
> @@ -837,6 +837,16 @@ static int usba_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
>  
>  	spin_lock_irqsave(&udc->lock, flags);
>  
> +	list_for_each_entry(req, &ep->queue, queue) {
> +		if (&req->req == _req)
> +			break;
> +	}
> +
> +	if (&req->req != _req) {
> +		spin_unlock_irqrestore(&udc->lock, flags);
> +		return -EINVAL;
> +	}
> +
>  	if (req->using_dma) {
>  		/*
>  		 * If this request is currently being transferred,
> -- 
> 1.7.9.5
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141223/bdbb74a1/attachment.sig>
