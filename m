From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Thu, 26 Jun 2014 12:18:02 +0530
Subject: [PATCH] arm: do not force irq affinity setting
Message-ID: <1403765282-16934-1-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When no online CPU is present in affinity mask we
copy cpu_online_mask to it, hence no need to force
affinity setting.

Also, when there is a online CPU present in affinity
mask we pass the same affinity mask which contains
the current CPU too which is going down. And with
force == true GIC driver skips online check which
results in keeping the affinity to offline CPU.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 arch/arm/kernel/irq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 2c42576..5c4d38e 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -175,7 +175,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	c = irq_data_get_irq_chip(d);
 	if (!c->irq_set_affinity)
 		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
-	else if (c->irq_set_affinity(d, affinity, true) == IRQ_SET_MASK_OK && ret)
+	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
 		cpumask_copy(d->affinity, affinity);
 
 	return ret;
-- 
1.7.4.1
