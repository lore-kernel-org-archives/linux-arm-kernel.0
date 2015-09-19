From: yangyingliang@huawei.com (Yang Yingliang)
Date: Sat, 19 Sep 2015 11:05:58 +0800
Subject: [RFC PATCH v5 3/4] arm64: fix a migrating irq bug when hotplug cpu
In-Reply-To: <1442631959-10228-1-git-send-email-yangyingliang@huawei.com>
References: <1442631959-10228-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1442631959-10228-4-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When cpu is disabled, all irqs will be migratged to another cpu.
In some cases, a new affinity is different, it needed to be coppied
to irq's affinity. But if the type of irq is LPI, it's affinity will
not be coppied because of irq_set_affinity's return value. Fix it by
using irq_do_set_affinity.

And migrating interrupts is a core code matter, so use the generic
function irq_migrate_all_off_this_cpu() to migrate interrupts in
kernel/irq/migration.c.

Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/irq.h |  1 -
 arch/arm64/kernel/irq.c      | 62 --------------------------------------------
 arch/arm64/kernel/smp.c      |  2 +-
 4 files changed, 2 insertions(+), 64 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7d95663..e0cac17 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -410,6 +410,7 @@ config NR_CPUS
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
+	select GENERIC_IRQ_MIGRATION
 	help
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index bbb251b..0916929 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -7,7 +7,6 @@
 
 struct pt_regs;
 
-extern void migrate_irqs(void);
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
 
 static inline void acpi_irq_init(void)
diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 11dc3fd..9f17ec0 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -27,7 +27,6 @@
 #include <linux/init.h>
 #include <linux/irqchip.h>
 #include <linux/seq_file.h>
-#include <linux/ratelimit.h>
 
 unsigned long irq_err_count;
 
@@ -54,64 +53,3 @@ void __init init_IRQ(void)
 	if (!handle_arch_irq)
 		panic("No interrupt controller found.");
 }
-
-#ifdef CONFIG_HOTPLUG_CPU
-static bool migrate_one_irq(struct irq_desc *desc)
-{
-	struct irq_data *d = irq_desc_get_irq_data(desc);
-	const struct cpumask *affinity = irq_data_get_affinity_mask(d);
-	struct irq_chip *c;
-	bool ret = false;
-
-	/*
-	 * If this is a per-CPU interrupt, or the affinity does not
-	 * include this CPU, then we have nothing to do.
-	 */
-	if (irqd_is_per_cpu(d) || !cpumask_test_cpu(smp_processor_id(), affinity))
-		return false;
-
-	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
-		affinity = cpu_online_mask;
-		ret = true;
-	}
-
-	c = irq_data_get_irq_chip(d);
-	if (!c->irq_set_affinity)
-		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
-	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
-		cpumask_copy(irq_data_get_affinity_mask(d), affinity);
-
-	return ret;
-}
-
-/*
- * The current CPU has been marked offline.  Migrate IRQs off this CPU.
- * If the affinity settings do not allow other CPUs, force them onto any
- * available CPU.
- *
- * Note: we must iterate over all IRQs, whether they have an attached
- * action structure or not, as we need to get chained interrupts too.
- */
-void migrate_irqs(void)
-{
-	unsigned int i;
-	struct irq_desc *desc;
-	unsigned long flags;
-
-	local_irq_save(flags);
-
-	for_each_irq_desc(i, desc) {
-		bool affinity_broken;
-
-		raw_spin_lock(&desc->lock);
-		affinity_broken = migrate_one_irq(desc);
-		raw_spin_unlock(&desc->lock);
-
-		if (affinity_broken)
-			pr_warn_ratelimited("IRQ%u no longer affine to CPU%u\n",
-					    i, smp_processor_id());
-	}
-
-	local_irq_restore(flags);
-}
-#endif /* CONFIG_HOTPLUG_CPU */
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index dbdaacd..ee5cafa 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -232,7 +232,7 @@ int __cpu_disable(void)
 	/*
 	 * OK - migrate IRQs away from this CPU
 	 */
-	migrate_irqs();
+	irq_migrate_all_off_this_cpu();
 
 	/*
 	 * Remove this CPU from the vm mask set of all processes.
-- 
2.5.0
