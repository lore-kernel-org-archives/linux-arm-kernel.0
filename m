From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 6 Jan 2010 16:49:09 -0500
Subject: [PATCH] [ARM] mmp: fix irq handling in mmp2
Message-ID: <mailman.125.1262786809.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/include/mach/entry-macro.S |    4 ++--
 arch/arm/mach-mmp/irq-mmp2.c                 |   16 +++++++++++-----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/entry-macro.S
b/arch/arm/mach-mmp/include/mach/entry-macro.S
index 5f5c780..c42d9d4 100644
--- a/arch/arm/mach-mmp/include/mach/entry-macro.S
+++ b/arch/arm/mach-mmp/include/mach/entry-macro.S
@@ -16,8 +16,8 @@

 	.macro	get_irqnr_preamble, base, tmp
 	mrc	p15, 0, \tmp, c0, c0, 0		@ CPUID
-	and	\tmp, \tmp, #0xff0
-	cmp	\tmp, #0x580
+	and	\tmp, \tmp, #0xff00
+	cmp	\tmp, #0x5800
 	ldr	\base, =ICU_VIRT_BASE
 	addne	\base, \base, #0x10c		@ PJ1 AP INT SEL register
 	addeq	\base, \base, #0x104		@ PJ4 IRQ SEL register
diff --git a/arch/arm/mach-mmp/irq-mmp2.c b/arch/arm/mach-mmp/irq-mmp2.c
index 25b7c51..3493cab 100644
--- a/arch/arm/mach-mmp/irq-mmp2.c
+++ b/arch/arm/mach-mmp/irq-mmp2.c
@@ -45,7 +45,7 @@ static struct irq_chip icu_irq_chip = {
 static void _name_##_mask_irq(unsigned int irq)				\
 {									\
 	uint32_t r;							\
-	r = __raw_readl(prefix##_MASK) & ~(1 << (irq - (irq_base)));	\
+	r = __raw_readl(prefix##_MASK) | (1 << (irq - irq_base));	\
 	__raw_writel(r, prefix##_MASK);					\
 }

@@ -53,7 +53,7 @@ static void _name_##_mask_irq(unsigned int irq)				\
 static void _name_##_unmask_irq(unsigned int irq)			\
 {									\
 	uint32_t r;							\
-	r = __raw_readl(prefix##_MASK) | (1 << (irq - (irq_base)));	\
+	r = __raw_readl(prefix##_MASK) & ~(1 << (irq - irq_base));	\
 	__raw_writel(r, prefix##_MASK);					\
 }

@@ -63,12 +63,12 @@ static void _name_##_irq_demux(unsigned int irq,
struct irq_desc *desc)	\
 	unsigned long status, mask, n;					\
 	mask = __raw_readl(prefix##_MASK);				\
 	while (1) {							\
-		status = __raw_readl(prefix##_STATUS) & mask;		\
+		status = __raw_readl(prefix##_STATUS) & ~mask;		\
 		if (status == 0)					\
 			break;						\
 		n = find_first_bit(&status, BITS_PER_LONG);		\
 		while (n < BITS_PER_LONG) {				\
-			generic_handle_irq((irq_base) + n);		\
+			generic_handle_irq(irq_base + n);		\
 			n = find_next_bit(&status, BITS_PER_LONG, n+1);	\
 		}							\
 	}								\
@@ -95,7 +95,7 @@ static void init_mux_irq(struct irq_chip *chip, int
start, int num)
 	int irq;

 	for (irq = start; num > 0; irq++, num--) {
-		chip->mask(irq);
+		chip->mask_ack(irq);
 		set_irq_chip(irq, chip);
 		set_irq_flags(irq, IRQF_VALID);
 		set_irq_handler(irq, handle_level_irq);
@@ -135,4 +135,10 @@ void __init mmp2_init_irq(void)
 	set_irq_chained_handler(IRQ_MMP2_TWSI_MUX, twsi_irq_demux);
 	set_irq_chained_handler(IRQ_MMP2_MISC_MUX, misc_irq_demux);
 	set_irq_chained_handler(IRQ_MMP2_SSP_MUX, ssp_irq_demux);
+
+	icu_unmask_irq(IRQ_MMP2_PMIC_MUX);
+	icu_unmask_irq(IRQ_MMP2_RTC_MUX);
+	icu_unmask_irq(IRQ_MMP2_TWSI_MUX);
+	icu_unmask_irq(IRQ_MMP2_MISC_MUX);
+	icu_unmask_irq(IRQ_MMP2_SSP_MUX);
 }
-- 
1.5.6.5
