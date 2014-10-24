From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 24 Oct 2014 13:59:18 +0200
Subject: [PATCH 05/17] clocksource: time-armada-370-xp: add suspend/resume
 support
In-Reply-To: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1414151970-6626-6-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds a set of suspend/resume syscore_ops to respectively
save and restore a number of timer registers, in order to make sure
the clockevent and clocksource devices continue to work properly
accross a suspend/resume cycle.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel at vger.kernel.org
---
 drivers/clocksource/time-armada-370-xp.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index 0451e62..1a32dcb 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -43,6 +43,7 @@
 #include <linux/module.h>
 #include <linux/sched_clock.h>
 #include <linux/percpu.h>
+#include <linux/syscore_ops.h>
 
 /*
  * Timer block registers.
@@ -223,6 +224,28 @@ static struct notifier_block armada_370_xp_timer_cpu_nb = {
 	.notifier_call = armada_370_xp_timer_cpu_notify,
 };
 
+static u32 timer_ctrl_reg, timer_local_ctrl_reg;
+
+static int armada_370_xp_timer_suspend(void)
+{
+	timer_ctrl_reg = readl(timer_base + TIMER_CTRL_OFF);
+	timer_local_ctrl_reg = readl(local_base + TIMER_CTRL_OFF);
+	return 0;
+}
+
+static void armada_370_xp_timer_resume(void)
+{
+	writel(0xffffffff, timer_base + TIMER0_VAL_OFF);
+	writel(0xffffffff, timer_base + TIMER0_RELOAD_OFF);
+	writel(timer_ctrl_reg, timer_base + TIMER_CTRL_OFF);
+	writel(timer_local_ctrl_reg, local_base + TIMER_CTRL_OFF);
+}
+
+struct syscore_ops armada_370_xp_timer_syscore_ops = {
+	.suspend	= armada_370_xp_timer_suspend,
+	.resume		= armada_370_xp_timer_resume,
+};
+
 static void __init armada_370_xp_timer_common_init(struct device_node *np)
 {
 	u32 clr = 0, set = 0;
@@ -285,6 +308,8 @@ static void __init armada_370_xp_timer_common_init(struct device_node *np)
 	/* Immediately configure the timer on the boot CPU */
 	if (!res)
 		armada_370_xp_timer_setup(this_cpu_ptr(armada_370_xp_evt));
+
+	register_syscore_ops(&armada_370_xp_timer_syscore_ops);
 }
 
 static void __init armada_xp_timer_init(struct device_node *np)
-- 
2.0.0
