From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 25 Mar 2014 07:33:46 +0000
Subject: [PATCH v2 02/19] arm64: initial support for GICv3
In-Reply-To: <CABg9mcucJ_UouRbJ_Urirz6ita5uUvYuQkmeA1-Df00KSjFcnA@mail.gmail.com>
References: <1395316386-12617-1-git-send-email-marc.zyngier@arm.com>
 <1395316386-12617-3-git-send-email-marc.zyngier@arm.com>
 <CAMDttNew0S7xVVKge7AAR3W6bdQzKdvN9Z7cHPDUCq=jZ98q1A@mail.gmail.com>
 <533012B8.2070303@arm.com>
 <CABg9mcucJ_UouRbJ_Urirz6ita5uUvYuQkmeA1-Df00KSjFcnA@mail.gmail.com>
Message-ID: <5331315A.9010001@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/03/14 06:35, Z Lim wrote:
> Hi Marc,
> 
> On Mon, Mar 24, 2014 at 4:10 AM, Marc Zyngier <marc.zyngier@arm.com
> <mailto:marc.zyngier@arm.com>> wrote:
>>
>> Hi Zi,
>>
>> On 22/03/14 01:21, Zi Shen Lim wrote:
>> > Hi Marc,
>> >
>> > On Thu, Mar 20, 2014 at 4:52 AM, Marc Zyngier <marc.zyngier@arm.com
> <mailto:marc.zyngier@arm.com>
>> > <mailto:marc.zyngier at arm.com <mailto:marc.zyngier@arm.com>>> wrote:
>> > <snip>
>> >
>> >
>> >     +       /*
>> >     +        * Find out how many interrupts are supported.
>> >     +        * The GIC only supports up to 1020 interrupt sources
>> >     (SGI+PPI+SPI)
>> >     +        */
>> >     +       gic_irqs = readl_relaxed(gic_data.dist_base + GICD_TYPER) &
>> >     0x1f;
>> >     +       gic_irqs = (gic_irqs + 1) * 32;
>> >     +       if (gic_irqs > 1020)
>> >     +               gic_irqs = 1020;
>> >     +       gic_data.irq_nr = gic_irqs;
>> >     +
>> >     +       gic_data.domain = irq_domain_add_linear(node, gic_irqs - 16,
>> >     +                                               &gic_irq_domain_ops,
>> >     &gic_data);
>> >
>> >
>> > Why gic_irqs - 16?
>>
>> Because we keep the SGIs (all 16 of them) for the core kernel (drivers
>> are not allowed to request them).
>>
>> >
>> >     __irq_domain_add(of_node, size, size, 0, ops, host_data);
>> >
>> >         domain->hwirq_max = hwirq_max;
>> >
>> >
>> > So hwirq_max is effectively set to actual_hwirq_max-16.
>> >
>> > Later, the following warning can be triggered:
>> >
>> >     int irq_domain_associate(struct irq_domain *domain, unsigned int
> virq,
>> >                              irq_hw_number_t hwirq)
>> >     {
>> >             struct irq_data *irq_data = irq_get_irq_data(virq);
>> >             int ret;
>> >
>> >             if (WARN(hwirq >= domain->hwirq_max,
>> >                      "error: hwirq 0x%x is too large for %s\n",
>> >     (int)hwirq, domain->name))
>> >                     return -EINVAL;
>>
>> Do you actually see this warning being triggered? I don't. We're using a
>> linear domain that doesn't call into this function.
> 
> I see this warning :(
> You can trigger it when a device's INT# falls within [gic_irqs-16,
> gic_irqs), which lines up with the -16 above.

Ah, got you. Hmmm. I may have to be slightly more creative then.

Thanks a lot for the report, I'll fix that as quickly as possible.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
