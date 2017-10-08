From: leo.yan@linaro.org (Leo Yan)
Date: Sun,  8 Oct 2017 22:12:46 +0800
Subject: [PATCH] arm64: kdump: Avoid to power off nonpanic CPUs
Message-ID: <1507471966-15367-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit a88ce63b642c ("arm64: kexec: have own crash_smp_send_stop() for
crash dump for nonpanic cores") introduces ARM64 architecture function
crash_smp_send_stop() to replace the weak function, this results in
the nonpanic CPUs to be hot-plugged out and CPUs are placed into low
power state on ARM64 platforms with the flow:

  Panic CPU:
    machine_crash_shutdown()
      crash_smp_send_stop()
	smp_cross_call(&mask, IPI_CPU_CRASH_STOP)

  Nonpanic CPUs:
    handle_IPI()
      ipi_cpu_crash_stop()
        cpu_ops[cpu]->cpu_die()

The upper patch has no issue if enabled crash dump only; but if enabled
crash dump and Coresight debug module for panic dumping at the meantime,
nonpanic CPUs are powered off in crash dump flow, later this may
introduce conflicts with the Coresight debug module because Coresight
debug registers dumping requires the CPU must be powered on for some
platforms (e.g. Hi6220 on Hikey board). If we cannot keep the CPUs
powered on, we can see the hardware lockup issue when access Coresight
debug registers.

To fix this issue, this commit removes CPU hotplug operation in func
crash_smp_send_stop() and let CPUs to run into WFE/WFI states so CPUs
can still be powered on after crash dump. This finally is more safe
for Coresight debug module to dump registers and avoid hardware lockup.

Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/kernel/smp.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 9f7195a..a65e68b 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -856,12 +856,6 @@ static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
 
 	local_irq_disable();
 
-#ifdef CONFIG_HOTPLUG_CPU
-	if (cpu_ops[cpu]->cpu_die)
-		cpu_ops[cpu]->cpu_die(cpu);
-#endif
-
-	/* just in case */
 	cpu_park_loop();
 #endif
 }
-- 
2.7.4
