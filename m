From: chao.xie@marvell.com (Chao Xie)
Date: Tue, 29 Jan 2013 03:25:59 -0500
Subject: [PATCH V1 RESEND] ARM: gic: add irq_set_affinity to gic_arch_extn
Message-ID: <1359447959-20554-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gic_arch_extn is used for ARCH specific interrupt controller.
It has added the callbacks for irq_mask/irq_unamsk and so, but
irq_set_affinity is not used.
For SMP architecure, when both cores are powered off, the GIC may
be powered off too. An external interrupt controller can be used
as a logic to detect the interrupt and acknowledge power managment
unitto wake up core.
Because the irqs may be bound to different cors, when set irq
affinity, the external interrupt controller should be set too. Then
it can acknowledge the power managment unit to wake up correct core.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/common/gic.c |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 36ae03a..49920a0 100644
--- a/arch/arm/common/gic.c
+++ b/arch/arm/common/gic.c
@@ -82,12 +82,15 @@ static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
  * Default make them NULL.
  */
 struct irq_chip gic_arch_extn = {
-	.irq_eoi	= NULL,
-	.irq_mask	= NULL,
-	.irq_unmask	= NULL,
-	.irq_retrigger	= NULL,
-	.irq_set_type	= NULL,
-	.irq_set_wake	= NULL,
+	.irq_eoi		= NULL,
+	.irq_mask		= NULL,
+	.irq_unmask		= NULL,
+	.irq_retrigger		= NULL,
+	.irq_set_type		= NULL,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	= NULL,
+#endif
+	.irq_set_wake		= NULL,
 };
 
 #ifndef MAX_GIC_NR
@@ -245,6 +248,7 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	unsigned int shift = (gic_irq(d) % 4) * 8;
 	unsigned int cpu = cpumask_any_and(mask_val, cpu_online_mask);
 	u32 val, mask, bit;
+	int ret = IRQ_SET_MASK_OK;
 
 	if (cpu >= NR_GIC_CPU_IF || cpu >= nr_cpu_ids)
 		return -EINVAL;
@@ -253,11 +257,16 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	bit = gic_cpu_map[cpu] << shift;
 
 	raw_spin_lock(&irq_controller_lock);
-	val = readl_relaxed(reg) & ~mask;
-	writel_relaxed(val | bit, reg);
+	if (gic_arch_extn.irq_set_affinity)
+		ret = gic_arch_extn.irq_set_affinity(d, mask_val, force);
+
+	if (ret == IRQ_SET_MASK_OK) {
+		val = readl_relaxed(reg) & ~mask;
+		writel_relaxed(val | bit, reg);
+	}
 	raw_spin_unlock(&irq_controller_lock);
 
-	return IRQ_SET_MASK_OK;
+	return ret;
 }
 #endif
 
-- 
1.7.4.1
