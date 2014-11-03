From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Mon, 3 Nov 2014 13:57:29 -0600
Subject: [V9 PATCH 2/2] irqchip: gicv2m: Add supports for ARM GICv2m
 MSI(-X)
In-Reply-To: <54578CC7.4050901@arm.com>
References: <1414743990-28421-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1414743990-28421-3-git-send-email-suravee.suthikulpanit@amd.com>
 <54574FF7.706@arm.com> <54578CC7.4050901@arm.com>
Message-ID: <5457DE29.4020907@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/3/2014 8:10 AM, Marc Zyngier wrote:
> On 03/11/14 09:50, Marc Zyngier wrote:
>
>>> @@ -843,10 +847,14 @@ static int gic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>>>          unsigned int type = IRQ_TYPE_NONE;
>>>          struct of_phandle_args *irq_data = arg;
>>>
>>> -       ret = gic_irq_domain_xlate(domain, irq_data->np, irq_data->args,
>>> -                                  irq_data->args_count, &hwirq, &type);
>>> -       if (ret)
>>> -               return ret;
>>> +       if (irq_data) {
>>> +               ret = gic_irq_domain_xlate(domain, irq_data->np, irq_data->args,
>>> +                                          irq_data->args_count, &hwirq, &type);
>>> +               if (ret)
>>> +                       return ret;
>>> +       } else {
>>> +               hwirq = virq;
>>> +       }
>>
>> I'm slightly puzzled here. What's the purpose of this? The whole goal of
>> the domain hierarchy is to avoid that kind of thing. Also, you should
>> never have to call xlate on an MSI, because it should never be described
>> in the device tree the first place.
>
> Thinking of it some more:
>
> The actual reason why this is required is because the MSI domain calls
> into this via irq_domain_alloc_irqs_parent(). But because MSIs are not
> described in DT, they do not have a of_phandle to pass down to the xlate
> helper. In this case, the v2m widget has the knowledge of what are the
> valid SPI numbers, and the core GIC code must blindly accept it.
>
> This definitely requires a fat comment, because this is far from obvious.
>
> Thanks,
>
> 	M.
>

I'll put in proper comments here.

Suravee
