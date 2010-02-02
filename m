From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Tue,  2 Feb 2010 15:59:17 -0800
Subject: [PATCH 05/16] ARM: LPC32XX: Added LPC32XX identifier to INTC register
	field macros
In-Reply-To: <LPC32XX architecture files (updated)>
References: <LPC32XX architecture files (updated)>
Message-ID: <1265155168-28909-6-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

The INTC macros and associated code have been updated with the
LPC32XX identifier.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/include/mach/entry-macro.S |    6 +-
 arch/arm/mach-lpc32xx/include/mach/platform.h    |   12 ++--
 arch/arm/mach-lpc32xx/irq.c                      |   69 +++++++++++-----------
 3 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/include/mach/entry-macro.S b/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
index 01331f1..25f2adc 100644
--- a/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
+++ b/arch/arm/mach-lpc32xx/include/mach/entry-macro.S
@@ -39,7 +39,7 @@
 	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
 	/* Get MIC status first */
 	ldr	\base, =IO_ADDRESS(LPC32XX_MIC_BASE)
-	ldr	\irqstat, [\base, #INTC_STAT]
+	ldr	\irqstat, [\base, #LPC32XX_INTC_STAT]
 	and	\irqstat, \irqstat, #0xFFFFFFFC
 	mov	\tmp, #0
 
@@ -49,7 +49,7 @@
 
 	/* SIC1 interrupts start at offset 32 */
 	ldr	\base, =IO_ADDRESS(LPC32XX_SIC1_BASE)
-	ldr	\irqstat, [\base, #INTC_STAT]
+	ldr	\irqstat, [\base, #LPC32XX_INTC_STAT]
 	mov	\tmp, #32
 
 	/* Drop through to SIC2 if SIC1 is not pending */
@@ -58,7 +58,7 @@
 
 	/* SIC2 interrupts start at offset 64 */
 	ldr	\base, =IO_ADDRESS(LPC32XX_SIC2_BASE)
-	ldr	\irqstat, [\base, #INTC_STAT]
+	ldr	\irqstat, [\base, #LPC32XX_INTC_STAT]
 	mov	\tmp, #64
 
 	/* Safety check only, exit if no status on MIC, SIC1, SIC2 */
diff --git a/arch/arm/mach-lpc32xx/include/mach/platform.h b/arch/arm/mach-lpc32xx/include/mach/platform.h
index 7e9ade1..099db8a 100644
--- a/arch/arm/mach-lpc32xx/include/mach/platform.h
+++ b/arch/arm/mach-lpc32xx/include/mach/platform.h
@@ -588,12 +588,12 @@
 /*
  * Interrupt controller register offsets
  */
-#define INTC_MASK		0x00
-#define INTC_RAW_STAT		0x04
-#define INTC_STAT		0x08
-#define INTC_POLAR		0x0C
-#define INTC_ACT_TYPE		0x10
-#define INTC_TYPE		0x14
+#define LPC32XX_INTC_MASK			0x00
+#define LPC32XX_INTC_RAW_STAT			0x04
+#define LPC32XX_INTC_STAT			0x08
+#define LPC32XX_INTC_POLAR			0x0C
+#define LPC32XX_INTC_ACT_TYPE			0x10
+#define LPC32XX_INTC_TYPE			0x14
 
 /*
  *
diff --git a/arch/arm/mach-lpc32xx/irq.c b/arch/arm/mach-lpc32xx/irq.c
index 3e45d32..3ac8b4d 100644
--- a/arch/arm/mach-lpc32xx/irq.c
+++ b/arch/arm/mach-lpc32xx/irq.c
@@ -68,9 +68,9 @@ static void lpc32xx_mask_irq(unsigned int irq)
 
 	get_controller(irq, &ctrl, &mask);
 
-	reg = readl(ctrl + INTC_MASK);
+	reg = readl(ctrl + LPC32XX_INTC_MASK);
 	reg &= ~mask;
-	writel(reg, (ctrl + INTC_MASK));
+	writel(reg, (ctrl + LPC32XX_INTC_MASK));
 }
 
 static void lpc32xx_unmask_irq(unsigned int irq)
@@ -79,9 +79,9 @@ static void lpc32xx_unmask_irq(unsigned int irq)
 
 	get_controller(irq, &ctrl, &mask);
 
-	reg = readl(ctrl + INTC_MASK);
+	reg = readl(ctrl + LPC32XX_INTC_MASK);
 	reg |= mask;
-	writel(reg, (ctrl + INTC_MASK));
+	writel(reg, (ctrl + LPC32XX_INTC_MASK));
 }
 
 static void lpc32xx_mask_ack_irq(unsigned int irq)
@@ -90,7 +90,7 @@ static void lpc32xx_mask_ack_irq(unsigned int irq)
 
 	get_controller(irq, &ctrl, &mask);
 
-	writel(mask, (ctrl + INTC_RAW_STAT));
+	writel(mask, (ctrl + LPC32XX_INTC_RAW_STAT));
 }
 
 static int lpc32xx_set_irq_type(unsigned int irq, unsigned int type)
@@ -102,45 +102,45 @@ static int lpc32xx_set_irq_type(unsigned int irq, unsigned int type)
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
 		/* Rising edge sensitive */
-		reg = readl(ctrl + INTC_POLAR);
+		reg = readl(ctrl + LPC32XX_INTC_POLAR);
 		reg |= mask;
-		writel(reg, (ctrl + INTC_POLAR));
-		reg = readl(ctrl + INTC_ACT_TYPE);
+		writel(reg, (ctrl + LPC32XX_INTC_POLAR));
+		reg = readl(ctrl + LPC32XX_INTC_ACT_TYPE);
 		reg |= mask;
-		writel(reg, (ctrl + INTC_ACT_TYPE));
+		writel(reg, (ctrl + LPC32XX_INTC_ACT_TYPE));
 		set_irq_handler(irq, handle_edge_irq);
 		break;
 
 	case IRQ_TYPE_EDGE_FALLING:
 		/* Falling edge sensitive */
-		reg = readl(ctrl + INTC_POLAR);
+		reg = readl(ctrl + LPC32XX_INTC_POLAR);
 		reg &= ~mask;
-		writel(reg, (ctrl + INTC_POLAR));
-		reg = readl(ctrl + INTC_ACT_TYPE);
+		writel(reg, (ctrl + LPC32XX_INTC_POLAR));
+		reg = readl(ctrl + LPC32XX_INTC_ACT_TYPE);
 		reg |= mask;
-		writel(reg, (ctrl + INTC_ACT_TYPE));
+		writel(reg, (ctrl + LPC32XX_INTC_ACT_TYPE));
 		set_irq_handler(irq, handle_edge_irq);
 		break;
 
 	case IRQ_TYPE_LEVEL_LOW:
 		/* Low level sensitive */
-		reg = readl(ctrl + INTC_POLAR);
+		reg = readl(ctrl + LPC32XX_INTC_POLAR);
 		reg &= ~mask;
-		writel(reg, (ctrl + INTC_POLAR));
-		reg = readl(ctrl + INTC_ACT_TYPE);
+		writel(reg, (ctrl + LPC32XX_INTC_POLAR));
+		reg = readl(ctrl + LPC32XX_INTC_ACT_TYPE);
 		reg &= ~mask;
-		writel(reg, (ctrl + INTC_ACT_TYPE));
+		writel(reg, (ctrl + LPC32XX_INTC_ACT_TYPE));
 		set_irq_handler(irq, handle_level_irq);
 		break;
 
 	case IRQ_TYPE_LEVEL_HIGH:
 		/* High level sensitive */
-		reg = readl(ctrl + INTC_POLAR);
+		reg = readl(ctrl + LPC32XX_INTC_POLAR);
 		reg |= mask;
-		writel(reg, (ctrl + INTC_POLAR));
-		reg = readl(ctrl + INTC_ACT_TYPE);
+		writel(reg, (ctrl + LPC32XX_INTC_POLAR));
+		reg = readl(ctrl + LPC32XX_INTC_ACT_TYPE);
 		reg &= ~mask;
-		writel(reg, (ctrl + INTC_ACT_TYPE));
+		writel(reg, (ctrl + LPC32XX_INTC_ACT_TYPE));
 		set_irq_handler(irq, handle_level_irq);
 		break;
 
@@ -198,21 +198,21 @@ void __init lpc32xx_init_irq(void)
 
 	/* Setup MIC */
 	vloc = io_p2v(LPC32XX_MIC_BASE);
-	writel(0, (vloc + INTC_MASK));
-	writel(MIC_APR_DEFAULT, (vloc + INTC_POLAR));
-	writel(MIC_ATR_DEFAULT, (vloc + INTC_ACT_TYPE));
+	writel(0, (vloc + LPC32XX_INTC_MASK));
+	writel(MIC_APR_DEFAULT, (vloc + LPC32XX_INTC_POLAR));
+	writel(MIC_ATR_DEFAULT, (vloc + LPC32XX_INTC_ACT_TYPE));
 
 	/* Setup SIC1 */
 	vloc = io_p2v(LPC32XX_SIC1_BASE);
-	writel(0, (vloc + INTC_MASK));
-	writel(SIC1_APR_DEFAULT, (vloc + INTC_POLAR));
-	writel(SIC1_ATR_DEFAULT, (vloc + INTC_ACT_TYPE));
+	writel(0, (vloc + LPC32XX_INTC_MASK));
+	writel(SIC1_APR_DEFAULT, (vloc + LPC32XX_INTC_POLAR));
+	writel(SIC1_ATR_DEFAULT, (vloc + LPC32XX_INTC_ACT_TYPE));
 
 	/* Setup SIC2 */
 	vloc = io_p2v(LPC32XX_SIC2_BASE);
-	writel(0, (vloc + INTC_MASK));
-	writel(SIC2_APR_DEFAULT, (vloc + INTC_POLAR));
-	writel(SIC2_ATR_DEFAULT, (vloc + INTC_ACT_TYPE));
+	writel(0, (vloc + LPC32XX_INTC_MASK));
+	writel(SIC2_APR_DEFAULT, (vloc + LPC32XX_INTC_POLAR));
+	writel(SIC2_ATR_DEFAULT, (vloc + LPC32XX_INTC_ACT_TYPE));
 
 	/* Configure supported IRQ's */
 	for (i = 0; i < NR_IRQS; i++) {
@@ -229,8 +229,9 @@ void __init lpc32xx_init_irq(void)
 		SIC2_APR_DEFAULT, SIC2_ATR_DEFAULT, 64);
 
 	/* mask all interrupts except SUBIRQA and SUBFIQ */
-	writel((1 << IRQ_SUB1IRQ) | (1 << IRQ_SUB2IRQ) | (1 << IRQ_SUB1FIQ) |
-		(1 << IRQ_SUB2FIQ), (io_p2v(LPC32XX_MIC_BASE) + INTC_MASK));
-	writel(0, (io_p2v(LPC32XX_SIC1_BASE) + INTC_MASK));
-	writel(0, (io_p2v(LPC32XX_SIC2_BASE) + INTC_MASK));
+	writel((1 << IRQ_SUB1IRQ) | (1 << IRQ_SUB2IRQ) |
+		(1 << IRQ_SUB1FIQ) | (1 << IRQ_SUB2FIQ),
+		(io_p2v(LPC32XX_MIC_BASE) + LPC32XX_INTC_MASK));
+	writel(0, (io_p2v(LPC32XX_SIC1_BASE) + LPC32XX_INTC_MASK));
+	writel(0, (io_p2v(LPC32XX_SIC2_BASE) + LPC32XX_INTC_MASK));
 }
-- 
1.6.6
