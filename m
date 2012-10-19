From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Oct 2012 11:56:29 +0200
Subject: [PATCH v2] ARM: SMP_TWD: make setup()/stop() reentrant
Message-ID: <1350640589-31821-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes the SMP_TWD clock .setup()/.stop() pair reentrant by
not re-fetching the clk and re-registering the clock event every
time .setup() is called. We also make sure to call the
clk_enable()/clk_disable() pair on subsequent calls.

As it has been brought to my knowledge that this pair is going
to be called from atomic contexts for CPU clusters coming and
going, the clk_prepare()/clk_unprepare() calls cannot be called
on subsequent .setup()/.stop() iterations.

The patch assumes that the code will make sure that
twd_set_mode() is called through .set_mode() on the clock
event *after* the .setup() call, so that the timer registers
are fully re-programmed after a new .setup() cycle.

Cc: Shawn Guo <shawn.guo@linaro.org>
Reported-by: Peter Chen <peter.chen@freescale.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Peter/Shawn: can you please respond with a Tested-by from your
system(s) to indicate if this works as expected?
---
 arch/arm/kernel/smp_twd.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index b92d524..229231a 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -31,6 +31,7 @@ static void __iomem *twd_base;
 
 static struct clk *twd_clk;
 static unsigned long twd_timer_rate;
+static bool initial_setup_called;
 
 static struct clock_event_device __percpu **twd_evt;
 static int twd_ppi;
@@ -93,6 +94,8 @@ static void twd_timer_stop(struct clock_event_device *clk)
 {
 	twd_set_mode(CLOCK_EVT_MODE_UNUSED, clk);
 	disable_percpu_irq(clk->irq);
+	if (!IS_ERR(twd_clk))
+		clk_disable(twd_clk);
 }
 
 #ifdef CONFIG_COMMON_CLK
@@ -265,8 +268,21 @@ static int __cpuinit twd_timer_setup(struct clock_event_device *clk)
 {
 	struct clock_event_device **this_cpu_clk;
 
-	if (!twd_clk)
-		twd_clk = twd_get_clock();
+	/*
+	 * If the basic setup has been done before, don't bother
+	 * with yet again looking up the clock and register the clock
+	 * source.
+	 */
+	if (initial_setup_called) {
+		if (!IS_ERR(twd_clk))
+			clk_enable(twd_clk);
+		__raw_writel(0, twd_base + TWD_TIMER_CONTROL);
+		enable_percpu_irq(clk->irq, 0);
+		return 0;
+	}
+	initial_setup_called = true;
+
+	twd_clk = twd_get_clock();
 
 	if (!IS_ERR_OR_NULL(twd_clk))
 		twd_timer_rate = clk_get_rate(twd_clk);
-- 
1.7.11.7
