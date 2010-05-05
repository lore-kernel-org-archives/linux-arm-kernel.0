From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed,  5 May 2010 17:58:11 +0200
Subject: [PATCH] plat-nomadik: use the MTU clocksrc for sched_clock
Message-ID: <1273075091-2311-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This provides some serious scheduling for the Nomadik family by
introducing a sched_clock() using the MTU clock source in the
same manner as e.g. OMAP or U300. This type of solutions has been
discussed at no end in the past, however we need this resolution
for making measurements and using HRTimers.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/plat-nomadik/timer.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-nomadik/timer.c b/arch/arm/plat-nomadik/timer.c
index db67402..0ff3798 100644
--- a/arch/arm/plat-nomadik/timer.c
+++ b/arch/arm/plat-nomadik/timer.c
@@ -20,6 +20,15 @@
 
 void __iomem *mtu_base; /* ssigned by machine code */
 
+/*
+ * Kernel assumes that sched_clock can be called early
+ * but the MTU may not yet be initialized.
+ */
+static cycle_t nmdk_read_timer_dummy(struct clocksource *cs)
+{
+	return 0;
+}
+
 /* clocksource: MTU decrements, so we negate the value being read. */
 static cycle_t nmdk_read_timer(struct clocksource *cs)
 {
@@ -29,12 +38,27 @@ static cycle_t nmdk_read_timer(struct clocksource *cs)
 static struct clocksource nmdk_clksrc = {
 	.name		= "mtu_0",
 	.rating		= 200,
-	.read		= nmdk_read_timer,
+	.read		= nmdk_read_timer_dummy,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.shift		= 20,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+/*
+ * Override the global weak sched_clock symbol with this
+ * local implementation which uses the clocksource to get some
+ * better resolution when scheduling the kernel. We accept that
+ * this wraps around for now, since it is just a relative time
+ * stamp. (Inspired by OMAP implementation.)
+ */
+unsigned long long notrace sched_clock(void)
+{
+	return clocksource_cyc2ns(nmdk_clksrc.read(
+				  &nmdk_clksrc),
+				  nmdk_clksrc.mult,
+				  nmdk_clksrc.shift);
+}
+
 /* Clockevent device: use one-shot mode */
 static void nmdk_clkevt_mode(enum clock_event_mode mode,
 			     struct clock_event_device *dev)
@@ -121,6 +145,8 @@ void __init nmdk_timer_init(void)
 	writel(cr | MTU_CRn_ENA, mtu_base + MTU_CR(0));
 
 	nmdk_clksrc.mult = clocksource_hz2mult(rate, nmdk_clksrc.shift);
+	/* Now the scheduling clock is ready */
+	nmdk_clksrc.read = nmdk_read_timer;
 
 	if (clocksource_register(&nmdk_clksrc))
 		pr_err("timer: failed to initialize clock source %s\n",
-- 
1.6.3.3
