From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Sat,  6 Jun 2015 05:57:27 +0200
Subject: [PATCH 5/6] ARM:Gemini:use timer 1 as clockevent timer
In-Reply-To: <1433563048-21922-1-git-send-email-ulli.kroll@googlemail.com>
References: <1433563048-21922-1-git-send-email-ulli.kroll@googlemail.com>
Message-ID: <1433563048-21922-6-git-send-email-ulli.kroll@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is based on openwrt patch found in
target/linux/gemini/patches-3.18/160-gemini-timers.patch

It removes usage of timer 2 as clockevent timer and uses
timer 1.
Also setup the needed register for interrupt handling missed in
the initial patch

Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
---
 arch/arm/mach-gemini/time.c | 106 ++++++++++++++++++++++++++------------------
 1 file changed, 62 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-gemini/time.c b/arch/arm/mach-gemini/time.c
index e919b96..29ec2c3 100644
--- a/arch/arm/mach-gemini/time.c
+++ b/arch/arm/mach-gemini/time.c
@@ -63,19 +63,11 @@ static int gemini_timer_set_next_event(unsigned long cycles,
 {
 	u32 cr;
 
-	cr = readl(TIMER_CR);
-
-	/* This may be overdoing it, feel free to test without this */
-	cr &= ~TIMER_2_CR_ENABLE;
-	cr &= ~TIMER_2_CR_INT;
-	writel(cr, TIMER_CR);
-
-	/* Set next event */
-	writel(cycles, TIMER_COUNT(GEMINI_TIMER2_BASE));
-	writel(cycles, TIMER_LOAD(GEMINI_TIMER2_BASE));
-	cr |= TIMER_2_CR_ENABLE;
-	cr |= TIMER_2_CR_INT;
-	writel(cr, TIMER_CR);
+	/* Setup the match register */
+	cr = readl(TIMER_COUNT(GEMINI_TIMER1_BASE));
+	writel(cr + cycles, TIMER_MATCH1(GEMINI_TIMER1_BASE));
+	if (readl(TIMER_COUNT(GEMINI_TIMER1_BASE)) - cr > cycles)
+		return -ETIME;
 
 	return 0;
 }
@@ -87,32 +79,55 @@ static void gemini_timer_set_mode(enum clock_event_mode mode,
 	u32 cr;
 
 	switch (mode) {
-        case CLOCK_EVT_MODE_PERIODIC:
-		/* Start the timer */
-		writel(period,
-		       TIMER_COUNT(GEMINI_TIMER2_BASE));
-		writel(period,
-		       TIMER_LOAD(GEMINI_TIMER2_BASE));
+	case CLOCK_EVT_MODE_PERIODIC:
+		/* Stop timer and interrupt. */
+		cr = readl(TIMER_CR);
+		cr &= ~(TIMER_1_CR_ENABLE | TIMER_1_CR_INT);
+		writel(cr, TIMER_CR);
+
+		/* Setup timer to fire at 1/HZ intervals. */
+		cr = 0xffffffff - (period - 1);
+		writel(cr, TIMER_COUNT(GEMINI_TIMER1_BASE));
+		writel(cr, TIMER_LOAD(GEMINI_TIMER1_BASE));
+
+		/* enable interrupt on overflaw */
+		cr = readl(TIMER_INTR_MASK);
+		cr &= ~(TIMER_1_INT_MATCH1 | TIMER_1_INT_MATCH2);
+		cr |= TIMER_1_INT_OVERFLOW;
+		writel(cr, TIMER_INTR_MASK);
+
+		/* start the timer */
 		cr = readl(TIMER_CR);
-		cr |= TIMER_2_CR_ENABLE;
-		cr |= TIMER_2_CR_INT;
+		cr |= TIMER_1_CR_ENABLE | TIMER_1_CR_INT;
 		writel(cr, TIMER_CR);
 		break;
+
 	case CLOCK_EVT_MODE_ONESHOT:
 	case CLOCK_EVT_MODE_UNUSED:
-        case CLOCK_EVT_MODE_SHUTDOWN:
-	case CLOCK_EVT_MODE_RESUME:
-		/*
-		 * Disable also for oneshot: the set_next() call will
-		 * arm the timer instead.
-		 */
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		/* Stop timer and interrupt. */
+		cr = readl(TIMER_CR);
+		cr &= ~(TIMER_1_CR_ENABLE | TIMER_1_CR_INT);
+		writel(cr, TIMER_CR);
+
+		/* Setup counter start from 0 */
+		writel(0, TIMER_COUNT(GEMINI_TIMER1_BASE));
+		writel(0, TIMER_LOAD(GEMINI_TIMER1_BASE));
+
+		/* enable interrupt */
+		cr = readl(TIMER_INTR_MASK);
+		cr &= ~(TIMER_1_INT_OVERFLOW | TIMER_1_INT_MATCH2);
+		cr |= TIMER_1_INT_MATCH1;
+		writel(cr, TIMER_INTR_MASK);
+
+		/* start the timer */
 		cr = readl(TIMER_CR);
-		cr &= ~TIMER_2_CR_ENABLE;
-		cr &= ~TIMER_2_CR_INT;
+		cr |= TIMER_1_CR_ENABLE;
 		writel(cr, TIMER_CR);
 		break;
-	default:
-                break;
+
+	case CLOCK_EVT_MODE_RESUME:
+		break;
 	}
 }
 
@@ -120,6 +135,7 @@ static void gemini_timer_set_mode(enum clock_event_mode mode,
 static struct clock_event_device gemini_clockevent = {
 	.name		= "TIMER2",
 	.rating		= 300, /* Reasonably fast and accurate clock event */
+	.shift		= 32,
 	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
 	.set_next_event	= gemini_timer_set_next_event,
 	.set_mode	= gemini_timer_set_mode,
@@ -172,20 +188,22 @@ void __init gemini_timer_init(void)
 	}
 
 	/*
-	 * Make irqs happen for the system timer
+	 * Reset the interrupt mask and status
+	 */
+	writel(TIMER_INT_ALL_MASK, TIMER_INTR_MASK);
+	writel(0, TIMER_INTR_STATE);
+	writel(TIMER_1_CR_UPDOWN | TIMER_3_CR_ENABLE | TIMER_3_CR_UPDOWN,
+		TIMER_CR);
+
+	/*
+	 * Setup clockevent timer (interrupt-driven.)
 	 */
-	setup_irq(IRQ_TIMER2, &gemini_timer_irq);
-
-	/* Enable and use TIMER1 as clock source */
-	writel(0xffffffff, TIMER_COUNT(GEMINI_TIMER1_BASE));
-	writel(0xffffffff, TIMER_LOAD(GEMINI_TIMER1_BASE));
-	writel(TIMER_1_CR_ENABLE, TIMER_CR);
-	if (clocksource_mmio_init(TIMER_COUNT(GEMINI_TIMER1_BASE),
-				  "TIMER1", tick_rate, 300, 32,
-				  clocksource_mmio_readl_up))
-		pr_err("timer: failed to initialize gemini clock source\n");
-
-	/* Configure and register the clockevent */
+	writel(0, TIMER_COUNT(GEMINI_TIMER1_BASE));
+	writel(0, TIMER_LOAD(GEMINI_TIMER1_BASE));
+	writel(0, TIMER_MATCH1(GEMINI_TIMER1_BASE));
+	writel(0, TIMER_MATCH2(GEMINI_TIMER1_BASE));
+	setup_irq(IRQ_TIMER1, &gemini_timer_irq);
+	gemini_clockevent.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&gemini_clockevent, tick_rate,
 					1, 0xffffffff);
 }
-- 
2.4.2
