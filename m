From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 12 Dec 2011 10:57:50 +0100
Subject: [PATCH 4/4] ARM: smp_twd: reconfigure clockevents after cpufreq change
Message-ID: <1323683870-23937-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This break-out from Colin Cross' cpufreq-aware TWD patch
will handle the case when our localtimer's clock changes with
the cpu clock. A cpufreq transtion notifier will be registered
only if the platform has supplied a specified clock to the TWD.

After a cpufreq transition, update the clockevent's frequency
by fetching the new clock rate from the clock framework and
reprogram the next clock event.

The necessary changes in the clockevents framework was done by
Thomas Gleixner in kernel v3.0.

Signed-off-by: Colin Cross <ccross@android.com>
Cc: Russell King <linux@arm.linux.org.uk>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
[Broke out, ifdef:ed CPUfreq stuff for non-cpufreq configs]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/kernel/smp_twd.c |   47 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index a13e1c0..92dbd80 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/clk.h>
+#include <linux/cpufreq.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -94,6 +95,52 @@ void twd_timer_stop(struct clock_event_device *clk)
 	disable_percpu_irq(clk->irq);
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
-- 
1.7.3.2
