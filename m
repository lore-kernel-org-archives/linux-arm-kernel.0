From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 30 Mar 2010 12:32:17 -0500
Subject: [PATCH] vic: factor out common init code
In-Reply-To: <63386a3d1003250120m2d33233h60b202724a643a71@mail.gmail.com>
References: <AcrG7twc5wXJWTzzQtezYQpL1OiKYw==>
	<0D753D10438DA54287A00B02708426976368AC7704@AUSP01VMBX24.collaborationhost.net>
	<63386a3d1003250120m2d33233h60b202724a643a71@mail.gmail.com>
Message-ID: <0D753D10438DA54287A00B0270842697636915380E@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 25, 2010 1:20 AM, Linus Walleij wrote:
> 2010/3/19 H Hartley Sweeten <hartleys@visionengravers.com>:
>
>> This factors out the common initialization code for the two vic
>> vendors into easier maintainable functions.
>
> Sorry for the delay. Tested this on U300 and it works like a charm,
> good patch.
>
> Tested-by: Linus Walleij <linus.walleij@stericsson.com>

Are there any more comments/tested-by's on this patch?

Regards,
Hartley

---

This factors out the common initialization code for the two vic
vendors into easier maintainable functions.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Tested-by: Linus Walleij <linus.walleij@stericsson.com>
Cc: Alessandro Rubini <rubini@unipv.it>
Cc: Andrea Gallo <andrea.gallo@stericsson.com>
Cc: Ben Dooks <ben-linux@fluff.org>

---

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index 1cf999a..ba65f6e 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -266,13 +266,53 @@ static int vic_set_wake(unsigned int irq, unsigned int on)
 #endif /* CONFIG_PM */
 
 static struct irq_chip vic_chip = {
-	.name	= "VIC",
-	.ack	= vic_ack_irq,
-	.mask	= vic_mask_irq,
-	.unmask	= vic_unmask_irq,
-	.set_wake = vic_set_wake,
+	.name		= "VIC",
+	.ack		= vic_ack_irq,
+	.mask		= vic_mask_irq,
+	.unmask		= vic_unmask_irq,
+	.set_wake	= vic_set_wake,
 };
 
+static void __init vic_disable(void __iomem *base)
+{
+	writel(0, base + VIC_INT_SELECT);
+	writel(0, base + VIC_INT_ENABLE);
+	writel(~0, base + VIC_INT_ENABLE_CLEAR);
+	writel(0, base + VIC_IRQ_STATUS);
+	writel(0, base + VIC_ITCR);
+	writel(~0, base + VIC_INT_SOFT_CLEAR);
+}
+
+static void __init vic_clear_interrupts(void __iomem *base)
+{
+	unsigned int i;
+
+	writel(0, base + VIC_PL190_VECT_ADDR);
+	for (i = 0; i < 19; i++) {
+		unsigned int value;
+
+		value = readl(base + VIC_PL190_VECT_ADDR);
+		writel(value, base + VIC_PL190_VECT_ADDR);
+	}
+}
+
+static void __init vic_set_irq_sources(void __iomem *base,
+				unsigned int irq_start, u32 vic_sources)
+{
+	unsigned int i;
+
+	for (i = 0; i < 32; i++) {
+		if (vic_sources & (1 << i)) {
+			unsigned int irq = irq_start + i;
+
+			set_irq_chip(irq, &vic_chip);
+			set_irq_chip_data(irq, base);
+			set_irq_handler(irq, handle_level_irq);
+			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
+		}
+	}
+}
+
 /*
  * The PL190 cell from ARM has been modified by ST to handle 64 interrupts.
  * The original cell has 32 interrupts, while the modified one has 64,
@@ -287,13 +327,7 @@ static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
 	int vic_2nd_block = ((unsigned long)base & ~PAGE_MASK) != 0;
 
 	/* Disable all interrupts initially. */
-
-	writel(0, base + VIC_INT_SELECT);
-	writel(0, base + VIC_INT_ENABLE);
-	writel(~0, base + VIC_INT_ENABLE_CLEAR);
-	writel(0, base + VIC_IRQ_STATUS);
-	writel(0, base + VIC_ITCR);
-	writel(~0, base + VIC_INT_SOFT_CLEAR);
+	vic_disable(base);
 
 	/*
 	 * Make sure we clear all existing interrupts. The vector registers
@@ -302,13 +336,8 @@ static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
 	 * the second base address, which is 0x20 in the page
 	 */
 	if (vic_2nd_block) {
-		writel(0, base + VIC_PL190_VECT_ADDR);
-		for (i = 0; i < 19; i++) {
-			unsigned int value;
+		vic_clear_interrupts(base);
 
-			value = readl(base + VIC_PL190_VECT_ADDR);
-			writel(value, base + VIC_PL190_VECT_ADDR);
-		}
 		/* ST has 16 vectors as well, but we don't enable them by now */
 		for (i = 0; i < 16; i++) {
 			void __iomem *reg = base + VIC_VECT_CNTL0 + (i * 4);
@@ -318,16 +347,7 @@ static void __init vic_init_st(void __iomem *base, unsigned int irq_start,
 		writel(32, base + VIC_PL190_DEF_VECT_ADDR);
 	}
 
-	for (i = 0; i < 32; i++) {
-		if (vic_sources & (1 << i)) {
-			unsigned int irq = irq_start + i;
-
-			set_irq_chip(irq, &vic_chip);
-			set_irq_chip_data(irq, base);
-			set_irq_handler(irq, handle_level_irq);
-			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-		}
-	}
+	vic_set_irq_sources(base, irq_start, vic_sources);
 }
 
 /**
@@ -365,37 +385,14 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
 	}
 
 	/* Disable all interrupts initially. */
+	vic_disable(base);
 
-	writel(0, base + VIC_INT_SELECT);
-	writel(0, base + VIC_INT_ENABLE);
-	writel(~0, base + VIC_INT_ENABLE_CLEAR);
-	writel(0, base + VIC_IRQ_STATUS);
-	writel(0, base + VIC_ITCR);
-	writel(~0, base + VIC_INT_SOFT_CLEAR);
-
-	/*
-	 * Make sure we clear all existing interrupts
-	 */
-	writel(0, base + VIC_PL190_VECT_ADDR);
-	for (i = 0; i < 19; i++) {
-		unsigned int value;
-
-		value = readl(base + VIC_PL190_VECT_ADDR);
-		writel(value, base + VIC_PL190_VECT_ADDR);
-	}
+	/* Make sure we clear all existing interrupts */
+	vic_clear_interrupts(base);
 
 	vic_init2(base);
 
-	for (i = 0; i < 32; i++) {
-		if (vic_sources & (1 << i)) {
-			unsigned int irq = irq_start + i;
-
-			set_irq_chip(irq, &vic_chip);
-			set_irq_chip_data(irq, base);
-			set_irq_handler(irq, handle_level_irq);
-			set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
-		}
-	}
+	vic_set_irq_sources(base, irq_start, vic_sources);
 
 	vic_pm_register(base, irq_start, resume_sources);
 }
