From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Jul 2011 10:00:11 +0100
Subject: [PATCH] ARM: S5P64X0: External Interrupt Support
In-Reply-To: <1310712094-19831-1-git-send-email-padma.v@samsung.com>
References: <1310712094-19831-1-git-send-email-padma.v@samsung.com>
Message-ID: <20110715090011.GN23270@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 15, 2011 at 12:11:34PM +0530, Padmavathi Venna wrote:
> +#define eint_offset(irq)	((irq) - IRQ_EINT(0))
> +#define eint_irq_to_bit(irq)	((u32)(1 << eint_offset(irq)))
> +
> +static inline void s5p64x0_irq_eint_mask(struct irq_data *data)
> +{
> +	u32 mask;
> +
> +	mask = __raw_readl(S5P64X0_EINT0MASK);
> +	mask |= (u32)data->chip_data;
> +	__raw_writel(mask, S5P64X0_EINT0MASK);
> +}
> +
> +static void s5p64x0_irq_eint_unmask(struct irq_data *data)
> +{
> +	u32 mask;
> +
> +	mask = __raw_readl(S5P64X0_EINT0MASK);
> +	mask &= ~((u32)data->chip_data);
> +	__raw_writel(mask, S5P64X0_EINT0MASK);
> +}
> +
> +static inline void s5p64x0_irq_eint_ack(struct irq_data *data)
> +{
> +	__raw_writel((u32)data->chip_data, S5P64X0_EINT0PEND);
> +}
> +
> +static void s5p64x0_irq_eint_maskack(struct irq_data *data)
> +{
> +	/* compiler should in-line these */
> +	s5p64x0_irq_eint_mask(data);
> +	s5p64x0_irq_eint_ack(data);
> +}

Won't genirqchip support deal with all of the above for you?

> +
> +static int s5p64x0_irq_eint_set_type(struct irq_data *data, unsigned int type)
> +{
> +	int offs = eint_offset(data->irq);
> +	int shift;
> +	u32 ctrl, mask;
> +	u32 newvalue = 0;
> +	unsigned int id;
> +
> +	if (offs > 15)
> +		return -EINVAL;
> +
> +	switch (type) {
> +	case IRQ_TYPE_NONE:
> +		printk(KERN_WARNING "No edge setting!\n");
> +		break;
> +
> +	case IRQ_TYPE_EDGE_RISING:
> +		newvalue = S3C2410_EXTINT_RISEEDGE;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_FALLING:
> +		newvalue = S3C2410_EXTINT_FALLEDGE;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_BOTH:
> +		newvalue = S3C2410_EXTINT_BOTHEDGE;
> +		break;
> +
> +	case IRQ_TYPE_LEVEL_LOW:
> +		newvalue = S3C2410_EXTINT_LOWLEV;
> +		break;
> +
> +	case IRQ_TYPE_LEVEL_HIGH:
> +		newvalue = S3C2410_EXTINT_HILEV;
> +		break;
> +
> +	default:
> +		printk(KERN_ERR "No such irq type %d", type);
> +		return -1;

NO!  Stop this right now and never do it again.  Please _always_ look
up the right error code and use it.

'return -1' is almost never valid.
