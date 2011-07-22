From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Jul 2011 10:42:54 +0100
Subject: [RFC PATCH v9 1/4] ARM: gic: consolidate PPI handling
In-Reply-To: <1311267448-14652-2-git-send-email-marc.zyngier@arm.com>
References: <1311267448-14652-1-git-send-email-marc.zyngier@arm.com>
	<1311267448-14652-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110722094254.GD21416@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 05:57:25PM +0100, Marc Zyngier wrote:
> @@ -256,12 +260,33 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
>  	irq_set_chained_handler(irq, gic_handle_cascade_irq);
>  }
>  
> +static unsigned int gic_nr_ppis, gic_ppi_base;
> +
> +#define PPI_IRQACT(nr)						\
> +	{							\
> +		.handler	= percpu_timer_handler,		\

Won't this break on non-SMP non-localtimer builds?

> +		.flags		= IRQF_PERCPU | IRQF_TIMER,	\
> +		.irq		= nr,				\
> +		.name		= "PPI-" # nr,			\
> +	}
> +
> +static struct irqaction ppi_irqaction_template[16] __initdata = {
> +	PPI_IRQACT(0),  PPI_IRQACT(1),  PPI_IRQACT(2),  PPI_IRQACT(3),
> +	PPI_IRQACT(4),  PPI_IRQACT(5),  PPI_IRQACT(6),  PPI_IRQACT(7),
> +	PPI_IRQACT(8),  PPI_IRQACT(9),  PPI_IRQACT(10), PPI_IRQACT(11),
> +	PPI_IRQACT(12), PPI_IRQACT(13), PPI_IRQACT(14), PPI_IRQACT(15),
> +};
> +
> +static struct irqaction *ppi_irqaction;
> +
>  static void __init gic_dist_init(struct gic_chip_data *gic,
>  	unsigned int irq_start)
>  {
>  	unsigned int gic_irqs, irq_limit, i;
>  	void __iomem *base = gic->dist_base;
>  	u32 cpumask = 1 << smp_processor_id();
> +	u32 dist_ctr, nrcpus;

nrcpus doesn't seem to be used.  With that eliminated, dist_ctr doesn't
seem to have much purpose.

> +	u32 nrppis = 0, ppi_base = 0;

Might be better to move this inside the "if (gic == &gic_data[0]) {" block,
along with the printk too.

>  
>  	cpumask |= cpumask << 8;
>  	cpumask |= cpumask << 16;
> @@ -272,11 +297,38 @@ static void __init gic_dist_init(struct gic_chip_data *gic,
>  	 * Find out how many interrupts are supported.
>  	 * The GIC only supports up to 1020 interrupt sources.
>  	 */
> -	gic_irqs = readl_relaxed(base + GIC_DIST_CTR) & 0x1f;
> -	gic_irqs = (gic_irqs + 1) * 32;
> +	dist_ctr = readl_relaxed(base + GIC_DIST_CTR);
> +	gic_irqs = ((dist_ctr & 0x1f) + 1) * 32;
>  	if (gic_irqs > 1020)
>  		gic_irqs = 1020;
>  
> +	/* Find out how many CPUs are supported (8 max). */
> +	nrcpus = ((dist_ctr >> 5) & 7) + 1;

As mentioned above, the above change can be killed because it doesn't
alter anything which is used.

> +
> +	/*
> +	 * Nobody would be insane enough to use PPIs on a secondary
> +	 * GIC, right?
> +	 */
> +	if (gic == &gic_data[0]) {
> +		nrppis = 16 - (irq_start & 15);
> +		ppi_base = gic->irq_offset + 32 - nrppis;
> +		ppi_irqaction = kzalloc(sizeof(*ppi_irqaction) * nrppis,
> +					 GFP_KERNEL);
> +		if (!ppi_irqaction) {
> +			pr_err("GIC: Can't allocate PPI memory");
> +			nrppis = 0;
> +			ppi_base = 0;
> +		}
> +
> +		for (i = 0; i < nrppis; i++)
> +			ppi_irqaction[i] = ppi_irqaction_template[i + (ppi_base & 15)];
> +		gic_nr_ppis = nrppis;
> +		gic_ppi_base = ppi_base;

Would:
		ppi_irqaction = kmemdup(ppi_irqaction_template,
					sizeof(*ppi_irqaction) * nrppis,
					GFP_KERNEL);
		if (ppi_irqaction) {
			gic_nr_ppis = nrppis;
			gic_ppi_base = ppi_base;
		}

be a shorter way to write what you have above?
