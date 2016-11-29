From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Tue, 29 Nov 2016 15:15:16 +0300
Subject: [PATCH] clocksource/arm_global_timer: reconfigure clockevents after
 cpufreq change
In-Reply-To: <1480421716-30782-1-git-send-email-al.kochet@gmail.com>
References: <1480421716-30782-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1480421716-30782-2-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After a cpufreq transition, update the clockevent's frequency
by fetching the new clock rate from the clock framework and
reprogram the next clock event.

The clock supplying the arm-global-timer on the rk3188 is coming
from the the cpu clock itself and thus changes its rate everytime
cpufreq adjusts the cpu frequency.

Found by code review, real impact not known. Assume what actual
HZ value will be different from expected on platforms using
arm-global-timer as clockevent.

The patch is port of commit 4fd7f9b12810 ("ARM: 7212/1: smp_twd:
reconfigure clockevents after cpufreq change") and
commit 2b25d9f64b54 ("ARM: 7535/1: Reprogram smp_twd based on
new common clk framework notifiers").

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/clocksource/arm_global_timer.c |   93 +++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 8da0329..55addeb 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -49,6 +49,7 @@
  * the units for all operations.
  */
 static void __iomem *gt_base;
+static struct clk *gt_clk;
 static unsigned long gt_clk_rate;
 static int gt_ppi;
 static struct clock_event_device __percpu *gt_evt;
@@ -137,6 +138,97 @@ static int gt_clockevent_set_next_event(unsigned long evt,
 	return 0;
 }
 
+#ifdef CONFIG_COMMON_CLK
+
+/*
+ * Updates clockevent frequency when the cpu frequency changes.
+ * Called on the cpu that is changing frequency with interrupts disabled.
+ */
+static void gt_update_frequency(void *new_rate)
+{
+	gt_clk_rate = *((unsigned long *) new_rate);
+
+	clockevents_update_freq(raw_cpu_ptr(gt_evt), gt_clk_rate);
+}
+
+static int gt_rate_change(struct notifier_block *nb,
+	unsigned long flags, void *data)
+{
+	struct clk_notifier_data *cnd = data;
+
+	/*
+	 * The gt clock events must be reprogrammed to account for the new
+	 * frequency.  The timer is local to a cpu, so cross-call to the
+	 * changing cpu.
+	 */
+	if (flags == POST_RATE_CHANGE)
+		on_each_cpu(gt_update_frequency,
+				  (void *)&cnd->new_rate, 1);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block gt_clk_nb = {
+	.notifier_call = gt_rate_change,
+};
+
+static int gt_clk_init(void)
+{
+	if (gt_evt && raw_cpu_ptr(gt_evt) && !IS_ERR(gt_clk))
+		return clk_notifier_register(gt_clk, &gt_clk_nb);
+
+	return 0;
+}
+core_initcall(gt_clk_init);
+
+#elif defined (CONFIG_CPU_FREQ)
+
+#include <linux/cpufreq.h>
+
+/*
+ * Updates clockevent frequency when the cpu frequency changes.
+ * Called on the cpu that is changing frequency with interrupts disabled.
+ */
+static void gt_update_frequency(void *data)
+{
+	gt_clk_rate = clk_get_rate(gt_clk);
+
+	clockevents_update_freq(raw_cpu_ptr(gt_evt), gt_clk_rate);
+}
+
+static int gt_cpufreq_transition(struct notifier_block *nb,
+	unsigned long state, void *data)
+{
+	struct cpufreq_freqs *freqs = data;
+
+	/*
+	 * The gt clock events must be reprogrammed to account for the new
+	 * frequency.  The timer is local to a cpu, so cross-call to the
+	 * changing cpu.
+	 */
+	if (state == CPUFREQ_POSTCHANGE)
+		smp_call_function_single(freqs->cpu, gt_update_frequency,
+			NULL, 1);
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block gt_cpufreq_nb = {
+	.notifier_call = gt_cpufreq_transition,
+};
+
+static int gt_cpufreq_init(void)
+{
+	if (gt_evt && raw_cpu_ptr(gt_evt) && !IS_ERR(gt_clk))
+		return cpufreq_register_notifier(&gt_cpufreq_nb,
+			CPUFREQ_TRANSITION_NOTIFIER);
+
+	return 0;
+}
+core_initcall(gt_cpufreq_init);
+
+#endif
+
 static irqreturn_t gt_clockevent_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = dev_id;
@@ -257,7 +349,6 @@ static int __init gt_clocksource_init(void)
 
 static int __init global_timer_of_register(struct device_node *np)
 {
-	struct clk *gt_clk;
 	int err = 0;
 
 	/*
-- 
1.7.9.5
