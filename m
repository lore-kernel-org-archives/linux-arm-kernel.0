From: arunks.linux@gmail.com (arunks.linux at gmail.com)
Date: Tue,  6 May 2014 21:25:07 +0530
Subject: arm64: Fix machine_shutdown() definition
Message-ID: <1399391708-13442-1-git-send-email-arunks.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arun KS <arun.linux@gmail.com>

machine_shutdown() is a hook for kexec. Add a comment saying so, since
it isn't obvious from the function name.

Halt, power-off, and restart have different requirements re: stopping
secondary CPUs than kexec has. The former simply require the secondary
CPUs to be quiesced somehow, whereas kexec requires them to be
completely non-operational, so that no matter where the kexec target
images are written in RAM, they won't influence operation of the
secondary CPUS,which could happen if the CPUs were still executing some
kind of pin loop. To this end, modify machine_halt, power_off, and
restart to call smp_send_stop() directly, rather than calling
machine_shutdown().

In machine_shutdown(), replace the call to smp_send_stop() with a call
to disable_nonboot_cpus(). This completely disables all but one CPU,
thus satisfying the kexec requirements a couple paragraphs above.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
Signed-off-by: Arun KS <getarunks@gmail.com>
Signed-off-by: Arun KS <arunks.linux@gmail.com>
---
 arch/arm64/kernel/process.c |   41 +++++++++++++++++++++++++++++++++++------
 1 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 6391485..2d43614 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -113,29 +113,58 @@ void arch_cpu_idle_dead(void)
 }
 #endif
 
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
 
 	/* Disable interrupts first */
 	local_irq_disable();
-- 
1.7.6
