From: yangyingliang@huawei.com (Yang Yingliang)
Date: Sat, 29 Aug 2015 21:00:57 +0800
Subject: [PATCH] arm64: fix a migrating irq bug when hotplug cpu
Message-ID: <55E1AD09.7020701@huawei.com>
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
---
  arch/arm64/kernel/irq.c | 9 ++++++---
  1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 463fa2e..2acc8ec 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -78,10 +78,13 @@ static bool migrate_one_irq(struct irq_desc *desc)
  	}

  	c = irq_data_get_irq_chip(d);
-	if (!c->irq_set_affinity)
+	if (!c->irq_set_affinity) {
  		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
-	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && 
ret)
-		cpumask_copy(irq_data_get_affinity_mask(d), affinity);
+	} else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK 
&& ret) {
+		int r = c->irq_set_affinity(d, affinity, false);
+		if ((r == IRQ_SET_MASK_OK || r == IRQ_SET_MASK_OK_DONE) && ret)
+			cpumask_copy(irq_data_get_affinity_mask(d), affinity);
+	}

  	return ret;
  }
-- 
2.5.0
