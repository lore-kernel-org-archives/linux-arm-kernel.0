From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 May 2015 14:52:21 +0100
Subject: [PATCHv3 03/12] arm64: smp: consistently use error codes
In-Reply-To: <1432648350-5454-1-git-send-email-mark.rutland@arm.com>
References: <1432648350-5454-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1432648350-5454-4-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpu_kill currently returns one for success and zero for failure, which
is unlike all the other cpu_operations, which return zero for success
and an error code upon failure. This difference is unnecessarily
confusing.

Make cpu_kill consistent with the other cpu_operations.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/psci.c |  7 +++----
 arch/arm64/kernel/smp.c  | 10 +++++++---
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index efe3480..17e717c 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -501,7 +501,7 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
 	int err, i;
 
 	if (!psci_ops.affinity_info)
-		return 1;
+		return 0;
 	/*
 	 * cpu_kill could race with cpu_die and we can
 	 * potentially end up declaring this cpu undead
@@ -512,7 +512,7 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
 		err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
 		if (err == PSCI_0_2_AFFINITY_LEVEL_OFF) {
 			pr_info("CPU%d killed.\n", cpu);
-			return 1;
+			return 0;
 		}
 
 		msleep(10);
@@ -521,8 +521,7 @@ static int cpu_psci_cpu_kill(unsigned int cpu)
 
 	pr_warn("CPU%d may not have shut down cleanly (AFFINITY_INFO reports %d)\n",
 			cpu, err);
-	/* Make op_cpu_kill() fail. */
-	return 0;
+	return -ETIMEDOUT;
 }
 #endif
 #endif
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b698208..2b503a3 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -249,7 +249,7 @@ static int op_cpu_kill(unsigned int cpu)
 	 * time and hope that it's dead, so let's skip the wait and just hope.
 	 */
 	if (!cpu_ops[cpu]->cpu_kill)
-		return 1;
+		return 0;
 
 	return cpu_ops[cpu]->cpu_kill(cpu);
 }
@@ -262,6 +262,8 @@ static DECLARE_COMPLETION(cpu_died);
  */
 void __cpu_die(unsigned int cpu)
 {
+	int err;
+
 	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
 		pr_crit("CPU%u: cpu didn't die\n", cpu);
 		return;
@@ -274,8 +276,10 @@ void __cpu_die(unsigned int cpu)
 	 * verify that it has really left the kernel before we consider
 	 * clobbering anything it might still be using.
 	 */
-	if (!op_cpu_kill(cpu))
-		pr_warn("CPU%d may not have shut down cleanly\n", cpu);
+	err = op_cpu_kill(cpu);
+	if (err)
+		pr_warn("CPU%d may not have shut down cleanly: %d\n",
+			cpu, err);
 }
 
 /*
-- 
1.9.1
