From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Aug 2016 11:35:58 +0100
Subject: [RFC PATCH 2/2] arm64: debug: convert OS lock CPU hotplug notifier to
 new infrastructure
In-Reply-To: <1472207758-24394-1-git-send-email-will.deacon@arm.com>
References: <1472207758-24394-1-git-send-email-will.deacon@arm.com>
Message-ID: <1472207758-24394-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 debug monitor initialisation code uses a CPU hotplug notifier
to clear the OS lock when CPUs come online.

This patch converts the code to the new hotplug mechanism.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/debug-monitors.c | 30 ++++++------------------------
 include/linux/cpuhotplug.h         |  1 +
 2 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 91fff48d0f57..3f9023654dac 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -132,36 +132,18 @@ NOKPROBE_SYMBOL(disable_debug_monitors);
 /*
  * OS lock clearing.
  */
-static void clear_os_lock(void *unused)
+static int clear_os_lock(unsigned int cpu)
 {
 	asm volatile("msr oslar_el1, %0" : : "r" (0));
+	isb();
+	return 0;
 }
 
-static int os_lock_notify(struct notifier_block *self,
-				    unsigned long action, void *data)
-{
-	if ((action & ~CPU_TASKS_FROZEN) == CPU_ONLINE)
-		clear_os_lock(NULL);
-	return NOTIFY_OK;
-}
-
-static struct notifier_block os_lock_nb = {
-	.notifier_call = os_lock_notify,
-};
-
 static int debug_monitors_init(void)
 {
-	cpu_notifier_register_begin();
-
-	/* Clear the OS lock. */
-	on_each_cpu(clear_os_lock, NULL, 1);
-	isb();
-
-	/* Register hotplug handler. */
-	__register_cpu_notifier(&os_lock_nb);
-
-	cpu_notifier_register_done();
-	return 0;
+	return cpuhp_setup_state(CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING,
+				 "CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING",
+				 clear_os_lock, NULL);
 }
 postcore_initcall(debug_monitors_init);
 
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 3758fe6d5968..8c999a202452 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -45,6 +45,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_METAG_STARTING,
 	CPUHP_AP_MIPS_OP_LOONGSON3_STARTING,
 	CPUHP_AP_ARM_VFP_STARTING,
+	CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING,
 	CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING,
 	CPUHP_AP_PERF_ARM_STARTING,
 	CPUHP_AP_ARM_L2X0_STARTING,
-- 
2.1.4
