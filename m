From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  5 Nov 2018 11:55:16 +0000
Subject: [PATCH 6/7] arm64: capabilities: Use linear array for detection and
 verification
In-Reply-To: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
References: <1541418917-14219-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1541418917-14219-7-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the sorted list of capability entries for the detection and
verification.

Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 96e687e..fff430d 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1508,28 +1508,25 @@ static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 			cap_set_elf_hwcap(hwcaps);
 }
 
-static void __update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
-				      u16 scope_mask, const char *info)
+static void update_cpu_capabilities(u16 scope_mask)
 {
+	int i;
+	const struct arm64_cpu_capabilities *caps;
+
 	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
-	for (; caps->matches; caps++) {
-		if (!(caps->type & scope_mask) ||
+	for (i = 0; i < ARM64_NCAPS; i++) {
+		caps = cpu_hwcaps_ptrs[i];
+		if (!caps || !(caps->type & scope_mask) ||
+		    cpus_have_cap(caps->capability) ||
 		    !caps->matches(caps, cpucap_default_scope(caps)))
 			continue;
 
-		if (!cpus_have_cap(caps->capability) && caps->desc)
-			pr_info("%s %s\n", info, caps->desc);
+		if (caps->desc)
+			pr_info("detected: %s\n", caps->desc);
 		cpus_set_cap(caps->capability);
 	}
 }
 
-static void update_cpu_capabilities(u16 scope_mask)
-{
-	__update_cpu_capabilities(arm64_errata, scope_mask,
-				  "enabling workaround for");
-	__update_cpu_capabilities(arm64_features, scope_mask, "detected:");
-}
-
 static int __enable_cpu_capability(void *arg)
 {
 	const struct arm64_cpu_capabilities *cap = arg;
@@ -1593,16 +1590,17 @@ static void __init enable_cpu_capabilities(u16 scope_mask)
  *
  * Returns "false" on conflicts.
  */
-static bool
-__verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps,
-			u16 scope_mask)
+static bool verify_local_cpu_caps(u16 scope_mask)
 {
+	int i;
 	bool cpu_has_cap, system_has_cap;
+	const struct arm64_cpu_capabilities *caps;
 
 	scope_mask &= ARM64_CPUCAP_SCOPE_MASK;
 
-	for (; caps->matches; caps++) {
-		if (!(caps->type & scope_mask))
+	for (i = 0; i < ARM64_NCAPS; i++) {
+		caps = cpu_hwcaps_ptrs[i];
+		if (!caps || !(caps->type & scope_mask))
 			continue;
 
 		cpu_has_cap = caps->matches(caps, SCOPE_LOCAL_CPU);
@@ -1633,7 +1631,7 @@ __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps,
 		}
 	}
 
-	if (caps->matches) {
+	if (i < ARM64_NCAPS) {
 		pr_crit("CPU%d: Detected conflict for capability %d (%s), System: %d, CPU: %d\n",
 			smp_processor_id(), caps->capability,
 			caps->desc, system_has_cap, cpu_has_cap);
@@ -1643,12 +1641,6 @@ __verify_local_cpu_caps(const struct arm64_cpu_capabilities *caps,
 	return true;
 }
 
-static bool verify_local_cpu_caps(u16 scope_mask)
-{
-	return __verify_local_cpu_caps(arm64_errata, scope_mask) &&
-	       __verify_local_cpu_caps(arm64_features, scope_mask);
-}
-
 /*
  * Check for CPU features that are used in early boot
  * based on the Boot CPU value.
-- 
2.7.4
