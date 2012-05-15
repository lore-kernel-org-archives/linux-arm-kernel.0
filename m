From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 15 May 2012 10:29:43 -0600
Subject: [PATCH 15/20] ARM: Exynos: Add irq_domain support for gpio wakeup
 interrupts
In-Reply-To: <1335813270-13083-16-git-send-email-thomas.abraham@linaro.org>
References: <1335813270-13083-1-git-send-email-thomas.abraham@linaro.org>
 <1335813270-13083-16-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120515162943.EDA6A3E07AF@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Apr 2012 12:14:25 -0700, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> Add a irq_domain for all the 32 gpio external wakeup interrupt sources.
> Since there are users of fixed linux irq numbers of the external wakeup
> interrupts, the legacy mapping is used for the irq domain. The fixups
> required to use irq domain based interrupt mapping is also included.
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  arch/arm/mach-exynos/common.c                 |   67 +++++++++++++++++--------
>  arch/arm/mach-exynos/include/mach/regs-gpio.h |    4 +-
>  2 files changed, 48 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
> index 810f804..0d69412 100644
> --- a/arch/arm/mach-exynos/common.c
> +++ b/arch/arm/mach-exynos/common.c
> @@ -752,6 +752,9 @@ static DEFINE_SPINLOCK(eint_lock);
>  
>  static unsigned int eint0_15_data[16];
>  
> +#define EXYNOS_EINT_NR 32
> +static struct irq_domain *irq_domain;
> +
>  static inline int exynos4_irq_to_gpio(unsigned int irq)
>  {
>  	if (irq < IRQ_EINT(0))
> @@ -842,9 +845,9 @@ static inline void exynos_irq_eint_mask(struct irq_data *data)
>  	u32 mask;
>  
>  	spin_lock(&eint_lock);
> -	mask = __raw_readl(EINT_MASK(exynos_eint_base, data->irq));
> -	mask |= EINT_OFFSET_BIT(data->irq);
> -	__raw_writel(mask, EINT_MASK(exynos_eint_base, data->irq));
> +	mask = __raw_readl(EINT_MASK(exynos_eint_base, data->hwirq));
> +	mask |= EINT_OFFSET_BIT(data->hwirq);
> +	__raw_writel(mask, EINT_MASK(exynos_eint_base, data->hwirq));
>  	spin_unlock(&eint_lock);
>  }
>  
> @@ -853,16 +856,16 @@ static void exynos_irq_eint_unmask(struct irq_data *data)
>  	u32 mask;
>  
>  	spin_lock(&eint_lock);
> -	mask = __raw_readl(EINT_MASK(exynos_eint_base, data->irq));
> -	mask &= ~(EINT_OFFSET_BIT(data->irq));
> -	__raw_writel(mask, EINT_MASK(exynos_eint_base, data->irq));
> +	mask = __raw_readl(EINT_MASK(exynos_eint_base, data->hwirq));
> +	mask &= ~(EINT_OFFSET_BIT(data->hwirq));
> +	__raw_writel(mask, EINT_MASK(exynos_eint_base, data->hwirq));
>  	spin_unlock(&eint_lock);
>  }
>  
>  static inline void exynos_irq_eint_ack(struct irq_data *data)
>  {
> -	__raw_writel(EINT_OFFSET_BIT(data->irq),
> -		     EINT_PEND(exynos_eint_base, data->irq));
> +	__raw_writel(EINT_OFFSET_BIT(data->hwirq),
> +		     EINT_PEND(exynos_eint_base, data->hwirq));
>  }
>  
>  static void exynos_irq_eint_maskack(struct irq_data *data)
> @@ -873,7 +876,7 @@ static void exynos_irq_eint_maskack(struct irq_data *data)
>  
>  static int exynos_irq_eint_set_type(struct irq_data *data, unsigned int type)
>  {
> -	int offs = EINT_OFFSET(data->irq);
> +	int offs = data->hwirq;
>  	int shift;
>  	u32 ctrl, mask;
>  	u32 newvalue = 0;
> @@ -908,10 +911,10 @@ static int exynos_irq_eint_set_type(struct irq_data *data, unsigned int type)
>  	mask = 0x7 << shift;
>  
>  	spin_lock(&eint_lock);
> -	ctrl = __raw_readl(EINT_CON(exynos_eint_base, data->irq));
> +	ctrl = __raw_readl(EINT_CON(exynos_eint_base, data->hwirq));
>  	ctrl &= ~mask;
>  	ctrl |= newvalue << shift;
> -	__raw_writel(ctrl, EINT_CON(exynos_eint_base, data->irq));
> +	__raw_writel(ctrl, EINT_CON(exynos_eint_base, data->hwirq));
>  	spin_unlock(&eint_lock);
>  
>  	if (soc_is_exynos5250())
> @@ -955,7 +958,7 @@ static inline void exynos_irq_demux_eint(unsigned int start)
>  
>  	while (status) {
>  		irq = fls(status) - 1;
> -		generic_handle_irq(irq + start);
> +		generic_handle_irq(irq_find_mapping(irq_domain, irq + start));
>  		status &= ~(1 << irq);
>  	}
>  }
> @@ -964,8 +967,8 @@ static void exynos_irq_demux_eint16_31(unsigned int irq, struct irq_desc *desc)
>  {
>  	struct irq_chip *chip = irq_get_chip(irq);
>  	chained_irq_enter(chip, desc);
> -	exynos_irq_demux_eint(IRQ_EINT(16));
> -	exynos_irq_demux_eint(IRQ_EINT(24));
> +	exynos_irq_demux_eint(16);
> +	exynos_irq_demux_eint(24);
>  	chained_irq_exit(chip, desc);
>  }
>  
> @@ -973,6 +976,7 @@ static void exynos_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
>  {
>  	u32 *irq_data = irq_get_handler_data(irq);
>  	struct irq_chip *chip = irq_get_chip(irq);
> +	int eint_irq;
>  
>  	chained_irq_enter(chip, desc);
>  	chip->irq_mask(&desc->irq_data);
> @@ -980,15 +984,28 @@ static void exynos_irq_eint0_15(unsigned int irq, struct irq_desc *desc)
>  	if (chip->irq_ack)
>  		chip->irq_ack(&desc->irq_data);
>  
> -	generic_handle_irq(*irq_data);
> +	eint_irq = irq_find_mapping(irq_domain, *irq_data);
> +	generic_handle_irq(eint_irq);
>  
>  	chip->irq_unmask(&desc->irq_data);
>  	chained_irq_exit(chip, desc);
>  }
>  
> +static int exynos_eint_irq_domain_map(struct irq_domain *d, unsigned int irq,
> +					irq_hw_number_t hw)
> +{
> +	irq_set_chip_and_handler(irq, &exynos_irq_eint, handle_level_irq);
> +	set_irq_flags(irq, IRQF_VALID);
> +	return 0;
> +}
> +
> +static struct irq_domain_ops exynos_eint_irq_domain_ops = {
> +	.map = exynos_eint_irq_domain_map,
> +};
> +
>  static int __init exynos_init_irq_eint(void)
>  {
> -	int irq, *src_int;
> +	int irq, *src_int, irq_base;
>  	unsigned int paddr;
>  
>  	paddr = soc_is_exynos5250() ? EXYNOS5_PA_GPIO1 : EXYNOS4_PA_GPIO2;
> @@ -998,16 +1015,24 @@ static int __init exynos_init_irq_eint(void)
>  		return -ENXIO;
>  	}
>  
> -	for (irq = 0 ; irq <= 31 ; irq++) {
> -		irq_set_chip_and_handler(IRQ_EINT(irq), &exynos_irq_eint,
> -					 handle_level_irq);
> -		set_irq_flags(IRQ_EINT(irq), IRQF_VALID);
> +	irq_base = irq_alloc_descs(IRQ_EINT(0), 1, EXYNOS_EINT_NR, 0);
> +	if (IS_ERR_VALUE(irq_base)) {
> +		irq_base = IRQ_EINT(0);
> +		pr_warning("%s: irq desc alloc failed. Continuing with %d as "
> +				"linux irq base\n", __func__, irq_base);
> +	}
> +
> +	irq_domain = irq_domain_add_legacy(NULL, EXYNOS_EINT_NR, irq_base, 0,
> +					 &exynos_eint_irq_domain_ops, NULL);
> +	if (WARN_ON(!irq_domain)) {
> +		pr_warning("%s: irq domain init failed\n", __func__);
> +		return 0;
>  	}
>  
>  	irq_set_chained_handler(EXYNOS_IRQ_EINT16_31, exynos_irq_demux_eint16_31);
>  
>  	for (irq = 0 ; irq <= 15; irq++) {
> -		eint0_15_data[irq] = IRQ_EINT(irq);
> +		eint0_15_data[irq] = irq;
>  		src_int = soc_is_exynos5250() ? exynos5_eint0_15_src_int :
>  						exynos4_eint0_15_src_int;
>  		irq_set_handler_data(src_int[irq], &eint0_15_data[irq]);
> diff --git a/arch/arm/mach-exynos/include/mach/regs-gpio.h b/arch/arm/mach-exynos/include/mach/regs-gpio.h
> index e4b5b60..24bf4ec 100644
> --- a/arch/arm/mach-exynos/include/mach/regs-gpio.h
> +++ b/arch/arm/mach-exynos/include/mach/regs-gpio.h
> @@ -16,13 +16,13 @@
>  #include <mach/map.h>
>  #include <mach/irqs.h>
>  
> -#define EINT_REG_NR(x)			(EINT_OFFSET(x) >> 3)
> +#define EINT_REG_NR(x)			((x) >> 3)
>  #define EINT_CON(b, x)			(b + 0xE00 + (EINT_REG_NR(x) * 4))
>  #define EINT_FLTCON(b, x)		(b + 0xE80 + (EINT_REG_NR(x) * 4))
>  #define EINT_MASK(b, x)			(b + 0xF00 + (EINT_REG_NR(x) * 4))
>  #define EINT_PEND(b, x)			(b + 0xF40 + (EINT_REG_NR(x) * 4))
>  
> -#define EINT_OFFSET_BIT(x)		(1 << (EINT_OFFSET(x) & 0x7))
> +#define EINT_OFFSET_BIT(x)		(1 << ((x) & 0x7))
>  
>  /* compatibility for plat-s5p/irq-pm.c */
>  #define EXYNOS4_EINT40CON		(S5P_VA_GPIO2 + 0xE00)
> -- 
> 1.7.5.4
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
