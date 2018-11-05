From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  5 Nov 2018 11:55:17 +0000
Subject: [PATCH 7/7] arm64: capabilities: Batch cpu_enable callbacks
In-Reply-To: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
References: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1541418917-14219-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We use a stop_machine call for each available capability to
enable it on all the CPUs available at boot time. Instead
we could batch the cpu_enable callbacks to a single stop_machine()
call to save us some time.

Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  3 ++
 arch/arm64/kernel/cpufeature.c      | 70 +++++++++++++++++++++++--------------
 2 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 7e2ec64..0a15e2c 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -357,6 +357,9 @@ extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
 extern struct static_key_false arm64_const_caps_ready;
 
+#define for_each_available_cap(cap)		\
+	for_each_set_bit(cap, cpu_hwcaps, ARM64_NCAPS)
+
 bool this_cpu_has_cap(unsigned int cap);
 
 static inline bool cpu_have_feature(unsigned int num)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index fff430d..9a1cccc 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1527,11 +1527,27 @@ static void update_cpu_capabilities(u16 scope_mask)
 	}
 }
 
-static int __enable_cpu_capability(void *arg)
+/*
+ * Enable all the available capabilities on this CPU. The capabilities
+ * with BOOT_CPU scope are handled separately and hence skipped here.
+ */
+static int cpu_enable_non_boot_scope_capabilities(void *__unused)
 {
-	const struct arm64_cpu_capabilities *cap = arg;
+	int i;
+	u16 non_boot_scope = SCOPE_ALL & ~SCOPE_BOOT_CPU;
 
-	cap->cpu_enable(cap);
+	for_each_available_cap(i) {
+		const struct arm64_cpu_capabilities *cap = cpu_hwcaps_ptrs[i];
+
+		if (WARN_ON(!cap))
+			continue;
+
+		if (!(cap->type & non_boot_scope))
+			continue;
+
+		if (cap->cpu_enable)
+			cap->cpu_enable(cap);
+	}
 	return 0;
 }
 
@@ -1539,21 +1555,29 @@ static int __enable_cpu_capability(void *arg)
  * Run through the enabled capabilities and enable() it on all active
  * CPUs
  */
-static void __init
-__enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-			  u16 scope_mask)
+static void __init enable_cpu_capabilities(u16 scope_mask)
 {
+	int i;
+	const struct arm64_cpu_capabilities *caps;
+	bool boot_scope;
+
 	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
-	for (; caps->matches; caps++) {
-		unsigned int num = caps->capability;
+	boot_scope = !!(scope_mask & SCOPE_BOOT_CPU);
 
-		if (!(caps->type & scope_mask) || !cpus_have_cap(num))
+	for (i = 0; i < ARM64_NCAPS; i++) {
+		unsigned int num;
+
+		caps = cpu_hwcaps_ptrs[i];
+		if (!caps || !(caps->type & scope_mask))
+			continue;
+		num = caps->capability;
+		if (!cpus_have_cap(num))
 			continue;
 
 		/* Ensure cpus_have_const_cap(num) works */
 		static_branch_enable(&cpu_hwcap_keys[num]);
 
-		if (caps->cpu_enable) {
+		if (boot_scope && caps->cpu_enable)
 			/*
 			 * Capabilities with SCOPE_BOOT_CPU scope are finalised
 			 * before any secondary CPU boots. Thus, each secondary
@@ -1562,25 +1586,19 @@ __enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			 * the boot CPU, for which the capability must be
 			 * enabled here. This approach avoids costly
 			 * stop_machine() calls for this case.
-			 *
-			 * Otherwise, use stop_machine() as it schedules the
-			 * work allowing us to modify PSTATE, instead of
-			 * on_each_cpu() which uses an IPI, giving us a PSTATE
-			 * that disappears when we return.
 			 */
-			if (scope_mask & SCOPE_BOOT_CPU)
-				caps->cpu_enable(caps);
-			else
-				stop_machine(__enable_cpu_capability,
-					     (void *)caps, cpu_online_mask);
-		}
+			caps->cpu_enable(caps);
 	}
-}
 
-static void __init enable_cpu_capabilities(u16 scope_mask)
-{
-	__enable_cpu_capabilities(arm64_errata, scope_mask);
-	__enable_cpu_capabilities(arm64_features, scope_mask);
+	/*
+	 * For all non-boot scope capabilities, use stop_machine()
+	 * as it schedules the work allowing us to modify PSTATE,
+	 * instead of on_each_cpu() which uses an IPI, giving us a
+	 * PSTATE that disappears when we return.
+	 */
+	if (!boot_scope)
+		stop_machine(cpu_enable_non_boot_scope_capabilities,
+			     NULL, cpu_online_mask);
 }
 
 /*
-- 
2.7.4
