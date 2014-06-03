From: r.sricharan@ti.com (Sricharan R)
Date: Tue, 3 Jun 2014 13:12:58 +0530
Subject: [PATCH 06/14] irqchip: crossbar: fix memory leak incase of invalid
 entry
In-Reply-To: <1401781386-4982-1-git-send-email-r.sricharan@ti.com>
References: <1401781386-4982-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1401781386-4982-7-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nishanth Menon <nm@ti.com>

When the provided unused skip list entry is greater than max irqs
possible, we go to err3, but we fail to free register_offsets,
should have returned to err4 instead which ensures that allocated
register_offsets are freed as well.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/irqchip/irq-crossbar.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-crossbar.c b/drivers/irqchip/irq-crossbar.c
index 42a2e62..fea3e5d 100644
--- a/drivers/irqchip/irq-crossbar.c
+++ b/drivers/irqchip/irq-crossbar.c
@@ -225,7 +225,7 @@ static int __init crossbar_of_init(struct device_node *node,
 
 			if (entry > max) {
 				pr_err("Invalid skip entry\n");
-				goto err3;
+				goto err4;
 			}
 			cb->irq_map[entry] = IRQ_SKIP;
 		}
-- 
1.7.9.5
