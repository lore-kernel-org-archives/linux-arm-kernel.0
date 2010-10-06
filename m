From: Andreas.Gaer@baslerweb.com (Andreas.Gaer at baslerweb.com)
Date: Wed,  6 Oct 2010 10:38:55 +0200
Subject: [PATCH] davinci: Implement sched_clock()
Message-ID: <1286354335-31819-1-git-send-email-Andreas.Gaer@baslerweb.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andreas Gaeer <Andreas.Gaer@baslerweb.com>

Overwrite the default implementation of sched_clock that is based on
jiffies by something more precise. This improves timestamps in ftrace.
Implementation is copied from OMAP platform code.

Signed-off-by: Andreas Gaeer <Andreas.Gaer@baslerweb.com>
---
 arch/arm/mach-davinci/time.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 0f21c36..5d1eea0 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -272,15 +272,36 @@ static cycle_t read_cycles(struct clocksource *cs)
 	return (cycles_t)timer32_read(t);
 }
 
+/*
+ * Kernel assumes that sched_clock can be called early but may not have
+ * things ready yet.
+ */
+static cycle_t read_dummy(struct clocksource *cs)
+{
+	return 0;
+}
+
+
 static struct clocksource clocksource_davinci = {
 	.rating		= 300,
-	.read		= read_cycles,
+	.read		= read_dummy,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.shift		= 24,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
 /*
+ * Overwrite weak default sched_clock with something more precise
+ */
+unsigned long long notrace sched_clock(void)
+{
+	const cycle_t cyc = clocksource_davinci.read(&clocksource_davinci);
+
+	return clocksource_cyc2ns(cyc, clocksource_davinci.mult,
+				clocksource_davinci.shift);
+}
+
+/*
  * clockevent
  */
 static int davinci_set_next_event(unsigned long cycles,
@@ -377,6 +398,7 @@ static void __init davinci_timer_init(void)
 	davinci_clock_tick_rate = clk_get_rate(timer_clk);
 
 	/* setup clocksource */
+	clocksource_davinci.read = read_cycles;
 	clocksource_davinci.name = id_to_name[clocksource_id];
 	clocksource_davinci.mult =
 		clocksource_khz2mult(davinci_clock_tick_rate/1000,
-- 
1.7.2.2
