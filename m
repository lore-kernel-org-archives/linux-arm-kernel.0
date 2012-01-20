From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 10:03:24 +0000
Subject: [PATCH] ARM: SMP: use a timing out completion for cpu hotplug
Message-ID: <E1RoBJc-0005UK-7t@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than open-coding the jiffy-based wait, and polling for the
secondary CPU to come online, use a completion instead.  This
removes the need to poll, instead we will be notified when the
secondary CPU has initialized.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/smp.c |   17 ++++++-----------
 1 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 57db122..2b26dca 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -58,6 +58,8 @@ enum ipi_msg_type {
 	IPI_CPU_STOP,
 };
 
+static DECLARE_COMPLETION(cpu_running);
+
 int __cpuinit __cpu_up(unsigned int cpu)
 {
 	struct cpuinfo_arm *ci = &per_cpu(cpu_data, cpu);
@@ -98,20 +100,12 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	 */
 	ret = boot_secondary(cpu, idle);
 	if (ret == 0) {
-		unsigned long timeout;
-
 		/*
 		 * CPU was successfully started, wait for it
 		 * to come online or time out.
 		 */
-		timeout = jiffies + HZ;
-		while (time_before(jiffies, timeout)) {
-			if (cpu_online(cpu))
-				break;
-
-			udelay(10);
-			barrier();
-		}
+		wait_for_completion_timeout(&cpu_running,
+						 msecs_to_jiffies(1000));
 
 		if (!cpu_online(cpu)) {
 			pr_crit("CPU%u: failed to come online\n", cpu);
@@ -300,9 +294,10 @@ asmlinkage void __cpuinit secondary_start_kernel(void)
 	/*
 	 * OK, now it's safe to let the boot CPU continue.  Wait for
 	 * the CPU migration code to notice that the CPU is online
-	 * before we continue.
+	 * before we continue - which happens after __cpu_up returns.
 	 */
 	set_cpu_online(cpu, true);
+	complete(&cpu_running);
 
 	/*
 	 * Setup the percpu timer for this CPU.
-- 
1.7.4.4
