From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Sat,  6 Jun 2015 05:57:24 +0200
Subject: [PATCH 2/6] ARM:Gemini:move IOADDRESS() into #define's
In-Reply-To: <1433563048-21922-1-git-send-email-ulli.kroll@googlemail.com>
References: <1433563048-21922-1-git-send-email-ulli.kroll@googlemail.com>
Message-ID: <1433563048-21922-3-git-send-email-ulli.kroll@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For better code readability move IO_ADDRESS() into register definitions

Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
---
 arch/arm/mach-gemini/time.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-gemini/time.c b/arch/arm/mach-gemini/time.c
index d0bbd2f..76e3ca7 100644
--- a/arch/arm/mach-gemini/time.c
+++ b/arch/arm/mach-gemini/time.c
@@ -23,11 +23,11 @@
 #define GEMINI_TIMER2_BASE		(GEMINI_TIMER_BASE + 0x10)
 #define GEMINI_TIMER3_BASE		(GEMINI_TIMER_BASE + 0x20)
 
-#define TIMER_COUNT(BASE_ADDR)		(BASE_ADDR  + 0x00)
-#define TIMER_LOAD(BASE_ADDR)		(BASE_ADDR  + 0x04)
-#define TIMER_MATCH1(BASE_ADDR)		(BASE_ADDR  + 0x08)
-#define TIMER_MATCH2(BASE_ADDR)		(BASE_ADDR  + 0x0C)
-#define TIMER_CR(BASE_ADDR)		(BASE_ADDR  + 0x30)
+#define TIMER_COUNT(BASE_ADDR)		(IO_ADDRESS(BASE_ADDR) + 0x00)
+#define TIMER_LOAD(BASE_ADDR)		(IO_ADDRESS(BASE_ADDR) + 0x04)
+#define TIMER_MATCH1(BASE_ADDR)		(IO_ADDRESS(BASE_ADDR) + 0x08)
+#define TIMER_MATCH2(BASE_ADDR)		(IO_ADDRESS(BASE_ADDR) + 0x0C)
+#define TIMER_CR(BASE_ADDR)		(IO_ADDRESS(BASE_ADDR) + 0x30)
 
 #define TIMER_1_CR_ENABLE		(1 << 0)
 #define TIMER_1_CR_CLOCK		(1 << 1)
@@ -46,19 +46,19 @@ static int gemini_timer_set_next_event(unsigned long cycles,
 {
 	u32 cr;
 
-	cr = readl(TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+	cr = readl(TIMER_CR(GEMINI_TIMER_BASE));
 
 	/* This may be overdoing it, feel free to test without this */
 	cr &= ~TIMER_2_CR_ENABLE;
 	cr &= ~TIMER_2_CR_INT;
-	writel(cr, TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+	writel(cr, TIMER_CR(GEMINI_TIMER_BASE));
 
 	/* Set next event */
-	writel(cycles, TIMER_COUNT(IO_ADDRESS(GEMINI_TIMER2_BASE)));
-	writel(cycles, TIMER_LOAD(IO_ADDRESS(GEMINI_TIMER2_BASE)));
+	writel(cycles, TIMER_COUNT(GEMINI_TIMER2_BASE));
+	writel(cycles, TIMER_LOAD(GEMINI_TIMER2_BASE));
 	cr |= TIMER_2_CR_ENABLE;
 	cr |= TIMER_2_CR_INT;
-	writel(cr, TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+	writel(cr, TIMER_CR(GEMINI_TIMER_BASE));
 
 	return 0;
 }
@@ -73,13 +73,13 @@ static void gemini_timer_set_mode(enum clock_event_mode mode,
         case CLOCK_EVT_MODE_PERIODIC:
 		/* Start the timer */
 		writel(period,
-		       TIMER_COUNT(IO_ADDRESS(GEMINI_TIMER2_BASE)));
+		       TIMER_COUNT(GEMINI_TIMER2_BASE));
 		writel(period,
-		       TIMER_LOAD(IO_ADDRESS(GEMINI_TIMER2_BASE)));
-		cr = readl(TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+		       TIMER_LOAD(GEMINI_TIMER2_BASE));
+		cr = readl(TIMER_CR(GEMINI_TIMER_BASE));
 		cr |= TIMER_2_CR_ENABLE;
 		cr |= TIMER_2_CR_INT;
-		writel(cr, TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+		writel(cr, TIMER_CR(GEMINI_TIMER_BASE));
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 	case CLOCK_EVT_MODE_UNUSED:
@@ -89,10 +89,10 @@ static void gemini_timer_set_mode(enum clock_event_mode mode,
 		 * Disable also for oneshot: the set_next() call will
 		 * arm the timer instead.
 		 */
-		cr = readl(TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+		cr = readl(TIMER_CR(GEMINI_TIMER_BASE));
 		cr &= ~TIMER_2_CR_ENABLE;
 		cr &= ~TIMER_2_CR_INT;
-		writel(cr, TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
+		writel(cr, TIMER_CR(GEMINI_TIMER_BASE));
 		break;
 	default:
                 break;
@@ -160,10 +160,10 @@ void __init gemini_timer_init(void)
 	setup_irq(IRQ_TIMER2, &gemini_timer_irq);
 
 	/* Enable and use TIMER1 as clock source */
-	writel(0xffffffff, TIMER_COUNT(IO_ADDRESS(GEMINI_TIMER1_BASE)));
-	writel(0xffffffff, TIMER_LOAD(IO_ADDRESS(GEMINI_TIMER1_BASE)));
-	writel(TIMER_1_CR_ENABLE, TIMER_CR(IO_ADDRESS(GEMINI_TIMER_BASE)));
-	if (clocksource_mmio_init(TIMER_COUNT(IO_ADDRESS(GEMINI_TIMER1_BASE)),
+	writel(0xffffffff, TIMER_COUNT(GEMINI_TIMER1_BASE));
+	writel(0xffffffff, TIMER_LOAD(GEMINI_TIMER1_BASE));
+	writel(TIMER_1_CR_ENABLE, TIMER_CR(GEMINI_TIMER_BASE));
+	if (clocksource_mmio_init(TIMER_COUNT(GEMINI_TIMER1_BASE),
 				  "TIMER1", tick_rate, 300, 32,
 				  clocksource_mmio_readl_up))
 		pr_err("timer: failed to initialize gemini clock source\n");
-- 
2.4.2
