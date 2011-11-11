From: robherring2@gmail.com (Rob Herring)
Date: Fri, 11 Nov 2011 09:51:18 -0600
Subject: [REPOST PATCH] ARM: gic: allow GIC to support non-banked setups
In-Reply-To: <1320421221-28711-1-git-send-email-marc.zyngier@arm.com>
References: <1320421221-28711-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <4EBD4476.7030200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/04/2011 10:40 AM, Marc Zyngier wrote:
> The GIC support code is heavily using the fact that hardware
> implementations are exposing banked registers. Unfortunately, it
> looks like at least one GIC implementation (EXYNOS4) offers both
> the distributor and the CPU interfaces at different addresses,
> depending on the CPU.
> 
> This problem is solved by turning the distributor and CPU interface
> addresses into per-cpu variables. The EXYNOS4 code is updated not
> to mess with the GIC internals while handling interrupts, and
> struct gic_chip_data is back to being private.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> I'm reposting this in order to generate some comments on the
> approach. An alternative has been suggested by Will Deacon,
> by adding platform specific callbacks returning the base addresses.
> Both solutions have a runtime impact on "normal" platforms.
> 
This doesn't really work well for DT as you are adding a place where the
platform needs to know the register addresses. Perhaps extending the gic
reg field to an array of cpu and dist addresses. This could all be setup
by gic_of_init on cpu 0.

It would be nice if everyone else wasn't punished with percpu data
lookups for the base addresses for 1 weird platform...

Rob

> The current state is quite ugly (the code is racy, messes with
> GIC internals, abuses the gic_arch_extn hooks and duplicates
> gic_secondary_init). As such, I'm hoping we can reach a quick
> decision on how to fix this.
> 
> Patch against mainline as of 03/11/2011.
> 
>  arch/arm/common/gic.c               |   78 +++++++++++++++++++++++++++--------
>  arch/arm/include/asm/hardware/gic.h |   19 +-------
>  arch/arm/mach-exynos4/cpu.c         |   14 ------
>  arch/arm/mach-exynos4/platsmp.c     |   28 ++-----------
>  4 files changed, 68 insertions(+), 71 deletions(-)
> 
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index 0e6ae47..1565fca 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -43,6 +43,23 @@
>  #include <asm/mach/irq.h>
>  #include <asm/hardware/gic.h>
>  
> +struct gic_chip_data {
> +	unsigned int irq_offset;
> +	void __percpu __iomem **dist_base;
> +	void __percpu __iomem **cpu_base;
> +#ifdef CONFIG_CPU_PM
> +	u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
> +	u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
> +	u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
> +	u32 __percpu *saved_ppi_enable;
> +	u32 __percpu *saved_ppi_conf;
> +#endif
> +#ifdef CONFIG_IRQ_DOMAIN
> +	struct irq_domain domain;
> +#endif
> +	unsigned int gic_irqs;
> +};
> +
>  static DEFINE_RAW_SPINLOCK(irq_controller_lock);
>  
>  /* Address of GIC 0 CPU interface */
> @@ -67,16 +84,26 @@ struct irq_chip gic_arch_extn = {
>  
>  static struct gic_chip_data gic_data[MAX_GIC_NR] __read_mostly;
>  
> +static inline void __iomem *gic_data_dist_base(struct gic_chip_data *data)
> +{
> +	return *__this_cpu_ptr(data->dist_base);
> +}
> +
>  static inline void __iomem *gic_dist_base(struct irq_data *d)
>  {
>  	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
> -	return gic_data->dist_base;
> +	return gic_data_dist_base(gic_data);
> +}
> +
> +static inline void __iomem *gic_data_cpu_base(struct gic_chip_data *data)
> +{
> +	return *__this_cpu_ptr(data->cpu_base);
>  }
>  
>  static inline void __iomem *gic_cpu_base(struct irq_data *d)
>  {
>  	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
> -	return gic_data->cpu_base;
> +	return gic_data_cpu_base(gic_data);
>  }
>  
>  static inline unsigned int gic_irq(struct irq_data *d)
> @@ -225,7 +252,7 @@ static void gic_handle_cascade_irq(unsigned int irq, struct irq_desc *desc)
>  	chained_irq_enter(chip, desc);
>  
>  	raw_spin_lock(&irq_controller_lock);
> -	status = readl_relaxed(chip_data->cpu_base + GIC_CPU_INTACK);
> +	status = readl_relaxed(gic_data_cpu_base(chip_data) + GIC_CPU_INTACK);
>  	raw_spin_unlock(&irq_controller_lock);
>  
>  	gic_irq = (status & 0x3ff);
> @@ -270,7 +297,7 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
>  	u32 cpumask;
>  	unsigned int gic_irqs = gic->gic_irqs;
>  	struct irq_domain *domain = &gic->domain;
> -	void __iomem *base = gic->dist_base;
> +	void __iomem *base = gic_data_dist_base(gic);
>  	u32 cpu = 0;
>  
>  #ifdef CONFIG_SMP
> @@ -330,8 +357,8 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
>  
>  static void __cpuinit gic_cpu_init(struct gic_chip_data *gic)
>  {
> -	void __iomem *dist_base = gic->dist_base;
> -	void __iomem *base = gic->cpu_base;
> +	void __iomem *dist_base = gic_data_dist_base(gic);
> +	void __iomem *base = gic_data_cpu_base(gic);
>  	int i;
>  
>  	/*
> @@ -368,7 +395,7 @@ static void gic_dist_save(unsigned int gic_nr)
>  		BUG();
>  
>  	gic_irqs = gic_data[gic_nr].gic_irqs;
> -	dist_base = gic_data[gic_nr].dist_base;
> +	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
>  
>  	if (!dist_base)
>  		return;
> @@ -403,7 +430,7 @@ static void gic_dist_restore(unsigned int gic_nr)
>  		BUG();
>  
>  	gic_irqs = gic_data[gic_nr].gic_irqs;
> -	dist_base = gic_data[gic_nr].dist_base;
> +	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
>  
>  	if (!dist_base)
>  		return;
> @@ -439,8 +466,8 @@ static void gic_cpu_save(unsigned int gic_nr)
>  	if (gic_nr >= MAX_GIC_NR)
>  		BUG();
>  
> -	dist_base = gic_data[gic_nr].dist_base;
> -	cpu_base = gic_data[gic_nr].cpu_base;
> +	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
> +	cpu_base = gic_data_cpu_base(&gic_data[gic_nr]);
>  
>  	if (!dist_base || !cpu_base)
>  		return;
> @@ -465,8 +492,8 @@ static void gic_cpu_restore(unsigned int gic_nr)
>  	if (gic_nr >= MAX_GIC_NR)
>  		BUG();
>  
> -	dist_base = gic_data[gic_nr].dist_base;
> -	cpu_base = gic_data[gic_nr].cpu_base;
> +	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
> +	cpu_base = gic_data_cpu_base(&gic_data[gic_nr]);
>  
>  	if (!dist_base || !cpu_base)
>  		return;
> @@ -569,13 +596,24 @@ void __init gic_init(unsigned int gic_nr, int irq_start,
>  	struct gic_chip_data *gic;
>  	struct irq_domain *domain;
>  	int gic_irqs;
> +	int cpu;
>  
>  	BUG_ON(gic_nr >= MAX_GIC_NR);
>  
>  	gic = &gic_data[gic_nr];
>  	domain = &gic->domain;
> -	gic->dist_base = dist_base;
> -	gic->cpu_base = cpu_base;
> +	gic->dist_base = alloc_percpu(void __iomem *);
> +	gic->cpu_base = alloc_percpu(void __iomem *);
> +	if (WARN_ON(!gic->dist_base || !gic->cpu_base)) {
> +		free_percpu(gic->dist_base);
> +		free_percpu(gic->cpu_base);
> +		return;
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		*per_cpu_ptr(gic->dist_base, cpu) = dist_base;
> +		*per_cpu_ptr(gic->cpu_base, cpu) = cpu_base;
> +	}
>  
>  	/*
>  	 * For primary GICs, skip over SGIs.
> @@ -617,11 +655,17 @@ void __init gic_init(unsigned int gic_nr, int irq_start,
>  	gic_pm_init(gic);
>  }
>  
> -void __cpuinit gic_secondary_init(unsigned int gic_nr)
> +void __cpuinit gic_secondary_init_base(unsigned int gic_nr,
> +				       void __iomem *dist_base,
> +				       void __iomem *cpu_base)
>  {
>  	BUG_ON(gic_nr >= MAX_GIC_NR);
>  
> -	gic_cpu_init(&gic_data[gic_nr]);
> +	if (dist_base)
> +		*__this_cpu_ptr(gic_data[gic_nr].dist_base) = dist_base;
> +	if (cpu_base)
> +		*__this_cpu_ptr(gic_data[gic_nr].cpu_base) = cpu_base;
> +	gic_cpu_init(&gic_data[gic_nr]);	
>  }
>  
>  #ifdef CONFIG_SMP
> @@ -641,7 +685,7 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>  	dsb();
>  
>  	/* this always happens on GIC0 */
> -	writel_relaxed(map << 16 | irq, gic_data[0].dist_base + GIC_DIST_SOFTINT);
> +	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
>  }
>  #endif
>  
> diff --git a/arch/arm/include/asm/hardware/gic.h b/arch/arm/include/asm/hardware/gic.h
> index 3e91f22..729e00b 100644
> --- a/arch/arm/include/asm/hardware/gic.h
> +++ b/arch/arm/include/asm/hardware/gic.h
> @@ -41,25 +41,12 @@ extern struct irq_chip gic_arch_extn;
>  
>  void gic_init(unsigned int, int, void __iomem *, void __iomem *);
>  int gic_of_init(struct device_node *node, struct device_node *parent);
> -void gic_secondary_init(unsigned int);
> +void gic_secondary_init_base(unsigned int, void __iomem *, void __iomem *);
>  void gic_cascade_irq(unsigned int gic_nr, unsigned int irq);
>  void gic_raise_softirq(const struct cpumask *mask, unsigned int irq);
>  
> -struct gic_chip_data {
> -	void __iomem *dist_base;
> -	void __iomem *cpu_base;
> -#ifdef CONFIG_CPU_PM
> -	u32 saved_spi_enable[DIV_ROUND_UP(1020, 32)];
> -	u32 saved_spi_conf[DIV_ROUND_UP(1020, 16)];
> -	u32 saved_spi_target[DIV_ROUND_UP(1020, 4)];
> -	u32 __percpu *saved_ppi_enable;
> -	u32 __percpu *saved_ppi_conf;
> -#endif
> -#ifdef CONFIG_IRQ_DOMAIN
> -	struct irq_domain domain;
> -#endif
> -	unsigned int gic_irqs;
> -};
> +#define gic_secondary_init(n)	gic_secondary_init_base((n), NULL, NULL)
> +
>  #endif
>  
>  #endif
> diff --git a/arch/arm/mach-exynos4/cpu.c b/arch/arm/mach-exynos4/cpu.c
> index a348434..017c990 100644
> --- a/arch/arm/mach-exynos4/cpu.c
> +++ b/arch/arm/mach-exynos4/cpu.c
> @@ -200,17 +200,6 @@ void __init exynos4_init_clocks(int xtal)
>  	exynos4_setup_clocks();
>  }
>  
> -static void exynos4_gic_irq_fix_base(struct irq_data *d)
> -{
> -	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
> -
> -	gic_data->cpu_base = S5P_VA_GIC_CPU +
> -			    (gic_bank_offset * smp_processor_id());
> -
> -	gic_data->dist_base = S5P_VA_GIC_DIST +
> -			    (gic_bank_offset * smp_processor_id());
> -}
> -
>  void __init exynos4_init_irq(void)
>  {
>  	int irq;
> @@ -218,9 +207,6 @@ void __init exynos4_init_irq(void)
>  	gic_bank_offset = soc_is_exynos4412() ? 0x4000 : 0x8000;
>  
>  	gic_init(0, IRQ_PPI(0), S5P_VA_GIC_DIST, S5P_VA_GIC_CPU);
> -	gic_arch_extn.irq_eoi = exynos4_gic_irq_fix_base;
> -	gic_arch_extn.irq_unmask = exynos4_gic_irq_fix_base;
> -	gic_arch_extn.irq_mask = exynos4_gic_irq_fix_base;
>  
>  	for (irq = 0; irq < MAX_COMBINER_NR; irq++) {
>  
> diff --git a/arch/arm/mach-exynos4/platsmp.c b/arch/arm/mach-exynos4/platsmp.c
> index 0559540..8b8e2f8 100644
> --- a/arch/arm/mach-exynos4/platsmp.c
> +++ b/arch/arm/mach-exynos4/platsmp.c
> @@ -65,39 +65,19 @@ static void __iomem *scu_base_addr(void)
>  
>  static DEFINE_SPINLOCK(boot_lock);
>  
> -static void __cpuinit exynos4_gic_secondary_init(void)
> +void __cpuinit platform_secondary_init(unsigned int cpu)
>  {
>  	void __iomem *dist_base = S5P_VA_GIC_DIST +
> -				(gic_bank_offset * smp_processor_id());
> +				(gic_bank_offset * cpu_logical_map(cpu));
>  	void __iomem *cpu_base = S5P_VA_GIC_CPU +
> -				(gic_bank_offset * smp_processor_id());
> -	int i;
> -
> -	/*
> -	 * Deal with the banked PPI and SGI interrupts - disable all
> -	 * PPI interrupts, ensure all SGI interrupts are enabled.
> -	 */
> -	__raw_writel(0xffff0000, dist_base + GIC_DIST_ENABLE_CLEAR);
> -	__raw_writel(0x0000ffff, dist_base + GIC_DIST_ENABLE_SET);
> +				(gic_bank_offset * cpu_logical_map(cpu));
>  
>  	/*
> -	 * Set priority on PPI and SGI interrupts
> -	 */
> -	for (i = 0; i < 32; i += 4)
> -		__raw_writel(0xa0a0a0a0, dist_base + GIC_DIST_PRI + i * 4 / 4);
> -
> -	__raw_writel(0xf0, cpu_base + GIC_CPU_PRIMASK);
> -	__raw_writel(1, cpu_base + GIC_CPU_CTRL);
> -}
> -
> -void __cpuinit platform_secondary_init(unsigned int cpu)
> -{
> -	/*
>  	 * if any interrupts are already enabled for the primary
>  	 * core (e.g. timer irq), then they will not have been enabled
>  	 * for us: do so
>  	 */
> -	exynos4_gic_secondary_init();
> +	gic_secondary_init_base(0, dist_base, cpu_base);
>  
>  	/*
>  	 * let the primary processor know we're out of the
