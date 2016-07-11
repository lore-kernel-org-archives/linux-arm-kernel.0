From: anna-maria@linutronix.de (Anna-Maria Gleixner)
Date: Mon, 11 Jul 2016 12:28:45 -0000
Subject: [patch 33/66] arm: Convert VFP hotplug notifiers to state machine
References: <20160711122450.923603742@linutronix.de>
Message-ID: <20160711122533.391066007@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Gleixner <tglx@linutronix.de>

Straight forward conversion plus commentary why code which is executed
in hotplug callbacks needs to be invoked before installing them.

Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org

---
 arch/arm/vfp/vfpmodule.c   |   28 +++++++++++++++++-----------
 include/linux/cpuhotplug.h |    1 +
 2 files changed, 18 insertions(+), 11 deletions(-)

--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -643,19 +643,19 @@ int vfp_restore_user_hwstate(struct user
  * hardware state at every thread switch.  We clear our held state when
  * a CPU has been killed, indicating that the VFP hardware doesn't contain
  * a threads VFP state.  When a CPU starts up, we re-enable access to the
- * VFP hardware.
- *
- * Both CPU_DYING and CPU_STARTING are called on the CPU which
+ * VFP hardware. The callbacks below are called on the CPU which
  * is being offlined/onlined.
  */
-static int vfp_hotplug(struct notifier_block *b, unsigned long action,
-	void *hcpu)
+static int vfp_dying_cpu(unsigned int cpu)
 {
-	if (action == CPU_DYING || action == CPU_DYING_FROZEN)
-		vfp_current_hw_state[(long)hcpu] = NULL;
-	else if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
-		vfp_enable(NULL);
-	return NOTIFY_OK;
+	vfp_force_reload(cpu, current_thread_info());
+	return 0;
+}
+
+static int vfp_starting_cpu(unsigned int unused)
+{
+	vfp_enable(NULL);
+	return 0;
 }
 
 void vfp_kmode_exception(void)
@@ -732,6 +732,10 @@ static int __init vfp_init(void)
 	unsigned int vfpsid;
 	unsigned int cpu_arch = cpu_architecture();
 
+	/*
+	 * Enable the access to the VFP on all online CPUs so the
+	 * following test on FPSID will succeed.
+	 */
 	if (cpu_arch >= CPU_ARCH_ARMv6)
 		on_each_cpu(vfp_enable, NULL, 1);
 
@@ -794,7 +798,9 @@ static int __init vfp_init(void)
 		VFP_arch = (vfpsid & FPSID_ARCH_MASK) >> FPSID_ARCH_BIT;
 	}
 
-	hotcpu_notifier(vfp_hotplug, 0);
+	cpuhp_setup_state_nocalls(CPUHP_AP_ARM_VFP_STARTING,
+				  "AP_ARM_VFP_STARTING", vfp_starting_cpu,
+				  vfp_dying_cpu);
 
 	vfp_vector = vfp_support_entry;
 
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -35,6 +35,7 @@ enum cpuhp_state {
 	CPUHP_AP_PERF_X86_CQM_STARTING,
 	CPUHP_AP_PERF_X86_CSTATE_STARTING,
 	CPUHP_AP_PERF_XTENSA_STARTING,
+	CPUHP_AP_ARM_VFP_STARTING,
 	CPUHP_AP_NOTIFY_STARTING,
 	CPUHP_AP_ONLINE,
 	CPUHP_TEARDOWN_CPU,
