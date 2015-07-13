From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Jul 2015 20:29:01 -0000
Subject: [patch 02/11] ARM/locomo: Consolidate chained IRQ handler
 install/remove
References: <20150713090726.316699641@linutronix.de>
Message-ID: <20150713090936.097948542@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chained irq handlers usually set up handler data as well. We now have
a function to set both under irq_desc->lock. Replace the two calls
with one.

Search and conversion was done with coccinelle.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/common/locomo.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: tip/arch/arm/common/locomo.c
===================================================================
--- tip.orig/arch/arm/common/locomo.c
+++ tip/arch/arm/common/locomo.c
@@ -475,8 +475,7 @@ static void __locomo_remove(struct locom
 	device_for_each_child(lchip->dev, NULL, locomo_remove_child);
 
 	if (lchip->irq != NO_IRQ) {
-		irq_set_chained_handler(lchip->irq, NULL);
-		irq_set_handler_data(lchip->irq, NULL);
+		irq_set_chained_handler_and_data(lchip->irq, NULL, NULL);
 	}
 
 	iounmap(lchip->base);
