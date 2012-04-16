From: balbi@ti.com (Felipe Balbi)
Date: Mon, 16 Apr 2012 12:22:47 +0300
Subject: [PATCH 12/12] USB: gadget/at91_udc: add gpio_to_irq() function
 to vbus interrupt
In-Reply-To: <041833f4078b6c28cf8a286fad8982bfae18f4b8.1334567594.git.nicolas.ferre@atmel.com>
References: <cover.1334567594.git.nicolas.ferre@atmel.com>
 <041833f4078b6c28cf8a286fad8982bfae18f4b8.1334567594.git.nicolas.ferre@atmel.com>
Message-ID: <20120416092246.GH30878@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2012 at 11:20:56AM +0200, Nicolas Ferre wrote:
> Now that we are using irqdomains, we need to convert GPIO pins to Linux
> IRQ numbers using the gpio_to_irq() function.
> This call is added to request/free_irq calls.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: linux-usb at vger.kernel.org

Please carry on with your series, patches looks fine.

Acked-by: Felipe Balbi <balbi@ti.com>

> ---
>  drivers/usb/gadget/at91_udc.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
> index 0c935d7..9d7bcd9 100644
> --- a/drivers/usb/gadget/at91_udc.c
> +++ b/drivers/usb/gadget/at91_udc.c
> @@ -1863,8 +1863,8 @@ static int __devinit at91udc_probe(struct platform_device *pdev)
>  			mod_timer(&udc->vbus_timer,
>  				  jiffies + VBUS_POLL_TIMEOUT);
>  		} else {
> -			if (request_irq(udc->board.vbus_pin, at91_vbus_irq,
> -					0, driver_name, udc)) {
> +			if (request_irq(gpio_to_irq(udc->board.vbus_pin),
> +					at91_vbus_irq, 0, driver_name, udc)) {
>  				DBG("request vbus irq %d failed\n",
>  				    udc->board.vbus_pin);
>  				retval = -EBUSY;
> @@ -1886,7 +1886,7 @@ static int __devinit at91udc_probe(struct platform_device *pdev)
>  	return 0;
>  fail4:
>  	if (gpio_is_valid(udc->board.vbus_pin) && !udc->board.vbus_polled)
> -		free_irq(udc->board.vbus_pin, udc);
> +		free_irq(gpio_to_irq(udc->board.vbus_pin), udc);
>  fail3:
>  	if (gpio_is_valid(udc->board.vbus_pin))
>  		gpio_free(udc->board.vbus_pin);
> @@ -1924,7 +1924,7 @@ static int __exit at91udc_remove(struct platform_device *pdev)
>  	device_init_wakeup(&pdev->dev, 0);
>  	remove_debug_file(udc);
>  	if (gpio_is_valid(udc->board.vbus_pin)) {
> -		free_irq(udc->board.vbus_pin, udc);
> +		free_irq(gpio_to_irq(udc->board.vbus_pin), udc);
>  		gpio_free(udc->board.vbus_pin);
>  	}
>  	free_irq(udc->udp_irq, udc);
> -- 
> 1.7.10
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120416/31a8e606/attachment-0001.sig>
