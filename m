From: james.morse@arm.com (James Morse)
Date: Mon, 25 Apr 2016 18:10:50 +0100
Subject: [PATCH v8 13/13] arm64: hibernate: Refuse to hibernate if the boot
 cpu is offline
In-Reply-To: <1461604250-12789-1-git-send-email-james.morse@arm.com>
References: <1461604250-12789-1-git-send-email-james.morse@arm.com>
Message-ID: <1461604250-12789-14-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hibernation represents a system state save/restore through
a system reboot; this implies that the logical cpus carrying
out hibernation/thawing must be the same, so that the context
saved in the snapshot image on hibernation is consistent with
the state of the system on resume. If resume from hibernation
is driven through kernel command line parameter, the cpu responsible
for thawing the system will be whatever CPU firmware boots the system
on upon cold-boot (ie logical cpu 0); this means that in order to
keep system context consistent between the hibernate snapshot image
and system state on kernel resume from hibernate, logical cpu 0 must
be online on hibernation and must be the logical cpu that creates
the snapshot image.

This patch adds a PM notifier that enforces logical cpu 0 is online
when the hibernation is started (and prevents hibernation if it is
not), which is sufficient to guarantee it will be the one creating
the snapshot image therefore providing the resume cpu a consistent
snapshot of the system to resume to.

Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/kernel/hibernate.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index c88c3a4ae637..9466abc84ca5 100644
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
@@ -442,3 +443,28 @@ int swsusp_arch_resume(void)
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
