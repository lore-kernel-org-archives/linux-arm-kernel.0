From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 May 2017 16:17:41 +0100
Subject: [PATCH 3/6] irqchip: irq-mvebu-gicp: new driver for Marvell GICP
In-Reply-To: <20170530165454.6ca24dbc@free-electrons.com>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496135772-20694-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <2ea42715-700b-c363-eeba-db83b0f63a70@arm.com>
 <20170530165454.6ca24dbc@free-electrons.com>
Message-ID: <5b882159-4de1-5a8e-5737-56542f2aee3a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/05/17 15:54, Thomas Petazzoni wrote:
> Hello,
> 
> On Tue, 30 May 2017 14:55:57 +0100, Marc Zyngier wrote:
> 
>>> +	for (i = 0; i < GICP_INT_COUNT; i++)
>>> +		writel(i, regs + GICP_CLRSPI_NSR_OFFSET);  
>>
>> What does this do on an edge interrupt?
> 
> I guess nothing. What the ICU does is:
> 
>  * For level interrupts: when the interrupt wire is asserted, write to
>    SETNSR, when the interrupt wire is deasserted, write to CLRNSR
> 
>  * For edge interrupts: only the interrupt assertion causes a write to
>    SETNSR.
> 
>> I bet this doesn't have any effect
> 
> Indeed. But do we care? Can an edge interrupt be left pending from the
> firmware?

I cannot see why not. It is just as likely as a level interrupt.

> 
>> , so you may want to use the irq_set_irqchip_state() API to clear a
>> potential pending state instead (and you may want to wire it in the
>> ICU driver itself as well).
> 
> I'm not sure how to use this irq_set_irqchip_state() API. I guess it
> needs a virq that corresponds to the GIC SPI interrupt, and I'm not
> sure how to get that.

You do have the virtual interrupt when doing the allocation (it is
passed as a parameter). So you could perform the mapping (call into the
lower layers), and clear the pending bit using the above API.

But maybe you don't have any edge interrupt on this SoC, and it doesn't
matter.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
