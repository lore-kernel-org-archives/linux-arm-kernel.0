From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Jul 2015 20:29:00 -0000
Subject: [patch 01/11] ARM/orion: Consolidate chained IRQ handler
 install/remove
References: <20150713090726.316699641@linutronix.de>
Message-ID: <20150713090936.019766165@linutronix.de>
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
 arch/arm/plat-orion/gpio.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Index: tip/arch/arm/plat-orion/gpio.c
===================================================================
--- tip.orig/arch/arm/plat-orion/gpio.c
+++ tip/arch/arm/plat-orion/gpio.c
@@ -582,8 +582,9 @@ void __init orion_gpio_init(struct devic
 
 	for (i = 0; i < 4; i++) {
 		if (irqs[i]) {
-			irq_set_handler_data(irqs[i], ochip);
-			irq_set_chained_handler(irqs[i], gpio_irq_handler);
+			irq_set_chained_handler_and_data(irqs[i],
+							 gpio_irq_handler,
+							 ochip);
 		}
 	}
 
