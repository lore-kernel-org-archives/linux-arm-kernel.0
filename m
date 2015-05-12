From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Tue, 12 May 2015 14:50:06 -0700
Subject: [PATCH tip/core/rcu 8/9] arm: Use common outgoing-CPU-notification
 code
In-Reply-To: <1431467407-1223-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20150512214945.GA813@linux.vnet.ibm.com>
 <1431467407-1223-1-git-send-email-paulmck@linux.vnet.ibm.com>
Message-ID: <1431467407-1223-8-git-send-email-paulmck@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

This commit removes the open-coded CPU-offline notification with new
common code.  In particular, this change avoids calling scheduler code
using RCU from an offline CPU that RCU is ignoring.  This is a minimal
change.  A more intrusive change might invoke the cpu_check_up_prepare()
and cpu_set_state_online() functions at CPU-online time, which would
allow onlining throw an error if the CPU did not go offline properly.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/kernel/smp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

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
-- 
1.8.1.5
