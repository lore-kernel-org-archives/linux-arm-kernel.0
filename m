From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 29 Mar 2011 10:00:19 +0200
Subject: [patch 23/29] arm: at91: Cleanup irq chip
In-Reply-To: <20110328170652.972256153@linutronix.de>
References: <20110328170219.059141076@linutronix.de>
	<20110328170652.972256153@linutronix.de>
Message-ID: <4D919193.2070601@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 28/03/2011 19:12, Thomas Gleixner :
> Avoid the whole lazy disable dance in the demux handler by providing a
> irq_disable() callback.
> 
> Use the proper accessor functions and tidy up gpio_irq_handler()
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Seems ok.

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/mach-at91/gpio.c |   31 +++++++++----------------------
>  1 file changed, 9 insertions(+), 22 deletions(-)
> 
> Index: linux-2.6-tip/arch/arm/mach-at91/gpio.c
> ===================================================================
> --- linux-2.6-tip.orig/arch/arm/mach-at91/gpio.c
> +++ linux-2.6-tip/arch/arm/mach-at91/gpio.c
> @@ -375,6 +375,7 @@ static int gpio_irq_type(struct irq_data
>  
>  static struct irq_chip gpio_irqchip = {
>  	.name		= "GPIO",
> +	.irq_disable	= gpio_irq_mask,
>  	.irq_mask	= gpio_irq_mask,
>  	.irq_unmask	= gpio_irq_unmask,
>  	.irq_set_type	= gpio_irq_type,
> @@ -384,16 +385,14 @@ static struct irq_chip gpio_irqchip = {
>  static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
>  {
>  	unsigned	pin;
> -	struct irq_desc	*gpio;
> -	struct at91_gpio_chip *at91_gpio;
> -	void __iomem	*pio;
> +	struct irq_data *idata = irq_desc_get_irq_data(desc);
> +	struct irq_chip *chip = irq_data_get_irq_chip(idata);
> +	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(idata);
> +	void __iomem	*pio = at91_gpio->regbase;
>  	u32		isr;
>  
> -	at91_gpio = get_irq_chip_data(irq);
> -	pio = at91_gpio->regbase;
> -
>  	/* temporarily mask (level sensitive) parent IRQ */
> -	desc->irq_data.chip->irq_ack(&desc->irq_data);
> +	chip->irq_ack(idata);
>  	for (;;) {
>  		/* Reading ISR acks pending (edge triggered) GPIO interrupts.
>  		 * When there none are pending, we're finished unless we need
> @@ -409,27 +408,15 @@ static void gpio_irq_handler(unsigned ir
>  		}
>  
>  		pin = at91_gpio->chip.base;
> -		gpio = &irq_desc[pin];
>  
>  		while (isr) {
> -			if (isr & 1) {
> -				if (unlikely(gpio->depth)) {
> -					/*
> -					 * The core ARM interrupt handler lazily disables IRQs so
> -					 * another IRQ must be generated before it actually gets
> -					 * here to be disabled on the GPIO controller.
> -					 */
> -					gpio_irq_mask(irq_get_irq_data(pin));
> -				}
> -				else
> -					generic_handle_irq(pin);
> -			}
> +			if (isr & 1)
> +				generic_handle_irq(pin);
>  			pin++;
> -			gpio++;
>  			isr >>= 1;
>  		}
>  	}
> -	desc->irq_data.chip->irq_unmask(&desc->irq_data);
> +	chip->irq_unmask(idata);
>  	/* now it may re-trigger */
>  }
>  
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Nicolas Ferre
