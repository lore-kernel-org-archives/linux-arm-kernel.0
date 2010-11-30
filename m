From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Tue, 30 Nov 2010 14:36:59 +0100
Subject: [PATCH 29/54] ARM: mmp: irq_data conversion.
In-Reply-To: <cover.1291118519.git.buytenh@wantstofly.org>
References: <cover.1291118519.git.buytenh@wantstofly.org>
Message-ID: <20101130133659.GD15575@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
 arch/arm/mach-mmp/irq-mmp2.c   |   46 ++++++++++++++++++++-------------------
 arch/arm/mach-mmp/irq-pxa168.c |   18 +++++++-------
 2 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-mmp/irq-mmp2.c b/arch/arm/mach-mmp/irq-mmp2.c
index 01342be..fa03703 100644
--- a/arch/arm/mach-mmp/irq-mmp2.c
+++ b/arch/arm/mach-mmp/irq-mmp2.c
@@ -20,48 +20,48 @@
 
 #include "common.h"
 
-static void icu_mask_irq(unsigned int irq)
+static void icu_mask_irq(struct irq_data *d)
 {
-	uint32_t r = __raw_readl(ICU_INT_CONF(irq));
+	uint32_t r = __raw_readl(ICU_INT_CONF(d->irq));
 
 	r &= ~ICU_INT_ROUTE_PJ4_IRQ;
-	__raw_writel(r, ICU_INT_CONF(irq));
+	__raw_writel(r, ICU_INT_CONF(d->irq));
 }
 
-static void icu_unmask_irq(unsigned int irq)
+static void icu_unmask_irq(struct irq_data *d)
 {
-	uint32_t r = __raw_readl(ICU_INT_CONF(irq));
+	uint32_t r = __raw_readl(ICU_INT_CONF(d->irq));
 
 	r |= ICU_INT_ROUTE_PJ4_IRQ;
-	__raw_writel(r, ICU_INT_CONF(irq));
+	__raw_writel(r, ICU_INT_CONF(d->irq));
 }
 
 static struct irq_chip icu_irq_chip = {
 	.name		= "icu_irq",
-	.mask		= icu_mask_irq,
-	.mask_ack	= icu_mask_irq,
-	.unmask		= icu_unmask_irq,
+	.irq_mask	= icu_mask_irq,
+	.irq_mask_ack	= icu_mask_irq,
+	.irq_unmask	= icu_unmask_irq,
 };
 
-static void pmic_irq_ack(unsigned int irq)
+static void pmic_irq_ack(struct irq_data *d)
 {
-	if (irq == IRQ_MMP2_PMIC)
+	if (d->irq == IRQ_MMP2_PMIC)
 		mmp2_clear_pmic_int();
 }
 
 #define SECOND_IRQ_MASK(_name_, irq_base, prefix)			\
-static void _name_##_mask_irq(unsigned int irq)				\
+static void _name_##_mask_irq(struct irq_data *d)			\
 {									\
 	uint32_t r;							\
-	r = __raw_readl(prefix##_MASK) | (1 << (irq - irq_base));	\
+	r = __raw_readl(prefix##_MASK) | (1 << (d->irq - irq_base));	\
 	__raw_writel(r, prefix##_MASK);					\
 }
 
 #define SECOND_IRQ_UNMASK(_name_, irq_base, prefix)			\
-static void _name_##_unmask_irq(unsigned int irq)			\
+static void _name_##_unmask_irq(struct irq_data *d)			\
 {									\
 	uint32_t r;							\
-	r = __raw_readl(prefix##_MASK) & ~(1 << (irq - irq_base));	\
+	r = __raw_readl(prefix##_MASK) & ~(1 << (d->irq - irq_base));	\
 	__raw_writel(r, prefix##_MASK);					\
 }
 
@@ -88,8 +88,8 @@ SECOND_IRQ_UNMASK(_name_, irq_base, prefix)				\
 SECOND_IRQ_DEMUX(_name_, irq_base, prefix)				\
 static struct irq_chip _name_##_irq_chip = {				\
 	.name		= #_name_,					\
-	.mask		= _name_##_mask_irq,				\
-	.unmask		= _name_##_unmask_irq,				\
+	.irq_mask	= _name_##_mask_irq,				\
+	.irq_unmask	= _name_##_unmask_irq,				\
 }
 
 SECOND_IRQ_CHIP(pmic, IRQ_MMP2_PMIC_BASE, MMP2_ICU_INT4);
@@ -103,10 +103,12 @@ static void init_mux_irq(struct irq_chip *chip, int start, int num)
 	int irq;
 
 	for (irq = start; num > 0; irq++, num--) {
+		struct irq_data *d = irq_get_irq_data(irq);
+
 		/* mask and clear the IRQ */
-		chip->mask(irq);
-		if (chip->ack)
-			chip->ack(irq);
+		chip->irq_mask(d);
+		if (chip->irq_ack)
+			chip->irq_ack(d);
 
 		set_irq_chip(irq, chip);
 		set_irq_flags(irq, IRQF_VALID);
@@ -119,7 +121,7 @@ void __init mmp2_init_icu(void)
 	int irq;
 
 	for (irq = 0; irq < IRQ_MMP2_MUX_BASE; irq++) {
-		icu_mask_irq(irq);
+		icu_mask_irq(irq_get_irq_data(irq));
 		set_irq_chip(irq, &icu_irq_chip);
 		set_irq_flags(irq, IRQF_VALID);
 
@@ -139,7 +141,7 @@ void __init mmp2_init_icu(void)
 	/* NOTE: IRQ_MMP2_PMIC requires the PMIC MFPR register
 	 * to be written to clear the interrupt
 	 */
-	pmic_irq_chip.ack = pmic_irq_ack;
+	pmic_irq_chip.irq_ack = pmic_irq_ack;
 
 	init_mux_irq(&pmic_irq_chip, IRQ_MMP2_PMIC_BASE, 2);
 	init_mux_irq(&rtc_irq_chip, IRQ_MMP2_RTC_BASE, 2);
diff --git a/arch/arm/mach-mmp/irq-pxa168.c b/arch/arm/mach-mmp/irq-pxa168.c
index 52ff2f0..f86b450 100644
--- a/arch/arm/mach-mmp/irq-pxa168.c
+++ b/arch/arm/mach-mmp/irq-pxa168.c
@@ -25,21 +25,21 @@
 #define PRIORITY_DEFAULT	0x1
 #define PRIORITY_NONE		0x0	/* means IRQ disabled */
 
-static void icu_mask_irq(unsigned int irq)
+static void icu_mask_irq(struct irq_data *d)
 {
-	__raw_writel(PRIORITY_NONE, ICU_INT_CONF(irq));
+	__raw_writel(PRIORITY_NONE, ICU_INT_CONF(d->irq));
 }
 
-static void icu_unmask_irq(unsigned int irq)
+static void icu_unmask_irq(struct irq_data *d)
 {
-	__raw_writel(IRQ_ROUTE_TO_AP | PRIORITY_DEFAULT, ICU_INT_CONF(irq));
+	__raw_writel(IRQ_ROUTE_TO_AP | PRIORITY_DEFAULT, ICU_INT_CONF(d->irq));
 }
 
 static struct irq_chip icu_irq_chip = {
-	.name	= "icu_irq",
-	.ack	= icu_mask_irq,
-	.mask	= icu_mask_irq,
-	.unmask	= icu_unmask_irq,
+	.name		= "icu_irq",
+	.irq_ack	= icu_mask_irq,
+	.irq_mask	= icu_mask_irq,
+	.irq_unmask	= icu_unmask_irq,
 };
 
 void __init icu_init_irq(void)
@@ -47,7 +47,7 @@ void __init icu_init_irq(void)
 	int irq;
 
 	for (irq = 0; irq < 64; irq++) {
-		icu_mask_irq(irq);
+		icu_mask_irq(irq_get_irq_data(irq));
 		set_irq_chip(irq, &icu_irq_chip);
 		set_irq_handler(irq, handle_level_irq);
 		set_irq_flags(irq, IRQF_VALID);
-- 
1.7.1
