From: vnkgutta@codeaurora.org (Venkata Narendra Kumar Gutta)
Date: Thu, 19 Jul 2018 15:18:46 -0700
Subject: [PATCH] ARM64: smp: Fix cpu_up() racing with sys_reboot
Message-ID: <1532038726-3376-1-git-send-email-vnkgutta@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing stops a process from hotplugging in a CPU concurrently
with a sys_reboot() call. In such a situation we could have
ipi_cpu_stop() mark a cpu as 'offline' and _cpu_up() ignore the
fact that the CPU is not really offline and call the
CPU_UP_PREPARE notifier. When this happens stop_machine code will
complain that the cpu thread already exists and BUG_ON().

CPU0                      CPU1

 sys_reboot()
 kernel_restart()
 machine_restart()
 machine_shutdown()
 smp_send_stop()
 ...                   ipi_cpu_stop()
		       set_cpu_online(1, false)
                       local_irq_disable()
                       while(1)
        <PREEMPT>
 cpu_up()
 _cpu_up()
 if (!cpu_online(1))
 __cpu_notify(CPU_UP_PREPARE...)

 cpu_stop_cpu_callback()
 BUG_ON(stopper->thread)

This is easily reproducible by hotplugging in and out in a tight
loop while also rebooting.

Since the CPU is not really offline and hasn't gone through the
proper steps to be marked as such, let's mark the CPU as inactive.
This is just as easily testable as online and avoids any possibility
of _cpu_up() trying to bring the CPU back online when it never was
offline to begin with. Based on the similar patchset by for arm
targets 040c163( "ARM: smp: Fix cpu_up() racing with sys_reboot)"

Signed-off-by: Abhimanyu Kapur <abhimany@codeaurora.org>
Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
---
 arch/arm64/kernel/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 2faa986..adee4d3 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -790,7 +790,7 @@ void arch_irq_work_raise(void)
  */
 static void ipi_cpu_stop(unsigned int cpu)
 {
-	set_cpu_online(cpu, false);
+	set_cpu_active(cpu, false);
 
 	local_daif_mask();
 	sdei_mask_local_cpu();
@@ -925,10 +925,10 @@ void smp_send_stop(void)
 
 	/* Wait up to one second for other CPUs to stop */
 	timeout = USEC_PER_SEC;
-	while (num_online_cpus() > 1 && timeout--)
+	while (num_active_cpus() > 1 && timeout--)
 		udelay(1);
 
-	if (num_online_cpus() > 1)
+	if (num_active_cpus() > 1)
 		pr_warning("SMP: failed to stop secondary CPUs %*pbl\n",
 			   cpumask_pr_args(cpu_online_mask));
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
