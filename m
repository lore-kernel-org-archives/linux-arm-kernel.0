From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Thu, 29 Aug 2013 15:55:42 +0100
Subject: [PATCH v6 5/5] drivers: clocksource: add CPU PM notifier for ARM
 architected timer
In-Reply-To: <1377788142-21388-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1377788142-21388-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <1377788142-21388-6-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Few control settings done in architected timer as part of initialisation
can be lost when CPU enters deeper power states. They need to be
restored when the CPU is (warm)reset again.

This patch adds CPU PM notifiers to save the counter control register
when entering low power modes and restore it when CPU exits low power.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9777b36..611f9cb 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -13,6 +13,7 @@
 #include <linux/device.h>
 #include <linux/smp.h>
 #include <linux/cpu.h>
+#include <linux/cpu_pm.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/of_irq.h>
@@ -275,6 +276,33 @@ static struct notifier_block arch_timer_cpu_nb = {
 	.notifier_call = arch_timer_cpu_notify,
 };
 
+#ifdef CONFIG_CPU_PM
+static unsigned int saved_cntkctl;
+static int arch_timer_cpu_pm_notify(struct notifier_block *self,
+				    unsigned long action, void *hcpu)
+{
+	if (action == CPU_PM_ENTER)
+		saved_cntkctl = arch_timer_get_cntkctl();
+	else if (action == CPU_PM_ENTER_FAILED || action == CPU_PM_EXIT)
+		arch_timer_set_cntkctl(saved_cntkctl);
+	return NOTIFY_OK;
+}
+
+static struct notifier_block arch_timer_cpu_pm_notifier = {
+	.notifier_call = arch_timer_cpu_pm_notify,
+};
+
+static int __init arch_timer_cpu_pm_init(void)
+{
+	return cpu_pm_register_notifier(&arch_timer_cpu_pm_notifier);
+}
+#else
+static int __init arch_timer_cpu_pm_init(void)
+{
+	return 0;
+}
+#endif
+
 static int __init arch_timer_register(void)
 {
 	int err;
@@ -324,11 +352,17 @@ static int __init arch_timer_register(void)
 	if (err)
 		goto out_free_irq;
 
+	err = arch_timer_cpu_pm_init();
+	if (err)
+		goto out_unreg_notify;
+
 	/* Immediately configure the timer on the boot CPU */
 	arch_timer_setup(this_cpu_ptr(arch_timer_evt));
 
 	return 0;
 
+out_unreg_notify:
+	unregister_cpu_notifier(&arch_timer_cpu_nb);
 out_free_irq:
 	if (arch_timer_use_virtual)
 		free_percpu_irq(arch_timer_ppi[VIRT_PPI], arch_timer_evt);
-- 
1.8.1.2
