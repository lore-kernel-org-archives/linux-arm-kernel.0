From: yangyingliang@huawei.com (Yang Yingliang)
Date: Sat, 19 Sep 2015 11:05:57 +0800
Subject: [RFC PATCH v5 2/4] genirq: add irq_migrate_all_off_this_cpu() for cpu
 hotplug
In-Reply-To: <1442631959-10228-1-git-send-email-yangyingliang@huawei.com>
References: <1442631959-10228-1-git-send-email-yangyingliang@huawei.com>
Message-ID: <1442631959-10228-3-git-send-email-yangyingliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add irq_migrate_all_off_this_cpu() into kernel/irq/migration.c.
So we can use it to migrate interrupts, when cpu is offline.

Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 include/linux/irq.h    |  2 ++
 kernel/irq/migration.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 6f8b340..c111fa1 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -438,6 +438,8 @@ extern int irq_set_affinity_locked(struct irq_data *data,
 				   const struct cpumask *cpumask, bool force);
 extern int irq_set_vcpu_affinity(unsigned int irq, void *vcpu_info);
 
+extern void irq_migrate_all_off_this_cpu(void);
+
 #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_PENDING_IRQ)
 void irq_move_irq(struct irq_data *data);
 void irq_move_masked_irq(struct irq_data *data);
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index 1ff2b77..6e3e38d 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -1,6 +1,7 @@
 
 #include <linux/irq.h>
 #include <linux/interrupt.h>
+#include <linux/ratelimit.h>
 
 #include "internals.h"
 
@@ -79,3 +80,66 @@ void irq_move_irq(struct irq_data *idata)
 		idata->chip->irq_unmask(idata);
 }
 #endif
+
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
