From: james.morse@arm.com (James Morse)
Date: Wed, 13 Apr 2016 17:31:50 +0100
Subject: [PATCH v7 17/16] arm64: hibernate: Refuse to hibernate if the boot
 cpu is offline
In-Reply-To: <1459529620-22150-1-git-send-email-james.morse@arm.com>
Message-ID: <1460565110-26341-1-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is important to hibernate/resume on the same CPU, otherwise we may
change the cpu order or restore a big cpu's register state on a little
cpu.

We know cpu 0 is the cpu the firmware booted us on last time, refuse to
hibernate if it has been hotplugged out. Follow x86's example by registering
a pm notifier that is called before processes are frozen and devices are
stopped.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/hibernate.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 486315249f2a..1ef4bf2207a5 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -17,6 +17,7 @@
 #define pr_fmt(x) "hibernate: " x
 #include <linux/kvm_host.h>
 #include <linux/mm.h>
+#include <linux/notifier.h>
 #include <linux/pm.h>
 #include <linux/sched.h>
 #include <linux/suspend.h>
@@ -476,3 +477,28 @@ int swsusp_arch_resume(void)
 out:
 	return rc;
 }
+
+static int check_boot_cpu_online_pm_callback(struct notifier_block *nb,
+					     unsigned long action, void *ptr)
+{
+	if (action == PM_HIBERNATION_PREPARE &&
+	     cpumask_first(cpu_online_mask) != 0) {
+		pr_warn("CPU0 is offline.\n");
+		return notifier_from_errno(-ENODEV);
+	}
+
+	return NOTIFY_OK;
+}
+
+static int __init check_boot_cpu_online_init(void)
+{
+	/*
+	 * Set this pm_notifier callback with a lower priority than
+	 * cpu_hotplug_pm_callback, so that cpu_hotplug_pm_callback will be
+	 * called earlier to disable cpu hotplug before the cpu online check.
+	 */
+	pm_notifier(check_boot_cpu_online_pm_callback, -INT_MAX);
+
+	return 0;
+}
+core_initcall(check_boot_cpu_online_init);
-- 
2.8.0.rc3
