From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 May 2017 16:33:56 +0100
Subject: [PATCH 3/6] irqchip: irq-mvebu-gicp: new driver for Marvell GICP
In-Reply-To: <20170530172500.7bf522e1@free-electrons.com>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496135772-20694-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <2ea42715-700b-c363-eeba-db83b0f63a70@arm.com>
 <20170530165454.6ca24dbc@free-electrons.com>
 <5b882159-4de1-5a8e-5737-56542f2aee3a@arm.com>
 <20170530172500.7bf522e1@free-electrons.com>
Message-ID: <78184320-9b38-1be4-f821-4e5409681222@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/05/17 16:25, Thomas Petazzoni wrote:
> Hello,
> 
> On Tue, 30 May 2017 16:17:41 +0100, Marc Zyngier wrote:
> 
>>> Indeed. But do we care? Can an edge interrupt be left pending from the
>>> firmware?  
>>
>> I cannot see why not. It is just as likely as a level interrupt.
> 
> OK.
> 
>>> I'm not sure how to use this irq_set_irqchip_state() API. I guess it
>>> needs a virq that corresponds to the GIC SPI interrupt, and I'm not
>>> sure how to get that.  
>>
>> You do have the virtual interrupt when doing the allocation (it is
>> passed as a parameter). So you could perform the mapping (call into the
>> lower layers), and clear the pending bit using the above API.
> 
> So in mvebu_icu_irq_domain_alloc(), if I do:
> 
> 	irq_se_irqchip_state(virq, IRQCHIP_STATE_MASKED, true);

That would be

	irq_set_irqchip_state(virq, IRQCHIP_STATE_PENDING, false);

instead. It is expected that the interrupt is already masked (otherwise,
you could be in trouble).

> this will go all the way to the ->irq_set_irqchip_state() in the GIC? I

Yup.

> thought the virq we had was referring to an irq from the ICU domain,
> not from the GIC one. But maybe I'm still getting confused by all these
> irq domains.

I'm afraid you are... ;-) This is a hierarchical domain, so the virq is
constant across the whole stack, only the irqchip-specific identifier
(hwirq) changes (see how you get it from the core code, and propatage it
to the parent domain). If you implement irq_set_irqchip_state at the ICU
level by directly calling into the parent, you should be just fine.

> 
>> But maybe you don't have any edge interrupt on this SoC, and it doesn't
>> matter.
> 
> We currently don't have any in the devices we support in the SoC, but
> since the ICU does support edge interrupts explicitly, it's nicer if we
> can get this right. Plus if this actually works, we don't need the
> marvell,gicp "driver" anymore.

That'd be great.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
