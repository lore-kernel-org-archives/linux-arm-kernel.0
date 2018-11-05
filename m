From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  5 Nov 2018 11:55:15 +0000
Subject: [PATCH 5/7] arm64: capabilities: Optimize this_cpu_has_cap
In-Reply-To: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
References: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1541418917-14219-6-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make use of the sorted capability list to access the capability
entry in this_cpu_has_cap() to avoid iterating over the two
tables.

Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7e9ebbe..96e687e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1508,25 +1508,6 @@ static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 			cap_set_elf_hwcap(hwcaps);
 }
 
-/*
- * Check if the current CPU has a given feature capability.
- * Should be called from non-preemptible context.
- */
-static bool __this_cpu_has_cap(const struct arm64_cpu_capabilities *cap_array,
-			       unsigned int cap)
-{
-	const struct arm64_cpu_capabilities *caps;
-
-	if (WARN_ON(preemptible()))
-		return false;
-
-	for (caps = cap_array; caps->matches; caps++)
-		if (caps->capability == cap)
-			return caps->matches(caps, SCOPE_LOCAL_CPU);
-
-	return false;
-}
-
 static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 				      u16 scope_mask, const char *info)
 {
@@ -1776,10 +1757,16 @@ static void __init mark_const_caps_ready(void)
 	static_branch_enable(&arm64_const_caps_ready);
 }
 
-bool this_cpu_has_cap(unsigned int cap)
+bool this_cpu_has_cap(unsigned int n)
 {
-	return (__this_cpu_has_cap(arm64_features, cap) ||
-		__this_cpu_has_cap(arm64_errata, cap));
+	if (!WARN_ON(preemptible()) && n < ARM64_NCAPS) {
+		const struct arm64_cpu_capabilities *cap = cpu_hwcaps_ptrs[n];
+
+		if (cap)
+			return cap->matches(cap, SCOPE_LOCAL_CPU);
+	}
+
+	return false;
 }
 
 static void __init setup_system_capabilities(void)
-- 
2.7.4
