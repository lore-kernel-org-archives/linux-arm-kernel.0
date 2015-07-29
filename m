From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 29 Jul 2015 18:10:45 +0200 (CEST)
Subject: [PATCH] irqchip: gic: Add a cpu map for each GIC instance
In-Reply-To: <1438180984-18219-1-git-send-email-jonathanh@nvidia.com>
References: <1438180984-18219-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <alpine.DEB.2.11.1507291810040.3825@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 Jul 2015, Jon Hunter wrote:

Cc'ing Marc ...

> The gic_init_bases() function initialises an array that stores the mapping
> between the GIC and CPUs. This array is a global array that is
> unconditionally initialised on every call to gic_init_bases(). Although,
> it is not common for there to be more than one GIC instance, there are
> some devices that do support nested GIC controllers and gic_init_bases()
> can be called more than once.
> 
> A 2nd call to gic_init_bases() will clear the previous CPU mapping and
> will only setup the mapping again for CPU0. This is because for child GIC
> controllers there is most likely only one recipient of the interrupt.
> 
> Fix this by moving the CPU mapping array to the GIC chip data structure
> so that it is initialised for each GIC instance separately. It is assumed
> that the bL switcher code is only interested in the root or primary GIC
> instance.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  arch/arm/common/bL_switcher.c   |  2 +-
>  drivers/irqchip/irq-gic.c       | 41 ++++++++++++++++++++++-------------------
>  include/linux/irqchip/arm-gic.h |  2 +-
>  3 files changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/common/bL_switcher.c b/arch/arm/common/bL_switcher.c
> index 37dc0fe1093f..4111d7b36077 100644
> --- a/arch/arm/common/bL_switcher.c
> +++ b/arch/arm/common/bL_switcher.c
> @@ -488,7 +488,7 @@ static int bL_switcher_halve_cpus(void)
>  		cluster = MPIDR_AFFINITY_LEVEL(cpu_logical_map(i), 1);
>  
>  		/* Let's take note of the GIC ID for this CPU */
> -		gic_id = gic_get_cpu_id(i);
> +		gic_id = gic_get_cpu_id(i, 0);
>  		if (gic_id < 0) {
>  			pr_err("%s: bad GIC ID for CPU %d\n", __func__, i);
>  			bL_switcher_restore_cpus();
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index a530d9a9b810..78a7706c607e 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -50,6 +50,8 @@
>  
>  #include "irq-gic-common.h"
>  
> +#define NR_GIC_CPU_IF 8
> +
>  union gic_base {
>  	void __iomem *common_base;
>  	void __percpu * __iomem *percpu_base;
> @@ -70,18 +72,16 @@ struct gic_chip_data {
>  #ifdef CONFIG_GIC_NON_BANKED
>  	void __iomem *(*get_base)(union gic_base *);
>  #endif
> +	/*
> +	 * The GIC mapping of CPU interfaces does not necessarily match
> +	 * the logical CPU numbering.  Let's use a mapping as returned
> +	 * by the GIC itself.
> +	 */
> +	u8 cpu_map[NR_GIC_CPU_IF];
>  };
>  
>  static DEFINE_RAW_SPINLOCK(irq_controller_lock);
>  
> -/*
> - * The GIC mapping of CPU interfaces does not necessarily match
> - * the logical CPU numbering.  Let's use a mapping as returned
> - * by the GIC itself.
> - */
> -#define NR_GIC_CPU_IF 8
> -static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
> -
>  #ifndef MAX_GIC_NR
>  #define MAX_GIC_NR	1
>  #endif
> @@ -237,6 +237,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
>  static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>  			    bool force)
>  {
> +	struct gic_chip_data *gic = irq_data_get_irq_chip_data(d);
>  	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
>  	unsigned int cpu, shift = (gic_irq(d) % 4) * 8;
>  	u32 val, mask, bit;
> @@ -252,7 +253,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>  
>  	raw_spin_lock_irqsave(&irq_controller_lock, flags);
>  	mask = 0xff << shift;
> -	bit = gic_cpu_map[cpu] << shift;
> +	bit = gic->cpu_map[cpu] << shift;
>  	val = readl_relaxed(reg) & ~mask;
>  	writel_relaxed(val | bit, reg);
>  	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
> @@ -420,7 +421,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
>  	 */
>  	BUG_ON(cpu >= NR_GIC_CPU_IF);
>  	cpu_mask = gic_get_cpumask(gic);
> -	gic_cpu_map[cpu] = cpu_mask;
> +	gic->cpu_map[cpu] = cpu_mask;
>  
>  	/*
>  	 * Clear our mask from the other map entries in case they're
> @@ -428,7 +429,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
>  	 */
>  	for (i = 0; i < NR_GIC_CPU_IF; i++)
>  		if (i != cpu)
> -			gic_cpu_map[i] &= ~cpu_mask;
> +			gic->cpu_map[i] &= ~cpu_mask;
>  
>  	gic_cpu_config(dist_base, NULL);
>  
> @@ -677,7 +678,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>  
>  	/* Convert our logical CPU mask into a physical one. */
>  	for_each_cpu(cpu, mask)
> -		map |= gic_cpu_map[cpu];
> +		map |= gic->cpu_map[cpu];
>  
>  	/*
>  	 * Ensure that stores to Normal memory are visible to the
> @@ -722,15 +723,17 @@ void gic_send_sgi(unsigned int cpu_id, unsigned int irq)
>   * or -1 if the CPU number is too large or the interface ID is
>   * unknown (more than one bit set).
>   */
> -int gic_get_cpu_id(unsigned int cpu)
> +int gic_get_cpu_id(unsigned int cpu, unsigned int gic_nr)
>  {
>  	unsigned int cpu_bit;
>  
> +	if (gic_nr >= MAX_GIC_NR)
> +		return -EINVAL;
>  	if (cpu >= NR_GIC_CPU_IF)
> -		return -1;
> -	cpu_bit = gic_cpu_map[cpu];
> +		return -EINVAL;
> +	cpu_bit = gic_data[gic_nr].cpu_map[cpu];
>  	if (cpu_bit & (cpu_bit - 1))
> -		return -1;
> +		return -EINVAL;
>  	return __ffs(cpu_bit);
>  }
>  
> @@ -759,14 +762,14 @@ void gic_migrate_target(unsigned int new_cpu_id)
>  		return;
>  	gic_irqs = gic_data[gic_nr].gic_irqs;
>  
> -	cur_cpu_id = __ffs(gic_cpu_map[cpu]);
> +	cur_cpu_id = __ffs(gic->cpu_map[cpu]);
>  	cur_target_mask = 0x01010101 << cur_cpu_id;
>  	ror_val = (cur_cpu_id - new_cpu_id) & 31;
>  
>  	raw_spin_lock(&irq_controller_lock);
>  
>  	/* Update the target interface for this logical CPU */
> -	gic_cpu_map[cpu] = 1 << new_cpu_id;
> +	gic->cpu_map[cpu] = 1 << new_cpu_id;
>  
>  	/*
>  	 * Find all the peripheral interrupts targetting the current
> @@ -981,7 +984,7 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>  	 * It will be refined as each CPU probes its ID.
>  	 */
>  	for (i = 0; i < NR_GIC_CPU_IF; i++)
> -		gic_cpu_map[i] = 0xff;
> +		gic->cpu_map[i] = 0xff;
>  
>  	/*
>  	 * Find out how many interrupts are supported.
> diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
> index f52a9024be9a..9a4d30564492 100644
> --- a/include/linux/irqchip/arm-gic.h
> +++ b/include/linux/irqchip/arm-gic.h
> @@ -111,7 +111,7 @@ static inline void gic_init(unsigned int nr, int start,
>  int gicv2m_of_init(struct device_node *node, struct irq_domain *parent);
>  
>  void gic_send_sgi(unsigned int cpu_id, unsigned int irq);
> -int gic_get_cpu_id(unsigned int cpu);
> +int gic_get_cpu_id(unsigned int cpu, unsigned int gic_nr);
>  void gic_migrate_target(unsigned int new_cpu_id);
>  unsigned long gic_get_sgir_physaddr(void);
>  
> -- 
> 2.1.4
> 
> 
