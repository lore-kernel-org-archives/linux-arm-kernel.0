From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 18 Nov 2015 17:08:59 +0000
Subject: [PATCH 4/5] arm64: Make fail_incapable_cpu reusable
In-Reply-To: <1447866540-23207-1-git-send-email-suzuki.poulose@arm.com>
References: <1447866238-22970-1-git-send-email-suzuki.poulose@arm.com>
 <1447866540-23207-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1447866540-23207-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Refactors the code to get rid of the depenency on the capability
for fail_incapable_cpu(), so that it can be used by other checks.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c |   24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0669c63..5629f2c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -826,15 +826,15 @@ static u64 __raw_read_system_reg(u32 sys_id)
 }
 
 /*
- * Park the CPU which doesn't have the capability as advertised
- * by the system.
+ * Park the calling CPU which doesn't have the capability
+ * as advertised by the system.
  */
-static void fail_incapable_cpu(char *cap_type,
-				 const struct arm64_cpu_capabilities *cap)
+static void fail_incapable_cpu(void)
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
+			fail_incapable_cpu();
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
+			fail_incapable_cpu();
+		}
 	}
 }
 
-- 
1.7.9.5
