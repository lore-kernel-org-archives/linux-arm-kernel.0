From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Wed, 20 Apr 2011 01:21:50 -0700
Subject: arm: orion: Use generic irq chip
In-Reply-To: <20110416211307.498522459@linutronix.de>
References: <20110416211221.853079766@linutronix.de>
	<20110416211307.498522459@linutronix.de>
Message-ID: <4DAE979E.6000907@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2011 02:14 PM, Thomas Gleixner wrote:
> The core interrupt chip is a straight forward conversion. The gpio
> chip is implemented with two instances of the irq_chip_type which can
> be switched with the irq_set_type function. That allows us to use the
> generic callbacks and avoids the conditionals in them.
>
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> ---
>   arch/arm/plat-orion/gpio.c              |  110 ++++++++++----------------------
>   arch/arm/plat-orion/include/plat/gpio.h |    1
>   arch/arm/plat-orion/irq.c               |   49 ++------------
>   3 files changed, 44 insertions(+), 116 deletions(-)
>
> Index: linux-2.6/arch/arm/plat-orion/gpio.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/plat-orion/gpio.c
> +++ linux-2.6/arch/arm/plat-orion/gpio.c
> @@ -321,59 +321,16 @@ EXPORT_SYMBOL(orion_gpio_set_blink);
>    *        polarity    LEVEL          mask
>    *
>    ****************************************************************************/
> -static void gpio_irq_ack(struct irq_data *d)
> -{
> -	struct orion_gpio_chip *ochip = irq_data_get_irq_chip_data(d);
> -	int type = irqd_get_trigger_type(d);
> -
> -	if (type&  (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)) {
> -		int pin = d->irq - ochip->secondary_irq_base;
> -
> -		writel(~(1<<  pin), GPIO_EDGE_CAUSE(ochip));
> -	}
> -}
> -
> -static void gpio_irq_mask(struct irq_data *d)
> -{
> -	struct orion_gpio_chip *ochip = irq_data_get_irq_chip_data(d);
> -	int type = irqd_get_trigger_type(d);
> -	void __iomem *reg;
> -	int pin;
> -
> -	if (type&  (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
> -		reg = GPIO_EDGE_MASK(ochip);
> -	else
> -		reg = GPIO_LEVEL_MASK(ochip);
> -
> -	pin = d->irq - ochip->secondary_irq_base;
> -
> -	writel(readl(reg)&  ~(1<<  pin), reg);
> -}
> -
> -static void gpio_irq_unmask(struct irq_data *d)
> -{
> -	struct orion_gpio_chip *ochip = irq_data_get_irq_chip_data(d);
> -	int type = irqd_get_trigger_type(d);
> -	void __iomem *reg;
> -	int pin;
> -
> -	if (type&  (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING))
> -		reg = GPIO_EDGE_MASK(ochip);
> -	else
> -		reg = GPIO_LEVEL_MASK(ochip);
> -
> -	pin = d->irq - ochip->secondary_irq_base;
> -
> -	writel(readl(reg) | (1<<  pin), reg);
> -}
>
>   static int gpio_irq_set_type(struct irq_data *d, u32 type)
>   {
> -	struct orion_gpio_chip *ochip = irq_data_get_irq_chip_data(d);
> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> +	struct irq_chip_type *ct = irq_data_get_chip_type(d);
> +	struct orion_gpio_chip *ochip = gc->private;
>   	int pin;
>   	u32 u;
>
> -	pin = d->irq - ochip->secondary_irq_base;
> +	pin = d->irq - gc->irq_base;
>
>   	u = readl(GPIO_IO_CONF(ochip))&  (1<<  pin);
>   	if (!u) {
> @@ -382,18 +339,14 @@ static int gpio_irq_set_type(struct irq_
>   		return -EINVAL;
>   	}
>
> -	/*
> -	 * Set edge/level type.
> -	 */
> -	if (type&  (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING)) {
> -		__irq_set_handler_locked(d->irq, handle_edge_irq);
> -	} else if (type&  (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW)) {
> -		__irq_set_handler_locked(d->irq, handle_level_irq);
> -	} else {
> -		printk(KERN_ERR "failed to set irq=%d (type=%d)\n",
> -		       d->irq, type);
> +	type&= IRQ_TYPE_SENSE_MASK;
> +	if (type == IRQ_TYPE_NONE)
>   		return -EINVAL;
> -	}
> +
> +	/* Check if we need to change chip and handler */
> +	if (!(ct->type&  type))
> +		if (irq_setup_alt_chip(d, type))
> +			return -EINVAL;
>
>   	/*
>   	 * Configure interrupt polarity.
> @@ -425,19 +378,12 @@ static int gpio_irq_set_type(struct irq_
>   	return 0;
>   }
>
> -struct irq_chip orion_gpio_irq_chip = {
> -	.name		= "orion_gpio_irq",
> -	.irq_ack	= gpio_irq_ack,
> -	.irq_mask	= gpio_irq_mask,
> -	.irq_unmask	= gpio_irq_unmask,
> -	.irq_set_type	= gpio_irq_set_type,
> -};
> -
>   void __init orion_gpio_init(int gpio_base, int ngpio,
>   			    u32 base, int mask_offset, int secondary_irq_base)
>   {
>   	struct orion_gpio_chip *ochip;
> -	int i;
> +	struct irq_chip_generic *gc;
> +	struct irq_chip_type *ct;
>
>   	if (orion_gpio_chip_count == ARRAY_SIZE(orion_gpio_chips))
>   		return;
> @@ -471,15 +417,29 @@ void __init orion_gpio_init(int gpio_bas
>   	writel(0, GPIO_EDGE_MASK(ochip));
>   	writel(0, GPIO_LEVEL_MASK(ochip));
>
> -	for (i = 0; i<  ngpio; i++) {
> -		unsigned int irq = secondary_irq_base + i;
> +	gc = irq_alloc_generic_chip("orion_gpio_irq", 1, secondary_irq_base,
> +				    ochip->base, handle_level_irq);

should this be 2 instead of 1 ?
	gc = irq_alloc_generic_chip("orion_gpio_irq", 2,  ...


> +	gc->private = ochip;
> +
> +	ct = gc->chip_types;
> +	ct->regs.mask = ochip->mask_offset + GPIO_LEVEL_MASK_OFF;
> +	ct->type = IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW;
> +	ct->chip.irq_mask = irq_gc_mask_clr_bit;
> +	ct->chip.irq_unmask = irq_gc_mask_set_bit;
> +	ct->chip.irq_set_type = gpio_irq_set_type;
> +
> +	ct++;
> +	ct->regs.mask = ochip->mask_offset + GPIO_EDGE_MASK_OFF;
> +	ct->regs.ack = GPIO_EDGE_CAUSE_OFF;
> +	ct->type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
> +	ct->chip.irq_ack = irq_gc_ack;
> +	ct->chip.irq_mask = irq_gc_mask_clr_bit;
> +	ct->chip.irq_unmask = irq_gc_mask_set_bit;
> +	ct->chip.irq_set_type = gpio_irq_set_type;
> +	ct->handler = handle_edge_irq;
>
> -		irq_set_chip_and_handler(irq,&orion_gpio_irq_chip,
> -					 handle_level_irq);
> -		irq_set_chip_data(irq, ochip);
> -		irq_set_status_flags(irq, IRQ_LEVEL);
> -		set_irq_flags(irq, IRQF_VALID);
> -	}
> +	irq_setup_generic_chip(gc, IRQ_MSK(ngpio), IRQ_NOREQUEST,
> +			       IRQ_LEVEL | IRQ_NOPROBE);
>   }

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
