From: yangyingliang@huawei.com (Yang Yingliang)
Date: Thu, 24 Sep 2015 17:32:13 +0800
Subject: [RFC PATCH v6 1/3] genirq: introduce CONFIG_GENERIC_IRQ_MIGRATION and
 kernel/irq/cpuhotplug.c
In-Reply-To: <1443087135-17044-1-git-send-email-yangyingliang@huawei.com>
References: <1443087135-17044-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1443087135-17044-2-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add migrating interrupts code to a new file kernel/irq/cpuhotplug.c and
make it depends on CONFIG_GENERIC_IRQ_MIGRATION. So we can use it to migrate
interrupts, before cpu is offline.

Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 include/linux/irq.h     |  2 ++
 kernel/irq/Kconfig      |  4 +++
 kernel/irq/Makefile     |  1 +
 kernel/irq/cpuhotplug.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+)
 create mode 100644 kernel/irq/cpuhotplug.c

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 11bf092..45cc729 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -452,6 +452,8 @@ extern int irq_set_affinity_locked(struct irq_data *data,
 				   const struct cpumask *cpumask, bool force);
 extern int irq_set_vcpu_affinity(unsigned int irq, void *vcpu_info);
 
+extern void irq_migrate_all_off_this_cpu(void);
+
 #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_PENDING_IRQ)
 void irq_move_irq(struct irq_data *data);
 void irq_move_masked_irq(struct irq_data *data);
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 9a76e3b..3b48dab 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -30,6 +30,10 @@ config GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
 config GENERIC_PENDING_IRQ
 	bool
 
+# Support for generic irq migrating off cpu before the cpu is offline.
+config GENERIC_IRQ_MIGRATION
+	bool
+
 # Alpha specific irq affinity mechanism
 config AUTO_IRQ_AFFINITY
        bool
diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index d121235..2fc9cbd 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -5,5 +5,6 @@ obj-$(CONFIG_GENERIC_IRQ_PROBE) += autoprobe.o
 obj-$(CONFIG_IRQ_DOMAIN) += irqdomain.o
 obj-$(CONFIG_PROC_FS) += proc.o
 obj-$(CONFIG_GENERIC_PENDING_IRQ) += migration.o
+obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += cpuhotplug.o
 obj-$(CONFIG_PM_SLEEP) += pm.o
 obj-$(CONFIG_GENERIC_MSI_IRQ) += msi.o
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
new file mode 100644
index 0000000..8f2e9c0
--- /dev/null
+++ b/kernel/irq/cpuhotplug.c
@@ -0,0 +1,68 @@
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/ratelimit.h>
+
+#include "internals.h"
+
+static bool migrate_one_irq(struct irq_desc *desc)
+{
+	struct irq_data *d = irq_desc_get_irq_data(desc);
+	const struct cpumask *affinity = d->common->affinity;
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
+	if (!c->irq_set_affinity) {
+		pr_warn_ratelimited("IRQ%u: unable to set affinity\n", d->irq);
+	} else {
+		int r = irq_do_set_affinity(d, affinity, false);
+		if (r)
+			pr_warn_ratelimited("IRQ%u: set affinity failed(%d).\n", d->irq, r);
+	}
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
+void irq_migrate_all_off_this_cpu(void)
+{
+	unsigned int irq;
+	struct irq_desc *desc;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	for_each_active_irq(irq) {
+		bool affinity_broken;
+
+		desc = irq_to_desc(irq);
+		raw_spin_lock(&desc->lock);
+		affinity_broken = migrate_one_irq(desc);
+		raw_spin_unlock(&desc->lock);
+
+		if (affinity_broken)
+			pr_warn_ratelimited("IRQ%u no longer affine to CPU%u\n",
+					    irq, smp_processor_id());
+	}
+
+	local_irq_restore(flags);
+}
-- 
2.5.0
