From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Thu, 21 May 2015 20:29:21 -0700
Subject: Deferring ARM CPU-hotplug patch to 4.3
Message-ID: <20150522032921.GA28740@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!

I haven't heard from you on the patch below, so I am deferring it
to 4.3.  If I don't hear from you by the 4.3 merge window, I will
assume that you have fixed this some other way and drop it completely.

						Thanx, Paul

------------------------------------------------------------------------

    arm: Use common outgoing-CPU-notification code
    
    This commit removes the open-coded CPU-offline notification with new
    common code.  In particular, this change avoids calling scheduler code
    using RCU from an offline CPU that RCU is ignoring.  This is a minimal
    change.  A more intrusive change might invoke the cpu_check_up_prepare()
    and cpu_set_state_online() functions at CPU-online time, which would
    allow onlining throw an error if the CPU did not go offline properly.
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: linux-arm-kernel at lists.infradead.org
    Cc: Russell King <linux@arm.linux.org.uk>

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index cca5b8758185..8ef0ef0287ee 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -218,15 +218,13 @@ int __cpu_disable(void)
 	return 0;
 }
 
-static DECLARE_COMPLETION(cpu_died);
-
 /*
  * called on the thread which is asking for a CPU to be shutdown -
  * waits until shutdown has completed, or it is timed out.
  */
 void __cpu_die(unsigned int cpu)
 {
-	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
+	if (!cpu_wait_death(cpu, 5)) {
 		pr_err("CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
@@ -272,7 +270,7 @@ void __ref cpu_die(void)
 	 * this returns, power and/or clocks can be removed at any point
 	 * from this CPU and its cache by platform_cpu_kill().
 	 */
-	complete(&cpu_died);
+	(void)cpu_report_death();
 
 	/*
 	 * Ensure that the cache lines associated with that completion are
