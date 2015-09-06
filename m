From: yangyingliang@huawei.com (Yang Yingliang)
Date: Sun, 6 Sep 2015 12:23:41 +0800
Subject: [RFC PATCH v1 4/4] arm/arm64: fix a migrating irq bug when hotplug cpu
In-Reply-To: <1441513421-8092-1-git-send-email-yangyingliang@huawei.com>
References: <1441513421-8092-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1441513421-8092-5-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When cpu is disabled, all irqs will be migratged to another cpu.
In some cases, a new affinity is different, it needed to be coppied
to irq's affinity. But if the type of irq is LPI, it's affinity will
not be coppied because of irq_set_affinity's return value. Fix it by
using irq_do_set_affinity.

And migrating interrupts is a core code matter, so move the code to
kernel/irq/migration.c and select CONFIG_GENERIC_IRQ_MIGRATION when
CONFIG_HOTPLUG_CPU and CONFIG_SMP is enabled.

Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/arm/Kconfig             |  1 +
 arch/arm/include/asm/irq.h   |  1 -
 arch/arm/kernel/irq.c        | 62 --------------------------------------------
 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/irq.h |  1 -
 arch/arm64/kernel/irq.c      | 62 --------------------------------------------
 kernel/irq/migration.c       | 62 ++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 64 insertions(+), 126 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 41cbb4a..ebc8a33 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -22,6 +22,7 @@ config ARM
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_IRQ_PROBE
+	select GENERIC_IRQ_MIGRATION if SMP && HOTPLUG_CPU
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_PCI_IOMAP
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 53c15de..d17fc900 100644
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
index baf8ede..2efdb40 100644
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
@@ -135,64 +134,3 @@ int __init arch_probe_nr_irqs(void)
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
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b7b9cea..6ffe411 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -32,6 +32,7 @@ config ARM64
 	select GENERIC_CPU_AUTOPROBE
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_IRQ_PROBE
+	select GENERIC_IRQ_MIGRATION if SMP && HOTPLUG_CPU
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IRQ_SHOW_LEVEL
 	select GENERIC_PCI_IOMAP
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
index 463fa2e..04ac1f6 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -27,7 +27,6 @@
 #include <linux/init.h>
 #include <linux/irqchip.h>
 #include <linux/seq_file.h>
-#include <linux/ratelimit.h>
 
 unsigned long irq_err_count;
 
@@ -56,64 +55,3 @@ void __init init_IRQ(void)
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
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index 37ddb7b..5801c79 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -1,6 +1,7 @@
 
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/ratelimit.h>
 
 #include "internals.h"
 
@@ -77,3 +78,64 @@ void irq_move_irq(struct irq_data *idata)
 	if (!masked)
 		idata->chip->irq_unmask(idata);
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+static bool migrate_one_irq(struct irq_desc *desc)
+{
+	struct irq_data *d = irq_desc_get_irq_data(desc);
+	const struct cpumask *affinity = d->affinity;
+	struct irq_chip *c;
+	bool ret = false;
+
+	/*
+	 * If this is a per-CPU interrupt, or the affinity does not
+	 * include this CPU, then we have nothing to do.
+	 */
+	if (irqd_is_per_cpu(d) || !cpumask_test_cpu(smp_processor_id(), affinity))
+		return false;
+
+	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
+		affinity = cpu_online_mask;
+		ret = true;
+	}
+
+	c = irq_data_get_irq_chip(d);
+	if (!c->irq_set_affinity)
+		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
+	else
+		irq_do_set_affinity(d, affinity, false);
+
+	return ret;
+}
+
+/*
+ * The current CPU has been marked offline.  Migrate IRQs off this CPU.
+ * If the affinity settings do not allow other CPUs, force them onto any
+ * available CPU.
+ *
+ * Note: we must iterate over all IRQs, whether they have an attached
+ * action structure or not, as we need to get chained interrupts too.
+ */
+void migrate_irqs(void)
+{
+	unsigned int i;
+	struct irq_desc *desc;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	for_each_irq_desc(i, desc) {
+		bool affinity_broken;
+
+		raw_spin_lock(&desc->lock);
+		affinity_broken = migrate_one_irq(desc);
+		raw_spin_unlock(&desc->lock);
+
+		if (affinity_broken)
+			pr_warn_ratelimited("IRQ%u no longer affine to CPU%u\n",
+					    i, smp_processor_id());
+	}
+
+	local_irq_restore(flags);
+}
+#endif /* CONFIG_HOTPLUG_CPU */
-- 
2.5.0
