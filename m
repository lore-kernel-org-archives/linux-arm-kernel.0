From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 21 Aug 2017 19:54:43 +0900
Subject: [PATCH v2] irqchip: uniphier-aidet: add UniPhier AIDET irqchip
 driver
In-Reply-To: <e3b865f5-a779-f176-67ef-9ffac25019d4@arm.com>
References: <1503309663-2742-1-git-send-email-yamada.masahiro@socionext.com>
 <e3b865f5-a779-f176-67ef-9ffac25019d4@arm.com>
Message-ID: <CAK7LNAS_bTsweGB-WqbSoh8myTET9KW-7oN0FLZTmAf_K317aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,


2017-08-21 19:25 GMT+09:00 Marc Zyngier <marc.zyngier@arm.com>:
> On 21/08/17 11:01, Masahiro Yamada wrote:
>> +static struct irq_chip uniphier_aidet_irq_chip = {
>> +     .name = "AIDET",
>> +     .irq_mask = irq_chip_mask_parent,
>> +     .irq_unmask = irq_chip_unmask_parent,
>> +     .irq_eoi = irq_chip_eoi_parent,
>> +     .irq_set_type = uniphier_aidet_irq_set_type,
>
> Is this irqchip only used in a uniprocessor system? If not, how is the
> interrupt affinity managed without a irq_set_affinity callback?

I missed that.
I will set irq_chip_set_affinity_parent.




>> +     /* parent is GIC */
>> +     parent_fwspec.fwnode = domain->parent->fwnode;
>> +     parent_fwspec.param_count = 3;
>> +     parent_fwspec.param[0] = 0;             /* SPI */
>> +     parent_fwspec.param[1] = hwirq;
>> +     parent_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;   /* properly set later */
>
> Why defer it to later? You already have the right information in "type",
> so you might as well provide it immediately.


Because .irq_set_type() will set it up
before the IRQ is really in use.


If we look gic_irq_domain_alloc() implementation,
it does not care "type".

gic_set_type() will manipulate hardware registers.


Having said that, it shouldn't hurt to set type here.



>> +
>> +     priv->domain = irq_domain_add_hierarchy(parent_domain, 0,
>> +                                             UNIPHIER_AIDET_NR_IRQS,
>> +                                             dev->of_node,
>> +                                             &uniphier_aidet_domain_ops,
>> +                                             priv);
>
> Nit: please use irq_domain_create_hierarchy. This does the exact same
> thing, but is consistent with the use of fwnode instead of mixing
> of_node and fwnode in this code.
>

I will do so.


Thanks.


-- 
Best Regards
Masahiro Yamada
