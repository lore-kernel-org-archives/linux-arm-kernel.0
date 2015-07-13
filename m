From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Jul 2015 20:29:11 -0000
Subject: [patch 08/11] ARM/dove: Prepare pmu_irq_handler for irq argument
 removal
References: <20150713090726.316699641@linutronix.de>
Message-ID: <20150713090936.596588884@linutronix.de>
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
 arch/arm/mach-dove/irq.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: tip/arch/arm/mach-dove/irq.c
===================================================================
--- tip.orig/arch/arm/mach-dove/irq.c
+++ tip/arch/arm/mach-dove/irq.c
@@ -69,8 +69,9 @@ static struct irq_chip pmu_irq_chip = {
 	.irq_ack	= pmu_irq_ack,
 };
 
-static void pmu_irq_handler(unsigned int irq, struct irq_desc *desc)
+static void pmu_irq_handler(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	unsigned long cause = readl(PMU_INTERRUPT_CAUSE);
 
 	cause &= readl(PMU_INTERRUPT_MASK);
