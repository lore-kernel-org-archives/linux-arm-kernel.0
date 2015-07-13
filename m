From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Jul 2015 20:29:14 -0000
Subject: [patch 10/11] ARM/pxa: Prepare balloon3_irq_handler for irq argument
 removal
References: <20150713090726.316699641@linutronix.de>
Message-ID: <20150713090936.757251293@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq argument of most interrupt flow handlers is unused or merily
used instead of a local variable. The handlers which need the irq
argument can retrieve the irq number from the irq descriptor.

While at it fix the pointless lookup of irq_data with the proper
methods to retrieve the same information from the irq descriptor.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-pxa/balloon3.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: tip/arch/arm/mach-pxa/balloon3.c
===================================================================
--- tip.orig/arch/arm/mach-pxa/balloon3.c
+++ tip/arch/arm/mach-pxa/balloon3.c
@@ -496,18 +496,18 @@ static struct irq_chip balloon3_irq_chip
 	.irq_unmask	= balloon3_unmask_irq,
 };
 
-static void balloon3_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void balloon3_irq_handler(unsigned int __irq, struct irq_desc *desc)
 {
 	unsigned long pending = __raw_readl(BALLOON3_INT_CONTROL_REG) &
 					balloon3_irq_enabled;
 	do {
-		/* clear useless edge notification */
-		if (desc->irq_data.chip->irq_ack) {
-			struct irq_data *d;
+		struct irq_data *d = irq_desc_get_irq_data(desc);
+		struct irq_chip *chip = irq_data_get_chip(d);
+		unsigned int irq;
 
-			d = irq_get_irq_data(BALLOON3_AUX_NIRQ);
-			desc->irq_data.chip->irq_ack(d);
-		}
+		/* clear useless edge notification */
+		if (chip->irq_ack)
+			chip->irq_ack(d);
 
 		while (pending) {
 			irq = BALLOON3_IRQ(0) + __ffs(pending);
