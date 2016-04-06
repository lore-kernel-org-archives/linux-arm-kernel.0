From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed,  6 Apr 2016 12:24:10 +0100
Subject: [PATCH 1/5] arm64: cpufeature: Add scope for capability check
In-Reply-To: <1459941854-5190-1-git-send-email-suzuki.poulose@arm.com>
References: <1459941854-5190-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1459941854-5190-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add scope parameter to the arm64_cpu_capabilities::matches(),
so that this can be reused for checking the capability on a
given CPU vs the system wide. By default, the system uses
'system' wide values for setting the CPU_HWCAPs and ELF_HWCAPs.

Cc: James Morse <james.morse@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |    8 +++++++-
 arch/arm64/kernel/cpu_errata.c      |    2 +-
 arch/arm64/kernel/cpufeature.c      |   37 +++++++++++++++++++----------------
 3 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index ca8fb4b..5f10344 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -78,10 +78,16 @@ struct arm64_ftr_reg {
 	struct arm64_ftr_bits	*ftr_bits;
 };
 
+/* scope of capability check */
+enum {
+	SCOPE_SYSTEM,
+	SCOPE_CPU,
+};
+
 struct arm64_cpu_capabilities {
 	const char *desc;
 	u16 capability;
-	bool (*matches)(const struct arm64_cpu_capabilities *);
+	bool (*matches)(const struct arm64_cpu_capabilities *caps, int scope);
 	void (*enable)(void *);		/* Called on all active CPUs */
 	union {
 		struct {	/* To be used for erratum handling only */
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 06afd04..2fd5780 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -22,7 +22,7 @@
 #include <asm/cpufeature.h>
 
 static bool __maybe_unused
-is_affected_midr_range(const struct arm64_cpu_capabilities *entry)
+is_affected_midr_range(const struct arm64_cpu_capabilities *entry, int __unused)
 {
 	return MIDR_IS_CPU_MODEL_RANGE(read_cpuid_id(), entry->midr_model,
 				       entry->midr_range_min,
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c31be96..d3ee1df 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -71,7 +71,9 @@ DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 
 /* meta feature for alternatives */
 static bool __maybe_unused
-cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry);
+cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused);
+
+static u64 __raw_read_system_reg(u32 sys_id);
 
 static struct arm64_ftr_bits ftr_id_aa64isar0[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
@@ -633,19 +635,23 @@ feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
 }
 
 static bool
-has_cpuid_feature(const struct arm64_cpu_capabilities *entry)
+has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
 {
 	u64 val;
 
-	val = read_system_reg(entry->sys_reg);
+	if (scope == SCOPE_SYSTEM)
+		val = read_system_reg(entry->sys_reg);
+	else
+		val = __raw_read_system_reg(entry->sys_reg);
+
 	return feature_matches(val, entry);
 }
 
-static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry)
+static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry, int scope)
 {
 	bool has_sre;
 
-	if (!has_cpuid_feature(entry))
+	if (!has_cpuid_feature(entry, scope))
 		return false;
 
 	has_sre = gic_enable_sre();
@@ -656,7 +662,7 @@ static bool has_useable_gicv3_cpuif(const struct arm64_cpu_capabilities *entry)
 	return has_sre;
 }
 
-static bool has_no_hw_prefetch(const struct arm64_cpu_capabilities *entry)
+static bool has_no_hw_prefetch(const struct arm64_cpu_capabilities *entry, int __unused)
 {
 	u32 midr = read_cpuid_id();
 	u32 rv_min, rv_max;
@@ -668,7 +674,7 @@ static bool has_no_hw_prefetch(const struct arm64_cpu_capabilities *entry)
 	return MIDR_IS_CPU_MODEL_RANGE(midr, MIDR_THUNDERX, rv_min, rv_max);
 }
 
-static bool runs_at_el2(const struct arm64_cpu_capabilities *entry)
+static bool runs_at_el2(const struct arm64_cpu_capabilities *entry, int __unused)
 {
 	return is_kernel_in_hyp_mode();
 }
@@ -830,7 +836,7 @@ static bool cpus_have_elf_hwcap(const struct arm64_cpu_capabilities *cap)
 static void __init setup_elf_hwcaps(const struct arm64_cpu_capabilities *hwcaps)
 {
 	for (; hwcaps->matches; hwcaps++)
-		if (hwcaps->matches(hwcaps))
+		if (hwcaps->matches(hwcaps, SCOPE_SYSTEM))
 			cap_set_elf_hwcap(hwcaps);
 }
 
@@ -838,7 +844,7 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info)
 {
 	for (; caps->matches; caps++) {
-		if (!caps->matches(caps))
+		if (!caps->matches(caps, SCOPE_SYSTEM))
 			continue;
 
 		if (!cpus_have_cap(caps->capability) && caps->desc)
@@ -929,28 +935,25 @@ static void
 verify_local_elf_hwcaps(const struct arm64_cpu_capabilities *caps)
 {
 
-	for (; caps->matches; caps++) {
-		if (!cpus_have_elf_hwcap(caps))
-			continue;
-		if (!feature_matches(__raw_read_system_reg(caps->sys_reg), caps)) {
+	for (; caps->matches; caps++)
+		if (cpus_have_elf_hwcap(caps) && !caps->matches(caps, SCOPE_CPU)) {
 			pr_crit("CPU%d: missing HWCAP: %s\n",
 					smp_processor_id(), caps->desc);
 			cpu_die_early();
 		}
-	}
 }
 
 static void
 verify_local_cpu_features(const struct arm64_cpu_capabilities *caps)
 {
 	for (; caps->matches; caps++) {
-		if (!cpus_have_cap(caps->capability) || !caps->sys_reg)
+		if (!cpus_have_cap(caps->capability))
 			continue;
 		/*
 		 * If the new CPU misses an advertised feature, we cannot proceed
 		 * further, park the cpu.
 		 */
-		if (!feature_matches(__raw_read_system_reg(caps->sys_reg), caps)) {
+		if (!caps->matches(caps, SCOPE_CPU)) {
 			pr_crit("CPU%d: missing feature: %s\n",
 					smp_processor_id(), caps->desc);
 			cpu_die_early();
@@ -1021,7 +1024,7 @@ void __init setup_cpu_features(void)
 }
 
 static bool __maybe_unused
-cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry)
+cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused)
 {
 	return (cpus_have_cap(ARM64_HAS_PAN) && !cpus_have_cap(ARM64_HAS_UAO));
 }
-- 
1.7.9.5
