From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Jul 2015 20:29:03 -0000
Subject: [patch 03/11] ARM/irq: Use access helper irq_data_get_affinity_mask()
References: <20150713090726.316699641@linutronix.de>
Message-ID: <20150713090936.176152466@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiang Liu <jiang.liu@linux.intel.com>

This is a preparatory patch for moving irq_data struct members.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/kernel/irq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: tip/arch/arm/kernel/irq.c
===================================================================
--- tip.orig/arch/arm/kernel/irq.c
+++ tip/arch/arm/kernel/irq.c
@@ -140,7 +140,7 @@ int __init arch_probe_nr_irqs(void)
 static bool migrate_one_irq(struct irq_desc *desc)
 {
 	struct irq_data *d = irq_desc_get_irq_data(desc);
-	const struct cpumask *affinity = d->affinity;
+	const struct cpumask *affinity = irq_data_get_affinity_mask(d);
 	struct irq_chip *c;
 	bool ret = false;
 
@@ -160,7 +160,7 @@ static bool migrate_one_irq(struct irq_d
 	if (!c->irq_set_affinity)
 		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
 	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
-		cpumask_copy(d->affinity, affinity);
+		cpumask_copy(irq_data_get_affinity_mask(d), affinity);
 
 	return ret;
 }
