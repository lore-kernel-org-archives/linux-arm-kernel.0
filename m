From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu,  7 Jul 2016 10:01:01 +0200
Subject: [PATCH 28/93] clocksource/drivers/arm_global_timer: Convert init
 function to return error
In-Reply-To: <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
References: <577E0BED.3020608@linaro.org>
 <1467878526-1238-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1467878526-1238-28-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init functions do not return any error. They behave as the following:

  - panic, thus leading to a kernel crash while another timer may work and
       make the system boot up correctly

  or

  - print an error and let the caller unaware if the state of the system

Change that by converting the init functions to return an error conforming
to the CLOCKSOURCE_OF_RET prototype.

Proper error handling (rollback, errno value) will be changed later case
by case, thus this change just return back an error or success in the init
function.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 drivers/clocksource/arm_global_timer.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
index 9df0d16..40104fc 100644
--- a/drivers/clocksource/arm_global_timer.c
+++ b/drivers/clocksource/arm_global_timer.c
@@ -238,7 +238,7 @@ static void __init gt_delay_timer_init(void)
 	register_current_timer_delay(&gt_delay_timer);
 }
 
-static void __init gt_clocksource_init(void)
+static int __init gt_clocksource_init(void)
 {
 	writel(0, gt_base + GT_CONTROL);
 	writel(0, gt_base + GT_COUNTER0);
@@ -249,7 +249,7 @@ static void __init gt_clocksource_init(void)
 #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
 	sched_clock_register(gt_sched_clock_read, 64, gt_clk_rate);
 #endif
-	clocksource_register_hz(&gt_clocksource, gt_clk_rate);
+	return clocksource_register_hz(&gt_clocksource, gt_clk_rate);
 }
 
 static int gt_cpu_notify(struct notifier_block *self, unsigned long action,
@@ -270,7 +270,7 @@ static struct notifier_block gt_cpu_nb = {
 	.notifier_call = gt_cpu_notify,
 };
 
-static void __init global_timer_of_register(struct device_node *np)
+static int __init global_timer_of_register(struct device_node *np)
 {
 	struct clk *gt_clk;
 	int err = 0;
@@ -283,19 +283,19 @@ static void __init global_timer_of_register(struct device_node *np)
 	if (read_cpuid_part() == ARM_CPU_PART_CORTEX_A9
 	    && (read_cpuid_id() & 0xf0000f) < 0x200000) {
 		pr_warn("global-timer: non support for this cpu version.\n");
-		return;
+		return -ENOSYS;
 	}
 
 	gt_ppi = irq_of_parse_and_map(np, 0);
 	if (!gt_ppi) {
 		pr_warn("global-timer: unable to parse irq\n");
-		return;
+		return -EINVAL;
 	}
 
 	gt_base = of_iomap(np, 0);
 	if (!gt_base) {
 		pr_warn("global-timer: invalid base address\n");
-		return;
+		return -ENXIO;
 	}
 
 	gt_clk = of_clk_get(np, 0);
@@ -332,11 +332,17 @@ static void __init global_timer_of_register(struct device_node *np)
 	}
 
 	/* Immediately configure the timer on the boot CPU */
-	gt_clocksource_init();
-	gt_clockevents_init(this_cpu_ptr(gt_evt));
+	err = gt_clocksource_init();
+	if (err)
+		goto out_irq;
+	
+	err = gt_clockevents_init(this_cpu_ptr(gt_evt));
+	if (err)
+		goto out_irq;
+
 	gt_delay_timer_init();
 
-	return;
+	return 0;
 
 out_irq:
 	free_percpu_irq(gt_ppi, gt_evt);
@@ -347,8 +353,10 @@ out_clk:
 out_unmap:
 	iounmap(gt_base);
 	WARN(err, "ARM Global timer register failed (%d)\n", err);
+
+	return err;
 }
 
 /* Only tested on r2p2 and r3p0  */
-CLOCKSOURCE_OF_DECLARE(arm_gt, "arm,cortex-a9-global-timer",
+CLOCKSOURCE_OF_DECLARE_RET(arm_gt, "arm,cortex-a9-global-timer",
 			global_timer_of_register);
-- 
1.9.1
