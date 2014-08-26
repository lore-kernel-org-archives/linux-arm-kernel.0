From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 26 Aug 2014 16:03:35 +0100
Subject: [PATCH 2/2] GICv3: implement CPU PM notifier
In-Reply-To: <1409065415-20176-1-git-send-email-sudeep.holla@arm.com>
References: <1409065415-20176-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1409065415-20176-3-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep Holla <sudeep.holla@arm.com>

When a CPU enters a low power state, the contents of the GICv3/4 system
registers are lost. They need to be saved and restored if required.

For now, since most of the GICv3 register are set some initial values and
not modified at runtime, it is better to re-initialise rather than saving
and restoring them. It may need to be saved and restored in future if
required.

This patch adds a notifier to disable the redistributor(if allowed) and
Group1 interrupts when powering down the processor and to re-initialise
the system registers on wakeup.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 57 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 37062ba6704b..4afbbc835939 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/cpu.h>
+#include <linux/cpu_pm.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
@@ -383,6 +384,21 @@ static int gic_populate_rdist(void)
 	return -ENODEV;
 }
 
+static void gic_cpu_sys_reg_init(void)
+{
+	/* Enable system registers */
+	gic_enable_sre();
+
+	/* Set priority mask register */
+	gic_write_pmr(DEFAULT_PMR_VALUE);
+
+	/* EOI deactivates interrupt too (mode 0) */
+	gic_write_ctlr(ICC_CTLR_EL1_EOImode_drop_dir);
+
+	/* ... and let's hit the road... */
+	gic_write_grpen1(1);
+}
+
 static void gic_cpu_init(void)
 {
 	void __iomem *rbase;
@@ -397,17 +413,8 @@ static void gic_cpu_init(void)
 
 	gic_cpu_config(rbase, gic_redist_wait_for_rwp);
 
-	/* Enable system registers */
-	gic_enable_sre();
-
-	/* Set priority mask register */
-	gic_write_pmr(DEFAULT_PMR_VALUE);
-
-	/* EOI deactivates interrupt too (mode 0) */
-	gic_write_ctlr(ICC_CTLR_EL1_EOImode_drop_dir);
-
-	/* ... and let's hit the road... */
-	gic_write_grpen1(1);
+	/* initialise system registers */
+	gic_cpu_sys_reg_init();
 }
 
 #ifdef CONFIG_SMP
@@ -543,6 +550,33 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 #define gic_smp_init()		do { } while(0)
 #endif
 
+#ifdef CONFIG_CPU_PM
+static int gic_cpu_pm_notifier(struct notifier_block *self,
+			       unsigned long cmd, void *v)
+{
+	if (cmd == CPU_PM_EXIT) {
+		gic_enable_redist(true);
+		gic_cpu_sys_reg_init();
+	} else if (cmd == CPU_PM_ENTER) {
+		gic_write_grpen1(0);
+		gic_enable_redist(false);
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block gic_cpu_pm_notifier_block = {
+	.notifier_call = gic_cpu_pm_notifier,
+};
+
+static void gic_cpu_pm_init(void)
+{
+	cpu_pm_register_notifier(&gic_cpu_pm_notifier_block);
+}
+
+#else
+static inline void gic_cpu_pm_init(void) { }
+#endif /* CONFIG_CPU_PM */
+
 static struct irq_chip gic_chip = {
 	.name			= "GICv3",
 	.irq_mask		= gic_mask_irq,
@@ -682,6 +716,7 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 	gic_smp_init();
 	gic_dist_init();
 	gic_cpu_init();
+	gic_cpu_pm_init();
 
 	return 0;
 
-- 
1.8.3.2
