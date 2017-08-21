From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 21 Aug 2017 12:53:00 +0100
Subject: [PATCH v2] irqchip: uniphier-aidet: add UniPhier AIDET irqchip
 driver
In-Reply-To: <CAK7LNAS_bTsweGB-WqbSoh8myTET9KW-7oN0FLZTmAf_K317aw@mail.gmail.com>
References: <1503309663-2742-1-git-send-email-yamada.masahiro@socionext.com>
 <e3b865f5-a779-f176-67ef-9ffac25019d4@arm.com>
 <CAK7LNAS_bTsweGB-WqbSoh8myTET9KW-7oN0FLZTmAf_K317aw@mail.gmail.com>
Message-ID: <44a166ec-019e-8f84-5469-b095eb4d26fe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/08/17 11:54, Masahiro Yamada wrote:

>>> +     /* parent is GIC */
>>> +     parent_fwspec.fwnode = domain->parent->fwnode;
>>> +     parent_fwspec.param_count = 3;
>>> +     parent_fwspec.param[0] = 0;             /* SPI */
>>> +     parent_fwspec.param[1] = hwirq;
>>> +     parent_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;   /* properly set later */
>>
>> Why defer it to later? You already have the right information in "type",
>> so you might as well provide it immediately.
> 
> 
> Because .irq_set_type() will set it up
> before the IRQ is really in use.
> 
> 
> If we look gic_irq_domain_alloc() implementation,
> it does not care "type".
> 
> gic_set_type() will manipulate hardware registers.

But that's out of the scope of this driver. Whatever the GIC driver does
(or doesn't), you should pass it the right information.

> Having said that, it shouldn't hurt to set type here.
Exactly.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
