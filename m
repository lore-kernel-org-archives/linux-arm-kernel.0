From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Jan 2018 12:27:58 +0000
Subject: [PATCH 05/16] arm64: Add flags to check the safety of a capability
 for late CPU
In-Reply-To: <20180123122809.16269-1-suzuki.poulose@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
Message-ID: <20180123122809.16269-6-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add two different flags to indicate if the conflict of a capability
on a late CPU with the current system state

 1) Can a CPU have a capability when the system doesn't have it ?

    Most arm64 features could have this set. While erratum work arounds
    cannot have this, as we may miss work arounds.

 2) Can a CPU miss a capability when the system has it ?
    This could be set for arm64 erratum work arounds as we don't
    care if a CPU doesn't need the work around. However it should
    be clear for features.

These flags could be added to certain entries based on their nature.

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 4fd5de8ef33e..27d037bb0451 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -94,10 +94,25 @@ extern struct arm64_ftr_reg arm64_ftr_reg_ctrel0;
 #define SCOPE_SYSTEM				ARM64_CPUCAP_SCOPE_SYSTEM
 #define SCOPE_LOCAL_CPU				ARM64_CPUCAP_SCOPE_LOCAL_CPU
 
-/* CPU errata detected at boot time based on feature of one or more CPUs */
-#define ARM64_CPUCAP_STRICT_CPU_LOCAL_ERRATUM	(ARM64_CPUCAP_SCOPE_LOCAL_CPU)
-/* CPU feature detected at boot time based on system-wide value of a feature */
-#define ARM64_CPUCAP_BOOT_SYSTEM_FEATURE	(ARM64_CPUCAP_SCOPE_SYSTEM)
+/* Is it safe for a late CPU to have this capability when system doesn't already have */
+#define ARM64_CPUCAP_LATE_CPU_SAFE_TO_HAVE	BIT(2)
+/* Is it safe for a late CPU to miss this capability when system has it */
+#define ARM64_CPUCAP_LATE_CPU_SAFE_TO_MISS	BIT(3)
+
+/*
+ * CPU errata detected at boot time based on feature of one or more CPUs.
+ * It is not safe for a late CPU to have this feature when the system doesn't
+ * have it. But it is safe to miss the feature if the system has it.
+ */
+#define ARM64_CPUCAP_STRICT_CPU_LOCAL_ERRATUM	\
+	(ARM64_CPUCAP_SCOPE_LOCAL_CPU | ARM64_CPUCAP_LATE_CPU_SAFE_TO_MISS)
+/*
+ * CPU feature detected at boot time based on system-wide value of a feature.
+ * It is safe for a late CPU to have this feature even though the system doesn't
+ * have it already. But the CPU must have this feature if the system does.
+ */
+#define ARM64_CPUCAP_BOOT_SYSTEM_FEATURE	\
+	(ARM64_CPUCAP_SCOPE_SYSTEM | ARM64_CPUCAP_LATE_CPU_SAFE_TO_HAVE)
 
 struct arm64_cpu_capabilities {
 	const char *desc;
@@ -128,6 +143,18 @@ static inline int cpucap_default_scope(const struct arm64_cpu_capabilities *cap)
 	return cap->type & ARM64_CPUCAP_SCOPE_MASK;
 }
 
+static inline bool
+cpucap_late_cpu_missing_cap_safe(const struct arm64_cpu_capabilities *cap)
+{
+	return !!(cap->type & ARM64_CPUCAP_LATE_CPU_SAFE_TO_MISS);
+}
+
+static inline bool
+cpucap_late_cpu_have_cap_safe(const struct arm64_cpu_capabilities *cap)
+{
+	return !!(cap->type & ARM64_CPUCAP_LATE_CPU_SAFE_TO_HAVE);
+}
+
 extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 extern struct static_key_false cpu_hwcap_keys[ARM64_NCAPS];
 extern struct static_key_false arm64_const_caps_ready;
-- 
2.13.6
