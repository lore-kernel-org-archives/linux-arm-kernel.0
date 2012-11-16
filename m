From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 16 Nov 2012 11:38:05 +0100
Subject: [PATCH 2/6] irqchip: sunxi: Add irq controller driver
In-Reply-To: <50A6047A.8090609@free-electrons.com>
References: <1353019586-21043-1-git-send-email-maxime.ripard@free-electrons.com>
 <1353019586-21043-3-git-send-email-maxime.ripard@free-electrons.com>
 <50A5ECBF.9060304@denx.de> <50A6047A.8090609@free-electrons.com>
Message-ID: <20121116113805.053eb5fa@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Fri, 16 Nov 2012 10:16:42 +0100, Maxime Ripard wrote:
> >> +asmlinkage void __exception_irq_entry sunxi_handle_irq(struct pt_regs *regs)
> >> +{
> >> +	u32 irq, reg;
> >> +	int i;
> >> +
> >> +	for (i = 0; i < 3; i++) {
> >> +		reg = readl(sunxi_irq_base + SUNXI_IRQ_PENDING_REG(i));
> >> +		if (reg == 0)
> >> +			continue;
> >> +		irq = ilog2(reg);
> >> +		break;
> >> +	}
> >> +	irq = irq_find_mapping(sunxi_irq_domain, irq);
> >> +	handle_IRQ(irq, regs);
> > 
> > Why don't you use the interrupt-vector register to get the active
> > interrupt source? Here is my version:
> > 
> > asmlinkage void __exception_irq_entry sunxi_handle_irq(struct pt_regs *regs)
> > {
> > 	u32 irq;
> > 
> > 	irq = readl(int_base + SW_INT_VECTOR_REG) >> 2;
> > 	irq = irq_find_mapping(sunxi_vic_domain, irq);
> > 	handle_IRQ(irq, regs);
> > }
> > 
> > I suggest you give it a try.
> 
> It definitely looks nicer. I'll try that and update.

How does this SW_INT_VECTOR_REG behave when there are multiple
interrupts pending? Shouldn't the code be something like:

	do {
		hwirq = readl(int_base + SW_INT_VECTOR_REG) >> 2;
		irq = irq_find_mapping(sunxi_vic_domain, hwirq);
		handle_IRQ(irq, regs);
	} while(hwirq != 0);

Or maybe the != 0 is not the good condition, but the idea is to handle
all pending interrupts. That said, the original code from Maxime was
not doing that as well.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
