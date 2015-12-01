From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue,  1 Dec 2015 15:12:06 +0000
Subject: [PATCH v2 1/6] arm64: Introduce kill_cpu_early
In-Reply-To: <1448982731-17182-1-git-send-email-suzuki.poulose@arm.com>
References: <1448982731-17182-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1448982731-17182-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Or in other words, make fail_incapable_cpu() reusable.

We use fail_incapable_cpu() to kill a secondary CPU early during the
bringup, which doesn't have the system advertised capabilities.
This patch makes the routine more generic, to kill a secondary
booting CPU, getting rid of the dependency on capability struct.
This can be used by checks which are not necessarily attached to
a capability struct (e.g, cpu ASIDBits).

In that process, renames the function to kill_cpu_early() to better
match its functionality. This will be later moved to arch/arm64/kernel/smp.c.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0669c63..a7e2262 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -826,15 +826,15 @@ static u64 __raw_read_system_reg(u32 sys_id)
 }
 
 /*
- * Park the CPU which doesn't have the capability as advertised
- * by the system.
+ * Kill the calling secondary CPU, early in bringup before it is turned
+ * online.
  */
-static void fail_incapable_cpu(char *cap_type,
-				 const struct arm64_cpu_capabilities *cap)
+void kill_cpu_early(void)
 {
 	int cpu = smp_processor_id();
 
-	pr_crit("CPU%d: missing %s : %s\n", cpu, cap_type, cap->desc);
+	pr_crit("CPU%d: will not boot\n", cpu);
+
 	/* Mark this CPU absent */
 	set_cpu_present(cpu, 0);
 
@@ -875,8 +875,11 @@ void verify_local_cpu_capabilities(void)
 		 * If the new CPU misses an advertised feature, we cannot proceed
 		 * further, park the cpu.
 		 */
-		if (!feature_matches(__raw_read_system_reg(caps[i].sys_reg), &caps[i]))
-			fail_incapable_cpu("arm64_features", &caps[i]);
+		if (!feature_matches(__raw_read_system_reg(caps[i].sys_reg), &caps[i])) {
+			pr_crit("CPU%d: missing feature: %s\n",
+					smp_processor_id(), caps[i].desc);
+			kill_cpu_early();
+		}
 		if (caps[i].enable)
 			caps[i].enable(NULL);
 	}
@@ -884,8 +887,11 @@ void verify_local_cpu_capabilities(void)
 	for (i = 0, caps = arm64_hwcaps; caps[i].desc; i++) {
 		if (!cpus_have_hwcap(&caps[i]))
 			continue;
-		if (!feature_matches(__raw_read_system_reg(caps[i].sys_reg), &caps[i]))
-			fail_incapable_cpu("arm64_hwcaps", &caps[i]);
+		if (!feature_matches(__raw_read_system_reg(caps[i].sys_reg), &caps[i])) {
+			pr_crit("CPU%d: missing HWCAP: %s\n",
+					smp_processor_id(), caps[i].desc);
+			kill_cpu_early();
+		}
 	}
 }
 
-- 
1.7.9.5
