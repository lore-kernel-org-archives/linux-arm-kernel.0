From: robherring2@gmail.com (Rob Herring)
Date: Wed, 08 Feb 2012 13:47:21 -0600
Subject: [PATCH] ARM: Exynos: Add irq domain and device tree support for
 interrupt combiner
In-Reply-To: <1328724604-11192-1-git-send-email-thomas.abraham@linaro.org>
References: <1328724604-11192-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <4F32D149.7030908@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2012 12:10 PM, Thomas Abraham wrote:
> A common irq domain for the interrupts managed by the interrupt combiners is
> setup. All the instances of irq combiner reference the common irq domain for
> translating hardware interrupts to linux irq number.
> 
> In case of device tree based boot, a interrupt specifier translator is setup
> that can translate interrupt specifiers for device nodes which use combiner
> as their interrupt parent.
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> Changes since v2:
> - Rebased to Grant's irqdomain/next branch.
> 
> Changes since v1:
> - Includes all changes suggested by Rob Herring.
> - Tested with SPARSE_IRQ enabled.
> 
>  arch/arm/mach-exynos/common.c |  100 ++++++++++++++++++++++++++++++++--------
>  1 files changed, 80 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index 6de298c..24693f0 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c

snip

> -	for (i = irq_start; i < combiner_data[combiner_nr].irq_offset
> -				+ MAX_IRQ_IN_COMBINER; i++) {
> -		irq_set_chip_and_handler(i, &combiner_chip, handle_level_irq);
> -		irq_set_chip_data(i, &combiner_data[combiner_nr]);
> -		set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
> +	if (combiner_init_irq_domain(COMBINER_IRQ(0, 0), MAX_COMBINER_NR *
> +					MAX_IRQ_IN_COMBINER, np))
> +		BUG();

You've already done a WARN. Do you need a BUG too?

> +	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
> +		combiner_init(irq, (void __iomem *)S5P_VA_COMBINER(irq));
> +		combiner_cascade_irq(irq, IRQ_SPI(irq));

This is relying on fixed Linux irq numbers and will break once GIC is
using linear domains. Somehow you need to lookup the linux irq# using
the GIC hw irq#.

Rob

>  	}
>  }
>  
> +
>  #ifdef CONFIG_OF
>  static const struct of_device_id exynos4_dt_irq_match[] = {
>  	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
> +	{ .compatible = "samsung,exynos4120-combiner",
> +			.data = combiner_of_init, },
>  	{},
>  };
>  #endif
>  
>  void __init exynos4_init_irq(void)
>  {
> -	int irq;
>  	unsigned int gic_bank_offset;
>  
>  	gic_bank_offset = soc_is_exynos4412() ? 0x4000 : 0x8000;
> @@ -408,12 +472,8 @@ void __init exynos4_init_irq(void)
>  		of_irq_init(exynos4_dt_irq_match);
>  #endif
>  
> -	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
> -
> -		combiner_init(irq, (void __iomem *)S5P_VA_COMBINER(irq),
> -				COMBINER_IRQ(irq, 0));
> -		combiner_cascade_irq(irq, IRQ_SPI(irq));
> -	}
> +	if (!of_have_populated_dt())
> +		combiner_of_init(NULL, NULL);
>  
>  	/*
>  	 * The parameters of s5p_init_irq() are for VIC init.
