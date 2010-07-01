From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 01 Jul 2010 15:45:02 +0200
Subject: [PATCH 2/3] at91_udc: Add vbus polarity and polling mode
In-Reply-To: <1277699955-9931-3-git-send-email-ryan@bluewatersys.com>
References: <1277699955-9931-1-git-send-email-ryan@bluewatersys.com>
	<1277699955-9931-3-git-send-email-ryan@bluewatersys.com>
Message-ID: <4C2C9BDE.8090504@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/06/2010 06:39, Ryan Mallon :
> Allow the vbus signal to optionally use polling. This is required if
> the vbus signal is connected to an non-interrupting io expander for
> example. If vbus is in polling mode, then it is assumed that the vbus
> gpio may sleep. Also add an option to have vbus be an active low
> signal. Both options are set in the platform data for the device.
> 
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>

Looks good, but... one question:

> @@ -1763,13 +1793,22 @@ static int __init at91udc_probe(struct platform_device *pdev)
>  		 * Get the initial state of VBUS - we cannot expect
>  		 * a pending interrupt.
>  		 */
> -		udc->vbus = gpio_get_value(udc->board.vbus_pin);
> -		if (request_irq(udc->board.vbus_pin, at91_vbus_irq,
> -				IRQF_DISABLED, driver_name, udc)) {
> -			DBG("request vbus irq %d failed\n",
> -					udc->board.vbus_pin);
> -			retval = -EBUSY;
> -			goto fail3;
> +		if (udc->board.vbus_polled) {
> +			udc->vbus = gpio_get_value_cansleep(udc->board.vbus_pin);

Shouldn't we need here something like:
udc->vbus =  (udc->board.vbus_active_low) ^ gpio_get_value_cansleep(udc->board.vbus_pin);

?

> +			INIT_WORK(&udc->vbus_timer_work, at91_vbus_timer_work);
> +			setup_timer(&udc->vbus_timer, at91_vbus_timer,
> +				    (unsigned long)udc);		
> +			mod_timer(&udc->vbus_timer,
> +				  jiffies + VBUS_POLL_TIMEOUT);
> +		} else {
> +			udc->vbus = gpio_get_value(udc->board.vbus_pin);

Ditto.

> +			if (request_irq(udc->board.vbus_pin, at91_vbus_irq,
> +					IRQF_DISABLED, driver_name, udc)) {
> +				DBG("request vbus irq %d failed\n",
> +				    udc->board.vbus_pin);
> +				retval = -EBUSY;
> +				goto fail3;
> +			}


Best regards,
-- 
Nicolas Ferre
