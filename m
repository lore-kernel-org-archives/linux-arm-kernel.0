From: zhangwm@marvell.com (Neil Zhang)
Date: Fri, 15 Aug 2014 15:31:57 +0800
Subject: [PATCH] arm: irq: fix the affinity when migrate a irq
Message-ID: <1408087917-22603-1-git-send-email-zhangwm@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ffde1de64012 ("irqchip: Gic: Support forced affinity setting")
has enable the forcing cpu affinity of interrupts for gic.

The current code of migrate_one_irq will pass the current affinity mask
to irq_set_affinity with force is true, it may select the cpu being
offlined as the target CPU again, then the interrupt won't be migrated
correctly.

Signed-off-by: Neil Zhang <zhangwm@marvell.com>
---
 arch/arm/kernel/irq.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 2c42576..6f5a878 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -167,11 +167,10 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	if (irqd_is_per_cpu(d) || !cpumask_test_cpu(smp_processor_id(), affinity))
 		return false;
 
-	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids) {
-		affinity = cpu_online_mask;
+	if (cpumask_any_and(affinity, cpu_online_mask) >= nr_cpu_ids)
 		ret = true;
-	}
 
+	affinity = cpu_online_mask;
 	c = irq_data_get_irq_chip(d);
 	if (!c->irq_set_affinity)
 		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
-- 
1.7.9.5
