From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 26 Aug 2016 18:15:40 +0100
Subject: [RFC PATCH 1/3] arm64: cpufeature: constify arm64_ftr_bits structures
In-Reply-To: <1472231742-13387-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1472231742-13387-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1472231742-13387-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64_ftr_bits structures are never modified, so make them read-only.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/cpufeature.h | 14 +++---
 arch/arm64/kernel/cpufeature.c      | 46 ++++++++++----------
 2 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 7099f26e3702..7c0b7cff17df 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -72,11 +72,11 @@ struct arm64_ftr_bits {
  * @sys_val		Safe value across the CPUs (system view)
  */
 struct arm64_ftr_reg {
-	u32			sys_id;
-	const char		*name;
-	u64			strict_mask;
-	u64			sys_val;
-	struct arm64_ftr_bits	*ftr_bits;
+	u32				sys_id;
+	const char			*name;
+	u64				strict_mask;
+	u64				sys_val;
+	const struct arm64_ftr_bits	*ftr_bits;
 };
 
 /* scope of capability check */
@@ -157,7 +157,7 @@ cpuid_feature_extract_unsigned_field(u64 features, int field)
 	return cpuid_feature_extract_unsigned_field_width(features, field, 4);
 }
 
-static inline u64 arm64_ftr_mask(struct arm64_ftr_bits *ftrp)
+static inline u64 arm64_ftr_mask(const struct arm64_ftr_bits *ftrp)
 {
 	return (u64)GENMASK(ftrp->shift + ftrp->width - 1, ftrp->shift);
 }
@@ -170,7 +170,7 @@ cpuid_feature_extract_field(u64 features, int field, bool sign)
 		cpuid_feature_extract_unsigned_field(features, field);
 }
 
-static inline s64 arm64_ftr_value(struct arm64_ftr_bits *ftrp, u64 val)
+static inline s64 arm64_ftr_value(const struct arm64_ftr_bits *ftrp, u64 val)
 {
 	return (s64)cpuid_feature_extract_field(val, ftrp->shift, ftrp->sign);
 }
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 62272eac1352..eac76cb3a206 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -74,7 +74,7 @@ static bool __maybe_unused
 cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused);
 
 
-static struct arm64_ftr_bits ftr_id_aa64isar0[] = {
+static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64ISAR0_RDM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 24, 4, 0),
@@ -87,7 +87,7 @@ static struct arm64_ftr_bits ftr_id_aa64isar0[] = {
 	ARM64_FTR_END,
 };
 
-static struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
+static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 28, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64PFR0_GIC_SHIFT, 4, 0),
@@ -101,7 +101,7 @@ static struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 	ARM64_FTR_END,
 };
 
-static struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
+static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
 	S_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN4_SHIFT, 4, ID_AA64MMFR0_TGRAN4_NI),
 	S_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN64_SHIFT, 4, ID_AA64MMFR0_TGRAN64_NI),
@@ -119,7 +119,7 @@ static struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
 	ARM64_FTR_END,
 };
 
-static struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
+static const struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_PAN_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR1_LOR_SHIFT, 4, 0),
@@ -130,7 +130,7 @@ static struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
 	ARM64_FTR_END,
 };
 
-static struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
+static const struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_LVA_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_IESB_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_LSM_SHIFT, 4, 0),
@@ -139,7 +139,7 @@ static struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
 	ARM64_FTR_END,
 };
 
-static struct arm64_ftr_bits ftr_ctr[] = {
+static const struct arm64_ftr_bits ftr_ctr[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 31, 1, 1),	/* RAO */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 28, 3, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_HIGHER_SAFE, 24, 4, 0),	/* CWG */
@@ -155,7 +155,7 @@ static struct arm64_ftr_bits ftr_ctr[] = {
 	ARM64_FTR_END,
 };
 
-static struct arm64_ftr_bits ftr_id_mmfr0[] = {
+static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
 	S_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 28, 4, 0xf),	/* InnerShr */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 24, 4, 0),	/* FCSE */
 	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, 20, 4, 0),	/* AuxReg */
@@ -167,7 +167,7 @@ static struct arm64_ftr_bits ftr_id_mmfr0[] = {
 	ARM64_FTR_END,
 };
 
-static struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
+static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_CTX_CMPS_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_WRPS_SHIFT, 4, 0),
@@ -178,14 +178,14 @@ static struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
 	ARM64_FTR_END,
 };
 
-static struct arm64_ftr_bits ftr_mvfr2[] = {
+static const struct arm64_ftr_bits ftr_mvfr2[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 8, 24, 0),	/* RAZ */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 4, 0),		/* FPMisc */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 0, 4, 0),		/* SIMDMisc */
 	ARM64_FTR_END,
 };
 
-static struct arm64_ftr_bits ftr_dczid[] = {
+static const struct arm64_ftr_bits ftr_dczid[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 5, 27, 0),	/* RAZ */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 1, 1),		/* DZP */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* BS */
@@ -193,7 +193,7 @@ static struct arm64_ftr_bits ftr_dczid[] = {
 };
 
 
-static struct arm64_ftr_bits ftr_id_isar5[] = {
+static const struct arm64_ftr_bits ftr_id_isar5[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_ISAR5_RDM_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 20, 4, 0),	/* RAZ */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_ISAR5_CRC32_SHIFT, 4, 0),
@@ -204,14 +204,14 @@ static struct arm64_ftr_bits ftr_id_isar5[] = {
 	ARM64_FTR_END,
 };
 
-static struct arm64_ftr_bits ftr_id_mmfr4[] = {
+static const struct arm64_ftr_bits ftr_id_mmfr4[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 8, 24, 0),	/* RAZ */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 4, 0),		/* ac2 */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 0, 4, 0),		/* RAZ */
 	ARM64_FTR_END,
 };
 
-static struct arm64_ftr_bits ftr_id_pfr0[] = {
+static const struct arm64_ftr_bits ftr_id_pfr0[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 16, 16, 0),	/* RAZ */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 12, 4, 0),	/* State3 */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 8, 4, 0),		/* State2 */
@@ -220,7 +220,7 @@ static struct arm64_ftr_bits ftr_id_pfr0[] = {
 	ARM64_FTR_END,
 };
 
-static struct arm64_ftr_bits ftr_id_dfr0[] = {
+static const struct arm64_ftr_bits ftr_id_dfr0[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
 	S_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 24, 4, 0xf),	/* PerfMon */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),
@@ -238,7 +238,7 @@ static struct arm64_ftr_bits ftr_id_dfr0[] = {
  * 0. Covers the following 32bit registers:
  * id_isar[0-4], id_mmfr[1-3], id_pfr1, mvfr[0-1]
  */
-static struct arm64_ftr_bits ftr_generic_32bits[] = {
+static const struct arm64_ftr_bits ftr_generic_32bits[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 24, 4, 0),
 	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),
@@ -250,17 +250,17 @@ static struct arm64_ftr_bits ftr_generic_32bits[] = {
 	ARM64_FTR_END,
 };
 
-static struct arm64_ftr_bits ftr_generic[] = {
+static const struct arm64_ftr_bits ftr_generic[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 0, 64, 0),
 	ARM64_FTR_END,
 };
 
-static struct arm64_ftr_bits ftr_generic32[] = {
+static const struct arm64_ftr_bits ftr_generic32[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 0, 32, 0),
 	ARM64_FTR_END,
 };
 
-static struct arm64_ftr_bits ftr_aa64raz[] = {
+static const struct arm64_ftr_bits ftr_aa64raz[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 0, 64, 0),
 	ARM64_FTR_END,
 };
@@ -346,7 +346,8 @@ static struct arm64_ftr_reg *get_arm64_ftr_reg(u32 sys_id)
 			search_cmp_ftr_reg);
 }
 
-static u64 arm64_ftr_set_value(struct arm64_ftr_bits *ftrp, s64 reg, s64 ftr_val)
+static u64 arm64_ftr_set_value(const struct arm64_ftr_bits *ftrp, s64 reg,
+			       s64 ftr_val)
 {
 	u64 mask = arm64_ftr_mask(ftrp);
 
@@ -355,7 +356,8 @@ static u64 arm64_ftr_set_value(struct arm64_ftr_bits *ftrp, s64 reg, s64 ftr_val
 	return reg;
 }
 
-static s64 arm64_ftr_safe_value(struct arm64_ftr_bits *ftrp, s64 new, s64 cur)
+static s64 arm64_ftr_safe_value(const struct arm64_ftr_bits *ftrp, s64 new,
+				s64 cur)
 {
 	s64 ret = 0;
 
@@ -407,7 +409,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 {
 	u64 val = 0;
 	u64 strict_mask = ~0x0ULL;
-	struct arm64_ftr_bits *ftrp;
+	const struct arm64_ftr_bits *ftrp;
 	struct arm64_ftr_reg *reg = get_arm64_ftr_reg(sys_reg);
 
 	BUG_ON(!reg);
@@ -464,7 +466,7 @@ void __init init_cpu_features(struct cpuinfo_arm64 *info)
 
 static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new)
 {
-	struct arm64_ftr_bits *ftrp;
+	const struct arm64_ftr_bits *ftrp;
 
 	for (ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
 		s64 ftr_cur = arm64_ftr_value(ftrp, reg->sys_val);
-- 
2.7.4
