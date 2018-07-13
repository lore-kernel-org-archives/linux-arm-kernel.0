From: alexander.sverdlin@nokia.com (Alexander Sverdlin)
Date: Fri, 13 Jul 2018 16:03:31 +0200
Subject: [PATCH] arm: Use generic irq_migrate_all_off_this_cpu() for CPU
 hotplug
Message-ID: <20180713140331.1158-1-alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have found that .irq_bus_lock/.irq_bus_sync_unlock of irqchip are not
honored during CPU hotplug migration and the reason for this is open-coded
IRQ affinity re-configuration in the existing ARM migrate_irqs()
implementation. Fortunately, this was already fixed for ARM64 in 217d453d
("arm64: fix a migrating irq bug when hotplug cpu").

So, just switch to the same generic code for ARM.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>
---
 arch/arm/Kconfig           |  1 +
 arch/arm/include/asm/irq.h |  1 -
 arch/arm/kernel/irq.c      | 61 --------------------------------------
 arch/arm/kernel/smp.c      |  2 +-
 4 files changed, 2 insertions(+), 63 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 843edfd000be..45a6cf925eec 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1449,6 +1449,7 @@ config NR_CPUS
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
 	depends on SMP
+	select GENERIC_IRQ_MIGRATION
 	help
 	  Say Y here to experiment with turning CPUs off and on.  CPUs
 	  can be controlled through /sys/devices/system/cpu.
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index b6f319606e30..2de321e89b94 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -25,7 +25,6 @@
 #ifndef __ASSEMBLY__
 struct irqaction;
 struct pt_regs;
-extern void migrate_irqs(void);
 
 extern void asm_do_IRQ(unsigned int, struct pt_regs *);
 void handle_IRQ(unsigned int, struct pt_regs *);
diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index ece04a457486..a7e047127c05 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -119,64 +119,3 @@ int __init arch_probe_nr_irqs(void)
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
index 0978282d5fc2..a9ab8f9fd20f 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -225,7 +225,7 @@ int __cpu_disable(void)
 	/*
 	 * OK - migrate IRQs away from this CPU
 	 */
-	migrate_irqs();
+	irq_migrate_all_off_this_cpu();
 
 	/*
 	 * Flush user cache and TLB mappings, and then remove this CPU
-- 
2.18.0
