From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 12 Dec 2014 10:51:22 +0000
Subject: [PATCH 1/3] irqchip: gicv3-its: Fix domain free in multi-MSI case
In-Reply-To: <1418381484-4394-1-git-send-email-marc.zyngier@arm.com>
References: <1418381484-4394-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1418381484-4394-2-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix stupid thinko on the path freeing the interrupts, where only
the first interrupt would get reset, and none of the others.

This should only affect multi-MSI allocations.

Reported-by: Wuyun Wu (Abel) <wuyun.wu@huawei.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e9d1615..ab01852 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1210,7 +1210,7 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 		clear_bit(event, its_dev->lpi_map);
 
 		/* Nuke the entry in the domain */
-		irq_domain_reset_irq_data(d);
+		irq_domain_reset_irq_data(data);
 	}
 
 	/* If all interrupts have been freed, start mopping the floor */
-- 
2.1.3
