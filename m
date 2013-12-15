From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Sun, 15 Dec 2013 08:28:12 +0400
Subject: [PATCH v3 05/10] arm: sa1100: use ioremap'ped access instead of
 direct register access
In-Reply-To: <1387081697-21841-1-git-send-email-dbaryshkov@gmail.com>
References: <1387081697-21841-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1387081697-21841-6-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ioremap MMIO register regions and use readl/writel family of functions
to access IRQ and GPIO edge detection registers.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-sa1100/irq.c | 127 +++++++++++++++++++++++++++++++--------------
 1 file changed, 89 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-sa1100/irq.c b/arch/arm/mach-sa1100/irq.c
index 341d296..5b2e183 100644
--- a/arch/arm/mach-sa1100/irq.c
+++ b/arch/arm/mach-sa1100/irq.c
@@ -17,13 +17,26 @@
 #include <linux/ioport.h>
 #include <linux/syscore_ops.h>
 
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
 
 #include "generic.h"
 
+static void __iomem *irq_regbase;
+
+#define ICIP_OFFSET	0x00  /* IC IRQ Pending reg.             */
+#define ICMR_OFFSET	0x04  /* IC Mask Reg.                    */
+#define ICLR_OFFSET	0x08  /* IC Level Reg.                   */
+#define ICCR_OFFSET	0x0C  /* IC Control Reg.                 */
+#define ICFP_OFFSET	0x10  /* IC FIQ Pending reg.             */
+#define ICPR_OFFSET	0x20  /* IC Pending Reg.                 */
+
+static void __iomem *gpio_regbase;
+
+#define GRER_OFFSET	0x10  /* GPIO Rising-Edge detect Reg.    */
+#define GFER_OFFSET	0x14  /* GPIO Falling-Edge detect Reg.   */
+#define GEDR_OFFSET	0x18  /* GPIO Edge Detect status Reg.    */
 
 /*
  * SA1100 GPIO edge detection for IRQs:
@@ -65,8 +78,10 @@ static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
 	} else
 		GPIO_IRQ_falling_edge &= ~mask;
 
-	GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
-	GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
+	writel_relaxed(GPIO_IRQ_rising_edge & GPIO_IRQ_mask,
+			gpio_regbase + GRER_OFFSET);
+	writel_relaxed(GPIO_IRQ_falling_edge & GPIO_IRQ_mask,
+			gpio_regbase + GFER_OFFSET);
 
 	return 0;
 }
@@ -76,17 +91,21 @@ static int sa1100_gpio_type(struct irq_data *d, unsigned int type)
  */
 static void sa1100_low_gpio_ack(struct irq_data *d)
 {
-	GEDR = (1 << d->irq);
+	writel_relaxed((1 << d->irq), gpio_regbase + GEDR_OFFSET);
 }
 
 static void sa1100_low_gpio_mask(struct irq_data *d)
 {
-	ICMR &= ~(1 << d->irq);
+	unsigned int r = readl_relaxed(irq_regbase + ICMR_OFFSET);
+	r &= ~BIT(d->irq);
+	writel_relaxed(r, irq_regbase + ICMR_OFFSET);
 }
 
 static void sa1100_low_gpio_unmask(struct irq_data *d)
 {
-	ICMR |= 1 << d->irq;
+	unsigned int r = readl_relaxed(irq_regbase + ICMR_OFFSET);
+	r |= BIT(d->irq);
+	writel_relaxed(r, irq_regbase + ICMR_OFFSET);
 }
 
 static int sa1100_low_gpio_wake(struct irq_data *d, unsigned int on)
@@ -118,13 +137,13 @@ sa1100_high_gpio_handler(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned int mask;
 
-	mask = GEDR & 0xfffff800;
+	mask = readl_relaxed(gpio_regbase + GEDR_OFFSET) & 0xfffff800;
 	do {
 		/*
 		 * clear down all currently active IRQ sources.
 		 * We will be processing them all.
 		 */
-		GEDR = mask;
+		writel_relaxed(mask, gpio_regbase + GEDR_OFFSET);
 
 		irq = IRQ_GPIO11;
 		mask >>= 11;
@@ -135,7 +154,7 @@ sa1100_high_gpio_handler(unsigned int irq, struct irq_desc *desc)
 			irq++;
 		} while (mask);
 
-		mask = GEDR & 0xfffff800;
+		mask = readl_relaxed(gpio_regbase + GEDR_OFFSET) & 0xfffff800;
 	} while (mask);
 }
 
@@ -148,17 +167,22 @@ static void sa1100_high_gpio_ack(struct irq_data *d)
 {
 	unsigned int mask = GPIO11_27_MASK(d->irq);
 
-	GEDR = mask;
+	writel_relaxed(mask, gpio_regbase + GEDR_OFFSET);
 }
 
 static void sa1100_high_gpio_mask(struct irq_data *d)
 {
 	unsigned int mask = GPIO11_27_MASK(d->irq);
+	unsigned int r;
 
 	GPIO_IRQ_mask &= ~mask;
 
-	GRER &= ~mask;
-	GFER &= ~mask;
+	r = readl_relaxed(gpio_regbase + GRER_OFFSET);
+	r &= ~mask;
+	writel_relaxed(r, gpio_regbase + GRER_OFFSET);
+	r = readl_relaxed(gpio_regbase + GFER_OFFSET);
+	r &= ~mask;
+	writel_relaxed(r, gpio_regbase + GFER_OFFSET);
 }
 
 static void sa1100_high_gpio_unmask(struct irq_data *d)
@@ -167,8 +191,10 @@ static void sa1100_high_gpio_unmask(struct irq_data *d)
 
 	GPIO_IRQ_mask |= mask;
 
-	GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
-	GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
+	writel_relaxed(GPIO_IRQ_rising_edge & GPIO_IRQ_mask,
+			gpio_regbase + GRER_OFFSET);
+	writel_relaxed(GPIO_IRQ_falling_edge & GPIO_IRQ_mask,
+			gpio_regbase + GFER_OFFSET);
 }
 
 static int sa1100_high_gpio_wake(struct irq_data *d, unsigned int on)
@@ -196,12 +222,16 @@ static struct irq_chip sa1100_high_gpio_chip = {
  */
 static void sa1100_mask_irq(struct irq_data *d)
 {
-	ICMR &= ~(1 << d->irq);
+	unsigned int r = readl_relaxed(irq_regbase + ICMR_OFFSET);
+	r &= ~BIT(d->irq);
+	writel_relaxed(r, irq_regbase + ICMR_OFFSET);
 }
 
 static void sa1100_unmask_irq(struct irq_data *d)
 {
-	ICMR |= (1 << d->irq);
+	unsigned int r = readl_relaxed(irq_regbase + ICMR_OFFSET);
+	r |= BIT(d->irq);
+	writel_relaxed(r, irq_regbase + ICMR_OFFSET);
 }
 
 /*
@@ -223,6 +253,9 @@ static struct irq_chip sa1100_normal_chip = {
 static struct resource irq_resource =
 	DEFINE_RES_MEM_NAMED(0x90050000, SZ_64K, "irqs");
 
+static struct resource gpio_resource =
+	DEFINE_RES_MEM_NAMED(0x90040000, 20, "gpios");
+
 static struct sa1100irq_state {
 	unsigned int	saved;
 	unsigned int	icmr;
@@ -235,27 +268,28 @@ static int sa1100irq_suspend(void)
 	struct sa1100irq_state *st = &sa1100irq_state;
 
 	st->saved = 1;
-	st->icmr = ICMR;
-	st->iclr = ICLR;
-	st->iccr = ICCR;
+	st->icmr = readl_relaxed(irq_regbase + ICMR_OFFSET);
+	st->iclr = readl_relaxed(irq_regbase + ICLR_OFFSET);
+	st->iccr = readl_relaxed(irq_regbase + ICCR_OFFSET);
 
 	/*
 	 * Disable all GPIO-based interrupts.
 	 */
-	ICMR &= ~(IC_GPIO11_27|IC_GPIO10|IC_GPIO9|IC_GPIO8|IC_GPIO7|
-		  IC_GPIO6|IC_GPIO5|IC_GPIO4|IC_GPIO3|IC_GPIO2|
-		  IC_GPIO1|IC_GPIO0);
+	writel_relaxed(st->icmr & ~0xfff, irq_regbase + ICMR_OFFSET);
 
 	/*
 	 * Set the appropriate edges for wakeup.
 	 */
-	GRER = GPIO_IRQ_wake_mask & GPIO_IRQ_rising_edge;
-	GFER = GPIO_IRQ_wake_mask & GPIO_IRQ_falling_edge;
+	writel_relaxed(GPIO_IRQ_wake_mask & GPIO_IRQ_rising_edge,
+			gpio_regbase + GRER_OFFSET);
+	writel_relaxed(GPIO_IRQ_wake_mask & GPIO_IRQ_falling_edge,
+			gpio_regbase + GFER_OFFSET);
 	
 	/*
 	 * Clear any pending GPIO interrupts.
 	 */
-	GEDR = GEDR;
+	writel_relaxed(readl_relaxed(gpio_regbase + GEDR_OFFSET),
+			gpio_regbase + GEDR_OFFSET);
 
 	return 0;
 }
@@ -265,13 +299,15 @@ static void sa1100irq_resume(void)
 	struct sa1100irq_state *st = &sa1100irq_state;
 
 	if (st->saved) {
-		ICCR = st->iccr;
-		ICLR = st->iclr;
+		writel_relaxed(st->iccr, irq_regbase + ICCR_OFFSET);
+		writel_relaxed(st->iclr, irq_regbase + ICLR_OFFSET);
 
-		GRER = GPIO_IRQ_rising_edge & GPIO_IRQ_mask;
-		GFER = GPIO_IRQ_falling_edge & GPIO_IRQ_mask;
+		writel_relaxed(GPIO_IRQ_rising_edge & GPIO_IRQ_mask,
+				gpio_regbase + GRER_OFFSET);
+		writel_relaxed(GPIO_IRQ_falling_edge & GPIO_IRQ_mask,
+				gpio_regbase + GFER_OFFSET);
 
-		ICMR = st->icmr;
+		writel_relaxed(st->icmr, irq_regbase + ICMR_OFFSET);
 	}
 }
 
@@ -294,8 +330,8 @@ sa1100_handle_irq(struct pt_regs *regs)
 	uint32_t icip, icmr, mask;
 
 	do {
-		icip = (ICIP);
-		icmr = (ICMR);
+		icip = readl_relaxed(irq_regbase + ICIP_OFFSET);
+		icmr = readl_relaxed(irq_regbase + ICMR_OFFSET);
 		mask = icip & icmr;
 
 		if (mask == 0)
@@ -310,23 +346,38 @@ void __init sa1100_init_irq(void)
 	unsigned int irq;
 
 	request_resource(&iomem_resource, &irq_resource);
+	request_resource(&iomem_resource, &gpio_resource);
+
+	irq_regbase = ioremap(irq_resource.start,
+			resource_size(&irq_resource));
+	if (!irq_regbase) {
+		pr_err("Can not remap IRQ registers!\n");
+		return;
+	}
+
+	gpio_regbase = ioremap(gpio_resource.start,
+			resource_size(&gpio_resource));
+	if (!gpio_regbase) {
+		pr_err("Can not remap IRQ registers!\n");
+		return;
+	}
 
 	/* disable all IRQs */
-	ICMR = 0;
+	writel_relaxed(0, irq_regbase + ICMR_OFFSET);
 
 	/* all IRQs are IRQ, not FIQ */
-	ICLR = 0;
+	writel_relaxed(0, irq_regbase + ICLR_OFFSET);
 
 	/* clear all GPIO edge detects */
-	GFER = 0;
-	GRER = 0;
-	GEDR = -1;
+	writel_relaxed(0, gpio_regbase + GFER_OFFSET);
+	writel_relaxed(0, gpio_regbase + GRER_OFFSET);
+	writel_relaxed(~0, gpio_regbase + GEDR_OFFSET);
 
 	/*
 	 * Whatever the doc says, this has to be set for the wait-on-irq
 	 * instruction to work... on a SA1100 rev 9 at least.
 	 */
-	ICCR = 1;
+	writel_relaxed(1, irq_regbase + ICCR_OFFSET);
 
 	for (irq = 0; irq <= 10; irq++) {
 		irq_set_chip_and_handler(irq, &sa1100_low_gpio_chip,
-- 
1.8.5.1
