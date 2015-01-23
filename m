From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 23 Jan 2015 14:22:26 +0000
Subject: [PATCH 3.19-rc2 v15 2/8] irqchip: gic: Make gic_raise_softirq FIQ-safe
In-Reply-To: <1422022952-31552-1-git-send-email-daniel.thompson@linaro.org>
References: <1422022952-31552-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1422022952-31552-3-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is currently possible for FIQ handlers to re-enter gic_raise_softirq()
and lock up.

    	gic_raise_softirq()
	   lock(x);
-~-> FIQ
        handle_fiq()
	   gic_raise_softirq()
	      lock(x);		<-- Lockup

arch/arm/ uses IPIs to implement arch_irq_work_raise(), thus this issue
renders it difficult for FIQ handlers to safely defer work to less
restrictive calling contexts.

This patch fixes the problem by converting the cpu_map_migration_lock
into a rwlock making it safe to re-enter the function.

Note that having made it safe to re-enter gic_raise_softirq() we no
longer need to mask interrupts during gic_raise_softirq() because the
b.L migration is always performed from task context.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index a9ed64dcc84b..c172176499f6 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -75,22 +75,25 @@ static DEFINE_RAW_SPINLOCK(irq_controller_lock);
 /*
  * This lock is used by the big.LITTLE migration code to ensure no IPIs
  * can be pended on the old core after the map has been updated.
+ *
+ * This lock may be locked for reading from both IRQ and FIQ handlers
+ * and therefore must not be locked for writing when these are enabled.
  */
 #ifdef CONFIG_BL_SWITCHER
-static DEFINE_RAW_SPINLOCK(cpu_map_migration_lock);
+static DEFINE_RWLOCK(cpu_map_migration_lock);
 
-static inline void bl_migration_lock(unsigned long *flags)
+static inline void bl_migration_lock(void)
 {
-	raw_spin_lock_irqsave(&cpu_map_migration_lock, *flags);
+	read_lock(&cpu_map_migration_lock);
 }
 
-static inline void bl_migration_unlock(unsigned long flags)
+static inline void bl_migration_unlock(void)
 {
-	raw_spin_unlock_irqrestore(&cpu_map_migration_lock, flags);
+	read_unlock(&cpu_map_migration_lock);
 }
 #else
-static inline void bl_migration_lock(unsigned long *flags) {}
-static inline void bl_migration_unlock(unsigned long flags) {}
+static inline void bl_migration_lock(void) {}
+static inline void bl_migration_unlock(void) {}
 #endif
 
 /*
@@ -640,12 +643,20 @@ static void __init gic_pm_init(struct gic_chip_data *gic)
 #endif
 
 #ifdef CONFIG_SMP
+/*
+ * Raise the specified IPI on all cpus set in mask.
+ *
+ * This function is safe to call from all calling contexts, including
+ * FIQ handlers. It relies on bl_migration_lock() being multiply acquirable
+ * to avoid deadlocks when the function is re-entered at different
+ * exception levels.
+ */
 static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 {
 	int cpu;
-	unsigned long flags, map = 0;
+	unsigned long map = 0;
 
-	bl_migration_lock(&flags);
+	bl_migration_lock();
 
 	/* Convert our logical CPU mask into a physical one. */
 	for_each_cpu(cpu, mask)
@@ -660,7 +671,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	/* this always happens on GIC0 */
 	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
 
-	bl_migration_unlock(flags);
+	bl_migration_unlock();
 }
 #endif
 
@@ -708,7 +719,8 @@ int gic_get_cpu_id(unsigned int cpu)
  * Migrate all peripheral interrupts with a target matching the current CPU
  * to the interface corresponding to @new_cpu_id.  The CPU interface mapping
  * is also updated.  Targets to other CPU interfaces are unchanged.
- * This must be called with IRQs locally disabled.
+ * This must be called from a task context and with IRQ and FIQ locally
+ * disabled.
  */
 void gic_migrate_target(unsigned int new_cpu_id)
 {
@@ -739,9 +751,9 @@ void gic_migrate_target(unsigned int new_cpu_id)
 	 * pending on the old cpu static. That means we can defer the
 	 * migration until after we have released the irq_controller_lock.
 	 */
-	raw_spin_lock(&cpu_map_migration_lock);
+	write_lock(&cpu_map_migration_lock);
 	gic_cpu_map[cpu] = 1 << new_cpu_id;
-	raw_spin_unlock(&cpu_map_migration_lock);
+	write_unlock(&cpu_map_migration_lock);
 
 	/*
 	 * Find all the peripheral interrupts targetting the current
-- 
1.9.3
