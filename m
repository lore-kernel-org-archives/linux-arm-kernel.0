From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Wed, 20 Apr 2011 01:20:52 -0700
Subject: genirq: Implement a generic interrupt chip
In-Reply-To: <20110416211307.117340150@linutronix.de>
References: <20110416211221.853079766@linutronix.de>
	<20110416211307.117340150@linutronix.de>
Message-ID: <4DAE9764.2090609@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/16/2011 02:14 PM, Thomas Gleixner wrote:
> Implement a generic interrupt chip, which is configurable and is able
> to handle the most common irq chip implementations.
>
> Signed-off-by: Thomas Gleixner<tglx@linutronix.de>
> ---
>   include/linux/irq.h       |  123 ++++++++++++++++++++++
>   kernel/irq/Makefile       |    1
>   kernel/irq/generic-chip.c |  251 ++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 375 insertions(+)
>
> Index: linux-2.6/include/linux/irq.h
> ===================================================================
> --- linux-2.6.orig/include/linux/irq.h
> +++ linux-2.6/include/linux/irq.h
> @@ -573,6 +573,129 @@ static inline int irq_reserve_irq(unsign
>   	return irq_reserve_irqs(irq, 1);
>   }
>
> +#ifndef irq_reg_writel
> +# define irq_reg_writel(val, addr)	writel(val, addr)
> +#endif
> +#ifndef irq_reg_readl
> +# define irq_reg_readl(addr)		readl(addr)
> +#endif
> +
> +/**
> + * struct irq_chip_regs - register offsets for struct irq_gci
> + * @enable:	Enable register offset to reg_base
> + * @disable:	Disable register offset to reg_base
> + * @mask:	Mask register offset to reg_base
> + * @ack:	Ack register offset to reg_base
> + * @ack:	Secondary Ack register offset to reg_base
> + * @eoi:	Eoi register offset to reg_base
> + * @type:	Type configuration register offset to reg_base
> + * @polarity:	Polarity configuration register offset to reg_base
> + */
> +struct irq_chip_regs {
> +	unsigned long		enable;
> +	unsigned long		disable;
> +	unsigned long		mask;
> +	unsigned long		ack;
> +	unsigned long		eoi;
> +	unsigned long		type;
> +	unsigned long		polarity;
> +};
> +
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
> +/**
> + * struct irq_chip_generic - Generic irq chip data structure
> + * @lock:		Lock to protect register and cache data access
> + * @reg_base:		Register base address (virtual)
> + * @irq_base:		Interrupt base nr for this chip
> + * @irq_cnt:		Number of interrupts handled by this chip
> + * @mask_cache:		Cached mask register
> + * @type_cache:		Cached type register
> + * @polarity_cache:	Cached polarity register
> + * @wake_enabled:	Interrupt can wakeup from suspend
> + * @wake_active:	Interrupt is marked as an wakeup from suspend source
> + * @num_ct:		Number of available irq_chip_type instances (usually 1)
> + * @private:		Private data for non generic chip callbacks
> + * @chip_types:		Array of interrupt irq_chip_types
> + *
> + * Note, that irq_chip_generic can have multiple irq_chip_type
> + * implementations which can be associated to a particular irq line of
> + * an irq_chip_generic instance. That allows to share and protect
> + * state in an irq_chip_generic instance when we need to implement
> + * different flow mechanisms (level/edge) for it.
> + */
> +struct irq_chip_generic {
> +	raw_spinlock_t		lock;
> +	void __iomem		*reg_base;
> +	unsigned int		irq_base;
> +	unsigned int		irq_cnt;
> +	u32			mask_cache;
> +	u32			type_cache;
> +	u32			polarity_cache;
> +	u32			wake_enabled;
> +	u32			wake_active;
> +	unsigned int		num_ct;
> +	void			*private;
> +	struct irq_chip_type	chip_types[0];
> +};
> +
> +/* Generic chip callback functions */
> +void irq_gc_noop(struct irq_data *d);
> +void irq_gc_mask_disable_reg(struct irq_data *d);
> +void irq_gc_mask_set_bit(struct irq_data *d);
> +void irq_gc_mask_clr_bit(struct irq_data *d);
> +void irq_gc_unmask_enable_reg(struct irq_data *d);
> +void irq_gc_ack(struct irq_data *d);
> +void irq_gc_mask_disable_reg_and_ack(struct irq_data *d);
> +void irq_gc_eoi(struct irq_data *d);
> +int irq_gc_set_wake(struct irq_data *d, unsigned int on);
> +
> +/* Setup functions for irq_chip_generic */
> +struct irq_chip_generic *
> +irq_alloc_generic_chip(const char *name, int nr_ct, unsigned int irq_base,
> +		       void __iomem *reg_base, irq_flow_handler_t handler);
> +void irq_setup_generic_chip(struct irq_chip_generic *gc, u32 msk,
> +			    unsigned int clr, unsigned int set);
> +int irq_setup_alt_chip(struct irq_data *d, unsigned int type);
> +
> +static inline struct irq_chip_type *irq_data_get_chip_type(struct irq_data *d)
> +{
> +	return container_of(d->chip, struct irq_chip_type, chip);
> +}
> +
> +#define IRQ_MSK(n) (u32)((n)<  32 ? ((1<<  (n)) - 1) : UINT_MAX)
> +
> +#ifdef CONFIG_SMP
> +static inline void irq_gc_lock(struct irq_chip_generic *gc)
> +{
> +	raw_spin_lock(&gc->lock);
> +}
> +
> +static inline void irq_gc_unlock(struct irq_chip_generic *gc)
> +{
> +	raw_spin_unlock(&gc->lock);
> +}
> +#else
> +static inline void irq_gc_lock(struct irq_chip_generic *gc) { }
> +static inline void irq_gc_unlock(struct irq_chip_generic *gc) { }
> +#endif
> +

Shall we create a new header file for this, lets say geneirc_irq_chip.h? 
The generic irq chip api is different from what  irq.h provides, I think

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
