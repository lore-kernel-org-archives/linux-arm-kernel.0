From: alexanders83@web.de (Alexander Stein)
Date: Thu, 24 Apr 2014 00:34:56 +0200
Subject: [PATCH] pinctrl/at91: Fix lockup when IRQ on PIOC and PIOD occurs
In-Reply-To: <1398289203-2407-1-git-send-email-alexanders83@web.de>
References: <1398289203-2407-1-git-send-email-alexanders83@web.de>
Message-ID: <7797320.MSqOMXU9Wd@kongar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry,

drop that. This one creates another issue with that linear IRQ mapping. The correct bits from the correct register is read (which is what I checked), but unfortunatly irq_find_mapping now only returns mappings for PIOC :(
I will rework that.

Alexander

On Wednesday 23 April 2014, 23:40:03 wrote Alexander Stein:
> With commit 8d56dfcc (pinctrl/at91: convert driver to use gpiolib irqchip)
> gpiochip_set_chained_irqchip is called for PIOC, PIOD and PIOE. The
> associated GPIO chip for the IRQ chip is overwritten each time, because
> they share the same hard IRQ line.
> Thus if an IRQ occurs on PIOC or PIOD, gpio_irq_handler will only check on
> PIOE (the assigned GPIO chip) where no event occured. Thus the IRQ will
> not be cleared, retriggering the ISR.
> Fix that (like done before) by only set the PIOC GPIO chip to the IRQ chip.
> 
> Signed-off-by: Alexander Stein <alexanders83@web.de>
> ---
>  drivers/pinctrl/pinctrl-at91.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> index 64a8f8f..dd7d3e4 100644
> --- a/drivers/pinctrl/pinctrl-at91.c
> +++ b/drivers/pinctrl/pinctrl-at91.c
> @@ -1468,6 +1468,7 @@ static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
>  static int at91_gpio_of_irq_setup(struct device_node *node,
>  				  struct at91_gpio_chip *at91_gpio)
>  {
> +	struct at91_gpio_chip   *prev = NULL;
>  	struct irq_data		*d = irq_get_irq_data(at91_gpio->pioc_virq);
>  	int ret;
>  
> @@ -1493,6 +1494,17 @@ static int at91_gpio_of_irq_setup(struct device_node *node,
>  		panic("at91_gpio.%d: couldn't allocate irq domain (DT).\n",
>  			at91_gpio->pioc_idx);
>  
> +	/* Setup chained handler */
> +	if (at91_gpio->pioc_idx)
> +		prev = gpio_chips[at91_gpio->pioc_idx - 1];
> +
> +	/* The top level handler handles one bank of GPIOs, except
> +	 * on some SoC it can handle up to three...
> +	 * We only set up the handler for the first of the list.
> +	 */
> +	if (prev && prev->next == at91_gpio)
> +		return 0;
> +
>  	/* Then register the chain on the parent IRQ */
>  	gpiochip_set_chained_irqchip(&at91_gpio->chip,
>  				     &gpio_irqchip,
> 
