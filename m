From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 30 May 2013 22:29:45 +0100
Subject: [RFC PATCHv4 6/6] irqchip: TI-Nspire irqchip support
In-Reply-To: <1369480087-24786-7-git-send-email-dt.tangr@gmail.com>
References: <1369480087-24786-1-git-send-email-dt.tangr@gmail.com>
 <1369480087-24786-7-git-send-email-dt.tangr@gmail.com>
Message-ID: <20130530212945.C026C3E0A90@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 25 May 2013 21:08:07 +1000, Daniel Tang <dt.tangr@gmail.com> wrote:
> Add support for the interrupt controller on TI-Nspires.
> 
> Signed-off-by: Daniel Tang <dt.tangr@gmail.com>
[...]
> +static void nspire_irq_ack(struct irq_data *irqd)
> +{
> +	void __iomem *base = irq_io_base;
> +
> +	if (irqd->hwirq < FIQ_START)
> +		base += IO_IRQ_BASE;
> +	else
> +		base += IO_FIQ_BASE;
> +
> +	readl(base + IO_RESET);
> +}
> +
> +static void nspire_irq_unmask(struct irq_data *irqd)
> +{
> +	void __iomem *base = irq_io_base;
> +	int irqnr = irqd->hwirq;
> +
> +	if (irqnr < FIQ_START) {
> +		base += IO_IRQ_BASE;
> +	} else {
> +		irqnr -= MAX_INTRS;
> +		base += IO_FIQ_BASE;
> +	}
> +
> +	writel((1<<irqnr), base + IO_ENABLE);
> +}
> +
> +static void nspire_irq_mask(struct irq_data *irqd)
> +{
> +	void __iomem *base = irq_io_base;
> +	int irqnr = irqd->hwirq;
> +
> +	if (irqnr < FIQ_START) {
> +		base += IO_IRQ_BASE;
> +	} else {
> +		irqnr -= FIQ_START;
> +		base += IO_FIQ_BASE;
> +	}
> +
> +	writel((1<<irqnr), base + IO_DISABLE);
> +}
> +
> +static struct irq_chip nspire_irq_chip = {
> +	.name		= "nspire_irq",
> +	.irq_ack	= nspire_irq_ack,
> +	.irq_mask	= nspire_irq_mask,
> +	.irq_unmask	= nspire_irq_unmask,
> +};

Should be using irq_generic_chip here. There is no need to reimplement
the above ack, mask and unmask functions. You should find the
irq_alloc_domain_generic_chips() patch in the tip tree irq/for-arm
branch. That branch is staged for merging in v3.11

Otherwise the patch looks good.

g.
