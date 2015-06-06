From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Sat,  6 Jun 2015 05:57:28 +0200
Subject: [PATCH 6/6] ARM:Gemini:add timer3 as sched_clock_source
In-Reply-To: <1433563048-21922-1-git-send-email-ulli.kroll@googlemail.com>
References: <1433563048-21922-1-git-send-email-ulli.kroll@googlemail.com>
Message-ID: <1433563048-21922-7-git-send-email-ulli.kroll@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is based on openwrt patch found in
target/linux/gemini/patches-3.18/160-gemini-timers.patch

It setups a free running timer (timer3) for scheduler clock

Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
---
 arch/arm/mach-gemini/time.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-gemini/time.c b/arch/arm/mach-gemini/time.c
index 29ec2c3..e419dd4 100644
--- a/arch/arm/mach-gemini/time.c
+++ b/arch/arm/mach-gemini/time.c
@@ -15,6 +15,8 @@
 #include <asm/mach/time.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
+#include <linux/sched_clock.h>
+
 
 /*
  * Register definitions for the timers
@@ -58,6 +60,11 @@
 
 static unsigned int tick_rate;
 
+static u64 notrace gemini_read_sched_clock(void)
+{
+	return readl(TIMER_COUNT(GEMINI_TIMER3_BASE));
+}
+
 static int gemini_timer_set_next_event(unsigned long cycles,
 				       struct clock_event_device *evt)
 {
@@ -196,6 +203,19 @@ void __init gemini_timer_init(void)
 		TIMER_CR);
 
 	/*
+	 * Setup free-running clocksource timer (interrupts
+	 * disabled.)
+	 */
+	writel(0, TIMER_COUNT(GEMINI_TIMER3_BASE));
+	writel(0, TIMER_LOAD(GEMINI_TIMER3_BASE));
+	writel(0, TIMER_MATCH1(GEMINI_TIMER3_BASE));
+	writel(0, TIMER_MATCH2(GEMINI_TIMER3_BASE));
+	clocksource_mmio_init(TIMER_COUNT(GEMINI_TIMER3_BASE),
+			"gemini_clocksource", tick_rate,
+			300, 32, clocksource_mmio_readl_up);
+	sched_clock_register(gemini_read_sched_clock, 32, tick_rate);
+
+	/*
 	 * Setup clockevent timer (interrupt-driven.)
 	 */
 	writel(0, TIMER_COUNT(GEMINI_TIMER1_BASE));
-- 
2.4.2
