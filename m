From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 18 Apr 2011 12:20:24 -0500
Subject: genirq: Implement a generic interrupt chip
In-Reply-To: <20110416211307.117340150@linutronix.de>
References: <20110416211221.853079766@linutronix.de>
	<20110416211307.117340150@linutronix.de>
Message-ID: <0D753D10438DA54287A00B027084269764D221CC64@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, April 16, 2011 2:14 PM, Thomas Gleixner wrote:
>
> Implement a generic interrupt chip, which is configurable and is able
> to handle the most common irq chip implementations.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/irq.h       |  123 ++++++++++++++++++++++
>  kernel/irq/Makefile       |    1 
>  kernel/irq/generic-chip.c |  251 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 375 insertions(+)
> 
> Index: linux-2.6/include/linux/irq.h
> ===================================================================
> --- linux-2.6.orig/include/linux/irq.h
> +++ linux-2.6/include/linux/irq.h

[snip]

> +/**
> + * struct irq_chip_type - Generic interrupt chip instance for a flow type
> + * @chip:		The real interrupt chip which provides the callbacks
> + * @regs:		Register offsets for this chip
> + * @handler:		Flow handler associated with this chip
> + * @type:		Chip can handle these flow types
> + *
> + * A irq_generic_chip can have several instances of irq_chip_type when
> + * it requires different functions and register offsets for different
> + * flow types.
> + */
> +struct irq_chip_type {
> +	struct irq_chip		chip;
> +	struct irq_chip_regs	regs;
> +	irq_flow_handler_t	handler;
> +	u32			type;
> +};
> +

[snip]

> Index: linux-2.6/kernel/irq/generic-chip.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6/kernel/irq/generic-chip.c

[snip]

> +/**
> + * irq_setup_generic_chip - Setup a range of interrupts with a generic chip
> + * @gc:		Generic irq chip holding all data
> + * @msk:	Bitmask holding the irqs to initialize relative to gc->irq_base
> + * @clr:	IRQ_* bits to clear
> + * @set:	IRQ_* bits to set
> + *
> + * Set up max. 32 interrupts starting from gc->irq_base. Note, this
> + * initializes all interrupts to the primary irq_chip_type and its
> + * associated handler.
> + */
> +void irq_setup_generic_chip(struct irq_chip_generic *gc, u32 msk,
> +			    unsigned int clr, unsigned int set)
> +{
> +	struct irq_chip_type *ct = gc->chip_types;
> +	unsigned int i;
> +
> +	/* Init mask cache */
> +	if (ct->irq_mask == irq_gc_mask_clr_bit ||
> +	    ct->irq_mask == irq_gc_mask_set_bit)

struct irq_chip_type does not have a member named 'irq_mask'

Regards,
Hartley
