From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  6 Mar 2015 16:37:44 +0000
Subject: [PATCH 05/11] irqchip: gic: Fix unsafe locking reported by lockdep
In-Reply-To: <1425659870-11832-1-git-send-email-marc.zyngier@arm.com>
References: <1425659870-11832-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1425659870-11832-6-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When compiled with CONFIG_LOCKDEP, the kernel shouts badly, saying
that the locking in the GIC code is unsafe. I'm afraid the kernel
is right:

       CPU0
       ----
  lock(irq_controller_lock);
  <Interrupt>
    lock(irq_controller_lock);

 *** DEADLOCK ***

This can happen while enabling, disabling, setting the type
or the affinity of an interrupt.

The fix is to take the interrupt_controller_lock with interrupts
disabled in these cases.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4634cf7..471e1cd 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -154,23 +154,25 @@ static inline unsigned int gic_irq(struct irq_data *d)
 static void gic_mask_irq(struct irq_data *d)
 {
 	u32 mask = 1 << (gic_irq(d) % 32);
+	unsigned long flags;
 
-	raw_spin_lock(&irq_controller_lock);
+	raw_spin_lock_irqsave(&irq_controller_lock, flags);
 	writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_CLEAR + (gic_irq(d) / 32) * 4);
 	if (gic_arch_extn.irq_mask)
 		gic_arch_extn.irq_mask(d);
-	raw_spin_unlock(&irq_controller_lock);
+	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 }
 
 static void gic_unmask_irq(struct irq_data *d)
 {
 	u32 mask = 1 << (gic_irq(d) % 32);
+	unsigned long flags;
 
-	raw_spin_lock(&irq_controller_lock);
+	raw_spin_lock_irqsave(&irq_controller_lock, flags);
 	if (gic_arch_extn.irq_unmask)
 		gic_arch_extn.irq_unmask(d);
 	writel_relaxed(mask, gic_dist_base(d) + GIC_DIST_ENABLE_SET + (gic_irq(d) / 32) * 4);
-	raw_spin_unlock(&irq_controller_lock);
+	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 }
 
 static void gic_eoi_irq(struct irq_data *d)
@@ -188,6 +190,7 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 {
 	void __iomem *base = gic_dist_base(d);
 	unsigned int gicirq = gic_irq(d);
+	unsigned long flags;
 	int ret;
 
 	/* Interrupt configuration for SGIs can't be changed */
@@ -199,14 +202,14 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 			    type != IRQ_TYPE_EDGE_RISING)
 		return -EINVAL;
 
-	raw_spin_lock(&irq_controller_lock);
+	raw_spin_lock_irqsave(&irq_controller_lock, flags);
 
 	if (gic_arch_extn.irq_set_type)
 		gic_arch_extn.irq_set_type(d, type);
 
 	ret = gic_configure_irq(gicirq, type, base, NULL);
 
-	raw_spin_unlock(&irq_controller_lock);
+	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 
 	return ret;
 }
@@ -227,6 +230,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	void __iomem *reg = gic_dist_base(d) + GIC_DIST_TARGET + (gic_irq(d) & ~3);
 	unsigned int cpu, shift = (gic_irq(d) % 4) * 8;
 	u32 val, mask, bit;
+	unsigned long flags;
 
 	if (!force)
 		cpu = cpumask_any_and(mask_val, cpu_online_mask);
@@ -236,12 +240,12 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
 		return -EINVAL;
 
-	raw_spin_lock(&irq_controller_lock);
+	raw_spin_lock_irqsave(&irq_controller_lock, flags);
 	mask = 0xff << shift;
 	bit = gic_cpu_map[cpu] << shift;
 	val = readl_relaxed(reg) & ~mask;
 	writel_relaxed(val | bit, reg);
-	raw_spin_unlock(&irq_controller_lock);
+	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
 
 	return IRQ_SET_MASK_OK;
 }
-- 
2.1.4
