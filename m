From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 2 May 2013 23:34:49 +0200 (CEST)
Subject: [PATCH] irqchip: add support for Marvell Orion SoCs
In-Reply-To: <1367519104-19677-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1367519104-19677-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <alpine.LFD.2.02.1305022324371.2891@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

please do not take the rant below personally. You just happen to
trigger it.

On Thu, 2 May 2013, Sebastian Hesselbarth wrote:

> +static void orion_irq_mask(struct irq_data *irqd)
> +{
> +	unsigned int irq = irqd_to_hwirq(irqd);
> +	unsigned int irq_off = irq % 32;
> +	int reg = irq / 32;
> +	u32 val;
> +
> +	val = readl(orion_irq_base[reg] + ORION_IRQ_MASK);
> +	writel(val & ~(1 << irq_off), orion_irq_base[reg] + ORION_IRQ_MASK);
> +}
> +
> +static void orion_irq_unmask(struct irq_data *irqd)
> +{
> +	unsigned int irq = irqd_to_hwirq(irqd);
> +	unsigned int irq_off = irq % 32;
> +	int reg = irq / 32;
> +	u32 val;
> +
> +	val = readl(orion_irq_base[reg] + ORION_IRQ_MASK);
> +	writel(val | (1 << irq_off), orion_irq_base[reg] + ORION_IRQ_MASK);
> +}

I'm really tired of looking at the next incarnation of an OF/DT irq
chip driver, which reimplements stuff which I have consolidated in the
generic irq chip implementation with a lot of effort.

Just look at the various implementations in drivers/irqchip/ and find
out how similar they are. Moving code to drivers/irqchip/ does not
make an excuse for reestablishing the mess which was addressed by the
generic irq chip implementation.

Can you - and that means all of you ARM folks - please get your gear
together and add the missing features to the generic irq chip
implementation? I'm not going to accept more of that OF/DT frenzy.

Thanks,

	tglx
