From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 22 Oct 2012 12:10:49 +0200
Subject: [PATCH v3] ARM: SMP_TWD: make setup()/stop() reentrant
Message-ID: <1350900649-25369-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

It has been brought to my knowledge that the .setup()/.stop()
function pair in the SMP TWD is going to be called from atomic
contexts for CPUs coming and going, and then the
clk_prepare()/clk_unprepare() calls cannot be called
on subsequent .setup()/.stop() iterations. This is however
just the tip of an iceberg as the function pair is not
designed to be reentrant at all.

This change makes the SMP_TWD clock .setup()/.stop() pair reentrant
by splitting the .setup() function in three parts:

- One COMMON part that is executed the first time the first CPU
  in the TWD cluster is initialized. This will fetch the TWD
  clk for the cluster and prepare+enable it. If no clk is
  available it will calibrate the rate instead.

- One part that is executed the FIRST TIME a certain CPU is
  brought on-line. This initializes and sets up the clock event
  for a certain CPU.

- One part that is executed on every subsequent .setup() call.
  This will re-initialize the clock event. This is augmented
  to call the clk_enable()/clk_disable() pair properly.

Cc: Shawn Guo <shawn.guo@linaro.org>
Reported-by: Peter Chen <peter.chen@freescale.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Split setup() in three parts
- re-register the clock event on every setup()
---
 arch/arm/kernel/smp_twd.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index b92d524..73e25e2 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -31,6 +31,8 @@ static void __iomem *twd_base;
 
 static struct clk *twd_clk;
 static unsigned long twd_timer_rate;
+static bool common_setup_called;
+static DEFINE_PER_CPU(bool, percpu_setup_called);
 
 static struct clock_event_device __percpu **twd_evt;
 static int twd_ppi;
@@ -93,6 +95,8 @@ static void twd_timer_stop(struct clock_event_device *clk)
 {
 	twd_set_mode(CLOCK_EVT_MODE_UNUSED, clk);
 	disable_percpu_irq(clk->irq);
+	if (!IS_ERR(twd_clk))
+		clk_disable(twd_clk);
 }
 
 #ifdef CONFIG_COMMON_CLK
@@ -264,15 +268,46 @@ static struct clk *twd_get_clock(void)
 static int __cpuinit twd_timer_setup(struct clock_event_device *clk)
 {
 	struct clock_event_device **this_cpu_clk;
+	int cpu = smp_processor_id();
 
-	if (!twd_clk)
+	/*
+	 * If the basic setup for this CPU has been done before don't
+	 * bother with the below.
+	 */
+	if (per_cpu(percpu_setup_called, cpu)) {
+		if (!IS_ERR(twd_clk))
+			clk_enable(twd_clk);
+		__raw_writel(0, twd_base + TWD_TIMER_CONTROL);
+		clockevents_register_device(*__this_cpu_ptr(twd_evt));
+		enable_percpu_irq(clk->irq, 0);
+		return 0;
+	}
+	per_cpu(percpu_setup_called, cpu) = true;
+
+	/*
+	 * This stuff only need to be done once for the entire TWD cluster
+	 * during the runtime of the system.
+	 */
+	if (!common_setup_called) {
 		twd_clk = twd_get_clock();
 
-	if (!IS_ERR_OR_NULL(twd_clk))
-		twd_timer_rate = clk_get_rate(twd_clk);
-	else
-		twd_calibrate_rate();
+		/*
+		 * We use IS_ERR_OR_NULL() here, because if the clock stubs
+		 * are active we will get a valid clk reference which is
+		 * however NULL and will return the rate 0. In that case we
+		 * need to calibrate the rate instead.
+		 */
+		if (!IS_ERR_OR_NULL(twd_clk))
+			twd_timer_rate = clk_get_rate(twd_clk);
+		else
+			twd_calibrate_rate();
+	}
+	common_setup_called = true;
 
+	/*
+	 * The following is done once per CPU the first time .setup() is
+	 * called.
+	 */
 	__raw_writel(0, twd_base + TWD_TIMER_CONTROL);
 
 	clk->name = "local_timer";
-- 
1.7.11.3
