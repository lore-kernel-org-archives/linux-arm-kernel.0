From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Jul 2015 20:29:09 -0000
Subject: [patch 07/11] ARM/sa1111: Prepare sa1111_irq_handler for irq argument
 removal
References: <20150713090726.316699641@linutronix.de>
Message-ID: <20150713090936.516105694@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The irq argument of most interrupt flow handlers is unused or merily
used instead of a local variable. The handlers which need the irq
argument can retrieve the irq number from the irq descriptor.

Search and update was done with coccinelle and the invaluable help of
Julia Lawall.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/common/sa1111.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: tip/arch/arm/common/sa1111.c
===================================================================
--- tip.orig/arch/arm/common/sa1111.c
+++ tip/arch/arm/common/sa1111.c
@@ -197,8 +197,9 @@ static struct sa1111_dev_info sa1111_dev
  * will call us again if there are more interrupts to process.
  */
 static void
-sa1111_irq_handler(unsigned int irq, struct irq_desc *desc)
+sa1111_irq_handler(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	unsigned int stat0, stat1, i;
 	struct sa1111 *sachip = irq_desc_get_handler_data(desc);
 	void __iomem *mapbase = sachip->base + SA1111_INTC;
