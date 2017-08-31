From: ludovic.desroches@microchip.com (Ludovic Desroches)
Date: Thu, 31 Aug 2017 15:02:33 +0200
Subject: [PATCH RESEND new email address] usb: gadget: udc: atmel: set
 vbus irqflags explicitly
In-Reply-To: <20170831125140.21600-1-nicolas.ferre@microchip.com>
References: <20170831124820.21423-1-nicolas.ferre@microchip.com>
 <20170831125140.21600-1-nicolas.ferre@microchip.com>
Message-ID: <20170831130233.enztdnkaj7dgg5gj@rfolt0960.corp.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 02:51:40PM +0200, Nicolas Ferre wrote:
> The driver triggers actions on both edges of the vbus signal.
> 
> The former PIO controller was triggering IRQs on both falling and rising edges
> by default. Newer PIO controller don't, so it's better to set it explicitly to
> IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING.
> 
> Without this patch we may trigger the connection with host but only on some
> bouncing signal conditions and thus lose connecting events.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> Cc: stable <stable@vger.kernel.org> # v4.4+
> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 98d71400f8a1..a884c022df7a 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -29,6 +29,8 @@
>  #include <linux/of_gpio.h>
>  
>  #include "atmel_usba_udc.h"
> +#define USBA_VBUS_IRQFLAGS (IRQF_ONESHOT \
> +			   | IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING)
>  
>  #ifdef CONFIG_USB_GADGET_DEBUG_FS
>  #include <linux/debugfs.h>
> @@ -2361,7 +2363,7 @@ static int usba_udc_probe(struct platform_device *pdev)
>  					IRQ_NOAUTOEN);
>  			ret = devm_request_threaded_irq(&pdev->dev,
>  					gpio_to_irq(udc->vbus_pin), NULL,
> -					usba_vbus_irq_thread, IRQF_ONESHOT,
> +					usba_vbus_irq_thread, USBA_VBUS_IRQFLAGS,
>  					"atmel_usba_udc", udc);
>  			if (ret) {
>  				udc->vbus_pin = -ENODEV;
> -- 
> 2.9.0
> 
