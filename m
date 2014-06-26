From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 26 Jun 2014 12:19:55 +0530
Subject: [PATCH] arm64: do not force irq affinity setting
Message-ID: <1403765395-16978-1-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unconditional copying cpu_online_mask to affinity
may result in migrating affinity to wrong CPU.

For example, IRQ 5 affinity mask contains CPU 4-7,
it was affined to CPU4 and CPU 0-7 are online.
Now if we hot-unplug CPU4 then with current
implementation affinity mask will contain
CPU 0-3,5-7 and IRQ 5 will be affined to CPU0.

Instead copy cpu_online_mask to affinity only if
no online CPU is present in affinity mask and do
not force affinity seeting which would do the
CPU online check.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 arch/arm64/kernel/irq.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 0f08dfd..dfa6e3e 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -97,19 +97,15 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	if (irqd_is_per_cpu(d) || !cpumask_test_cpu(smp_processor_id(), affinity))
 		return false;
 
-	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids)
+	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
+		affinity = cpu_online_mask;
 		ret = true;
+	}
 
-	/*
-	 * when using forced irq_set_affinity we must ensure that the cpu
-	 * being offlined is not present in the affinity mask, it may be
-	 * selected as the target CPU otherwise
-	 */
-	affinity = cpu_online_mask;
 	c = irq_data_get_irq_chip(d);
 	if (!c->irq_set_affinity)
 		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
-	else if (c->irq_set_affinity(d, affinity, true) == IRQ_SET_MASK_OK && ret)
+	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
 		cpumask_copy(d->affinity, affinity);
 
 	return ret;
-- 
1.7.4.1
