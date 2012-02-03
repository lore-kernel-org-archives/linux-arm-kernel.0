From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 03 Feb 2012 19:56:35 +0000
Subject: [PATCH 06/20] ARM: sa1111: implement support for sparse IRQs
In-Reply-To: <20120203195419.GH14129@n2100.arm.linux.org.uk>
References: <20120203195419.GH14129@n2100.arm.linux.org.uk>
Message-ID: <E1RtPFL-00043u-A6@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement the necessary allocation/freeing functionality to support
sparse IRQs with the SA-1111 device.  On non-sparse IRQ platforms,
this allows us to dynamically allocate from within the available IRQ
number space.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/common/sa1111.c |   43 ++++++++++++++++++++++++++++++++-----------
 1 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index d3a8f5e..b64a336 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -16,6 +16,7 @@
  */
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -28,9 +29,8 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
-#include <asm/mach-types.h>
-#include <asm/irq.h>
 #include <asm/mach/irq.h>
+#include <asm/mach-types.h>
 #include <asm/sizes.h>
 
 #include <asm/hardware/sa1111.h>
@@ -86,6 +86,7 @@
 #define IRQ_S1_CD_VALID		(52)
 #define IRQ_S0_BVD1_STSCHG	(53)
 #define IRQ_S1_BVD1_STSCHG	(54)
+#define SA1111_IRQ_NR		(55)
 
 extern void sa1110_mb_enable(void);
 extern void sa1110_mb_disable(void);
@@ -435,16 +436,28 @@ static struct irq_chip sa1111_high_chip = {
 	.irq_set_wake	= sa1111_wake_highirq,
 };
 
-static void sa1111_setup_irq(struct sa1111 *sachip)
+static int sa1111_setup_irq(struct sa1111 *sachip, unsigned irq_base)
 {
 	void __iomem *irqbase = sachip->base + SA1111_INTC;
 	unsigned i, irq;
+	int ret;
 
 	/*
 	 * We're guaranteed that this region hasn't been taken.
 	 */
 	request_mem_region(sachip->phys + SA1111_INTC, 512, "irq");
 
+	ret = irq_alloc_descs(-1, irq_base, SA1111_IRQ_NR, -1);
+	if (ret <= 0) {
+		dev_err(sachip->dev, "unable to allocate %u irqs: %d\n",
+			SA1111_IRQ_NR, ret);
+		if (ret == 0)
+			ret = -EINVAL;
+		return ret;
+	}
+
+	sachip->irq_base = ret;
+
 	/* disable all IRQs */
 	sa1111_writel(0, irqbase + SA1111_INTEN0);
 	sa1111_writel(0, irqbase + SA1111_INTEN1);
@@ -486,6 +499,11 @@ static void sa1111_setup_irq(struct sa1111 *sachip)
 	irq_set_irq_type(sachip->irq, IRQ_TYPE_EDGE_RISING);
 	irq_set_handler_data(sachip->irq, sachip);
 	irq_set_chained_handler(sachip->irq, sa1111_irq_handler);
+
+	dev_info(sachip->dev, "Providing IRQ%u-%u\n",
+		sachip->irq_base, sachip->irq_base + SA1111_IRQ_NR - 1);
+
+	return 0;
 }
 
 /*
@@ -740,7 +758,6 @@ __sa1111_probe(struct device *me, struct resource *mem, int irq)
 
 	sachip->phys = mem->start;
 	sachip->irq = irq;
-	sachip->irq_base = pd->irq_base;
 
 	/*
 	 * Map the whole region.  This also maps the
@@ -771,6 +788,16 @@ __sa1111_probe(struct device *me, struct resource *mem, int irq)
 	 */
 	sa1111_wake(sachip);
 
+	/*
+	 * The interrupt controller must be initialised before any
+	 * other device to ensure that the interrupts are available.
+	 */
+	if (sachip->irq != NO_IRQ) {
+		ret = sa1111_setup_irq(sachip, pd->irq_base);
+		if (ret)
+			goto err_unmap;
+	}
+
 #ifdef CONFIG_ARCH_SA1100
 	{
 	unsigned int val;
@@ -801,13 +828,6 @@ __sa1111_probe(struct device *me, struct resource *mem, int irq)
 	}
 #endif
 
-	/*
-	 * The interrupt controller must be initialised before any
-	 * other device to ensure that the interrupts are available.
-	 */
-	if (sachip->irq != NO_IRQ)
-		sa1111_setup_irq(sachip);
-
 	g_sa1111 = sachip;
 
 	has_devs = ~0;
@@ -858,6 +878,7 @@ static void __sa1111_remove(struct sa1111 *sachip)
 	if (sachip->irq != NO_IRQ) {
 		irq_set_chained_handler(sachip->irq, NULL);
 		irq_set_handler_data(sachip->irq, NULL);
+		irq_free_descs(sachip->irq_base, SA1111_IRQ_NR);
 
 		release_mem_region(sachip->phys + SA1111_INTC, 512);
 	}
-- 
1.7.4.4
