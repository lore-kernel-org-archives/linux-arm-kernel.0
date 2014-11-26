From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 26 Nov 2014 16:23:26 +0000
Subject: [PATCH 3.18-rc4 v10 2/6] irqchip: gic: Optimize locking in
 gic_raise_softirq
In-Reply-To: <1417019010-9220-1-git-send-email-daniel.thompson@linaro.org>
References: <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <1417019010-9220-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1417019010-9220-3-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently gic_raise_softirq() unconditionally takes and releases a lock
whose only purpose is to synchronize with the b.L switcher.

Remove this lock if the b.L switcher is not compiled in.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index 94d77118efa8..e875da93f24a 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -76,8 +76,23 @@ static DEFINE_RAW_SPINLOCK(irq_controller_lock);
  * This lock is used by the big.LITTLE migration code to ensure no IPIs
  * can be pended on the old core after the map has been updated.
  */
+#ifdef CONFIG_BL_SWITCHER
 static DEFINE_RAW_SPINLOCK(cpu_map_migration_lock);
 
+static inline void bl_migration_lock(unsigned long *flags)
+{
+	raw_spin_lock_irqsave(&cpu_map_migration_lock, *flags);
+}
+
+static inline void bl_migration_unlock(unsigned long flags)
+{
+	raw_spin_unlock_irqrestore(&cpu_map_migration_lock, flags);
+}
+#else
+static inline void bl_migration_lock(unsigned long *flags) {}
+static inline void bl_migration_unlock(unsigned long flags) {}
+#endif
+
 /*
  * The GIC mapping of CPU interfaces does not necessarily match
  * the logical CPU numbering.  Let's use a mapping as returned
@@ -630,7 +645,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	int cpu;
 	unsigned long flags, map = 0;
 
-	raw_spin_lock_irqsave(&cpu_map_migration_lock, flags);
+	bl_migration_lock(&flags);
 
 	/* Convert our logical CPU mask into a physical one. */
 	for_each_cpu(cpu, mask)
@@ -645,7 +660,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
 	/* this always happens on GIC0 */
 	writel_relaxed(map << 16 | irq, gic_data_dist_base(&gic_data[0]) + GIC_DIST_SOFTINT);
 
-	raw_spin_unlock_irqrestore(&cpu_map_migration_lock, flags);
+	bl_migration_unlock(flags);
 }
 #endif
 
-- 
1.9.3
