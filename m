From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Jun 2014 14:10:18 +0100
Subject: [RFC PATCH 2/9] genirq: Allow the state of a  forwarded irq to
 be save/restored
In-Reply-To: <1403688530-23273-3-git-send-email-marc.zyngier@arm.com>
References: <1403688530-23273-1-git-send-email-marc.zyngier@arm.com>
 <1403688530-23273-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140627131018.GS26276@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On Wed, Jun 25, 2014 at 10:28:43AM +0100, Marc Zyngier wrote:
> When a peripheral is shared between virtual machines, its interrupt
> state becomes part of the guest's state, and must be switched accordingly.
> 
> Introduce a pair of accessors (irq_get_fwd_state/irq_set_fwd_state) to
> retrieve the bits that can be of interest to KVM: pending, active, and masked.
> 
> - irq_get_fwd_state returns the state of the interrupt according to a mask
> containing any of the IRQ_STATE_PENDING, IRQ_STATE_ACTIVE or IRQ_STATE_MASKED
> bits.
> - irq_set_fwd_state sets the state of the interrupt according to a similar mask.
> 
> Only a forwarded interrupt can be manipulated in such a way.

[...]

> +/**
> + *	irq_set_fwd_state - set the state of a forwarded interrupt.
> + *	@irq: Interrupt line that is forwarded to a VM
> + *	@val: State to be restored
> + *	@mask: Bitmask of IRQ_FWD_STATE_* defining the valid bits in @val
> + *
> + *	This call sets the state of a forwarded interrupt, depending
> + *	on the mask which indicates the valid bits.
> + *
> + *	This function should be called with preemption disabled if the
> + *	interrupt controller has per-cpu registers.
> + */
> +int irq_set_fwd_state(unsigned int irq, u32 val, u32 mask)
> +{
> +	struct irq_desc *desc;
> +	struct irq_data *data;
> +	struct irq_chip *chip;
> +	unsigned long flags;
> +
> +	desc = irq_to_desc(irq);
> +	if (!desc)
> +		return -EINVAL;
> +
> +	data = irq_desc_get_irq_data(desc);
> +	if (!irqd_irq_forwarded(data))
> +		return -EINVAL;
> +
> +	chip = irq_desc_get_chip(desc);
> +	if (!chip->irq_set_fwd_state)
> +		return -EINVAL;
> +
> +	chip_bus_lock(desc);
> +	raw_spin_lock_irqsave(&desc->lock, flags);
> +	chip->irq_set_fwd_state(data, val, mask);
> +	raw_spin_unlock_irqrestore(&desc->lock, flags);
> +	chip_bus_sync_unlock(desc);

Having looked at this, I don't think you need to take the desc->lock after
all. I thought you might need it for irq_desc_get_chip, but that's not going
to change dynamically and you'd end up with a lock ordering problem against
chip_bus_lock anyway.

Will
