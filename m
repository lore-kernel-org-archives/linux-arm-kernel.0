From: sr@denx.de (Stefan Roese)
Date: Fri, 16 Nov 2012 11:47:41 +0100
Subject: [PATCH 2/6] irqchip: sunxi: Add irq controller driver
In-Reply-To: <20121116113805.053eb5fa@skate>
References: <1353019586-21043-1-git-send-email-maxime.ripard@free-electrons.com>
 <1353019586-21043-3-git-send-email-maxime.ripard@free-electrons.com>
 <50A5ECBF.9060304@denx.de> <50A6047A.8090609@free-electrons.com>
 <20121116113805.053eb5fa@skate>
Message-ID: <50A619CD.7020305@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2012 11:38 AM, Thomas Petazzoni wrote:
>>> asmlinkage void __exception_irq_entry sunxi_handle_irq(struct pt_regs *regs)
>>> {
>>> 	u32 irq;
>>>
>>> 	irq = readl(int_base + SW_INT_VECTOR_REG) >> 2;
>>> 	irq = irq_find_mapping(sunxi_vic_domain, irq);
>>> 	handle_IRQ(irq, regs);
>>> }
>>>
>>> I suggest you give it a try.
>>
>> It definitely looks nicer. I'll try that and update.
> 
> How does this SW_INT_VECTOR_REG behave when there are multiple
> interrupts pending?

Not 100% sure. Hard to guess with this sparse documentation. I would
expect that multiple interrupts would be queued here.

> Shouldn't the code be something like:
> 
> 	do {
> 		hwirq = readl(int_base + SW_INT_VECTOR_REG) >> 2;
> 		irq = irq_find_mapping(sunxi_vic_domain, hwirq);
> 		handle_IRQ(irq, regs);
> 	} while(hwirq != 0);
> 
> Or maybe the != 0 is not the good condition, but the idea is to handle
> all pending interrupts. That said, the original code from Maxime was
> not doing that as well.

Yes, that would be a good change.

Thanks,
Stefan
