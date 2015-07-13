From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Jul 2015 20:29:08 -0000
Subject: [patch 06/11] ARM/locomo: Prepare locomo_handler for irq argument
 removal
References: <20150713090726.316699641@linutronix.de>
Message-ID: <20150713090936.438905855@linutronix.de>
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
 arch/arm/common/locomo.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: tip/arch/arm/common/locomo.c
===================================================================
--- tip.orig/arch/arm/common/locomo.c
+++ tip/arch/arm/common/locomo.c
@@ -138,7 +138,7 @@ static struct locomo_dev_info locomo_dev
 	},
 };
 
-static void locomo_handler(unsigned int irq, struct irq_desc *desc)
+static void locomo_handler(unsigned int __irq, struct irq_desc *desc)
 {
 	struct locomo *lchip = irq_desc_get_chip_data(desc);
 	int req, i;
@@ -150,6 +150,8 @@ static void locomo_handler(unsigned int
 	req = locomo_readl(lchip->base + LOCOMO_ICR) & 0x0f00;
 
 	if (req) {
+		unsigned int irq;
+
 		/* generate the next interrupt(s) */
 		irq = lchip->irq_base;
 		for (i = 0; i <= 3; i++, irq++) {
