From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 18 May 2014 22:05:33 -0400
Subject: [PATCH v6 03/15] irq: gic: support hip04 gic
In-Reply-To: <1399795571-17231-4-git-send-email-haojian.zhuang@linaro.org>
References: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
 <1399795571-17231-4-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140519020533.GD27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian,

On Sun, May 11, 2014 at 04:05:59PM +0800, Haojian Zhuang wrote:
> There's a little difference between ARM GIC and HiP04 GIC.
> 
> * HiP04 GIC could support 16 cores at most, and ARM GIC could support
> 8 cores at most. So the difination on GIC_DIST_TARGET registers are
> different since CPU interfaces are increased from 8-bit to 16-bit.
> 
> * HiP04 GIC could support 510 interrupts at most, and ARM GIC could
> support 1020 interrupts at most.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/gic.txt |   1 +
>  drivers/irqchip/irq-gic.c                     | 160 ++++++++++++++++++++------
>  2 files changed, 129 insertions(+), 32 deletions(-)

As I'm still coming up to speed on this driver, I'm just going to make
some general comments about this patch.  If I appear to be off-base on
something, please don't assume I know better ;-)

I have no strong preference regarding using 'inline'.  In my own code, I
prefer to be explicit, but I also prefer to use macros in some of the
situations below.

I would try to avoid runtime calculations of known values (register
offsets, masks, etc) where possible.  I've tried to highlight some of
them below:

> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
> index 5573c08..150f7d6 100644
> --- a/Documentation/devicetree/bindings/arm/gic.txt
> +++ b/Documentation/devicetree/bindings/arm/gic.txt
> @@ -16,6 +16,7 @@ Main node required properties:
>  	"arm,cortex-a9-gic"
>  	"arm,cortex-a7-gic"
>  	"arm,arm11mp-gic"
> +	"hisilicon,hip04-gic"
>  - interrupt-controller : Identifies the node as an interrupt controller
>  - #interrupt-cells : Specifies the number of cells needed to encode an
>    interrupt source.  The type shall be a <u32> and the value shall be 3.
> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index f711fb6..d1d1430 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -68,6 +68,7 @@ struct gic_chip_data {
>  #ifdef CONFIG_GIC_NON_BANKED
>  	void __iomem *(*get_base)(union gic_base *);
>  #endif
> +	u32 nr_cpu_if;
>  };
>  
>  static DEFINE_RAW_SPINLOCK(irq_controller_lock);
> @@ -76,9 +77,11 @@ static DEFINE_RAW_SPINLOCK(irq_controller_lock);
>   * The GIC mapping of CPU interfaces does not necessarily match
>   * the logical CPU numbering.  Let's use a mapping as returned
>   * by the GIC itself.
> + *
> + * Hisilicon HiP04 extends the number of CPU interface from 8 to 16.
>   */
> -#define NR_GIC_CPU_IF 8
> -static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
> +#define NR_GIC_CPU_IF	16
> +static u16 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
>  
>  /*
>   * Supported arch specific GIC irq extension.
> @@ -241,20 +244,64 @@ static int gic_retrigger(struct irq_data *d)
>  	return 0;
>  }
>  
> +static inline bool gic_is_standard(struct gic_chip_data *gic)
> +{
> +	return (gic->nr_cpu_if == 8);
> +}
> +
> +static inline int gic_irqs_per_target_reg(struct gic_chip_data *gic)
> +{
> +	return 32 / gic->nr_cpu_if;
> +}
> +
>  #ifdef CONFIG_SMP
> +static inline u32 irq_to_target_reg(struct irq_data *d)
> +{
> +	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
> +	unsigned int i = gic_irq(d);
> +
> +	if (gic_is_standard(gic_data))
> +		i = i & ~3U;
> +	else
> +		i = (i << 1) & ~3U;
> +	return (i + GIC_DIST_TARGET);
> +}
> +
> +static inline u32 irq_to_core_shift(struct irq_data *d)
> +{
> +	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
> +	unsigned int i = gic_irq(d);
> +
> +	if (gic_is_standard(gic_data))
> +		return ((i % 4) << 3);
> +	return ((i % 2) << 4);
> +}
> +
> +static inline u32 irq_to_core_mask(struct irq_data *d)
> +{
> +	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
> +	u32 mask;
> +	/* ARM GIC, nr_cpu_if == 8; HiP04 GIC, nr_cpu_if == 16 */
> +	mask = (1 << gic_data->nr_cpu_if) - 1;
> +	return (mask << irq_to_core_shift(d));
> +}
> +
>  static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
>  			    bool force)
>  {
> -	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
> -	unsigned int shift = (gic_irq(d) % 4) * 8;
> +	void __iomem *reg;
> +	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
> +	unsigned int shift = irq_to_core_shift(d);
>  	unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
>  	u32 val, mask, bit;
>  
> -	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
> +	if (cpu >= gic_data->nr_cpu_if || cpu >= nr_cpu_ids)
>  		return -EINVAL;
>  
> +	reg = gic_dist_base(d) + irq_to_target_reg(d);
> +
>  	raw_spin_lock(&irq_controller_lock);
> -	mask = 0xff << shift;
> +	mask = irq_to_core_mask(d);

You're inside a spinlock here, calculating a mask value (in
irq_to_core_mask()) that never changes after boot.  It, in turn, calls
irq_to_core_shift() and checks gic_is_standard() to use two values that
also never change after boot.

Sure, these functions are inlined, but the compiler can't optimize for
something that's determined at runtime.  eg the mask, and X and Y in
((i % X) << Y).

>  	bit = gic_cpu_map[cpu] << shift;
>  	val = readl_relaxed(reg) & ~mask;
>  	writel_relaxed(val | bit, reg);
> @@ -354,15 +401,24 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
>  	irq_set_chained_handler(irq, gic_handle_cascade_irq);
>  }
>  
> -static u8 gic_get_cpumask(struct gic_chip_data *gic)
> +static u16 gic_get_cpumask(struct gic_chip_data *gic)
>  {
>  	void __iomem *base = gic_data_dist_base(gic);
>  	u32 mask, i;
>  
> -	for (i = mask = 0; i < 32; i += 4) {
> -		mask = readl_relaxed(base + GIC_DIST_TARGET + i);
> -		mask |= mask >> 16;
> -		mask |= mask >> 8;
> +	/*
> +	 * ARM GIC uses 8 registers for interrupt 0-31,
> +	 * HiP04 GIC uses 16 registers for interrupt 0-31.
> +	 */
> +	for (i = mask = 0; i < 32; i += gic_irqs_per_target_reg(gic)) {
> +		if (gic_is_standard(gic)) {
> +			mask = readl_relaxed(base + GIC_DIST_TARGET + i);
> +			mask |= mask >> 16;
> +			mask |= mask >> 8;
> +		} else {			/* HiP04 GIC */
> +			mask = readl_relaxed(base + GIC_DIST_TARGET + i * 2);
> +			mask |= mask >> 16;
> +		}
>  		if (mask)
>  			break;
>  	}
> @@ -370,6 +426,10 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
>  	if (!mask)
>  		pr_crit("GIC CPU mask not found - kernel will fail to boot.\n");
>  
> +	/* ARM GIC needs 8-bit cpu mask, HiP04 GIC needs 16-bit cpu mask. */
> +	if (gic_is_standard(gic))
> +		mask &= 0xff;
> +
>  	return mask;
>  }
>  
> @@ -392,10 +452,17 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
>  	 * Set all global interrupts to this CPU only.
>  	 */
>  	cpumask = gic_get_cpumask(gic);
> -	cpumask |= cpumask << 8;
> +	if (gic_is_standard(gic))
> +		cpumask |= cpumask << 8;
>  	cpumask |= cpumask << 16;
> -	for (i = 32; i < gic_irqs; i += 4)
> -		writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
> +	for (i = 32; i < gic_irqs; i += gic_irqs_per_target_reg(gic)) {
> +		if (gic_is_standard(gic))
> +			writel_relaxed(cpumask,
> +				       base + GIC_DIST_TARGET + i / 4 * 4);
> +		else
> +			writel_relaxed(cpumask,
> +				       base + GIC_DIST_TARGET + i / 2 * 4);
> +	}
>  
>  	/*
>  	 * Set priority on all global interrupts.
> @@ -423,7 +490,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
>  	/*
>  	 * Get what the GIC says our CPU mask is.
>  	 */
> -	BUG_ON(cpu >= NR_GIC_CPU_IF);
> +	BUG_ON(cpu >= gic->nr_cpu_if);
>  	cpu_mask = gic_get_cpumask(gic);
>  	gic_cpu_map[cpu] = cpu_mask;
>  
> @@ -431,7 +498,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
>  	 * Clear our mask from the other map entries in case they're
>  	 * still undefined.
>  	 */
> -	for (i = 0; i < NR_GIC_CPU_IF; i++)
> +	for (i = 0; i < gic->nr_cpu_if; i++)
>  		if (i != cpu)
>  			gic_cpu_map[i] &= ~cpu_mask;
>  
> @@ -467,7 +534,7 @@ void gic_cpu_if_down(void)
>   */
>  static void gic_dist_save(unsigned int gic_nr)
>  {
> -	unsigned int gic_irqs;
> +	unsigned int gic_irqs, nr_irq_per_target;
>  	void __iomem *dist_base;
>  	int i;
>  
> @@ -476,6 +543,7 @@ static void gic_dist_save(unsigned int gic_nr)
>  
>  	gic_irqs = gic_data[gic_nr].gic_irqs;
>  	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
> +	nr_irq_per_target = gic_irqs_per_target_reg(&gic_data[gic_nr]);

gic_dist_save() isn't called too often (suspend/idle), but this is
another example of calculating something that doesn't change after boot.

>  
>  	if (!dist_base)
>  		return;
> @@ -484,7 +552,7 @@ static void gic_dist_save(unsigned int gic_nr)
>  		gic_data[gic_nr].saved_spi_conf[i] =
>  			readl_relaxed(dist_base + GIC_DIST_CONFIG + i * 4);
>  
> -	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
> +	for (i = 0; i < DIV_ROUND_UP(gic_irqs, nr_irq_per_target); i++)
>  		gic_data[gic_nr].saved_spi_target[i] =
>  			readl_relaxed(dist_base + GIC_DIST_TARGET + i * 4);
>  
> @@ -502,7 +570,7 @@ static void gic_dist_save(unsigned int gic_nr)
>   */
>  static void gic_dist_restore(unsigned int gic_nr)
>  {
> -	unsigned int gic_irqs;
> +	unsigned int gic_irqs, nr_irq_per_target;
>  	unsigned int i;
>  	void __iomem *dist_base;
>  
> @@ -511,6 +579,7 @@ static void gic_dist_restore(unsigned int gic_nr)
>  
>  	gic_irqs = gic_data[gic_nr].gic_irqs;
>  	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
> +	nr_irq_per_target = gic_irqs_per_target_reg(&gic_data[gic_nr]);

Same.

>  
>  	if (!dist_base)
>  		return;
> @@ -525,7 +594,7 @@ static void gic_dist_restore(unsigned int gic_nr)
>  		writel_relaxed(0xa0a0a0a0,
>  			dist_base + GIC_DIST_PRI + i * 4);
>  
> -	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
> +	for (i = 0; i < DIV_ROUND_UP(gic_irqs, nr_irq_per_target); i++)
>  		writel_relaxed(gic_data[gic_nr].saved_spi_target[i],
>  			dist_base + GIC_DIST_TARGET + i * 4);
>  
> @@ -665,9 +734,19 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>  	 */
>  	dmb(ishst);
>  
> -	/* this always happens on GIC0 */
> -	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
> -
> +	/*
> +	 * CPUTargetList -- bit[23:16] in GIC_DIST_SOFTINT in ARM GIC.
> +	 *                  bit[23:8] in GIC_DIST_SOFTINT in HiP04 GIC.
> +	 * NSATT -- bit[15] in GIC_DIST_SOFTINT in ARM GIC.
> +	 *          bit[7] in GIC_DIST_SOFTINT in HiP04 GIC.
> +	 * this always happens on GIC0
> +	 */
> +	if (gic_is_standard(&gic_data[0]))
> +		map = map << 16;
> +	else
> +		map = map << 8;

ditto.  Inside a spinlock as well.

> +	writel_relaxed(map | irq,
> +		       gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
>  	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
>  }
>  #endif
> @@ -681,10 +760,15 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>   */
>  void gic_send_sgi(unsigned int cpu_id, unsigned int irq)
>  {
> -	BUG_ON(cpu_id >= NR_GIC_CPU_IF);
> +	BUG_ON(cpu_id >= gic_data[0].nr_cpu_if);
>  	cpu_id = 1 << cpu_id;
>  	/* this always happens on GIC0 */
> -	writel_relaxed((cpu_id << 16) | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
> +	if (gic_is_standard(&gic_data[0]))
> +		cpu_id = cpu_id << 16;
> +	else
> +		cpu_id = cpu_id << 8;

ditto.

> +	writel_relaxed(cpu_id | irq,
> +		       gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
>  }
>  
>  /*
> @@ -700,7 +784,7 @@ int gic_get_cpu_id(unsigned int cpu)
>  {
>  	unsigned int cpu_bit;
>  
> -	if (cpu >= NR_GIC_CPU_IF)
> +	if (cpu >= gic_data[0].nr_cpu_if)
>  		return -1;
>  	cpu_bit = gic_cpu_map[cpu];
>  	if (cpu_bit & (cpu_bit - 1))
> @@ -931,7 +1015,7 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>  	irq_hw_number_t hwirq_base;
>  	struct gic_chip_data *gic;
>  	int gic_irqs, irq_base, i;
> -	int nr_routable_irqs;
> +	int nr_routable_irqs, max_nr_irq;
>  
>  	BUG_ON(gic_nr >= MAX_GIC_NR);
>  
> @@ -967,12 +1051,22 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>  		gic_set_base_accessor(gic, gic_get_common_base);
>  	}
>  
> +	if (of_device_is_compatible(node, "hisilicon,hip04-gic")) {
> +		/* HiP04 GIC supports 16 CPUs at most */
> +		gic->nr_cpu_if = 16;
> +		max_nr_irq = 510;
> +	} else {
> +		/* ARM/Qualcomm GIC supports 8 CPUs at most */
> +		gic->nr_cpu_if = 8;
> +		max_nr_irq = 1020;
> +	}
> +
>  	/*
>  	 * Initialize the CPU interface map to all CPUs.
>  	 * It will be refined as each CPU probes its ID.
>  	 */
> -	for (i = 0; i < NR_GIC_CPU_IF; i++)
> -		gic_cpu_map[i] = 0xff;
> +	for (i = 0; i < gic->nr_cpu_if; i++)
> +		gic_cpu_map[i] = (1 << gic->nr_cpu_if) - 1;
>  
>  	/*
>  	 * For primary GICs, skip over SGIs.
> @@ -988,12 +1082,13 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>  
>  	/*
>  	 * Find out how many interrupts are supported.
> -	 * The GIC only supports up to 1020 interrupt sources.
> +	 * The ARM/Qualcomm GIC only supports up to 1020 interrupt sources.
> +	 * The HiP04 GIC only supports up to 510 interrupt sources.
>  	 */
>  	gic_irqs = readl_relaxed(gic_data_dist_base(gic) + GIC_DIST_CTR) & 0x1f;
>  	gic_irqs = (gic_irqs + 1) * 32;
> -	if (gic_irqs > 1020)
> -		gic_irqs = 1020;
> +	if (gic_irqs > max_nr_irq)
> +		gic_irqs = max_nr_irq;
>  	gic->gic_irqs = gic_irqs;
>  
>  	gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
> @@ -1069,6 +1164,7 @@ gic_of_init(struct device_node *node, struct device_node *parent)
>  }
>  IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
>  IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
> +IRQCHIP_DECLARE(hip04_gic, "hisilicon,hip04-gic", gic_of_init);
>  IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
>  IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);

I would re-evaluate your use of gic_is_standard() and attempt to
eliminate all post-bootup callers of it.

thx,

Jason.
