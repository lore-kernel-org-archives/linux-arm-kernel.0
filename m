From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 22 Sep 2011 15:46:56 +0200
Subject: [PATCH 6/7] ARM: plat-nomadik: timer: Export reset functions
Message-ID: <1316699216-21426-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Aaberg <jonas.aberg@stericsson.com>

We make the reset function from the driver public, then
we also move of all register defines from the public header
file into driver, where they belong.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Jonas Aaberg <jonas.aberg@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/plat-nomadik/include/plat/mtu.h |   47 +---------------------------
 arch/arm/plat-nomadik/timer.c            |   50 ++++++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 48 deletions(-)

diff --git a/arch/arm/plat-nomadik/include/plat/mtu.h b/arch/arm/plat-nomadik/include/plat/mtu.h
index 65704a3..6508e76 100644
--- a/arch/arm/plat-nomadik/include/plat/mtu.h
+++ b/arch/arm/plat-nomadik/include/plat/mtu.h
@@ -1,54 +1,11 @@
 #ifndef __PLAT_MTU_H
 #define __PLAT_MTU_H
 
-/*
- * Guaranteed runtime conversion range in seconds for
- * the clocksource and clockevent.
- */
-#define MTU_MIN_RANGE 4
-
 /* should be set by the platform code */
 extern void __iomem *mtu_base;
 
-/*
- * The MTU device hosts four different counters, with 4 set of
- * registers. These are register names.
- */
-
-#define MTU_IMSC	0x00	/* Interrupt mask set/clear */
-#define MTU_RIS		0x04	/* Raw interrupt status */
-#define MTU_MIS		0x08	/* Masked interrupt status */
-#define MTU_ICR		0x0C	/* Interrupt clear register */
-
-/* per-timer registers take 0..3 as argument */
-#define MTU_LR(x)	(0x10 + 0x10 * (x) + 0x00)	/* Load value */
-#define MTU_VAL(x)	(0x10 + 0x10 * (x) + 0x04)	/* Current value */
-#define MTU_CR(x)	(0x10 + 0x10 * (x) + 0x08)	/* Control reg */
-#define MTU_BGLR(x)	(0x10 + 0x10 * (x) + 0x0c)	/* At next overflow */
-
-/* bits for the control register */
-#define MTU_CRn_ENA		0x80
-#define MTU_CRn_PERIODIC	0x40	/* if 0 = free-running */
-#define MTU_CRn_PRESCALE_MASK	0x0c
-#define MTU_CRn_PRESCALE_1		0x00
-#define MTU_CRn_PRESCALE_16		0x04
-#define MTU_CRn_PRESCALE_256		0x08
-#define MTU_CRn_32BITS		0x02
-#define MTU_CRn_ONESHOT		0x01	/* if 0 = wraps reloading from BGLR*/
-
-/* Other registers are usual amba/primecell registers, currently not used */
-#define MTU_ITCR	0xff0
-#define MTU_ITOP	0xff4
-
-#define MTU_PERIPH_ID0	0xfe0
-#define MTU_PERIPH_ID1	0xfe4
-#define MTU_PERIPH_ID2	0xfe8
-#define MTU_PERIPH_ID3	0xfeC
-
-#define MTU_PCELL0	0xff0
-#define MTU_PCELL1	0xff4
-#define MTU_PCELL2	0xff8
-#define MTU_PCELL3	0xffC
+void nmdk_clkevt_reset(void);
+void nmdk_clksrc_reset(void);
 
 #endif /* __PLAT_MTU_H */
 
diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index a04b521..30b6433 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -21,7 +21,51 @@
 #include <asm/mach/time.h>
 #include <asm/sched_clock.h>
 
-#include <plat/mtu.h>
+/*
+ * Guaranteed runtime conversion range in seconds for
+ * the clocksource and clockevent.
+ */
+#define MTU_MIN_RANGE 4
+
+/*
+ * The MTU device hosts four different counters, with 4 set of
+ * registers. These are register names.
+ */
+
+#define MTU_IMSC	0x00	/* Interrupt mask set/clear */
+#define MTU_RIS		0x04	/* Raw interrupt status */
+#define MTU_MIS		0x08	/* Masked interrupt status */
+#define MTU_ICR		0x0C	/* Interrupt clear register */
+
+/* per-timer registers take 0..3 as argument */
+#define MTU_LR(x)	(0x10 + 0x10 * (x) + 0x00)	/* Load value */
+#define MTU_VAL(x)	(0x10 + 0x10 * (x) + 0x04)	/* Current value */
+#define MTU_CR(x)	(0x10 + 0x10 * (x) + 0x08)	/* Control reg */
+#define MTU_BGLR(x)	(0x10 + 0x10 * (x) + 0x0c)	/* At next overflow */
+
+/* bits for the control register */
+#define MTU_CRn_ENA		0x80
+#define MTU_CRn_PERIODIC	0x40	/* if 0 = free-running */
+#define MTU_CRn_PRESCALE_MASK	0x0c
+#define MTU_CRn_PRESCALE_1		0x00
+#define MTU_CRn_PRESCALE_16		0x04
+#define MTU_CRn_PRESCALE_256		0x08
+#define MTU_CRn_32BITS		0x02
+#define MTU_CRn_ONESHOT		0x01	/* if 0 = wraps reloading from BGLR*/
+
+/* Other registers are usual amba/primecell registers, currently not used */
+#define MTU_ITCR	0xff0
+#define MTU_ITOP	0xff4
+
+#define MTU_PERIPH_ID0	0xfe0
+#define MTU_PERIPH_ID1	0xfe4
+#define MTU_PERIPH_ID2	0xfe8
+#define MTU_PERIPH_ID3	0xfeC
+
+#define MTU_PCELL0	0xff0
+#define MTU_PCELL1	0xff4
+#define MTU_PCELL2	0xff8
+#define MTU_PCELL3	0xffC
 
 static bool clkevt_periodic;
 static u32 clk_prescale;
@@ -68,7 +112,7 @@ static int nmdk_clkevt_next(unsigned long evt, struct clock_event_device *ev)
 	return 0;
 }
 
-static void nmdk_clkevt_reset(void)
+void nmdk_clkevt_reset(void)
 {
 	if (clkevt_periodic) {
 
@@ -138,7 +182,7 @@ static struct irqaction nmdk_timer_irq = {
 	.dev_id		= &nmdk_clkevt,
 };
 
-static void nmdk_clksrc_reset(void)
+void nmdk_clksrc_reset(void)
 {
 	/* Disable */
 	writel(0, mtu_base + MTU_CR(0));
-- 
1.7.3.2
