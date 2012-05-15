From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 15 May 2012 21:55:01 +0400
Subject: [PATCH 1/2] ARM: clps711x: Cleanup IRQ handling
In-Reply-To: <1337104502-5292-1-git-send-email-shc_work@mail.ru>
References: <1337104502-5292-1-git-send-email-shc_work@mail.ru>
Message-ID: <1337104502-5292-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch contains two changes:
- Removed unused definitions from mach/irqs.h
- Do not mask interrupts in ack procedure, because we have separate
  intX_mask procedure for do it and actually these 2 functions are
  called sequentially

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/common.c            |   12 ------------
 arch/arm/mach-clps711x/include/mach/irqs.h |    5 +----
 2 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-clps711x/common.c b/arch/arm/mach-clps711x/common.c
index b6dfd2f..c965fd8 100644
--- a/arch/arm/mach-clps711x/common.c
+++ b/arch/arm/mach-clps711x/common.c
@@ -66,12 +66,6 @@ static void int1_mask(struct irq_data *d)
 
 static void int1_ack(struct irq_data *d)
 {
-	u32 intmr1;
-
-	intmr1 = clps_readl(INTMR1);
-	intmr1 &= ~(1 << d->irq);
-	clps_writel(intmr1, INTMR1);
-
 	switch (d->irq) {
 	case IRQ_CSINT:  clps_writel(0, COEOI);  break;
 	case IRQ_TC1OI:  clps_writel(0, TC1EOI); break;
@@ -108,12 +102,6 @@ static void int2_mask(struct irq_data *d)
 
 static void int2_ack(struct irq_data *d)
 {
-	u32 intmr2;
-
-	intmr2 = clps_readl(INTMR2);
-	intmr2 &= ~(1 << (d->irq - 16));
-	clps_writel(intmr2, INTMR2);
-
 	switch (d->irq) {
 	case IRQ_KBDINT: clps_writel(0, KBDEOI); break;
 	}
diff --git a/arch/arm/mach-clps711x/include/mach/irqs.h b/arch/arm/mach-clps711x/include/mach/irqs.h
index 30b7e97..14d215f 100644
--- a/arch/arm/mach-clps711x/include/mach/irqs.h
+++ b/arch/arm/mach-clps711x/include/mach/irqs.h
@@ -35,7 +35,6 @@
 #define IRQ_SSEOTI			15
 
 #define INT1_IRQS			(0x0000fff0)
-#define INT1_ACK_IRQS			(0x00004f10)
 
 /*
  * Interrupts from INTSR2
@@ -47,7 +46,5 @@
 #define IRQ_URXINT2			(16+13)	/* bit 13 */
 
 #define INT2_IRQS			(0x30070000)
-#define INT2_ACK_IRQS			(0x00010000)
-
-#define NR_IRQS                         30
 
+#define NR_IRQS				30
-- 
1.7.3.4
