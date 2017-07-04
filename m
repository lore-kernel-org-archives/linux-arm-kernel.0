From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue,  4 Jul 2017 11:10:39 +0200
Subject: [PATCH 1/3] irqchip/atmel-aic: Fix unbalanced of_node_put() in
 aic_common_irq_fixup()
Message-ID: <1499159441-29801-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

aic_common_irq_fixup() is calling twice of_node_put() on the same node
thus leading to an unbalanced refcount on the root node.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Reported-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Fixes: b2f579b58e93 ("irqchip: atmel-aic: Add irq fixup infrastructure")
Cc: <stable@vger.kernel.org>
---
 drivers/irqchip/irq-atmel-aic-common.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/irq-atmel-aic-common.c b/drivers/irqchip/irq-atmel-aic-common.c
index 28b26c80f4cf..7c5a43488d27 100644
--- a/drivers/irqchip/irq-atmel-aic-common.c
+++ b/drivers/irqchip/irq-atmel-aic-common.c
@@ -196,7 +196,6 @@ static void __init aic_common_irq_fixup(const struct of_device_id *matches)
 		return;
 
 	match = of_match_node(matches, root);
-	of_node_put(root);
 
 	if (match) {
 		void (*fixup)(struct device_node *) = match->data;
-- 
2.7.4
