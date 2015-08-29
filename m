From: yangyingliang@huawei.com (Yang Yingliang)
Date: Sat, 29 Aug 2015 21:07:17 +0800
Subject: [PATCH] ARM: fix a migrating irq bug when hotplug cpu
Message-ID: <55E1AE85.20500@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yang Yingliang <yangyingliang@huawei.com>

When cpu is disabled, all irqs will be migratged to another cpu.
In some cases, a new affinity is different, it needed to be coppied
to irq's affinity. But if the type of irq is LPI, it's affinity will
not be coppied because of irq_set_affinity's return value.
So copy the affinity, when the return value is IRQ_SET_MASK_OK_DONE.

Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
---
  arch/arm/kernel/irq.c | 9 ++++++---
  1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 350f188..32f2140 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -157,10 +157,13 @@ static bool migrate_one_irq(struct irq_desc *desc)
  	}

  	c = irq_data_get_irq_chip(d);
-	if (!c->irq_set_affinity)
+	if (!c->irq_set_affinity) {
  		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
-	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && 
ret)
-		cpumask_copy(d->affinity, affinity);
+	} else {
+		int r = c->irq_set_affinity(d, affinity, false);
+		if ((r == IRQ_SET_MASK_OK || r == IRQ_SET_MASK_OK_DONE) && ret)
+			cpumask_copy(d->affinity, affinity);
+	}

  	return ret;
  }
-- 
2.5.0
