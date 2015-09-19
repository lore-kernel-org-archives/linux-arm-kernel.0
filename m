From: yangyingliang@huawei.com (Yang Yingliang)
Date: Sat, 19 Sep 2015 11:05:59 +0800
Subject: [RFC PATCH v5 4/4] arm: fix a migrating irq bug when hotplug cpu
In-Reply-To: <1442631959-10228-1-git-send-email-yangyingliang@huawei.com>
References: <1442631959-10228-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1442631959-10228-5-git-send-email-yangyingliang@huawei.com>
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
 arch/arm/Kconfig           |  1 +
 arch/arm/include/asm/irq.h |  1 -
 arch/arm/kernel/irq.c      | 62 ----------------------------------------------
 arch/arm/kernel/smp.c      |  2 +-
 4 files changed, 2 insertions(+), 64 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 72ad724..bffba78 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1492,6 +1492,7 @@ config NR_CPUS
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
 	depends on SMP
+	select GENERIC_IRQ_MIGRATION
 	help
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index be1d07d..882bf98 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -24,7 +24,6 @@
 #ifndef __ASSEMBLY__
 struct irqaction;
 struct pt_regs;
-extern void migrate_irqs(void);
 
 extern void asm_do_IRQ(unsigned int, struct pt_regs *);
 void handle_IRQ(unsigned int, struct pt_regs *);
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 5ff4826..78abea8 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -31,7 +31,6 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
-#include <linux/ratelimit.h>
 #include <linux/errno.h>
 #include <linux/list.h>
 #include <linux/kallsyms.h>
@@ -136,64 +135,3 @@ int __init arch_probe_nr_irqs(void)
 	return nr_irqs;
 }
 #endif
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
-				i, smp_processor_id());
-	}
-
-	local_irq_restore(flags);
-}
-#endif /* CONFIG_HOTPLUG_CPU */
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 48185a7..fc26384 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -218,7 +218,7 @@ int __cpu_disable(void)
 	/*
 	 * OK - migrate IRQs away from this CPU
 	 */
-	migrate_irqs();
+	irq_migrate_all_off_this_cpu();
 
 	/*
 	 * Flush user cache and TLB mappings, and then remove this CPU
-- 
2.5.0
