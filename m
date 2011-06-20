From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 20 Jun 2011 10:48:07 +0200
Subject: [PATCH] clocksource/arm_smp_twd: handle frequency changes
Message-ID: <1308559687-30768-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Cross <ccross@android.com>

First add a clock called "smp_twd" that is used to determine the
twd frequency, which can also be used at init time to avoid
calibrating the twd frequency since we already know it.

Then the localtimer's clock changes with the cpu clock, since the
block has only one clock input. After a cpufreq transition, update
the clockevent's frequency and reprogram the next clock event
so we stay tight on the scheduled timeline.

Clock changes are based on Rob Herring's work.

This patch depends on the whole localtimer rewrite and move
shebang from Marc Zyngier, and that in turn depends on other
stuff.

Signed-off-by: Colin Cross <ccross@android.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[ifdef:ed CPUfreq stuff - rebased to Marc Z patches]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Marc, if you're pursuing this series, consider merging this on top,
it is needed for the new ARM A9 small-form factor reference platform
whatever it is called.
---
 drivers/clocksource/arm_smp_twd.c |   89 ++++++++++++++++++++++++++++++++++---
 1 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/arm_smp_twd.c b/drivers/clocksource/arm_smp_twd.c
index 5e2e8cc..a18ac0d 100644
--- a/drivers/clocksource/arm_smp_twd.c
+++ b/drivers/clocksource/arm_smp_twd.c
@@ -19,6 +19,10 @@
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/cpufreq.h
+#include <linux/err.h>
+#include <linux/percpu.h>
 
 #include <asm/hardware/gic.h>
 
@@ -35,6 +39,8 @@
 static void __iomem *twd_base;
 static int twd_ppi;
 
+static struct clk *twd_clk;
+static DEFINE_PER_CPU(struct clock_event_device *, twd_ce);
 static unsigned long twd_timer_rate;
 static DEFINE_PER_CPU(bool, irq_reqd);
 static struct clock_event_device __percpu *twd_evt;
@@ -90,6 +96,52 @@ static irqreturn_t twd_handler(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
+#ifdef CONFIG_CPU_FREQ
+
+/*
+ * Updates clockevent frequency when the cpu frequency changes.
+ * Called on the cpu that is changing frequency with interrupts disabled.
+ */
+static void twd_update_frequency(void *data)
+{
+	twd_timer_rate = clk_get_rate(twd_clk);
+
+	clockevents_update_freq(__get_cpu_var(twd_ce), twd_timer_rate);
+}
+
+static int twd_cpufreq_transition(struct notifier_block *nb,
+	unsigned long state, void *data)
+{
+	struct cpufreq_freqs *freqs = data;
+
+	/*
+	 * The twd clock events must be reprogrammed to account for the new
+	 * frequency.  The timer is local to a cpu, so cross-call to the
+	 * changing cpu.
+	 */
+	if (state == CPUFREQ_POSTCHANGE || state == CPUFREQ_RESUMECHANGE)
+		smp_call_function_single(freqs->cpu, twd_update_frequency,
+			NULL, 1);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block twd_cpufreq_nb = {
+	.notifier_call = twd_cpufreq_transition,
+};
+
+static int twd_cpufreq_init(void)
+{
+	if (!IS_ERR_OR_NULL(twd_clk))
+		return cpufreq_register_notifier(&twd_cpufreq_nb,
+			CPUFREQ_TRANSITION_NOTIFIER);
+
+	return 0;
+}
+core_initcall(twd_cpufreq_init);
+
+#endif
+
 static void __cpuinit twd_calibrate_rate(void)
 {
 	unsigned long count;
@@ -129,6 +181,27 @@ static void __cpuinit twd_calibrate_rate(void)
 	}
 }
 
+static struct clk *twd_get_clock(void)
+{
+	struct clk *clk;
+	int err;
+
+	clk = clk_get_sys("smp_twd", NULL);
+	if (IS_ERR(clk)) {
+		pr_err("smp_twd: clock not found: %d\n", (int)PTR_ERR(clk));
+		return clk;
+	}
+
+	err = clk_enable(clk);
+	if (err) {
+		pr_err("smp_twd: clock failed to enable: %d\n", err);
+		clk_put(clk);
+		return ERR_PTR(err);
+	}
+
+	return clk;
+}
+
 /*
  * Setup the local clock events for a CPU.
  */
@@ -137,7 +210,13 @@ static void __cpuinit twd_setup(void *data)
 	struct clock_event_device *clk = data;
 	int err;
 
-	twd_calibrate_rate();
+	if (!twd_clk)
+		twd_clk = twd_get_clock();
+
+	if (!IS_ERR_OR_NULL(twd_clk))
+		twd_timer_rate = clk_get_rate(twd_clk);
+	else
+		twd_calibrate_rate();
 
 	clk->name = "arm_smp_twd";
 	clk->features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT |
@@ -145,10 +224,6 @@ static void __cpuinit twd_setup(void *data)
 	clk->rating = 450;
 	clk->set_mode = twd_set_mode;
 	clk->set_next_event = twd_set_next_event;
-	clk->shift = 20;
-	clk->mult = div_sc(twd_timer_rate, NSEC_PER_SEC, clk->shift);
-	clk->max_delta_ns = clockevent_delta2ns(0xffffffff, clk);
-	clk->min_delta_ns = clockevent_delta2ns(0xf, clk);
 	clk->irq = gic_ppi_to_vppi(twd_ppi);
 	clk->cpumask = cpumask_of(smp_processor_id());
 
@@ -163,7 +238,9 @@ static void __cpuinit twd_setup(void *data)
 		return;
 	}
 
-	clockevents_register_device(clk);
+	__get_cpu_var(twd_ce) = clk;
+	clockevents_config_and_register(clk, twd_timer_rate,
+					0xf, 0xffffffff);
 }
 
 static void __cpuinit twd_teardown(void *data)
-- 
1.7.3.2
