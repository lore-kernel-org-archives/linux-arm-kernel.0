From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 13 Jul 2015 20:29:06 -0000
Subject: [patch 05/11] ARM,
 irq: Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc
References: <20150713090726.316699641@linutronix.de>
Message-ID: <20150713090936.341427183@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiang Liu <jiang.liu@linux.intel.com>

Use irq_desc_get_xxx() to avoid redundant lookup of irq_desc while we
already have a pointer to corresponding irq_desc.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/common/locomo.c   |    2 +-
 arch/arm/common/sa1111.c   |    2 +-
 arch/arm/plat-orion/gpio.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: tip/arch/arm/common/locomo.c
===================================================================
--- tip.orig/arch/arm/common/locomo.c
+++ tip/arch/arm/common/locomo.c
@@ -140,7 +140,7 @@ static struct locomo_dev_info locomo_dev
 
 static void locomo_handler(unsigned int irq, struct irq_desc *desc)
 {
-	struct locomo *lchip = irq_get_chip_data(irq);
+	struct locomo *lchip = irq_desc_get_chip_data(desc);
 	int req, i;
 
 	/* Acknowledge the parent IRQ */
Index: tip/arch/arm/common/sa1111.c
===================================================================
--- tip.orig/arch/arm/common/sa1111.c
+++ tip/arch/arm/common/sa1111.c
@@ -200,7 +200,7 @@ static void
 sa1111_irq_handler(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned int stat0, stat1, i;
-	struct sa1111 *sachip = irq_get_handler_data(irq);
+	struct sa1111 *sachip = irq_desc_get_handler_data(desc);
 	void __iomem *mapbase = sachip->base + SA1111_INTC;
 
 	stat0 = sa1111_readl(mapbase + SA1111_INTSTATCLR0);
Index: tip/arch/arm/plat-orion/gpio.c
===================================================================
--- tip.orig/arch/arm/plat-orion/gpio.c
+++ tip/arch/arm/plat-orion/gpio.c
@@ -409,7 +409,7 @@ static int gpio_irq_set_type(struct irq_
 
 static void gpio_irq_handler(unsigned irq, struct irq_desc *desc)
 {
-	struct orion_gpio_chip *ochip = irq_get_handler_data(irq);
+	struct orion_gpio_chip *ochip = irq_desc_get_handler_data(desc);
 	u32 cause, type;
 	int i;
 
