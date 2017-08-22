From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 22 Aug 2017 11:03:08 +0900
Subject: [PATCH v2] irqchip: uniphier-aidet: add UniPhier AIDET irqchip
 driver
In-Reply-To: <e3b865f5-a779-f176-67ef-9ffac25019d4@arm.com>
References: <1503309663-2742-1-git-send-email-yamada.masahiro@socionext.com>
 <e3b865f5-a779-f176-67ef-9ffac25019d4@arm.com>
Message-ID: <CAK7LNASUzuKpQyZt6ks44EoQOhvqgUU8rUfJyNknGNVAgWYAKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,


2017-08-21 19:25 GMT+09:00 Marc Zyngier <marc.zyngier@arm.com>:

>> +static struct irq_chip uniphier_aidet_irq_chip = {
>> +     .name = "AIDET",
>> +     .irq_mask = irq_chip_mask_parent,
>> +     .irq_unmask = irq_chip_unmask_parent,
>> +     .irq_eoi = irq_chip_eoi_parent,
>> +     .irq_set_type = uniphier_aidet_irq_set_type,
>
> Is this irqchip only used in a uniprocessor system? If not, how is the
> interrupt affinity managed without a irq_set_affinity callback?
>


After consideration, some questions popped up.



We can set other hooks, for example, .irq_{enable,disable} if we like.

         .irq_enable = irq_chip_enable_parent,
         .irq_disable = irq_chip_disable_parent,


I know the parent (GIC) implements unmask/mask instead of enable/disable,
but this is also out of the scope of this driver.

I am not familiar with the difference between unmask/mask and enable/disable.
IIUC, the difference is that
if enable/disable hooks are missing, IRQs are masked lazily.

If a child irqchip implemented enable/disable,
IRQs would be masked immediately.  So, in irq-domain hierarchy,
a child irqchip need to have a good insight about its parent
which is be better, unmask/mask or enable/disable.




> Nit: please use irq_domain_create_hierarchy.

I'd like to know your intention about your commit
2a5e9a072da6469a37d1f0b1577416f51223c280


Is that mean, irq_domain_add_hierarchy will be deprecated
some time in the future?


If I grep under drivers/irqchip/,
most drivers are currently using irq_domain_add_hierarchy(),
and this provides a shorter form for DT-based drivers.


-- 
Best Regards
Masahiro Yamada
