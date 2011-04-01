From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Fri, 01 Apr 2011 23:02:33 +0400
Subject: [PATCH 6/7] pxa25x: drop handling of udc_is_connected
In-Reply-To: <1301666188-11822-6-git-send-email-dbaryshkov@gmail.com>
References: <1301666188-11822-1-git-send-email-dbaryshkov@gmail.com>
	<1301666188-11822-6-git-send-email-dbaryshkov@gmail.com>
Message-ID: <4D962149.9090507@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Dmitry Eremin-Solenikov wrote:

> There are no more users of udc_is_connected. Drop this field from mach_info

    If I don't mistake, this patch does more than just that.

> and stop using it in pxa25x_udc.

    Hm, I don't see where you're doing that. Instead you're changing some checks 
for gadget speed and adding some code. And you've said that the driver never 
used that thing before. Hm?

> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
[...]

> diff --git a/drivers/usb/gadget/pxa25x_udc.c b/drivers/usb/gadget/pxa25x_udc.c
> index 6cb32b8..40ceb73 100644
> --- a/drivers/usb/gadget/pxa25x_udc.c
> +++ b/drivers/usb/gadget/pxa25x_udc.c
> @@ -1072,7 +1072,7 @@ udc_seq_show(struct seq_file *m, void *_d)
>  			(tmp & UDCCFR_ACM) ? " acm" : "");
>  	}
>  
> -	if (dev->gadget.speed != USB_SPEED_FULL || !dev->driver)
> +	if (dev->gadget.speed == USB_SPEED_UNKNOWN || !dev->driver)
>  		goto done;
>  
>  	seq_printf(m, "ep0 IN %lu/%lu, OUT %lu/%lu\nirqs %lu\n\n",
> @@ -1700,9 +1700,13 @@ pxa25x_udc_irq(int irq, void *_dev)
>  		if (unlikely(udccr & UDCCR_SUSIR)) {
>  			udc_ack_int_UDCCR(UDCCR_SUSIR);
>  			handled = 1;
> -			DBG(DBG_VERBOSE, "USB suspend\n");
> +			DBG(DBG_VERBOSE, "USB suspend%s\n",
> +				dev->gadget.speed != USB_SPEED_UNKNOWN
> +				? "" : "+disconnect");
>  
> -			if (dev->gadget.speed != USB_SPEED_UNKNOWN
> +			if (dev->gadget.speed == USB_SPEED_UNKNOWN)
> +				stop_activity(dev, dev->driver);
> +			else if (dev->gadget.speed != USB_SPEED_UNKNOWN

    This is redundant, as it will always be true after your first *if*.

WBR, Sergei
