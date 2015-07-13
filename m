From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Jul 2015 20:29:04 -0000
Subject: [patch 04/11] ARM/LPC32xx: Use irq_set_handler_locked()
References: <20150713090726.316699641@linutronix.de>
Message-ID: <20150713090936.258523333@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use irq_set_handler_locked() as it avoids a redundant lookup of the
irq descriptor.

Search and replacement was done with coccinelle.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-lpc32xx/irq.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: tip/arch/arm/mach-lpc32xx/irq.c
===================================================================
--- tip.orig/arch/arm/mach-lpc32xx/irq.c
+++ tip/arch/arm/mach-lpc32xx/irq.c
@@ -283,25 +283,25 @@ static int lpc32xx_set_irq_type(struct i
 	case IRQ_TYPE_EDGE_RISING:
 		/* Rising edge sensitive */
 		__lpc32xx_set_irq_type(d->hwirq, 1, 1);
-		__irq_set_handler_locked(d->irq, handle_edge_irq);
+		irq_set_handler_locked(d, handle_edge_irq);
 		break;
 
 	case IRQ_TYPE_EDGE_FALLING:
 		/* Falling edge sensitive */
 		__lpc32xx_set_irq_type(d->hwirq, 0, 1);
-		__irq_set_handler_locked(d->irq, handle_edge_irq);
+		irq_set_handler_locked(d, handle_edge_irq);
 		break;
 
 	case IRQ_TYPE_LEVEL_LOW:
 		/* Low level sensitive */
 		__lpc32xx_set_irq_type(d->hwirq, 0, 0);
-		__irq_set_handler_locked(d->irq, handle_level_irq);
+		irq_set_handler_locked(d, handle_level_irq);
 		break;
 
 	case IRQ_TYPE_LEVEL_HIGH:
 		/* High level sensitive */
 		__lpc32xx_set_irq_type(d->hwirq, 1, 0);
-		__irq_set_handler_locked(d->irq, handle_level_irq);
+		irq_set_handler_locked(d, handle_level_irq);
 		break;
 
 	/* Other modes are not supported */
