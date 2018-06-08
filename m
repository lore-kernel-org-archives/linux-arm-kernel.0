From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 8 Jun 2018 12:26:09 +0200
Subject: [PATCH v2 09/16] irqchip/irq-mvebu-sei: add new driver for
 Marvell SEI
In-Reply-To: <b11849f0-3593-51e1-8d4f-b05bfe6412a1@arm.com>
References: <20180522094042.24770-1-miquel.raynal@bootlin.com>
 <20180522094042.24770-10-miquel.raynal@bootlin.com>
 <b11849f0-3593-51e1-8d4f-b05bfe6412a1@arm.com>
Message-ID: <20180608122609.0bb051f6@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

> > +static struct irq_chip mvebu_sei_ap_wired_irq_chip = {
> > +	.name			= "AP wired SEI",
> > +	.irq_mask		= mvebu_sei_mask_irq,
> > +	.irq_unmask		= mvebu_sei_unmask_irq,
> > +	.irq_eoi		= irq_chip_eoi_parent,
> > +	.irq_set_affinity	= irq_chip_set_affinity_parent,
> > +	.irq_set_type		= irq_chip_set_type_parent,  
> 
> You seem to assume that this driver is purely dealing with edge
> interrupts. And yet you pass the request directly to the parrent. What
> does it mean? Shouldn't you at least check that this is an edge request
> and fail otherwise?

MSI are rising-edge interrupts while wired ones are level (high)
interrupts. I will correct this.


> > +		irq_chip = &mvebu_sei_ap_wired_irq_chip;
> > +		hwirq = fwspec->param[0];
> > +	} else {
> > +		irq_chip = &mvebu_sei_cp_msi_irq_chip;
> > +		spin_lock(&sei->cp_msi_lock);  
> 
> This could as well be a mutex.

Ok.

> 
> > +		hwirq = bitmap_find_free_region(sei->cp_msi_bitmap,
> > +						SEI_IRQ_COUNT, 0);  
> 
> It is a bit weird that you're allocating from a 64bit bitmap while you
> only have 43 interrupts available... At the 44th interrupt, something
> bad is going to happen.

Absolutely, to solve this issue, I just had to:

s/SEI_IRQ_COUNT/sei->cp_interrupts.number/ 

> 
> > +		spin_unlock(&sei->cp_msi_lock);
> > +		if (hwirq < 0)
> > +			return -ENOSPC;
> > +	}
> > +

[...]

> > +static void mvebu_sei_handle_cascade_irq(struct irq_desc *desc)
> > +{
> > +	struct mvebu_sei *sei = irq_desc_get_handler_data(desc);
> > +	struct irq_chip *chip = irq_desc_get_chip(desc);
> > +	unsigned long irqmap, irq_bit;
> > +	u32 reg_idx, virq, irqn;
> > +
> > +	chained_irq_enter(chip, desc);
> > +
> > +	/* Read both SEI cause registers (64 bits) */
> > +	for (reg_idx = 0; reg_idx < SEI_IRQ_REG_COUNT; reg_idx++) {
> > +		irqmap = readl_relaxed(sei->base + GICP_SECR(reg_idx));
> > +
> > +		/* Call handler for each set bit */
> > +		for_each_set_bit(irq_bit, &irqmap, SEI_IRQ_COUNT_PER_REG) {
> > +			/* Cause Register gives the SEI number */
> > +			irqn = irq_bit + reg_idx * SEI_IRQ_COUNT_PER_REG;
> > +			/*
> > +			 * Finding Linux mapping (virq) needs the right domain
> > +			 * and the relative hwirq (which start at 0 in both
> > +			 * cases, while irqn is relative to all SEI interrupts).
> > +			 */  
> 
> It is a bit odd that you're virtualizing the hwirq number. The whole
> point of splitting hwirq from virq is that you don't have to do that and
> can use the the raw HW number. You're saving a tiny bit of memory in the
> irq_domain, at the expense of more complexity. I don't know if that's
> worth it...
> 
> > +			if (irqn < sei->ap_interrupts.number) {
> > +				virq = irq_find_mapping(sei->ap_domain, irqn);
> > +			} else {
> > +				irqn -= sei->ap_interrupts.number;
> > +				virq = irq_find_mapping(sei->cp_domain, irqn);
> > +			}
> > +
> > +			/* Call IRQ handler */
> > +			generic_handle_irq(virq);
> > +		}
> > +
> > +		/* Clear interrupt indication by writing 1 to it */
> > +		writel(irqmap, sei->base + GICP_SECR(reg_idx));
> > +	}
> > +
> > +	chained_irq_exit(chip, desc);
> > +}

[...]

> It feels like this patch could do with a total split:
> 
> - Introduce the wired side of the driver
> - then the MSI part
> 
> Drop the common domain callbacks, and treat the two domains separately.
> I seriously doubt there will be much of an overlap anyway.

Maybe I don't get what "saving a tiny bit of memory" really means in
this situation. What I am doing right now is duplicating hundreds of
lines and changing things like:

        sei_hwirq = mvebu_sei_domain_to_sei_irq(..., hwirq)

into

        sei_hwirq = sei->ap_interrupts.first + d->hwirq;

and 

        sei_hwirq = sei->cp_interrupts.first + d->hwirq;

because I still need to translate this hwirq number into an offset
within 64 bits. In fact, for each configuration/management operation
like clearing, checking or masking an interrupt, a bit must be twisted
within a pair of registers. This offset cannot be just the hwirq
number, it must be shifted depending on the IRQ domain/type of
interrupt.

I'm sorry but I will need more guidance on this because I don't see the
point in duplicating so much code that was factorized.

Thanks,
Miqu?l
