From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 May 2013 13:55:27 +0100
Subject: [PATCH v2 1/5] irqchip: add support for Marvell Orion SoCs
In-Reply-To: <1367538519-23940-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367519104-19677-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1367538519-23940-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1367538519-23940-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130503125527.GE18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 03, 2013 at 01:48:35AM +0200, Sebastian Hesselbarth wrote:
> This patch adds an irqchip driver for the main interrupt controller found
> on Marvell Orion SoCs (Kirkwood, Dove, Orion5x, Discovery Innovation).
> Corresponding device tree documentation is also added.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Note: This patch triggers a checkpatch warning for
>   WARNING: Avoid CamelCase: <handle_IRQ>
> 
> Changelog:
> v1->v2:
> - rename compatible string to "marvell,orion-intc" (Suggested by Jason Gunthorpe)
> - request mem regions for irq base registers (Suggested by Jason Gunthorpe)
> - make orion_handle_irq static (Suggested by Jason Gunthorpe)
> - make use of IRQCHIP_DECLARE (Suggested by Jason Gunthorpe)

It would still be a good idea to convert this to use the generic chip
stuff which Thomas created, though exactly how is hard to see at the
moment.

> +static void orion_irq_mask(struct irq_data *irqd)
> +{
> +	unsigned int irq = irqd_to_hwirq(irqd);
> +	unsigned int irq_off = irq % 32;
> +	int reg = irq / 32;
> +	u32 val;
> +
> +	val = readl(orion_irq_base[reg] + ORION_IRQ_MASK);
> +	writel(val & ~(1 << irq_off), orion_irq_base[reg] + ORION_IRQ_MASK);
> +}

This could be replaced with irq_gc_mask_clr_bit().

> +
> +static void orion_irq_unmask(struct irq_data *irqd)
> +{
> +	unsigned int irq = irqd_to_hwirq(irqd);
> +	unsigned int irq_off = irq % 32;
> +	int reg = irq / 32;
> +	u32 val;
> +
> +	val = readl(orion_irq_base[reg] + ORION_IRQ_MASK);
> +	writel(val | (1 << irq_off), orion_irq_base[reg] + ORION_IRQ_MASK);
> +}

This with irq_gc_mask_set_bit().

> +
> +static struct irq_chip orion_irq_chip = {
> +	.name		= "orion_irq",
> +	.irq_mask	= orion_irq_mask,
> +	.irq_unmask	= orion_irq_unmask,
> +};
> +
> +static int orion_irq_map(struct irq_domain *d, unsigned int virq,
> +			 irq_hw_number_t hw)
> +{
> +	irq_set_chip_and_handler(virq, &orion_irq_chip,
> +				 handle_level_irq);
> +	set_irq_flags(virq, IRQF_VALID | IRQF_PROBE);

This is where it starts to get tricky, because I can't see how you'd
merge the irq_alloc_generic_chip() and irq_setup_generic_chip() with
this.  Maybe you don't need to do anything here and just do all that
in orion_of_init() instead?  But then you seem to need to know the
virq range before hand, and I can't see how that's known.  Maybe Thomas
can provide some enlightenment about how the gc irqchip stuff works
with the irq domain stuff...

However, you wouldn't need the statically defined orion_irq_chip nor
orion_irq_base[] either, because those would be held within the gc
irqchip stuff and stored in the upper layer.
