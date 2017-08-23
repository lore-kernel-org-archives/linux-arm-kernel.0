From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 23 Aug 2017 10:30:07 +0900
Subject: [PATCH v2] irqchip: uniphier-aidet: add UniPhier AIDET irqchip
 driver
In-Reply-To: <046d0078-bb9d-f043-b5b4-481c695e2bea@arm.com>
References: <1503309663-2742-1-git-send-email-yamada.masahiro@socionext.com>
 <e3b865f5-a779-f176-67ef-9ffac25019d4@arm.com>
 <CAK7LNASUzuKpQyZt6ks44EoQOhvqgUU8rUfJyNknGNVAgWYAKg@mail.gmail.com>
 <046d0078-bb9d-f043-b5b4-481c695e2bea@arm.com>
Message-ID: <CAK7LNATfeDk0rFjspEM08Y4R_3TKffE2dcBNCLnNn+t1G5YXew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

2017-08-22 17:20 GMT+09:00 Marc Zyngier <marc.zyngier@arm.com>:
> On 22/08/17 03:03, Masahiro Yamada wrote:
>> Hi Mark,
>>
>>
>> 2017-08-21 19:25 GMT+09:00 Marc Zyngier <marc.zyngier@arm.com>:
>>
>>>> +static struct irq_chip uniphier_aidet_irq_chip = {
>>>> +     .name = "AIDET",
>>>> +     .irq_mask = irq_chip_mask_parent,
>>>> +     .irq_unmask = irq_chip_unmask_parent,
>>>> +     .irq_eoi = irq_chip_eoi_parent,
>>>> +     .irq_set_type = uniphier_aidet_irq_set_type,
>>>
>>> Is this irqchip only used in a uniprocessor system? If not, how is the
>>> interrupt affinity managed without a irq_set_affinity callback?
>>>
>>
>>
>> After consideration, some questions popped up.
>>
>>
>>
>> We can set other hooks, for example, .irq_{enable,disable} if we like.
>>
>>          .irq_enable = irq_chip_enable_parent,
>>          .irq_disable = irq_chip_disable_parent,
>>
>>
>> I know the parent (GIC) implements unmask/mask instead of enable/disable,
>> but this is also out of the scope of this driver.
>>
>> I am not familiar with the difference between unmask/mask and enable/disable.
>> IIUC, the difference is that
>> if enable/disable hooks are missing, IRQs are masked lazily.
>
> That's a rather good thing. Disabling interrupts lazily is a net
> performance gain when you you have to repeatedly mask/unmask interrupts.
>
>> If a child irqchip implemented enable/disable,
>> IRQs would be masked immediately.  So, in irq-domain hierarchy,
>> a child irqchip need to have a good insight about its parent
>> which is be better, unmask/mask or enable/disable.
>
> Not necessarily. irq_chip_enable_parent will call unmask if enable is
> not implemented in the parent. But you'll loose the benefit of lazy
> masking of interrupts routed through this controller.

Right.
I will not add .irq_{enable/disable} to keep the benefit of lazy masking.




> There are many other things that are *much* worse, like the need to
> implement a irq_eoi callback even if the irqchip has no such concept.

Right. I noticed irq_eoi is mandatory when I tested my driver.

I notice handle_percpu_irq() and handle_percpu_devid_irq()
check the NULL pointer dereference like

        if (chip->irq_eoi)
                chip->irq_eoi(&desc->irq_data);

But, other flow handlers do not this.




>>> Nit: please use irq_domain_create_hierarchy.
>>
>> I'd like to know your intention about your commit
>> 2a5e9a072da6469a37d1f0b1577416f51223c280
>>
>> Is that mean, irq_domain_add_hierarchy will be deprecated
>> some time in the future?
>
> That's the intent, as we're moving towards a firmware-agnostic
> irq_domain layer. Think of it as a deprecated interface.
>
>> If I grep under drivers/irqchip/,
>> most drivers are currently using irq_domain_add_hierarchy(),
>> and this provides a shorter form for DT-based drivers.
> Yes, we have a lot of legacy, and I don't always catch new additions.

I see.

I hope all drivers will be converted and irq_domain_add_hierarchy() will be
deleted.

Having many variants with slight difference is confusing to driver developers.


-- 
Best Regards
Masahiro Yamada
