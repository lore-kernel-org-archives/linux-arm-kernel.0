From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 28 Aug 2013 12:36:01 +0100
Subject: [RFC PATCH 09/14] arm64: kernel: implement debug monitors CPU PM
 notifiers
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1377689766-17642-10-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a CPU is shutdown either through CPU idle or suspend to RAM, the
content of debug monitor registers must be reset or restored to proper
values when CPU resume from low power states. This patch implements a
CPU PM notifier that allows to restore the content of debug monitor
registers to allow proper suspend/resume operations.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/kernel/debug-monitors.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index cbfacf7..f78148f 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -19,6 +19,7 @@
  */
 
 #include <linux/cpu.h>
+#include <linux/cpu_pm.h>
 #include <linux/debugfs.h>
 #include <linux/hardirq.h>
 #include <linux/init.h>
@@ -154,6 +155,42 @@ static struct notifier_block os_lock_nb = {
 	.notifier_call = os_lock_notify,
 };
 
+#ifdef CONFIG_CPU_PM
+static DEFINE_PER_CPU(u32, mdscr);
+
+static int dm_cpu_pm_notify(struct notifier_block *self, unsigned long action,
+			     void *v)
+{
+	switch (action) {
+	case CPU_PM_ENTER:
+		__get_cpu_var(mdscr) = mdscr_read();
+		break;
+	case CPU_PM_EXIT:
+		clear_os_lock(NULL);
+		mdscr_write(__get_cpu_var(mdscr));
+		break;
+	case CPU_PM_ENTER_FAILED:
+	default:
+		return NOTIFY_DONE;
+	}
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block dm_cpu_pm_nb = {
+	.notifier_call = dm_cpu_pm_notify,
+};
+
+static void __init debug_monitors_pm_init(void)
+{
+	cpu_pm_register_notifier(&dm_cpu_pm_nb);
+}
+#else
+static inline void debug_monitors_pm_init(void)
+{
+}
+#endif
+
 static int debug_monitors_init(void)
 {
 	/* Clear the OS lock. */
@@ -162,6 +199,7 @@ static int debug_monitors_init(void)
 
 	/* Register hotplug handler. */
 	register_cpu_notifier(&os_lock_nb);
+	debug_monitors_pm_init();
 	return 0;
 }
 postcore_initcall(debug_monitors_init);
-- 
1.8.3.4
