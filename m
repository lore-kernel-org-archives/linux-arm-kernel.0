From: chao.xie@marvell.com (Chao Xie)
Date: Tue, 29 Jan 2013 00:17:09 -0500
Subject: [PATCH] ARM: gic: add irq_set_affinity to gic_arch_extn
Message-ID: <1359436629-19873-1-git-send-email-chao.xie@marvell.com>
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
 arch/arm/common/gic.c |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
index 36ae03a..8e4bc8a 100644
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
@@ -253,6 +256,8 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	bit = gic_cpu_map[cpu] << shift;
 
 	raw_spin_lock(&irq_controller_lock);
+	if (gic_arch_extn.irq_set_affinity)
+		return gic_arch_extn.irq_set_affinity(d, mask_val, force);
 	val = readl_relaxed(reg) & ~mask;
 	writel_relaxed(val | bit, reg);
 	raw_spin_unlock(&irq_controller_lock);
-- 
1.7.4.1
