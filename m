From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 05 Sep 2014 17:15:44 +0100
Subject: [PATCH 1/2 V4] irqchip: gic: Add supports for ARM GICv2m MSI(-X)
In-Reply-To: <53FEEF7C.1090902@amd.com>
References: <1407942041-3291-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1407942041-3291-2-git-send-email-suravee.suthikulpanit@amd.com>
 <87fvgxrgte.fsf@approximate.cambridge.arm.com> <53FEEF7C.1090902@amd.com>
Message-ID: <5409E1B0.5060703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/08/14 09:59, Suravee Suthikulpanit wrote:
> 
> 
> On 08/15/2014 09:03 AM, Marc Zyngier wrote:
>>> +
>>> +static struct irq_chip gicv2m_chip;
>>> +
>>> +#ifdef CONFIG_OF
>>
>> Is there any reason why this should be guarded by CONFIG_OF? Surely the
>> v2m capability should only be enabled if OF is.
> 
> [Suravee]
> We are also planning to support ACPI in the future also, which will be 
> using a different init function.  Also, there is the same #ifdef in the 
> irq-gic.c for the gic_of_init().  So, I am just trying to be consistent 
> here.
> 
> 
>>> +
>>> +       memcpy(&gicv2m_chip, gic->irq_chip, sizeof(struct irq_chip));
>>> +       gicv2m_chip.name = "GICv2m",
>>> +       gicv2m_chip.irq_mask = gicv2m_mask_irq;
>>> +       gicv2m_chip.irq_unmask = gicv2m_unmask_irq;
>>> +       gic->irq_chip = &gicv2m_chip;
>>
>> I liked it until this last line. You're overriding the irq_chip for the
>> whole GIC. I was expecting you'd only use it for the MSI range
>> (basically return a range to the caller, together with your brand new
>> irq_chip).
> 
> [Suravee]
> I'm not sure if I understand you point here. Actually, I don't see the 
> whole point of the need to have a whole different irq_chip for v2m 
> stuff.  All I need is just a way to overwrite the irq_chip.irq_mask() 
> and irq_chip.irq_unmask() with the v2m version which should check for 
> MSI before calling mask/unmask_msi_irq(). I should be able to just do:
> 
> 	gic->irq_chip.irq_mask = gicv2m_mask_irq;
> 	gic->irq_chip.irq_unmask = gicv2m_unmask_irq;

You should only do it for the few interrupts that are actually routed
via the v2m widget, not inflict the overhead on all interrupts.

This is why I insist on having a separate irqchip, and for this irqchip
to be only used for the MSI-generated interrupts.

Have a look at what I do for GICv3:
http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/tree/drivers/irqchip/irq-gic-v3.c?h=gicv3/its-split&id=b717e532c4312a410a8ee0cb2349baa2769c6b94#n712

and how this gets used when routing the interrupts:
http://git.kernel.org/cgit/linux/kernel/git/maz/arm-platforms.git/tree/drivers/irqchip/irq-gic-v3.c?h=gicv3/its-split&id=b717e532c4312a410a8ee0cb2349baa2769c6b94#n589

The ITS gets its own irqchip, entirely separate from the rest of the
GIC. This gives you the flexibility you require, and let the other
interrupts free of any overhead.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
