From: paulmck@linux.vnet.ibm.com (Paul E. McKenney)
Date: Tue, 12 May 2015 14:50:05 -0700
Subject: [PATCH tip/core/rcu 7/9] arm64: Use common outgoing-CPU-notification
 code
In-Reply-To: <1431467407-1223-1-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20150512214945.GA813@linux.vnet.ibm.com>
 <1431467407-1223-1-git-send-email-paulmck@linux.vnet.ibm.com>
Message-ID: <1431467407-1223-7-git-send-email-paulmck@linux.vnet.ibm.com>
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
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/smp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 2cb008177252..a899c1beff54 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -253,15 +253,13 @@ static int op_cpu_kill(unsigned int cpu)
 	return cpu_ops[cpu]->cpu_kill(cpu);
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
 		pr_crit("CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
@@ -294,7 +292,7 @@ void cpu_die(void)
 	local_irq_disable();
 
 	/* Tell __cpu_die() that this CPU is now safe to dispose of */
-	complete(&cpu_died);
+	(void)cpu_report_death();
 
 	/*
 	 * Actually shutdown the CPU. This must never fail. The specific hotplug
-- 
1.8.1.5
