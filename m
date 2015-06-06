From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Sat,  6 Jun 2015 05:57:26 +0200
Subject: [PATCH 4/6] ARM:Gemini:remove index for timer control register
In-Reply-To: <1433563048-21922-1-git-send-email-ulli.kroll@googlemail.com>
References: <1433563048-21922-1-git-send-email-ulli.kroll@googlemail.com>
Message-ID: <1433563048-21922-5-git-send-email-ulli.kroll@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TIMER_CR register control all three timer. No need for a index.

Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
---
 arch/arm/mach-gemini/time.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-gemini/time.c b/arch/arm/mach-gemini/time.c
index a8604a3..e919b96 100644
--- a/arch/arm/mach-gemini/time.c
+++ b/arch/arm/mach-gemini/time.c
@@ -27,7 +27,7 @@
 #define TIMER_LOAD(BASE_ADDR)		(IO_ADDRESS(BASE_ADDR) + 0x04)
 #define TIMER_MATCH1(BASE_ADDR)		(IO_ADDRESS(BASE_ADDR) + 0x08)
 #define TIMER_MATCH2(BASE_ADDR)		(IO_ADDRESS(BASE_ADDR) + 0x0C)
-#define TIMER_CR(BASE_ADDR)		(IO_ADDRESS(BASE_ADDR) + 0x30)
+#define TIMER_CR			(IO_ADDRESS(GEMINI_TIMER_BASE) + 0x30)
 #define TIMER_INTR_STATE		(IO_ADDRESS(GEMINI_TIMER_BASE) + 0x34)
 #define TIMER_INTR_MASK			(IO_ADDRESS(GEMINI_TIMER_BASE) + 0x38)
 
@@ -63,19 +63,19 @@ static int gemini_timer_set_next_event(unsigned long cycles,
 {
 	u32 cr;
 
-	cr = readl(TIMER_CR(GEMINI_TIMER_BASE));
+	cr = readl(TIMER_CR);
 
 	/* This may be overdoing it, feel free to test without this */
 	cr &= ~TIMER_2_CR_ENABLE;
 	cr &= ~TIMER_2_CR_INT;
-	writel(cr, TIMER_CR(GEMINI_TIMER_BASE));
+	writel(cr, TIMER_CR);
 
 	/* Set next event */
 	writel(cycles, TIMER_COUNT(GEMINI_TIMER2_BASE));
 	writel(cycles, TIMER_LOAD(GEMINI_TIMER2_BASE));
 	cr |= TIMER_2_CR_ENABLE;
 	cr |= TIMER_2_CR_INT;
-	writel(cr, TIMER_CR(GEMINI_TIMER_BASE));
+	writel(cr, TIMER_CR);
 
 	return 0;
 }
@@ -93,10 +93,10 @@ static void gemini_timer_set_mode(enum clock_event_mode mode,
 		       TIMER_COUNT(GEMINI_TIMER2_BASE));
 		writel(period,
 		       TIMER_LOAD(GEMINI_TIMER2_BASE));
-		cr = readl(TIMER_CR(GEMINI_TIMER_BASE));
+		cr = readl(TIMER_CR);
 		cr |= TIMER_2_CR_ENABLE;
 		cr |= TIMER_2_CR_INT;
-		writel(cr, TIMER_CR(GEMINI_TIMER_BASE));
+		writel(cr, TIMER_CR);
 		break;
 	case CLOCK_EVT_MODE_ONESHOT:
 	case CLOCK_EVT_MODE_UNUSED:
@@ -106,10 +106,10 @@ static void gemini_timer_set_mode(enum clock_event_mode mode,
 		 * Disable also for oneshot: the set_next() call will
 		 * arm the timer instead.
 		 */
-		cr = readl(TIMER_CR(GEMINI_TIMER_BASE));
+		cr = readl(TIMER_CR);
 		cr &= ~TIMER_2_CR_ENABLE;
 		cr &= ~TIMER_2_CR_INT;
-		writel(cr, TIMER_CR(GEMINI_TIMER_BASE));
+		writel(cr, TIMER_CR);
 		break;
 	default:
                 break;
@@ -179,7 +179,7 @@ void __init gemini_timer_init(void)
 	/* Enable and use TIMER1 as clock source */
 	writel(0xffffffff, TIMER_COUNT(GEMINI_TIMER1_BASE));
 	writel(0xffffffff, TIMER_LOAD(GEMINI_TIMER1_BASE));
-	writel(TIMER_1_CR_ENABLE, TIMER_CR(GEMINI_TIMER_BASE));
+	writel(TIMER_1_CR_ENABLE, TIMER_CR);
 	if (clocksource_mmio_init(TIMER_COUNT(GEMINI_TIMER1_BASE),
 				  "TIMER1", tick_rate, 300, 32,
 				  clocksource_mmio_readl_up))
-- 
2.4.2
