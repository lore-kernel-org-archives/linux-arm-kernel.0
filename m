From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 26 Feb 2015 11:13:07 +0100
Subject: [PATCH 2/8] irqchip: armada-370-xp: Initialize per cpu registers when
 CONFIG_SMP=N
In-Reply-To: <1424945593-20320-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1424945593-20320-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1424945593-20320-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

The irqchip driver called armada_xp_mpic_smp_cpu_init() when CONFIG_SMP=Y
to initialize some per cpu registers. The function is called on each
CPU by calling it explicitly on the boot CPU and then using a CPU notifier
for the non boot CPUs.

This commit removes the CONFIG_SMP constrain, so the per cpu registers are
also initialized when CONFIG_SMP=N, which is the right thing to do.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/irqchip/irq-armada-370-xp.c | 47 ++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 1caa8b579fdd..ebb5a11f55b9 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -289,28 +289,6 @@ static int armada_370_xp_mpic_irq_map(struct irq_domain *h,
 	return 0;
 }
 
-#ifdef CONFIG_SMP
-static void armada_mpic_send_doorbell(const struct cpumask *mask,
-				      unsigned int irq)
-{
-	int cpu;
-	unsigned long map = 0;
-
-	/* Convert our logical CPU mask into a physical one. */
-	for_each_cpu(cpu, mask)
-		map |= 1 << cpu_logical_map(cpu);
-
-	/*
-	 * Ensure that stores to Normal memory are visible to the
-	 * other CPUs before issuing the IPI.
-	 */
-	dsb();
-
-	/* submit softirq */
-	writel((map << 8) | irq, main_int_base +
-		ARMADA_370_XP_SW_TRIG_INT_OFFS);
-}
-
 static void armada_xp_mpic_smp_cpu_init(void)
 {
 	u32 control;
@@ -333,6 +311,28 @@ static void armada_xp_mpic_smp_cpu_init(void)
 	writel(0, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK_OFFS);
 }
 
+#ifdef CONFIG_SMP
+static void armada_mpic_send_doorbell(const struct cpumask *mask,
+				      unsigned int irq)
+{
+	int cpu;
+	unsigned long map = 0;
+
+	/* Convert our logical CPU mask into a physical one. */
+	for_each_cpu(cpu, mask)
+		map |= 1 << cpu_logical_map(cpu);
+
+	/*
+	 * Ensure that stores to Normal memory are visible to the
+	 * other CPUs before issuing the IPI.
+	 */
+	dsb();
+
+	/* submit softirq */
+	writel((map << 8) | irq, main_int_base +
+		ARMADA_370_XP_SW_TRIG_INT_OFFS);
+}
+
 static int armada_xp_mpic_secondary_init(struct notifier_block *nfb,
 					 unsigned long action, void *hcpu)
 {
@@ -569,9 +569,8 @@ static int __init armada_370_xp_mpic_of_init(struct device_node *node,
 
 	BUG_ON(!armada_370_xp_mpic_domain);
 
-#ifdef CONFIG_SMP
+	/* Setup for the boot CPU */
 	armada_xp_mpic_smp_cpu_init();
-#endif
 
 	armada_370_xp_msi_init(node, main_int_res.start);
 
-- 
2.3.0
