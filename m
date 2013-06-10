From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 10 Jun 2013 12:12:41 -0600
Subject: [PATCH] ARM: decouple CPU offlining from reboot/shutdown
Message-ID: <1370887961-31569-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

machine_shutdown() is a hook for kexec. Add a comment saying so, since
it isn't obvious from the function name.

Halt, power-off, and restart have different requirements re: stopping
secondary CPUs than kexec has. The former simply require the secondary
CPUs to be quiesced somehow, whereas kexec requires them to be completely
non-operational, so that no matter where the kexec target images are
written in RAM, they won't influence operation of the secondary CPUS,
which could happen if the CPUs were still executing some kind of pin
loop. To this end, modify machine_halt, power_off, and restart to call
smp_send_stop() directly, rather than calling machine_shutdown().

Remove smp_kill_cpus(), and its call from smp_send_stop().
smp_kill_cpus() was indirectly calling smp_ops.cpu_kill() without calling
smp_ops.cpu_die() on the target CPUs first. At least some implementations
of smp_ops had issues with this; it caused cpu_kill() to hang on Tegra,
for example. Since smp_send_stop() is only used for shutdown, halt, and
power-off, there is no need to attempt any kind of CPU hotplug here.

In machine_shutdown(), replace the call to smp_send_stop() with a call to
disable_nonboot_cpus(). This completely disables all but one CPU, thus
satisfying the kexec requirements a couple paragraphs above. Add a
BUG_ON() to validate this worked, since that function is not always
available. Adjust Kconfig dependencies for this change.

soft_restart() only restarts the primary CPU. Update it to BUG if any
secondary CPUs are still active. Any SMP system must provide a HW system
reset hook, rather than using soft_restart(). Simplify the code based on
that assumption.

Suggested-by: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
I assume I should add this to the ARM patch tracker if it's OK.
---
 arch/arm/Kconfig          |  2 +-
 arch/arm/kernel/process.c | 28 ++++++++++++++++++++--------
 arch/arm/kernel/smp.c     | 13 -------------
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 42d6ea2..d7b3d2e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2028,7 +2028,7 @@ config XIP_PHYS_ADDR
 
 config KEXEC
 	bool "Kexec system call (EXPERIMENTAL)"
-	depends on (!SMP || HOTPLUG_CPU)
+	depends on (!SMP || (HOTPLUG_CPU && PM_SLEEP_SMP))
 	help
 	  kexec is a system call that implements the ability to shutdown your
 	  current kernel, and to start another kernel.  It is like a reboot
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 282de48..dbe1692 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -97,13 +97,14 @@ void soft_restart(unsigned long addr)
 {
 	u64 *stack = soft_restart_stack + ARRAY_SIZE(soft_restart_stack);
 
+	BUG_ON(num_online_cpus() > 1);
+
 	/* Disable interrupts first */
 	local_irq_disable();
 	local_fiq_disable();
 
-	/* Disable the L2 if we're the last man standing. */
-	if (num_online_cpus() == 1)
-		outer_disable();
+	/* Disable the L2 */
+	outer_disable();
 
 	/* Change to the new stack and continue with the reset. */
 	call_with_stack(__soft_restart, (void *)addr, (void *)stack);
@@ -184,30 +185,41 @@ int __init reboot_setup(char *str)
 
 __setup("reboot=", reboot_setup);
 
+/* For kexec */
 void machine_shutdown(void)
 {
-#ifdef CONFIG_SMP
-	smp_send_stop();
+#ifdef CONFIG_PM_SLEEP_SMP
+	disable_nonboot_cpus();
 #endif
+
+	BUG_ON(num_online_cpus() > 1);
 }
 
 void machine_halt(void)
 {
-	machine_shutdown();
+#ifdef CONFIG_SMP
+	smp_send_stop();
+#endif
+
 	local_irq_disable();
 	while (1);
 }
 
 void machine_power_off(void)
 {
-	machine_shutdown();
+#ifdef CONFIG_SMP
+	smp_send_stop();
+#endif
+
 	if (pm_power_off)
 		pm_power_off();
 }
 
 void machine_restart(char *cmd)
 {
-	machine_shutdown();
+#ifdef CONFIG_SMP
+	smp_send_stop();
+#endif
 
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
