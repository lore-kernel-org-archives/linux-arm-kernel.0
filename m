From: chanho61.park@samsung.com (Chanho Park)
Date: Wed, 24 Oct 2012 11:20:12 +0900
Subject: [PATCH v4 2/5] ARM: EXYNOS: Correct combined IRQs for exynos4
In-Reply-To: <020c01cdb126$85c9c940$915d5bc0$%kim@samsung.com>
References: <1349662630-11607-1-git-send-email-chanho61.park@samsung.com>
 <1349662630-11607-3-git-send-email-chanho61.park@samsung.com>
 <020c01cdb126$85c9c940$915d5bc0$%kim@samsung.com>
Message-ID: <007401cdb18e$1907b3e0$4b171ba0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of Kukjin Kim
> Sent: Tuesday, October 23, 2012 10:59 PM
> To: 'Chanho Park'; ben-linux at fluff.org; linux-arm-kernel at lists.infradead.org;
> linux-samsung-soc at vger.kernel.org
> Cc: sachin.kamat at linaro.org; will.deacon at arm.com;
> kyungmin.park at samsung.com; linux at arm.linux.org.uk;
> thomas.abraham at linaro.org
> Subject: RE: [PATCH v4 2/5] ARM: EXYNOS: Correct combined IRQs for
> exynos4
> 
> Chanho Park wrote:
> >
> > This patch corrects combined IRQs for exynos4 series platform. The
> > exynos4412
> > has four extra combined irq group and the exynos4212 has two more
> > combined irqs than exynos4210. Each irq is mapped to IRQ_SPI(xx).
> > Unfortunately, extra 4 combined IRQs isn't sequential. So, we need to
> > map the irqs manually.
> >
> > Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  arch/arm/mach-exynos/common.c            |   42
> +++++++++++++++++++++++++----
> > -
> >  arch/arm/mach-exynos/include/mach/irqs.h |    4 ++-
> >  2 files changed, 39 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/arm/mach-exynos/common.c
> > b/arch/arm/mach-exynos/common.c index 709245e..fdd582a 100644
> > --- a/arch/arm/mach-exynos/common.c
> > +++ b/arch/arm/mach-exynos/common.c
> > @@ -560,23 +560,50 @@ static struct irq_domain_ops
> > combiner_irq_domain_ops = {
> >  	.map	= combiner_irq_domain_map,
> >  };
> >
> > +static unsigned int combiner_extra_irq(int group)
> 
> This is only for exynos4212 and exynos4412 so how about to use
> exynos4x12_combiner_extra_irq()?

I agree with you. I'll change it in next patchset.

> 
> > +{
> > +	switch (group) {
> > +	case 16:
> > +		return IRQ_SPI(107);
> > +	case 17:
> > +		return IRQ_SPI(108);
> > +	case 18:
> > +		return IRQ_SPI(48);
> > +	case 19:
> > +		return IRQ_SPI(42);
> > +	default:
> > +		return 0;
> > +	}
> > +}
> > +
> > +static unsigned int max_combiner_nr(void) {
> > +	if (soc_is_exynos5250())
> > +		return EXYNOS5_MAX_COMBINER_NR;
> > +	else if (soc_is_exynos4412())
> > +		return EXYNOS4_MAX_COMBINER_NR;
> 
> EXYNOS4412_MAX_COMBINER_NR is more clear?

EXYNOS4_MAX_COMBINER_NR is defined for MAX_COMBINER_NR which determines maximum combined irq number.
In this situation, EXYNOS4_MAX_COMBINER_NR is more clear than EXYNOS4412_xx.
How about this? I think it's more clearer in all cases.

-#define EXYNOS4_MAX_COMBINER_NR		16
+#define EXYNOS4210_MAX_COMBINER_NR		16
+#define EXYNOS4212_MAX_COMBINER_NR		18
+#define EXYNOS4412_MAX_COMBINER_NR		20
+#define EXYNOS4_MAX_COMBINER_NR		EXYNOS4412_MAX_COMBINER_NR

> 
> > +	else if (soc_is_exynos4212())
> > +		return EXYNOS4212_MAX_COMBINER_NR;
> > +	else
> > +		return EXYNOS4210_MAX_COMBINER_NR;
> > +}
> > +
> >  static void __init combiner_init(void __iomem *combiner_base,
> >  				 struct device_node *np)
> >  {
> >  	int i, irq, irq_base;
> >  	unsigned int max_nr, nr_irq;
> >
> > +	max_nr = max_combiner_nr();
> > +
> >  	if (np) {
> >  		if (of_property_read_u32(np, "samsung,combiner-nr",
> &max_nr))
> > {
> >  			pr_warning("%s: number of combiners not specified,
> "
> 
> Hmm...the message should be changed, because it is just defined by
> checking SoC with this changes not property of device tree...So how about
> just using
> pr_info() with proper message?

I agree with you. I'll fix it.

> 
> >  				"setting default as %d.\n",
> > -				__func__, EXYNOS4_MAX_COMBINER_NR);
> > -			max_nr = EXYNOS4_MAX_COMBINER_NR;
> > +				__func__, max_nr);
> >  		}
> > -	} else {
> > -		max_nr = soc_is_exynos5250() ?
> EXYNOS5_MAX_COMBINER_NR :
> > -
> 	EXYNOS4_MAX_COMBINER_NR;
> >  	}
> > +
> >  	nr_irq = max_nr * MAX_IRQ_IN_COMBINER;
> >
> >  	irq_base = irq_alloc_descs(COMBINER_IRQ(0, 0), 1, nr_irq, 0); @@
> > -593,7 +620,10 @@ static void __init combiner_init(void __iomem
> > *combiner_base,
> >  	}
> >
> >  	for (i = 0; i < max_nr; i++) {
> > -		irq = IRQ_SPI(i);
> > +		if (i < EXYNOS4210_MAX_COMBINER_NR ||
> soc_is_exynos5250())
> > +			irq = IRQ_SPI(i);
> > +		else
> > +			irq = combiner_extra_irq(i);
> >  #ifdef CONFIG_OF
> >  		if (np)
> >  			irq = irq_of_parse_and_map(np, i); diff --git
> > a/arch/arm/mach-exynos/include/mach/irqs.h b/arch/arm/mach-
> > exynos/include/mach/irqs.h index 35bced6..3a83546 100644
> > --- a/arch/arm/mach-exynos/include/mach/irqs.h
> > +++ b/arch/arm/mach-exynos/include/mach/irqs.h
> > @@ -165,7 +165,9 @@
> >  #define EXYNOS4_IRQ_FIMD0_VSYNC		COMBINER_IRQ(11, 1)
> >  #define EXYNOS4_IRQ_FIMD0_SYSTEM	COMBINER_IRQ(11, 2)
> >
> > -#define EXYNOS4_MAX_COMBINER_NR		16
> > +#define EXYNOS4210_MAX_COMBINER_NR	16
> > +#define EXYNOS4212_MAX_COMBINER_NR	18
> > +#define EXYNOS4_MAX_COMBINER_NR		20
> 
> EXYNOS4412_MAX_COMBINER_NR ?
> 
> >
> >  #define EXYNOS4_IRQ_GPIO1_NR_GROUPS	16
> >  #define EXYNOS4_IRQ_GPIO2_NR_GROUPS	9
> > --
> > 1.7.9.5
> 
> 
> 
> Thanks.
> 
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer, SW Solution
> Development Team, Samsung Electronics Co., Ltd.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
