From: julia@diku.dk (Julia Lawall)
Date: Mon, 2 Aug 2010 14:51:36 +0200 (CEST)
Subject: [PATCH] usb gadget: don't save bind callback in struct
	usb_gadget_driver
In-Reply-To: <1280752803-11441-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <op.vgs04dub7p4s8u@pikus>
	<1280752803-11441-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <Pine.LNX.4.64.1008021446470.10662@ask.diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/drivers/usb/gadget/amd5536udc.c b/drivers/usb/gadget/amd5536udc.c
> index 731150d..c266c1e 100644
> --- a/drivers/usb/gadget/amd5536udc.c
> +++ b/drivers/usb/gadget/amd5536udc.c
> @@ -1954,13 +1954,14 @@ static int setup_ep0(struct udc *dev)
>  }
>  
>  /* Called by gadget driver to register itself */
> -int usb_gadget_register_driver(struct usb_gadget_driver *driver)
> +int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
> +		int (*bind)(struct usb_gadget *))
>  {
>  	struct udc		*dev = udc;
>  	int			retval;
>  	u32 tmp;
>  
> -	if (!driver || !driver->bind || !driver->setup
> +	if (!driver || bind || !driver->setup

I have the impression that this should be !bind rather than bind.  
That would be like what is done in the patch for 
drivers/usb/gadget/fsl_udc_core.c below


> diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
> index 08a9a62..c16b402 100644
> --- a/drivers/usb/gadget/fsl_udc_core.c
> +++ b/drivers/usb/gadget/fsl_udc_core.c
> @@ -1765,7 +1765,8 @@ static irqreturn_t fsl_udc_irq(int irq, void *_udc)
>   * Hook to gadget drivers
>   * Called by initialization code of gadget drivers
>  *----------------------------------------------------------------*/
> -int usb_gadget_register_driver(struct usb_gadget_driver *driver)
> +int usb_gadget_probe_driver(struct usb_gadget_driver *driver,
> +		int (*bind)(struct usb_gadget *))
>  {
>  	int retval = -ENODEV;
>  	unsigned long flags = 0;
> @@ -1775,8 +1776,7 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
>  
>  	if (!driver || (driver->speed != USB_SPEED_FULL
>  				&& driver->speed != USB_SPEED_HIGH)
> -			|| !driver->bind || !driver->disconnect
> -			|| !driver->setup)
> +			|| !bind || !driver->disconnect || !driver->setup)
>  		return -EINVAL;

Here !driver->bind is converted to !bind.

julia
