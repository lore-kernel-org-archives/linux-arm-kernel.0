From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Oct 2014 10:44:43 +0100
Subject: [PATCH v3 3/7] irqchip: gic: Support hierarchy irq domain.
In-Reply-To: <3536113.xYztHpGTJM@wuerfel>
References: <1412864980-20273-1-git-send-email-yingjoe.chen@mediatek.com>
 <1412864980-20273-4-git-send-email-yingjoe.chen@mediatek.com>
 <543B93B4.3040404@arm.com> <3536113.xYztHpGTJM@wuerfel>
Message-ID: <543B9F0B.8000205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/10/14 10:27, Arnd Bergmann wrote:
> On Monday 13 October 2014 09:56:20 Marc Zyngier wrote:
>>         if (irq_domain_is_hierarchy(domain)) {
>> +               if (domain->ops->xlate) {
>> +                       /*
>> +                        * If we've already configured this interrupt,
>> +                        * don't do it again, or hell will break loose.
>> +                        */
>> +                       if (domain->ops->xlate(domain, irq_data->np,
>> +                                              irq_data->args,
>> +                                              irq_data->args_count,
>> +                                              &hwirq, &type))
>> +                               return 0;
>> +
>> +                       virq = irq_find_mapping(domain, hwirq);
>> +                       if (virq)
>> +                               return virq;
>> +               }
>>                 virq = irq_domain_alloc_irqs(domain, 1, NUMA_NO_NODE, irq_data);
>>                 return virq <= 0 ? 0 : virq;
>>         }
>>
>> Thoughts?
> 
> Using irq_find_mapping() first is probably the right approach, that
> is what irq_create_mapping() does too, and I suppose we want those
> to be symmetric.

Ah, good point. I somehow missed that.

> mt_sysirq_domain_alloc() in patch 4 has the irq_find_domain check
> in it, which I guess we can remove when it has moved to the common
> code.
> 
> I don't see irq_domain_alloc_irqs() in linux-next or older kernels, where
> does that get introduced?

This is part of Jiang's domain hierarchy series:
https://patchwork.ozlabs.org/patch/388279/

which I plan to use to get rid of the ugly gic_extn hack that only Tegra
uses (but that everyone tries to abuse), and also for the GICv2m support.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
