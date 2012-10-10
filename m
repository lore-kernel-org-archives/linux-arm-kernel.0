From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 10 Oct 2012 19:45:29 +0400
Subject: [PATCH 3/7] ARM: clps711x: rework IRQ sybsustem initialization
In-Reply-To: <1349883933-8881-1-git-send-email-shc_work@mail.ru>
References: <1349883933-8881-1-git-send-email-shc_work@mail.ru>
Message-ID: <1349883933-8881-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reworked IRQ subsystem to be able to use some interrupts
with "End of interrupt" handler.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/common.c            |   91 +++++++++++++++++++---------
 arch/arm/mach-clps711x/include/mach/irqs.h |    4 -
 2 files changed, 62 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index 218684f..38a18ee 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -66,6 +66,10 @@ static void int1_mask(struct irq_data *d)
 
 static void int1_ack(struct irq_data *d)
 {
+}
+
+static void int1_eoi(struct irq_data *d)
+{
 	switch (d->irq) {
 	case IRQ_CSINT:  clps_writel(0, COEOI);  break;
 	case IRQ_TC1OI:  clps_writel(0, TC1EOI); break;
@@ -86,7 +90,9 @@ static void int1_unmask(struct irq_data *d)
 }
 
 static struct irq_chip int1_chip = {
+	.name		= "Interrupt Vector 1  ",
 	.irq_ack	= int1_ack,
+	.irq_eoi	= int1_eoi,
 	.irq_mask	= int1_mask,
 	.irq_unmask	= int1_unmask,
 };
@@ -102,6 +108,10 @@ static void int2_mask(struct irq_data *d)
 
 static void int2_ack(struct irq_data *d)
 {
+}
+
+static void int2_eoi(struct irq_data *d)
+{
 	switch (d->irq) {
 	case IRQ_KBDINT: clps_writel(0, KBDEOI); break;
 	}
@@ -117,45 +127,68 @@ static void int2_unmask(struct irq_data *d)
 }
 
 static struct irq_chip int2_chip = {
+	.name		= "Interrupt Vector 2  ",
 	.irq_ack	= int2_ack,
+	.irq_eoi	= int2_eoi,
 	.irq_mask	= int2_mask,
 	.irq_unmask	= int2_unmask,
 };
 
+struct clps711x_irqdesc {
+	int			nr;
+	struct irq_chip		*chip;
+	irq_flow_handler_t	handle;
+};
+
+static struct clps711x_irqdesc clps711x_irqdescs[] __initdata = {
+	{ IRQ_CSINT,	&int1_chip,	handle_fasteoi_irq,	},
+	{ IRQ_EINT1,	&int1_chip,	handle_level_irq,	},
+	{ IRQ_EINT2,	&int1_chip,	handle_level_irq,	},
+	{ IRQ_EINT3,	&int1_chip,	handle_level_irq,	},
+	{ IRQ_TC1OI,	&int1_chip,	handle_fasteoi_irq,	},
+	{ IRQ_TC2OI,	&int1_chip,	handle_fasteoi_irq,	},
+	{ IRQ_RTCMI,	&int1_chip,	handle_fasteoi_irq,	},
+	{ IRQ_TINT,	&int1_chip,	handle_fasteoi_irq,	},
+	{ IRQ_UTXINT1,	&int1_chip,	handle_level_irq,	},
+	{ IRQ_URXINT1,	&int1_chip,	handle_level_irq,	},
+	{ IRQ_UMSINT,	&int1_chip,	handle_fasteoi_irq,	},
+	{ IRQ_SSEOTI,	&int1_chip,	handle_level_irq,	},
+	{ IRQ_KBDINT,	&int2_chip,	handle_fasteoi_irq,	},
+	{ IRQ_SS2RX,	&int2_chip,	handle_level_irq,	},
+	{ IRQ_SS2TX,	&int2_chip,	handle_level_irq,	},
+	{ IRQ_UTXINT2,	&int2_chip,	handle_level_irq,	},
+	{ IRQ_URXINT2,	&int2_chip,	handle_level_irq,	},
+};
+
 void __init clps711x_init_irq(void)
 {
 	unsigned int i;
 
-	for (i = 0; i < NR_IRQS; i++) {
-	        if (INT1_IRQS & (1 << i)) {
-			irq_set_chip_and_handler(i, &int1_chip,
-						 handle_level_irq);
-			set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
-		}
-		if (INT2_IRQS & (1 << i)) {
-			irq_set_chip_and_handler(i, &int2_chip,
-						 handle_level_irq);
-			set_irq_flags(i, IRQF_VALID | IRQF_PROBE);
-		}
+	/* Disable interrupts */
+ 	clps_writel(0, INTMR1);
+ 	clps_writel(0, INTMR2);
+	clps_writel(0, INTMR3);
+
+	/* Clear down any pending interrupts */
+	clps_writel(0, BLEOI);
+	clps_writel(0, MCEOI);
+ 	clps_writel(0, COEOI);
+ 	clps_writel(0, TC1EOI);
+ 	clps_writel(0, TC2EOI);
+ 	clps_writel(0, RTCEOI);
+ 	clps_writel(0, TEOI);
+ 	clps_writel(0, UMSEOI);
+ 	clps_writel(0, KBDEOI);
+	clps_writel(0, SRXEOF);
+	clps_writel(0xffffffff, DAISR);
+
+	for (i = 0; i < ARRAY_SIZE(clps711x_irqdescs); i++) {
+		irq_set_chip_and_handler(clps711x_irqdescs[i].nr,
+					 clps711x_irqdescs[i].chip,
+					 clps711x_irqdescs[i].handle);
+		set_irq_flags(clps711x_irqdescs[i].nr,
+			      IRQF_VALID | IRQF_PROBE);
 	}
-
-	/*
-	 * Disable interrupts
-	 */
-	clps_writel(0, INTMR1);
-	clps_writel(0, INTMR2);
-
-	/*
-	 * Clear down any pending interrupts
-	 */
-	clps_writel(0, COEOI);
-	clps_writel(0, TC1EOI);
-	clps_writel(0, TC2EOI);
-	clps_writel(0, RTCEOI);
-	clps_writel(0, TEOI);
-	clps_writel(0, UMSEOI);
-	clps_writel(0, SYNCIO);
-	clps_writel(0, KBDEOI);
 }
 
 static void clps711x_clockevent_set_mode(enum clock_event_mode mode,
diff --git a/arch/arm/mach-clps711x/include/mach/irqs.h b/arch/arm/mach-clps711x/include/mach/irqs.h
index 14d215f..1ea56db 100644
--- a/arch/arm/mach-clps711x/include/mach/irqs.h
+++ b/arch/arm/mach-clps711x/include/mach/irqs.h
@@ -34,8 +34,6 @@
 #define IRQ_UMSINT			14
 #define IRQ_SSEOTI			15
 
-#define INT1_IRQS			(0x0000fff0)
-
 /*
  * Interrupts from INTSR2
  */
@@ -45,6 +43,4 @@
 #define IRQ_UTXINT2			(16+12)	/* bit 12 */
 #define IRQ_URXINT2			(16+13)	/* bit 13 */
 
-#define INT2_IRQS			(0x30070000)
-
 #define NR_IRQS				30
-- 
1.7.8.6
