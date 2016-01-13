From: apinski@cavium.com (Andrew Pinski)
Date: Tue, 12 Jan 2016 23:08:15 -0800
Subject: [PATCH 1/5] ARM64: Support midr detected cpufeature
In-Reply-To: <1452668899-3553-1-git-send-email-apinski@cavium.com>
References: <1452668899-3553-1-git-send-email-apinski@cavium.com>
Message-ID: <1452668899-3553-2-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A soon to be added feature is marking the need for
software prefetching of 128 byte cache line.
This feature is not detected via bits of a system register
but rather matching of the Machine ID register.
This adds support for detecting a cpufeature by the MIDR.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/include/asm/cpufeature.h |   26 ++++++++++++++++++++++++--
 arch/arm64/include/asm/cputype.h    |    7 +++++++
 arch/arm64/kernel/cpu_errata.c      |   26 --------------------------
 arch/arm64/kernel/cpufeature.c      |   21 ++++++++++++++++++++-
 4 files changed, 51 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 8136afc..92aaac6 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -11,6 +11,7 @@
 
 #include <asm/hwcap.h>
 #include <asm/sysreg.h>
+#include <asm/cputype.h>
 
 /*
  * In the arm64 world (as in the ARM world), elf_hwcap is used both internally
@@ -78,14 +79,14 @@ struct arm64_cpu_capabilities {
 	u16 capability;
 	bool (*matches)(const struct arm64_cpu_capabilities *);
 	void (*enable)(void *);		/* Called on all active CPUs */
+	u32 sys_reg;
 	union {
-		struct {	/* To be used for erratum handling only */
+		struct {	/* MIDR matching used if sys_reg is SYS_MIDR_EL1. */
 			u32 midr_model;
 			u32 midr_range_min, midr_range_max;
 		};
 
 		struct {	/* Feature register checking */
-			u32 sys_reg;
 			int field_pos;
 			int min_field_value;
 			int hwcap_type;
@@ -94,6 +95,27 @@ struct arm64_cpu_capabilities {
 	};
 };
 
+static bool __maybe_unused
+is_affected_midr_range(const struct arm64_cpu_capabilities *entry)
+{
+		u32 midr = read_cpuid_id();
+
+		if ((midr & CPU_MODEL_MASK) != entry->midr_model)
+				return false;
+
+		midr &= MIDR_REVISION_MASK | MIDR_VARIANT_MASK;
+
+		return (midr >= entry->midr_range_min && midr <= entry->midr_range_max);
+}
+
+#define MIDR_RANGE(model, min, max) \
+		.matches = is_affected_midr_range, \
+		.sys_reg = SYS_MIDR_EL1, \
+		.midr_model = model, \
+		.midr_range_min = min, \
+		.midr_range_max = max
+
+
 extern DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 
 static inline bool cpu_have_feature(unsigned int num)
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 1a59493..cd99d28a 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -75,6 +75,13 @@
 
 #define CAVIUM_CPU_PART_THUNDERX	0x0A1
 
+#define MIDR_CORTEX_A53 MIDR_CPU_PART(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
+#define MIDR_CORTEX_A57 MIDR_CPU_PART(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
+#define MIDR_THUNDERX   MIDR_CPU_PART(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
+
+#define CPU_MODEL_MASK (MIDR_IMPLEMENTOR_MASK | MIDR_PARTNUM_MASK | \
+                                                MIDR_ARCHITECTURE_MASK)
+
 #ifndef __ASSEMBLY__
 
 /*
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 01248e8..cec63a9 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -21,32 +21,6 @@
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
 
-#define MIDR_CORTEX_A53 MIDR_CPU_PART(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
-#define MIDR_CORTEX_A57 MIDR_CPU_PART(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
-#define MIDR_THUNDERX	MIDR_CPU_PART(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
-
-#define CPU_MODEL_MASK (MIDR_IMPLEMENTOR_MASK | MIDR_PARTNUM_MASK | \
-			MIDR_ARCHITECTURE_MASK)
-
-static bool __maybe_unused
-is_affected_midr_range(const struct arm64_cpu_capabilities *entry)
-{
-	u32 midr = read_cpuid_id();
-
-	if ((midr & CPU_MODEL_MASK) != entry->midr_model)
-		return false;
-
-	midr &= MIDR_REVISION_MASK | MIDR_VARIANT_MASK;
-
-	return (midr >= entry->midr_range_min && midr <= entry->midr_range_max);
-}
-
-#define MIDR_RANGE(model, min, max) \
-	.matches = is_affected_midr_range, \
-	.midr_model = model, \
-	.midr_range_min = min, \
-	.midr_range_max = max
-
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #if	defined(CONFIG_ARM64_ERRATUM_826319) || \
 	defined(CONFIG_ARM64_ERRATUM_827319) || \
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0669c63..b0ee60e 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -869,8 +869,27 @@ void verify_local_cpu_capabilities(void)
 
 	caps = arm64_features;
 	for (i = 0; caps[i].desc; i++) {
-		if (!cpus_have_cap(caps[i].capability) || !caps[i].sys_reg)
+		/*
+		 * If the feature is not enable already, then don't try to
+		 * enable.
+		 */
+		if (!cpus_have_cap(caps[i].capability))
+			continue;
+		if (!caps[i].sys_reg)
+			continue;
+		/* Handle MIDR matching seperately. */
+		if (caps[i].sys_reg == SYS_MIDR_EL1) {
+			/*
+			 * If the new CPU is a different MIDR it means the
+			 * feature is missing, we cannot proceed further,
+			 * park the cpu.
+			 */
+			if (!is_affected_midr_range (&caps[i]))
+				fail_incapable_cpu("arm64_features", &caps[i]);
+			if (caps[i].enable)
+				caps[i].enable(NULL);
 			continue;
+		}
 		/*
 		 * If the new CPU misses an advertised feature, we cannot proceed
 		 * further, park the cpu.
-- 
1.7.2.5
