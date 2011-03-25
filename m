From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 25 Mar 2011 22:03:24 +0100 (CET)
Subject: [patch 17/23] arm: at91: Cleanup irq chip
In-Reply-To: <20110325132048.996818347@linutronix.de>
References: <20110325131617.258789658@linutronix.de>
	<20110325132048.996818347@linutronix.de>
Message-ID: <alpine.LFD.2.00.1103252202440.31464@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Mar 2011, Thomas Gleixner wrote:

> Avoid the whole lazy disable dance in the demux handler by providing a
> irq_disable() callback.
> 
> Use the proper accessor functions and tidy up gpio_irq_handler()
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
> +	struct irq_chip *chip = irq_data_get_chip(data);
> +	struct at91_gpio_chip *at91_gpio = irq_data_get_chip_data(data);

Sorry, needs to be

+	struct at91_gpio_chip *at91_gpio = irq_data_get_irq_chip_data(data);

Will fix and resend.

Thanks,

	tglx
