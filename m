From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Jan 2018 12:28:02 +0000
Subject: [PATCH 09/16] arm64: capabilities: Introduce strict features based on
 local CPU
In-Reply-To: <20180123122809.16269-1-suzuki.poulose@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
Message-ID: <20180123122809.16269-10-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add type for features that are detected on individual CPUs,
rather than on a system wide safe features. This behavior
is similar to that of a strict cpu erratum, where a later
CPU is not allowed to boot if the system doesn't posses it.

Use this for software prefetching capability.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 7 +++++++
 arch/arm64/kernel/cpufeature.c      | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index a621d2184227..4c3d6987acfc 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -118,6 +118,13 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
  */
 #define ARM64_CPUCAP_BOOT_SYSTEM_FEATURE	\
 	(ARM64_CPUCAP_SCOPE_SYSTEM | ARM64_CPUCAP_LATE_CPU_SAFE_TO_HAVE)
+/*
+ * CPU feature detected at boot time based on feature of one or more CPUs.
+ * It is not safe for a late CPU to have this feature, when the system doesn't
+ * have it. But it is safe to miss the feature if the system has it.
+ */
+#define ARM64_CPUCAP_STRICT_CPU_LOCAL_FEATURE	\
+	(ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_LATE_CPU_SAFE_TO_MISS)
 
 struct arm64_cpu_capabilities {
 	const char *desc;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 7ae5cf9092d0..111f6c4b4cd7 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -951,7 +951,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "Software prefetching using PRFM",
 		.capability = ARM64_HAS_NO_HW_PREFETCH,
-		.type = ARM64_CPUCAP_BOOT_SYSTEM_FEATURE,
+		.type = ARM64_CPUCAP_STRICT_CPU_LOCAL_FEATURE,
 		.matches = has_no_hw_prefetch,
 	},
 #ifdef CONFIG_ARM64_UAO
-- 
2.13.6
