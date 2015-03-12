From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 12 Mar 2015 13:39:16 +0000
Subject: [PATCH 4.0-rc2 v18 1/6] irqchip: gic: Optimize locking in
 gic_raise_softirq
In-Reply-To: <1426167561-25963-1-git-send-email-daniel.thompson@linaro.org>
References: <1422022952-31552-1-git-send-email-daniel.thompson@linaro.org>
 <1426167561-25963-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1426167561-25963-2-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently gic_raise_softirq() is locked using upon irq_controller_lock.
This lock is primarily used to make register read-modify-write sequences
atomic but gic_raise_softirq() uses it instead to ensure that the
big.LITTLE migration logic can figure out when it is safe to migrate
interrupts between physical cores.

This is sub-optimal in closely related ways:

1. No locking at all is required on systems where the b.L switcher is
   not configured.

2. Finer grain locking can be used on systems where the b.L switcher is
   present.

This patch resolves both of the above by introducing a separate finer
grain lock and providing conditionally compiled inlines to lock/unlock
it.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 drivers/irqchip/irq-gic.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 4634cf7d0ec3..f2a0b4525b65 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -73,6 +73,27 @@ struct gic_chip_data {
 static DEFINE_RAW_SPINLOCK(irq_controller_lock);
 
 /*
+ * This lock is used by the big.LITTLE migration code to ensure no IPIs
+ * can be pended on the old core after the map has been updated.
+ */
+#ifdef CONFIG_BL_SWITCHER
+static DEFINE_RAW_SPINLOCK(cpu_map_migration_lock);
+
+static inline void gic_migration_lock(unsigned long *flags)
+{
+	raw_spin_lock_irqsave(&cpu_map_migration_lock, *flags);
+}
+
+static inline void gic_migration_unlock(unsigned long flags)
+{
+	raw_spin_unlock_irqrestore(&cpu_map_migration_lock, flags);
+}
+#else
+static inline void gic_migration_lock(unsigned long *flags) {}
+static inline void gic_migration_unlock(unsigned long flags) {}
+#endif
+
+/*
  * The GIC mapping of CPU interfaces does not necessarily match
  * the logical CPU numbering.  Let's use a mapping as returned
  * by the GIC itself.
@@ -627,7 +648,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	int cpu;
 	unsigned long flags, map = 0;
 
-	raw_spin_lock_irqsave(&irq_controller_lock, flags);
+	gic_migration_lock(&flags);
 
 	/* Convert our logical CPU mask into a physical one. */
 	for_each_cpu(cpu, mask)
@@ -642,7 +663,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	/* this always happens on GIC0 */
 	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
 
-	raw_spin_unlock_irqrestore(&irq_controller_lock, flags);
+	gic_migration_unlock(flags);
 }
 #endif
 
@@ -713,8 +734,17 @@ void gic_migrate_target(unsigned int new_cpu_id)
 
 	raw_spin_lock(&irq_controller_lock);
 
-	/* Update the target interface for this logical CPU */
+	/*
+	 * Update the target interface for this logical CPU
+	 *
+	 * From the point we release the cpu_map_migration_lock any new
+	 * SGIs will be pended on the new cpu which makes the set of SGIs
+	 * pending on the old cpu static. That means we can defer the
+	 * migration until after we have released the irq_controller_lock.
+	 */
+	raw_spin_lock(&cpu_map_migration_lock);
 	gic_cpu_map[cpu] = 1 << new_cpu_id;
+	raw_spin_unlock(&cpu_map_migration_lock);
 
 	/*
 	 * Find all the peripheral interrupts targetting the current
-- 
2.1.0
