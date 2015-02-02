From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 02 Feb 2015 21:22:01 +0100
Subject: [PATCH v2] ARM: pxa: fix pxa interrupts handling in DT
In-Reply-To: <1422814816-23887-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Sun, 1 Feb 2015 19:20:16 +0100")
References: <1422743783-32511-1-git-send-email-robert.jarzmik@free.fr>
 <1422814816-23887-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87wq409i8m.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> @@ -66,18 +67,20 @@ static inline void __iomem *irq_base(int i)
>  void pxa_mask_irq(struct irq_data *d)
>  {
>  	void __iomem *base = irq_data_get_irq_chip_data(d);
> +	irq_hw_number_t irq = irqd_to_hwirq(d);
>  	uint32_t icmr = __raw_readl(base + ICMR);
>  
> -	icmr &= ~(1 << IRQ_BIT(d->irq));
> +	icmr &= ~BIT(irq);
This should be : icmr &= ~BIT(irq & 0x1f);

>  	__raw_writel(icmr, base + ICMR);
>  }
>  
>  void pxa_unmask_irq(struct irq_data *d)
>  {
>  	void __iomem *base = irq_data_get_irq_chip_data(d);
> +	irq_hw_number_t irq = irqd_to_hwirq(d);
>  	uint32_t icmr = __raw_readl(base + ICMR);
>  
> -	icmr |= 1 << IRQ_BIT(d->irq);
> +	icmr |= BIT(irq);
Ditto.

> +void __init pxa_init_irq(int irq_nr, int (*fn)(struct irq_data *, unsigned int))
> +{
> +	BUG_ON(irq_nr > MAX_INTERNAL_IRQS);
> +
> +	pxa_irq_base = io_p2v(0x40d00000);
> +	cpu_has_ipr = !cpu_is_pxa25x();
> +	pxa_init_irq_common(NULL, irq_nr, fn);
> +}
This requires "select IRQ_DOMAIN" in arch/arm/Kconfig in ARCH_PXA.

-- 
Robert
