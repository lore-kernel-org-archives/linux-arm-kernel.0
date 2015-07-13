From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Jul 2015 20:30:04 -0000
Subject: [patch] ARM64/irq: Use access helper irq_data_get_affinity_mask()
Message-ID: <20150713100010.928355574@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiang Liu <jiang.liu@linux.intel.com>

This is a preparatory patch for moving irq_data struct members.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm64/kernel/irq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: tip/arch/arm64/kernel/irq.c
===================================================================
--- tip.orig/arch/arm64/kernel/irq.c
+++ tip/arch/arm64/kernel/irq.c
@@ -61,7 +61,7 @@ void __init init_IRQ(void)
 static bool migrate_one_irq(struct irq_desc *desc)
 {
 	struct irq_data *d = irq_desc_get_irq_data(desc);
-	const struct cpumask *affinity = d->affinity;
+	const struct cpumask *affinity = irq_data_get_affinity_mask(d);
 	struct irq_chip *c;
 	bool ret = false;
 
@@ -81,7 +81,7 @@ static bool migrate_one_irq(struct irq_d
 	if (!c->irq_set_affinity)
 		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
 	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
-		cpumask_copy(d->affinity, affinity);
+		cpumask_copy(irq_data_get_affinity_mask(d), affinity);
 
 	return ret;
 }
