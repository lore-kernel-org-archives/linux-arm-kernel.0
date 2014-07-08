From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Jul 2014 18:40:20 -0400
Subject: [PATCH v9 02/14] irq: gic: support hip04 gic
In-Reply-To: <20140621015409.GZ21711@titan.lakedaemon.net>
References: <1400591427-21922-1-git-send-email-haojian.zhuang@linaro.org>
 <1400591427-21922-3-git-send-email-haojian.zhuang@linaro.org>
 <20140621015409.GZ21711@titan.lakedaemon.net>
Message-ID: <20140708224020.GI13433@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian,

I've set up a branch for all the changes to the gic driver this time
around.  Please keep an eye on:

  git://git.infradead.org/users/jcooper/linux.git irqchip/gic

And base your irqchip changes on top.

thx,

Jason.

On Fri, Jun 20, 2014 at 09:54:09PM -0400, Jason Cooper wrote:
> Hi Haojian,
> 
> I'm working through my backlog ...
> 
> On Tue, May 20, 2014 at 09:10:15PM +0800, Haojian Zhuang wrote:
> > There's a little difference between ARM GIC and HiP04 GIC.
> > 
> > * HiP04 GIC could support 16 cores at most, and ARM GIC could support
> > 8 cores at most. So the difination on GIC_DIST_TARGET registers are
> > different since CPU interfaces are increased from 8-bit to 16-bit.
> > 
> > * HiP04 GIC could support 510 interrupts at most, and ARM GIC could
> > support 1020 interrupts at most.
> > 
> > Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/arm/gic.txt |   1 +
> >  drivers/irqchip/irq-gic.c                     | 159 ++++++++++++++++++++------
> >  2 files changed, 124 insertions(+), 36 deletions(-)
> > 
> ...
> > diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> > index f711fb6..64af475 100644
> > --- a/drivers/irqchip/irq-gic.c
> > +++ b/drivers/irqchip/irq-gic.c
> > @@ -68,6 +68,7 @@ struct gic_chip_data {
> >  #ifdef CONFIG_GIC_NON_BANKED
> >  	void __iomem *(*get_base)(union gic_base *);
> >  #endif
> > +	u32 nr_cpu_if;
> >  };
> >  
> >  static DEFINE_RAW_SPINLOCK(irq_controller_lock);
> > @@ -76,9 +77,11 @@ static DEFINE_RAW_SPINLOCK(irq_controller_lock);
> >   * The GIC mapping of CPU interfaces does not necessarily match
> >   * the logical CPU numbering.  Let's use a mapping as returned
> >   * by the GIC itself.
> > + *
> > + * Hisilicon HiP04 extends the number of CPU interface from 8 to 16.
> >   */
> > -#define NR_GIC_CPU_IF 8
> > -static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
> > +#define NR_GIC_CPU_IF	16
> > +static u16 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
> >  
> >  /*
> >   * Supported arch specific GIC irq extension.
> > @@ -241,20 +244,62 @@ static int gic_retrigger(struct irq_data *d)
> >  	return 0;
> >  }
> >  
> > +static bool gic_is_standard(struct gic_chip_data *gic_data)
> > +{
> > +	return (gic_data->nr_cpu_if == 8);
> > +}
> > +
> > +static u32 irqs_per_target_reg(struct gic_chip_data *gic_data)
> > +{
> > +	return (32 / gic_data->nr_cpu_if);
> > +}
> > +
> > +/* i is the index of interrupt */
> > +static u32 irq_to_target_reg(struct gic_chip_data *gic_data, u32 i)
> > +{
> > +	if (gic_is_standard(gic_data))
> > +		i = i & ~3U;
> > +	else
> > +		i = (i << 1) & ~3U;
> > +	return (i + GIC_DIST_TARGET);
> > +}
> > +
> >  #ifdef CONFIG_SMP
> > +static u32 irq_to_core_shift(struct irq_data *d)
> > +{
> > +	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
> > +	unsigned int i = gic_irq(d);
> > +
> > +	if (gic_is_standard(gic_data))
> > +		return ((i % 4) << 3);
> > +	return ((i % 2) << 4);
> > +}
> > +
> > +static u32 irq_to_core_mask(struct irq_data *d)
> > +{
> > +	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
> > +	u32 mask;
> > +	/* ARM GIC, nr_cpu_if == 8; HiP04 GIC, nr_cpu_if == 16 */
> > +	mask = (1 << gic_data->nr_cpu_if) - 1;
> > +	return (mask << irq_to_core_shift(d));
> > +}
> > +
> >  static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
> >  			    bool force)
> >  {
> > -	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
> > -	unsigned int shift = (gic_irq(d) % 4) * 8;
> > +	void __iomem *reg;
> > +	struct gic_chip_data *gic_data = irq_data_get_irq_chip_data(d);
> > +	unsigned int shift = irq_to_core_shift(d);
> >  	unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
> >  	u32 val, mask, bit;
> >  
> > -	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
> > +	if (cpu >= gic_data->nr_cpu_if || cpu >= nr_cpu_ids)
> >  		return -EINVAL;
> >  
> > +	reg = gic_dist_base(d) + irq_to_target_reg(gic_data, gic_irq(d));
> > +
> >  	raw_spin_lock(&irq_controller_lock);
> > -	mask = 0xff << shift;
> > +	mask = irq_to_core_mask(d);
> 
> You still haven't addressed my comment from your previous version of
> this series.
> 
> Please calculate the mask once at boottime and store it.  Then you can
> use it in conjunction with the shift you calculate above.  This will
> remove the needless calculation inside the spinlock:
> 
>   mask = (1 << gic_data->nr_cpu_if) - 1;
> 
> It will also remove the extra call to irq_data_get_irq_chip_data() since
> you already did that in this function outside the spinlock.
> 
> >  	bit = gic_cpu_map[cpu] << shift;
> >  	val = readl_relaxed(reg) & ~mask;
> >  	writel_relaxed(val | bit, reg);
> > @@ -354,15 +399,20 @@ void __init gic_cascade_irq(unsigned int gic_nr, unsigned int irq)
> >  	irq_set_chained_handler(irq, gic_handle_cascade_irq);
> >  }
> >  
> > -static u8 gic_get_cpumask(struct gic_chip_data *gic)
> > +static u16 gic_get_cpumask(struct gic_chip_data *gic)
> >  {
> >  	void __iomem *base = gic_data_dist_base(gic);
> >  	u32 mask, i;
> >  
> > -	for (i = mask = 0; i < 32; i += 4) {
> > -		mask = readl_relaxed(base + GIC_DIST_TARGET + i);
> > +	/*
> > +	 * ARM GIC uses 8 registers for interrupt 0-31,
> > +	 * HiP04 GIC uses 16 registers for interrupt 0-31.
> > +	 */
> > +	for (i = mask = 0; i < 32; i++) {
> > +		mask = readl_relaxed(base + irq_to_target_reg(gic, i));
> >  		mask |= mask >> 16;
> > -		mask |= mask >> 8;
> > +		if (gic_is_standard(gic))
> > +			mask |= mask >> 8;
> >  		if (mask)
> >  			break;
> >  	}
> > @@ -370,6 +420,10 @@ static u8 gic_get_cpumask(struct gic_chip_data *gic)
> >  	if (!mask)
> >  		pr_crit("GIC CPU mask not found - kernel will fail to boot.\n");
> >  
> > +	/* ARM GIC needs 8-bit cpu mask, HiP04 GIC needs 16-bit cpu mask. */
> > +	if (gic_is_standard(gic))
> > +		mask &= 0xff;
> > +
> >  	return mask;
> >  }
> >  
> > @@ -392,10 +446,11 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
> >  	 * Set all global interrupts to this CPU only.
> >  	 */
> >  	cpumask = gic_get_cpumask(gic);
> > -	cpumask |= cpumask << 8;
> > +	if (gic_is_standard(gic))
> > +		cpumask |= cpumask << 8;
> >  	cpumask |= cpumask << 16;
> > -	for (i = 32; i < gic_irqs; i += 4)
> > -		writel_relaxed(cpumask, base + GIC_DIST_TARGET + i * 4 / 4);
> > +	for (i = 32; i < gic_irqs; i++)
> > +		writel_relaxed(cpumask, base + irq_to_target_reg(gic, i));
> >  
> >  	/*
> >  	 * Set priority on all global interrupts.
> > @@ -423,7 +478,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
> >  	/*
> >  	 * Get what the GIC says our CPU mask is.
> >  	 */
> > -	BUG_ON(cpu >= NR_GIC_CPU_IF);
> > +	BUG_ON(cpu >= gic->nr_cpu_if);
> >  	cpu_mask = gic_get_cpumask(gic);
> >  	gic_cpu_map[cpu] = cpu_mask;
> >  
> > @@ -431,7 +486,7 @@ static void gic_cpu_init(struct gic_chip_data *gic)
> >  	 * Clear our mask from the other map entries in case they're
> >  	 * still undefined.
> >  	 */
> > -	for (i = 0; i < NR_GIC_CPU_IF; i++)
> > +	for (i = 0; i < gic->nr_cpu_if; i++)
> >  		if (i != cpu)
> >  			gic_cpu_map[i] &= ~cpu_mask;
> >  
> > @@ -467,7 +522,7 @@ void gic_cpu_if_down(void)
> >   */
> >  static void gic_dist_save(unsigned int gic_nr)
> >  {
> > -	unsigned int gic_irqs;
> > +	unsigned int gic_irqs, target_reg = 0;
> >  	void __iomem *dist_base;
> >  	int i;
> >  
> > @@ -484,9 +539,11 @@ static void gic_dist_save(unsigned int gic_nr)
> >  		gic_data[gic_nr].saved_spi_conf[i] =
> >  			readl_relaxed(dist_base + GIC_DIST_CONFIG + i * 4);
> >  
> > -	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
> > +	for (i = 0; i < gic_irqs; i += irqs_per_target_reg(&gic_data[gic_nr])) {
> > +		target_reg = irq_to_target_reg(&gic_data[gic_nr], i);
> >  		gic_data[gic_nr].saved_spi_target[i] =
> > -			readl_relaxed(dist_base + GIC_DIST_TARGET + i * 4);
> > +			readl_relaxed(dist_base + target_reg);
> > +	}
> >  
> >  	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 32); i++)
> >  		gic_data[gic_nr].saved_spi_enable[i] =
> > @@ -502,7 +559,7 @@ static void gic_dist_save(unsigned int gic_nr)
> >   */
> >  static void gic_dist_restore(unsigned int gic_nr)
> >  {
> > -	unsigned int gic_irqs;
> > +	unsigned int gic_irqs, target_reg = 0;
> >  	unsigned int i;
> >  	void __iomem *dist_base;
> >  
> > @@ -525,9 +582,11 @@ static void gic_dist_restore(unsigned int gic_nr)
> >  		writel_relaxed(0xa0a0a0a0,
> >  			dist_base + GIC_DIST_PRI + i * 4);
> >  
> > -	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 4); i++)
> > +	for (i = 0; i < gic_irqs; i += irqs_per_target_reg(&gic_data[gic_nr])) {
> > +		target_reg = irq_to_target_reg(&gic_data[gic_nr], i);
> >  		writel_relaxed(gic_data[gic_nr].saved_spi_target[i],
> > -			dist_base + GIC_DIST_TARGET + i * 4);
> > +			dist_base + target_reg);
> > +	}
> >  
> >  	for (i = 0; i < DIV_ROUND_UP(gic_irqs, 32); i++)
> >  		writel_relaxed(gic_data[gic_nr].saved_spi_enable[i],
> > @@ -665,9 +724,19 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
> >  	 */
> >  	dmb(ishst);
> >  
> > -	/* this always happens on GIC0 */
> > -	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
> > -
> > +	/*
> > +	 * CPUTargetList -- bit[23:16] in GIC_DIST_SOFTINT in ARM GIC.
> > +	 *                  bit[23:8] in GIC_DIST_SOFTINT in HiP04 GIC.
> > +	 * NSATT -- bit[15] in GIC_DIST_SOFTINT in ARM GIC.
> > +	 *          bit[7] in GIC_DIST_SOFTINT in HiP04 GIC.
> > +	 * this always happens on GIC0
> > +	 */
> 
> > +	if (gic_is_standard(&gic_data[0]))
> > +		map = map << 16;
> > +	else
> > +		map = map << 8;
> 
> Here's another place where you should store the shift and avoid the if()
> logic inside the lock.
> 
> > +	writel_relaxed(map | irq,
> > +		       gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
> >  	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
> >  }
> >  #endif
> > @@ -681,10 +750,15 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
> >   */
> >  void gic_send_sgi(unsigned int cpu_id, unsigned int irq)
> >  {
> > -	BUG_ON(cpu_id >= NR_GIC_CPU_IF);
> > +	BUG_ON(cpu_id >= gic_data[0].nr_cpu_if);
> >  	cpu_id = 1 << cpu_id;
> >  	/* this always happens on GIC0 */
> > -	writel_relaxed((cpu_id << 16) | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
> 
> > +	if (gic_is_standard(&gic_data[0]))
> > +		cpu_id = cpu_id << 16;
> > +	else
> > +		cpu_id = cpu_id << 8;
> 
> You can use the stored shift here as well.
> 
> > +	writel_relaxed(cpu_id | irq,
> > +		       gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
> >  }
> >  
> >  /*
> > @@ -700,7 +774,7 @@ int gic_get_cpu_id(unsigned int cpu)
> >  {
> >  	unsigned int cpu_bit;
> >  
> > -	if (cpu >= NR_GIC_CPU_IF)
> > +	if (cpu >= gic_data[0].nr_cpu_if)
> >  		return -1;
> >  	cpu_bit = gic_cpu_map[cpu];
> >  	if (cpu_bit & (cpu_bit - 1))
> > @@ -747,13 +821,14 @@ void gic_migrate_target(unsigned int new_cpu_id)
> >  	 * CPU interface and migrate them to the new CPU interface.
> >  	 * We skip DIST_TARGET 0 to 7 as they are read-only.
> >  	 */
> > -	for (i = 8; i < DIV_ROUND_UP(gic_irqs, 4); i++) {
> > -		val = readl_relaxed(dist_base + GIC_DIST_TARGET + i * 4);
> > +	for (i = 8; i < gic_irqs; i += irqs_per_target_reg(&gic_data[gic_nr])) {
> > +		target_reg = irq_to_target_reg(&gic_data[gic_nr], i);
> > +		val = readl_relaxed(dist_base + target_reg);
> >  		active_mask = val & cur_target_mask;
> >  		if (active_mask) {
> >  			val &= ~active_mask;
> >  			val |= ror32(active_mask, ror_val);
> > -			writel_relaxed(val, dist_base + GIC_DIST_TARGET + i*4);
> > +			writel_relaxed(val, dist_base + target_reg);
> >  		}
> >  	}
> >  
> > @@ -931,7 +1006,7 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
> >  	irq_hw_number_t hwirq_base;
> >  	struct gic_chip_data *gic;
> >  	int gic_irqs, irq_base, i;
> > -	int nr_routable_irqs;
> > +	int nr_routable_irqs, max_nr_irq;
> >  
> >  	BUG_ON(gic_nr >= MAX_GIC_NR);
> >  
> > @@ -967,12 +1042,22 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
> >  		gic_set_base_accessor(gic, gic_get_common_base);
> >  	}
> >  
> > +	if (of_device_is_compatible(node, "hisilicon,hip04-gic")) {
> > +		/* HiP04 GIC supports 16 CPUs at most */
> > +		gic->nr_cpu_if = 16;
> > +		max_nr_irq = 510;
> > +	} else {
> > +		/* ARM/Qualcomm GIC supports 8 CPUs at most */
> > +		gic->nr_cpu_if = 8;
> > +		max_nr_irq = 1020;
> > +	}
> > +
> >  	/*
> >  	 * Initialize the CPU interface map to all CPUs.
> >  	 * It will be refined as each CPU probes its ID.
> >  	 */
> > -	for (i = 0; i < NR_GIC_CPU_IF; i++)
> > -		gic_cpu_map[i] = 0xff;
> > +	for (i = 0; i < gic->nr_cpu_if; i++)
> > +		gic_cpu_map[i] = (1 << gic->nr_cpu_if) - 1;
> >  
> >  	/*
> >  	 * For primary GICs, skip over SGIs.
> > @@ -988,12 +1073,13 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
> >  
> >  	/*
> >  	 * Find out how many interrupts are supported.
> > -	 * The GIC only supports up to 1020 interrupt sources.
> > +	 * The ARM/Qualcomm GIC only supports up to 1020 interrupt sources.
> > +	 * The HiP04 GIC only supports up to 510 interrupt sources.
> >  	 */
> >  	gic_irqs = readl_relaxed(gic_data_dist_base(gic) + GIC_DIST_CTR) & 0x1f;
> >  	gic_irqs = (gic_irqs + 1) * 32;
> > -	if (gic_irqs > 1020)
> > -		gic_irqs = 1020;
> > +	if (gic_irqs > max_nr_irq)
> > +		gic_irqs = max_nr_irq;
> >  	gic->gic_irqs = gic_irqs;
> >  
> >  	gic_irqs -= hwirq_base; /* calculate # of irqs to allocate */
> > @@ -1069,6 +1155,7 @@ gic_of_init(struct device_node *node, struct device_node *parent)
> >  }
> >  IRQCHIP_DECLARE(cortex_a15_gic, "arm,cortex-a15-gic", gic_of_init);
> >  IRQCHIP_DECLARE(cortex_a9_gic, "arm,cortex-a9-gic", gic_of_init);
> > +IRQCHIP_DECLARE(hip04_gic, "hisilicon,hip04-gic", gic_of_init);
> >  IRQCHIP_DECLARE(msm_8660_qgic, "qcom,msm-8660-qgic", gic_of_init);
> >  IRQCHIP_DECLARE(msm_qgic2, "qcom,msm-qgic2", gic_of_init);
> 
> thx,
> 
> Jason.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
