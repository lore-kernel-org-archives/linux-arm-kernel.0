From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Mon, 25 Apr 2011 13:17:01 -0700
Subject: [RFC PATCH 01/12] ARM: gic: add per-cpu interrupt multiplexer
In-Reply-To: <1303326501-15664-2-git-send-email-marc.zyngier@arm.com>
References: <1303326501-15664-1-git-send-email-marc.zyngier@arm.com>
	<1303326501-15664-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <4DB5D6BD.3000405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Zyngier wrote:
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index e9c2ff8..60f8915 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -42,6 +42,11 @@ struct gic_chip_data {
>  	unsigned int irq_offset;
>  	void __iomem *dist_base;
>  	void __iomem *cpu_base;
> +#ifdef CONFIG_ARM_GIC_VPPI
> +	int	     ppi_base;
> +	int	     vppi_base;
> +	u16	     nrppis;
> +#endif
>  };

Can you put some document around this struct? Mention that ppi_base, 
vppi_base and nrppis will be zero for non-primary gic.


>  static void __init gic_dist_init(struct gic_chip_data *gic,
>  	unsigned int irq_start)
>  {
> -	unsigned int gic_irqs, irq_limit, i;
> +	unsigned int gic_irqs, irq_limit, i, nrvppis = 0;
>  	void __iomem *base = gic->dist_base;
>  	u32 cpumask = 1 << smp_processor_id();
> +	u32 dist_ctr, nrcpus;
>  
>  	cpumask |= cpumask << 8;
>  	cpumask |= cpumask << 16;
> @@ -278,11 +359,32 @@ static void __init gic_dist_init(struct gic_chip_data *gic,
>  	 * Find out how many interrupts are supported.
>  	 * The GIC only supports up to 1020 interrupt sources.
>  	 */
> -	gic_irqs = readl(base + GIC_DIST_CTR) & 0x1f;
> -	gic_irqs = (gic_irqs + 1) * 32;
> +	dist_ctr = readl(base + GIC_DIST_CTR);
> +	gic_irqs = ((dist_ctr & 0x1f) + 1) * 32;
>  	if (gic_irqs > 1020)
>  		gic_irqs = 1020;
>  
> +	/* Find out how many CPUs are supported (8 max). */
> +	nrcpus = ((dist_ctr >> 5) & 7) + 1;
> +
> +#ifdef CONFIG_ARM_GIC_VPPI
> +	/*
> +	 * Nobody would be insane enough to use PPIs on a secondary
> +	 * GIC, right?
> +	 */
> +	if (gic == &gic_data[0]) {
> +		gic->nrppis = 16 - (irq_start % 16);
> +		gic->ppi_base = gic->irq_offset + 32 - gic->nrppis;
> +		nrvppis = gic->nrppis * nrcpus;
> +	} else {
> +		gic->ppi_base = 0;
> +		gic->vppi_base = 0;
> +	}
> +#endif
> +
> +	pr_info("Configuring GIC with %d sources (%d additional PPIs)\n",
> +		gic_irqs, nrvppis);
> +
>  	/*
>  	 * Set all global interrupts to be level triggered, active low.
>  	 */
> @@ -312,17 +414,39 @@ static void __init gic_dist_init(struct gic_chip_data *gic,
>  	 * Limit number of interrupts registered to the platform maximum
>  	 */
>  	irq_limit = gic->irq_offset + gic_irqs;
> -	if (WARN_ON(irq_limit > NR_IRQS))
> +	if (WARN_ON((irq_limit) > NR_IRQS))
>  		irq_limit = NR_IRQS;
>  
>  	/*
>  	 * Setup the Linux IRQ subsystem.
>  	 */
>  	for (i = irq_start; i < irq_limit; i++) {
> -		irq_set_chip_and_handler(i, &gic_chip, handle_fasteoi_irq);
> +#ifdef CONFIG_ARM_GIC_VPPI
> +		if (nrvppis && gic_irq_is_ppi(gic, i))
> +			irq_set_chip_and_handler(i, &gic_chip, gic_handle_ppi);
> +		else
> +#endif
> +		{
> +			irq_set_chip_and_handler(i, &gic_chip,
> +						 handle_fasteoi_irq);
> +			set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
> +		}
> +		irq_set_chip_data(i, gic);
> +	}
> +
> +#ifdef CONFIG_ARM_GIC_VPPI
> +	if (!nrvppis)
> +		goto out;
> +	gic->vppi_base = irq_alloc_descs(-1, 0, nrvppis, 0);
> +	if (unlikely(WARN_ON(gic->vppi_base < 0)))
> +		goto out;
> +	for (i = gic->vppi_base; i < (gic->vppi_base + nrvppis); i++) {
> +		irq_set_chip_and_handler(i, &gic_ppi_chip, handle_fasteoi_irq);

Can we do with handle_percpu_irq instead of handle_fasteoi_irq?

--
Sent by an employee of the Qualcomm Innovation Center, Inc. The Qualcomm 
Innovation Center, Inc. is a member of the Code Aurora Forum.
