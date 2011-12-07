From: robherring2@gmail.com (Rob Herring)
Date: Wed, 07 Dec 2011 10:24:36 -0600
Subject: [PATCH 2/4] arm: exynos4: add irq_domain support for wakeup
 interrupts
In-Reply-To: <1323266392-28330-3-git-send-email-thomas.abraham@linaro.org>
References: <1323266392-28330-1-git-send-email-thomas.abraham@linaro.org>
 <1323266392-28330-2-git-send-email-thomas.abraham@linaro.org>
 <1323266392-28330-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4EDF9344.7040003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On 12/07/2011 07:59 AM, Thomas Abraham wrote:
> Add irq_domain support for the 32 wakeup interrupt sources.
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/mach-exynos/include/mach/regs-gpio.h |    4 +-
>  arch/arm/mach-exynos/irq-eint.c               |   69 ++++++++++++++++---------
>  2 files changed, 46 insertions(+), 27 deletions(-)
> 

[snip]

> @@ -193,22 +199,35 @@ static void exynos4_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
>  
>  int __init exynos4_init_irq_eint(void)
>  {
> -	int irq;
> +	int irq, hwirq;
> +	struct irq_domain *domain = &exynos4_eint_irq_domain;
> +
> +	domain->irq_base = irq_alloc_descs(IRQ_EINT(0), IRQ_EINT(0),

Can this be dynamic and remove any compile time knowledge of the irq base?

> +						EXYNOS4_EINT_NR, 0);
> +	if (domain->irq_base < 0) {
> +		pr_err("exynos4_init_irq_eint: Failed to alloc irq descs\n");
> +		return -EBUSY;

You will hit this error with sparse irq unless you set nr_irq in mach
desc to NR_IRQ_LEGACY (16).

> +	}
> +	domain->nr_irq = EXYNOS4_EINT_NR;
> +	domain->ops = &irq_domain_simple_ops;
> +	irq_domain_add(domain);
>  
> -	for (irq = 0 ; irq <= 31 ; irq++) {
> -		irq_set_chip_and_handler(IRQ_EINT(irq), &exynos4_irq_eint,
> +	irq_domain_for_each_irq(domain, hwirq, irq) {
> +		irq_set_chip_and_handler(irq, &exynos4_irq_eint,
>  					 handle_level_irq);
> -		set_irq_flags(IRQ_EINT(irq), IRQF_VALID);
> +		set_irq_flags(irq, IRQF_VALID);
>  	}
>  
>  	irq_set_chained_handler(IRQ_EINT16_31, exynos4_irq_demux_eint16_31);
> +	irq_set_handler_data(IRQ_EINT16_31, &domain->irq_base);
>  
> -	for (irq = 0 ; irq <= 15 ; irq++) {
> -		eint0_15_data[irq] = IRQ_EINT(irq);
> +	for (hwirq = 0 ; hwirq <= 15 ; hwirq++) {
> +		irq = irq_domain_to_irq(domain, hwirq);
> +		eint0_15_data[irq] = irq;
>  
> -		irq_set_handler_data(exynos4_irq_eint_to_gic_irq(irq),
> +		irq_set_handler_data(exynos4_irq_eint_to_gic_irq(hwirq),
>  				     &eint0_15_data[irq]);
> -		irq_set_chained_handler(exynos4_irq_eint_to_gic_irq(irq),
> +		irq_set_chained_handler(exynos4_irq_eint_to_gic_irq(hwirq),
>  					exynos4_irq_eint0_15);
>  	}
>  
