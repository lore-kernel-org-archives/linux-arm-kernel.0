From: alex.shi@linaro.org (Alex Shi)
Date: Fri,  9 Mar 2018 17:07:02 +0800
Subject: [PATCH 19/39] arm64: prefetch: add alternative pattern for CPUs
 without a prefetcher
In-Reply-To: <20180309090722.26279-1-alex.shi@linaro.org>
References: <20180309090722.26279-1-alex.shi@linaro.org>
Message-ID: <20180309090722.26279-20-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

Most CPUs have a hardware prefetcher which generally performs better
without explicit prefetch instructions issued by software, however
some CPUs (e.g. Cavium ThunderX) rely solely on explicit prefetch
instructions.

This patch adds an alternative pattern (ARM64_HAS_NO_HW_PREFETCH) to
allow our library code to make use of explicit prefetch instructions
during things like copy routines only when the CPU does not have the
capability to perform the prefetching itself.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Tested-by: Andrew Pinski <apinski@cavium.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  3 ++-
 arch/arm64/include/asm/cputype.h    | 17 ++++++++++++++++-
 arch/arm64/kernel/cpu_errata.c      | 18 +++---------------
 arch/arm64/kernel/cpufeature.c      | 17 +++++++++++++++++
 4 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index ede73d2c09a4..77dd88f0d1fc 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -32,8 +32,9 @@
 #define ARM64_WORKAROUND_834220			7
 #define ARM64_WORKAROUND_CAVIUM_27456		8
 #define ARM64_HARDEN_BRANCH_PREDICTOR		9
+#define ARM64_HAS_NO_HW_PREFETCH		10
 
-#define ARM64_NCAPS				10
+#define ARM64_NCAPS				11
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 1a5949364ed0..7540284a17fe 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -57,11 +57,22 @@
 #define MIDR_IMPLEMENTOR(midr)	\
 	(((midr) & MIDR_IMPLEMENTOR_MASK) >> MIDR_IMPLEMENTOR_SHIFT)
 
-#define MIDR_CPU_PART(imp, partnum) \
+#define MIDR_CPU_MODEL(imp, partnum) \
 	(((imp)			<< MIDR_IMPLEMENTOR_SHIFT) | \
 	(0xf			<< MIDR_ARCHITECTURE_SHIFT) | \
 	((partnum)		<< MIDR_PARTNUM_SHIFT))
 
+#define MIDR_CPU_MODEL_MASK (MIDR_IMPLEMENTOR_MASK | MIDR_PARTNUM_MASK | \
+			     MIDR_ARCHITECTURE_MASK)
+
+#define MIDR_IS_CPU_MODEL_RANGE(midr, model, rv_min, rv_max)		\
+({									\
+	u32 _model = (midr) & MIDR_CPU_MODEL_MASK;			\
+	u32 rv = (midr) & (MIDR_REVISION_MASK | MIDR_VARIANT_MASK);	\
+									\
+	_model == (model) && rv >= (rv_min) && rv <= (rv_max);		\
+ })
+
 #define ARM_CPU_IMP_ARM			0x41
 #define ARM_CPU_IMP_APM			0x50
 #define ARM_CPU_IMP_CAVIUM		0x43
@@ -75,6 +86,10 @@
 
 #define CAVIUM_CPU_PART_THUNDERX	0x0A1
 
+#define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
+#define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
+#define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
+
 #ifndef __ASSEMBLY__
 
 /*
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 0d3ea874133d..b84a93e8c8bd 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -21,24 +21,12 @@
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
 
-#define MIDR_CORTEX_A53 MIDR_CPU_PART(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
-#define MIDR_CORTEX_A57 MIDR_CPU_PART(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
-#define MIDR_THUNDERX	MIDR_CPU_PART(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
-
-#define CPU_MODEL_MASK (MIDR_IMPLEMENTOR_MASK | MIDR_PARTNUM_MASK | \
-			MIDR_ARCHITECTURE_MASK)
-
 static bool __maybe_unused
 is_affected_midr_range(const struct arm64_cpu_capabilities *entry)
 {
-	u32 midr = read_cpuid_id();
-
-	if ((midr & CPU_MODEL_MASK) != entry->midr_model)
-		return false;
-
-	midr &= MIDR_REVISION_MASK | MIDR_VARIANT_MASK;
-
-	return (midr >= entry->midr_range_min && midr <= entry->midr_range_max);
+	return MIDR_IS_CPU_MODEL_RANGE(read_cpuid_id(), entry->midr_model,
+				       entry->midr_range_min,
+				       entry->midr_range_max);
 }
 
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 8488a829e24e..2cf2f799455a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -624,6 +624,18 @@ static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry)
 	return has_sre;
 }
 
+static bool has_no_hw_prefetch(const struct arm64_cpu_capabilities *entry)
+{
+	u32 midr = read_cpuid_id();
+	u32 rv_min, rv_max;
+
+	/* Cavium ThunderX pass 1.x and 2.x */
+	rv_min = 0;
+	rv_max = (1 << MIDR_VARIANT_SHIFT) | MIDR_REVISION_MASK;
+
+	return MIDR_IS_CPU_MODEL_RANGE(midr, MIDR_THUNDERX, rv_min, rv_max);
+}
+
 static const struct arm64_cpu_capabilities arm64_features[] = {
 	{
 		.desc = "GIC system register CPU interface",
@@ -654,6 +666,11 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.min_field_value = 2,
 	},
 #endif /* CONFIG_AS_LSE && CONFIG_ARM64_LSE_ATOMICS */
+	{
+		.desc = "Software prefetching using PRFM",
+		.capability = ARM64_HAS_NO_HW_PREFETCH,
+		.matches = has_no_hw_prefetch,
+	},
 	{},
 };
 
-- 
2.16.2.440.gc6284da
