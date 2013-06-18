From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jun 2013 11:35:35 +0100
Subject: [PATCH] ARM: irqchip: add support for MOXA ART SoCs
In-Reply-To: <1371549584-7169-1-git-send-email-jonas.jensen@gmail.com>
References: <1371549584-7169-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20130618103534.GW2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 11:59:44AM +0200, Jonas Jensen wrote:
> +void moxart_irq_ack(struct irq_data *irqd)
> +{
> +	unsigned int irq = irqd_to_hwirq(irqd);
> +
> +	writel(1 << irq, IRQ_CLEAR(moxart_irq_base));
> +}
> +
> +static void moxart_irq_mask(struct irq_data *irqd)
> +{
> +	unsigned int irq = irqd_to_hwirq(irqd);
> +	unsigned int mask;
> +
> +	mask = readl(IRQ_MASK(moxart_irq_base));
> +	mask &= ~(1 << irq);
> +	writel(mask, IRQ_MASK(moxart_irq_base));
> +}
> +
> +static void moxart_irq_unmask(struct irq_data *irqd)
> +{
> +	unsigned int irq = irqd_to_hwirq(irqd);
> +	unsigned int mask;
> +
> +	mask = readl(IRQ_MASK(moxart_irq_base));
> +	mask |= (1 << irq);
> +	writel(mask, IRQ_MASK(moxart_irq_base));
> +}

Is there a reason this isn't using the irq_chip_generic stuff which would
eliminate all the above?
