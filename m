From: jiang.liu@linux.intel.com (Jiang Liu)
Date: Mon,  1 Jun 2015 16:05:26 +0800
Subject: [Patch v3 17/36] ARM64,
 irq: Use access helper irq_data_get_affinity_mask()
In-Reply-To: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
References: <1433145945-789-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <1433145945-789-18-git-send-email-jiang.liu@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use access helper irq_data_get_affinity_mask() to hide implementation
details of struct irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/arm64/kernel/irq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
index 240b75c0e94f..463fa2e7e34c 100644
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -61,7 +61,7 @@ void __init init_IRQ(void)
 static bool migrate_one_irq(struct irq_desc *desc)
 {
 	struct irq_data *d = irq_desc_get_irq_data(desc);
-	const struct cpumask *affinity = d->affinity;
+	const struct cpumask *affinity = irq_data_get_affinity_mask(d);
 	struct irq_chip *c;
 	bool ret = false;
 
@@ -81,7 +81,7 @@ static bool migrate_one_irq(struct irq_desc *desc)
 	if (!c->irq_set_affinity)
 		pr_debug("IRQ%u: unable to set affinity\n", d->irq);
 	else if (c->irq_set_affinity(d, affinity, false) == IRQ_SET_MASK_OK && ret)
-		cpumask_copy(d->affinity, affinity);
+		cpumask_copy(irq_data_get_affinity_mask(d), affinity);
 
 	return ret;
 }
-- 
1.7.10.4
