From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 29 Mar 2011 09:49:52 +0200
Subject: [patch 29/29] arm: Fold irq_set_chip/irq_set_handler
In-Reply-To: <20110328170653.550118582@linutronix.de>
References: <20110328170219.059141076@linutronix.de>
	<20110328170653.550118582@linutronix.de>
Message-ID: <4D918F20.8050301@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/03/2011 19:12, Thomas Gleixner :
> Use irq_set_chip_and_handler() instead. Converted with coccinelle.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---

[..]


>  arch/arm/mach-at91/gpio.c               |    4 ++--
>  arch/arm/mach-at91/irq.c                |    3 +--

[..]

> Index: linux-2.6-tip/arch/arm/mach-at91/gpio.c
> ===================================================================
> --- linux-2.6-tip.orig/arch/arm/mach-at91/gpio.c
> +++ linux-2.6-tip/arch/arm/mach-at91/gpio.c
> @@ -511,8 +511,8 @@ void __init at91_gpio_irq_setup(void)
>  			 * Can use the "simple" and not "edge" handler since it's
>  			 * shorter, and the AIC handles interrupts sanely.
>  			 */
> -			irq_set_chip(pin, &gpio_irqchip);
> -			irq_set_handler(pin, handle_simple_irq);
> +			irq_set_chip_and_handler(pin, &gpio_irqchip,
> +						 handle_simple_irq);
>  			set_irq_flags(pin, IRQF_VALID);
>  		}
>  
> Index: linux-2.6-tip/arch/arm/mach-at91/irq.c
> ===================================================================
> --- linux-2.6-tip.orig/arch/arm/mach-at91/irq.c
> +++ linux-2.6-tip/arch/arm/mach-at91/irq.c
> @@ -143,8 +143,7 @@ void __init at91_aic_init(unsigned int p
>  		/* Active Low interrupt, with the specified priority */
>  		at91_sys_write(AT91_AIC_SMR(i), AT91_AIC_SRCTYPE_LOW | priority[i]);
>  
> -		irq_set_chip(i, &at91_aic_chip);
> -		irq_set_handler(i, handle_level_irq);
> +		irq_set_chip_and_handler(i, &at91_aic_chip, handle_level_irq);
>  		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
>  
>  		/* Perform 8 End Of Interrupt Command to make sure AIC will not Lock out nIRQ */

[..]

Thanks a lot Thomas,

Best regards,
-- 
Nicolas Ferre
