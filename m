From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 25 Jul 2013 15:11:06 -0400 (EDT)
Subject: [PATCH 02/13] ARM: gic: add CPU migration support
In-Reply-To: <51F10F85.7090508@arm.com>
References: <1374550289-25305-1-git-send-email-nicolas.pitre@linaro.org>
 <1374550289-25305-3-git-send-email-nicolas.pitre@linaro.org>
 <51F10F85.7090508@arm.com>
Message-ID: <alpine.LFD.2.03.1307251207110.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Jul 2013, Jonathan Austin wrote:

> Hi Nico,
> 
> I've got a couple of minor questions/comments about this one...
> 
> On 23/07/13 04:31, Nicolas Pitre wrote:
> > This is required by the big.LITTLE switcher code.
> > 
> > The gic_migrate_target() changes the CPU interface mapping for the
> > current CPU to redirect SGIs to the specified interface, and it also
> > updates the target CPU for each interrupts to that CPU interface
> > if they were targeting the current interface.  Finally, pending
> > SGIs for the current CPU are forwarded to the new interface.
> > 
> > Because Linux does not use it, the SGI source information for the
> > forwarded SGIs is not preserved.  Neither is the source information
> > for the SGIs sent by the current CPU to other CPUs adjusted to match
> > the new CPU interface mapping.  The required registers are banked so
> > only the target CPU could do it.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > ---
> >   drivers/irqchip/irq-gic.c       | 81
> > +++++++++++++++++++++++++++++++++++++++--
> >   include/linux/irqchip/arm-gic.h |  4 ++
> >   2 files changed, 82 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> > index ee7c503120..6bd5a8c1aa 100644
> > --- a/drivers/irqchip/irq-gic.c
> > +++ b/drivers/irqchip/irq-gic.c
> > @@ -253,10 +253,9 @@ static int gic_set_affinity(struct irq_data *d, const
> > struct cpumask *mask_val,
> >   	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
> >   		return -EINVAL;
> > 
> > +	raw_spin_lock(&irq_controller_lock);
> >   	mask = 0xff << shift;
> >   	bit = gic_cpu_map[cpu] << shift;
> > -
> > -	raw_spin_lock(&irq_controller_lock);
> >   	val = readl_relaxed(reg) & ~mask;
> >   	writel_relaxed(val | bit, reg);
> >   	raw_spin_unlock(&irq_controller_lock);
> > @@ -646,7 +645,9 @@ static void __init gic_pm_init(struct gic_chip_data
> > *gic)
> >   void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
> >   {
> >   	int cpu;
> > -	unsigned long map = 0;
> > +	unsigned long flags, map = 0;
> > +
> > +	raw_spin_lock_irqsave(&irq_controller_lock, flags);
> > 
> >   	/* Convert our logical CPU mask into a physical one. */
> >   	for_each_cpu(cpu, mask)
> > @@ -660,6 +661,80 @@ void gic_raise_softirq(const struct cpumask *mask,
> > unsigned int irq)
> > 
> >   	/* this always happens on GIC0 */
> >   	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) +
> > GIC_DIST_SOFTINT);
> > +
> > +	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
> > +}
> > +#endif
> > +
> > +#ifdef CONFIG_BL_SWITCHER
> > +/*
> > + * gic_migrate_target - migrate IRQs to another PU interface
> 
> (nit) Should that be _C_PU?

Obviously.

> > + *
> > + * @new_cpu_id: the CPU target ID to migrate IRQs to
> > + *
> > + * Migrate all peripheral interrupts with a target matching the current CPU
> > + * to the interface corresponding to @new_cpu_id.  The CPU interface
> > mapping
> > + * is also updated.  Targets to other CPU interfaces are unchanged.
> > + * This must be called with IRQs locally disabled.
> > + */
> > +void gic_migrate_target(unsigned int new_cpu_id)
> > +{
> > +	unsigned int old_cpu_id, gic_irqs, gic_nr = 0;
> > +	void __iomem *dist_base;
> > +	int i, ror_val, cpu = smp_processor_id();
> > +	u32 val, old_mask, active_mask;
> > +
> > +	if (gic_nr >= MAX_GIC_NR)
> > +		BUG();
> > +
> > +	dist_base = gic_data_dist_base(&gic_data[gic_nr]);
> > +	if (!dist_base)
> > +		return;
> > +	gic_irqs = gic_data[gic_nr].gic_irqs;
> > +
> > +	old_cpu_id = __ffs(gic_cpu_map[cpu]);
> > +	old_mask = 0x01010101 << old_cpu_id;
> 
> I don't think this is very clear, though section 4.3.12 of the GIC spec helps
> a lot! A little pointer or some more self-evident name for the mask might be
> nice...
> 
> old_mask = GIC_ITARGETSR_MASK << old_cpu_id
> 
> or similar? This at least points one to the right bit of documentation?

I've renamed old_cpu_id to cur_cpu_id and old_mask to cur_target_mask.
Also added a comment later on.

> > +	ror_val = (old_cpu_id - new_cpu_id) & 31;
> > +
> > +	raw_spin_lock(&irq_controller_lock);
> > +
> > +	gic_cpu_map[cpu] = 1 << new_cpu_id;
> > +
> > +	for (i = 8; i < DIV_ROUND_UP(gic_irqs, 4); i++) {
> 
> Does this '8' here warrant a #define? GIC_RO_INTR_REGS?
> 
> Perhaps everyone looking at the code will be familiar enough with the GIC to
> see immediately why the first 8 entries are being skipped...?

I've added a comment right before this loop explaining what is being 
done, mentioning why it starts at 8.

> I'm curious as to why we don't need to do anything for PPIs here - could there
> be any pending PPIs that don't get handled (I guess retargetting doesn't make
> sense for these?)

PPIs are strictly processor private and I don't think there is any way 
for one processor to set them on another processor.  So the only way to 
cope with those is for the outbound CPU to save and disable its PPI 
state, and let the inbound CPU enable them.  That should be up to each 
PPI-using driver to do via the cpu_pm_enter()/cpu_pm_exit() notifiers.

I've amended the patch with the following:

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 6bd5a8c1aa..268874ac75 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -668,7 +668,7 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 
 #ifdef CONFIG_BL_SWITCHER
 /*
- * gic_migrate_target - migrate IRQs to another PU interface
+ * gic_migrate_target - migrate IRQs to another CPU interface
  *
  * @new_cpu_id: the CPU target ID to migrate IRQs to
  *
@@ -679,10 +679,10 @@ void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
  */
 void gic_migrate_target(unsigned int new_cpu_id)
 {
-	unsigned int old_cpu_id, gic_irqs, gic_nr = 0;
+	unsigned int cur_cpu_id, gic_irqs, gic_nr = 0;
 	void __iomem *dist_base;
 	int i, ror_val, cpu = smp_processor_id();
-	u32 val, old_mask, active_mask;
+	u32 val, cur_target_mask, active_mask;
 
 	if (gic_nr >= MAX_GIC_NR)
 		BUG();
@@ -692,17 +692,23 @@ void gic_migrate_target(unsigned int new_cpu_id)
 		return;
 	gic_irqs = gic_data[gic_nr].gic_irqs;
 
-	old_cpu_id = __ffs(gic_cpu_map[cpu]);
-	old_mask = 0x01010101 << old_cpu_id;
-	ror_val = (old_cpu_id - new_cpu_id) & 31;
+	cur_cpu_id = __ffs(gic_cpu_map[cpu]);
+	cur_target_mask = 0x01010101 << cur_cpu_id;
+	ror_val = (cur_cpu_id - new_cpu_id) & 31;
 
 	raw_spin_lock(&irq_controller_lock);
 
+	/* Update the target interface for this logical CPU */
 	gic_cpu_map[cpu] = 1 << new_cpu_id;
 
+	/*
+	 * Find all the peripheral interrupts targetting the current
+	 * CPU interface and migrate them to the new CPU interface.
+	 * We skip DIST_TARGET 0 to 7 as they are read-only.
+	 */
 	for (i = 8; i < DIV_ROUND_UP(gic_irqs, 4); i++) {
 		val = readl_relaxed(dist_base + GIC_DIST_TARGET + i * 4);
-		active_mask = val & old_mask;
+		active_mask = val & cur_target_mask;
 		if (active_mask) {
 			val &= ~active_mask;
 			val |= ror32(active_mask, ror_val);
@@ -714,7 +720,7 @@ void gic_migrate_target(unsigned int new_cpu_id)
 
 	/*
 	 * Now let's migrate and clear any potential SGIs that might be
-	 * pending for us (old_cpu_id).  Since GIC_DIST_SGI_PENDING_SET
+	 * pending for us (cur_cpu_id).  Since GIC_DIST_SGI_PENDING_SET
 	 * is a banked register, we can only forward the SGI using
 	 * GIC_DIST_SOFTINT.  The original SGI source is lost but Linux
 	 * doesn't use that information anyway.
