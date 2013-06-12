From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Jun 2013 14:01:21 -0600
Subject: [PATCH V2 2/2] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <1371067281-655-1-git-send-email-swarren@wwwdotorg.org>
References: <1371067281-655-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1371067281-655-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Add comments to machine_shutdown()/halt()/power_off()/restart() that
describe their purpose and/or requirements re: CPUs being active/not.

In machine_shutdown(), replace the call to smp_send_stop() with a call to
disable_nonboot_cpus(). This completely disables all but one CPU, thus
satisfying the requirement that only a single CPU be active for kexec.
Adjust Kconfig dependencies for this change.

In machine_halt()/power_off()/restart(), call smp_send_stop() directly,
rather than via machine_shutdown(); these functions don't need to
completely de-activate all CPUs using hotplug, but rather just quiesce
them.

Remove smp_kill_cpus(), and its call from smp_send_stop().
smp_kill_cpus() was indirectly calling smp_ops.cpu_kill() without calling
smp_ops.cpu_die() on the target CPUs first. At least some implementations
of smp_ops had issues with this; it caused cpu_kill() to hang on Tegra,
for example. Since smp_send_stop() is only used for shutdown, halt, and
power-off, there is no need to attempt any kind of CPU hotplug here.

Adjust Kconfig to reflect that machine_shutdown() (and hence kexec)
relies upon disable_nonboot_cpus(). However, this alone doesn't guarantee
that hotplug will work, or even that hotplug is implemented for a
particular piece of HW that a multi-platform zImage runs on. Hence, add
error-checking to machine_kexec() to determine whether it did work.

Suggested-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2:
* Removed some unnecessary #ifdefs.
* Simplified Kconfig depends for kexec.
* Replace BUG()s with kinder error-checking code.
* Significantly structurally reworked.
---
 arch/arm/Kconfig                |  2 +-
 arch/arm/kernel/machine_kexec.c |  4 ++++
 arch/arm/kernel/process.c       | 43 +++++++++++++++++++++++++++++++++++------
 arch/arm/kernel/smp.c           | 13 -------------
 4 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 42d6ea2..ecab9f7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2028,7 +2028,7 @@ config XIP_PHYS_ADDR
 
 config KEXEC
 	bool "Kexec system call (EXPERIMENTAL)"
-	depends on (!SMP || HOTPLUG_CPU)
+	depends on (!SMP || PM_SLEEP_SMP)
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/arch/arm/kernel/machine_kexec.c b/arch/arm/kernel/machine_kexec.c
index 8ef8c93..4fb074c 100644
--- a/arch/arm/kernel/machine_kexec.c
+++ b/arch/arm/kernel/machine_kexec.c
@@ -134,6 +134,10 @@ void machine_kexec(struct kimage *image)
 	unsigned long reboot_code_buffer_phys;
 	void *reboot_code_buffer;
 
+	if (num_online_cpus() > 1) {
+		pr_err("kexec: error: multiple CPUs still online\n");
+		return;
+	}
 
 	page_list = image->head & PAGE_MASK;
 
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 282de48..6e8931c 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -184,30 +184,61 @@ int __init reboot_setup(char *str)
 
 __setup("reboot=", reboot_setup);
 
+/*
+ * Called by kexec, immediately prior to machine_kexec().
+ *
+ * This must completely disable all secondary CPUs; simply causing those CPUs
+ * to execute e.g. a RAM-based pin loop is not sufficient. This allows the
+ * kexec'd kernel to use any and all RAM as it sees fit, without having to
+ * avoid any code or data used by any SW CPU pin loop. The CPU hotplug
+ * functionality embodied in disable_nonboot_cpus() to achieve this.
+ */
 void machine_shutdown(void)
 {
-#ifdef CONFIG_SMP
-	smp_send_stop();
-#endif
+	disable_nonboot_cpus();
 }
 
+/*
+ * Halting simply requires that the secondary CPUs stop performing any
+ * activity (executing tasks, handling interrupts). smp_send_stop()
+ * achieves this.
+ */
 void machine_halt(void)
 {
-	machine_shutdown();
+	smp_send_stop();
+
 	local_irq_disable();
 	while (1);
 }
 
+/*
+ * Power-off simply requires that the secondary CPUs stop performing any
+ * activity (executing tasks, handling interrupts). smp_send_stop()
+ * achieves this. When the system power is turned off, it will take all CPUs
+ * with it.
+ */
 void machine_power_off(void)
 {
-	machine_shutdown();
+	smp_send_stop();
+
 	if (pm_power_off)
 		pm_power_off();
 }
 
+/*
+ * Restart requires that the secondary CPUs stop performing any activity
+ * while the primary CPU resets the system. Systems with a single CPU can
+ * use soft_restart() as their machine descriptor's .restart hook, since that
+ * will cause the only available CPU to reset. Systems with multiple CPUs must
+ * provide a HW restart implementation, to ensure that all CPUs reset at once.
+ * This is required so that any code running after reset on the primary CPU
+ * doesn't have to co-ordinate with other CPUs to ensure they aren't still
+ * executing pre-reset code, and using RAM that the primary CPU's code wishes
+ * to use. Implementing such co-ordination would be essentially impossible.
+ */
 void machine_restart(char *cmd)
 {
-	machine_shutdown();
+	smp_send_stop();
 
 	arm_pm_restart(reboot_mode, cmd);
 
diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 550d63c..5919eb4 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -651,17 +651,6 @@ void smp_send_reschedule(int cpu)
 	smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
-static void smp_kill_cpus(cpumask_t *mask)
-{
-	unsigned int cpu;
-	for_each_cpu(cpu, mask)
-		platform_cpu_kill(cpu);
-}
-#else
-static void smp_kill_cpus(cpumask_t *mask) { }
-#endif
-
 void smp_send_stop(void)
 {
 	unsigned long timeout;
@@ -679,8 +668,6 @@ void smp_send_stop(void)
 
 	if (num_online_cpus() > 1)
 		pr_warning("SMP: failed to stop secondary CPUs\n");
-
-	smp_kill_cpus(&mask);
 }
 
 /*
-- 
1.8.1.5
