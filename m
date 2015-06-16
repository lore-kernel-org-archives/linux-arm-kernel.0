From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Jun 2015 23:06:56 +0100
Subject: [PATCH 8/9] irq: irq-keystonr: fix race in installing chained IRQ
 handler
Message-ID: <E1Z4z0S-0002Ss-1V@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a race where a pending interrupt could be received and the handler
called before the handler's data has been setup, by converting to
irq_set_chained_handler_and_data().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Depends on patch 1.

 drivers/irqchip/irq-keystone.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index 78e8b3ce5252..00b0193687ef 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -184,8 +184,7 @@ static int keystone_irq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, kirq);
 
-	irq_set_chained_handler(kirq->irq, keystone_irq_handler);
-	irq_set_handler_data(kirq->irq, kirq);
+	irq_set_chained_handler_and_data(kirq->irq, keystone_irq_handler, kirq);
 
 	/* clear all source bits */
 	keystone_irq_writel(kirq, ~0x0);
-- 
2.1.0
