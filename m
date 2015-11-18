From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 18 Nov 2015 17:08:57 +0000
Subject: [PATCH 2/5] arm64: cpufeature: Track unsigned fields
In-Reply-To: <1447866540-23207-1-git-send-email-suzuki.poulose@arm.com>
References: <1447866238-22970-1-git-send-email-suzuki.poulose@arm.com>
 <1447866540-23207-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1447866540-23207-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the feature bits have unsigned values and need
to be treated accordingly to avoid errors. Adds the property
to the feature bits and use the appropriate field extract helpers.

Reported-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |   10 ++++++++--
 arch/arm64/kernel/cpufeature.c      |   37 ++++++++++++++++++++++-------------
 2 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 7a16102..29c3f5d 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -46,8 +46,12 @@ enum ftr_type {
 #define FTR_STRICT	true	/* SANITY check strict matching required */
 #define FTR_NONSTRICT	false	/* SANITY check ignored */
 
+#define FTR_SIGNED	true	/* Value should be treated as signed */
+#define FTR_UNSIGNED	false	/* Value should be treated as unsigned */
+
 struct arm64_ftr_bits {
-	bool		strict;	  /* CPU Sanity check: strict matching required ? */
+	bool		sign;	/* Value is signed ? */
+	bool		strict;	/* CPU Sanity check: strict matching required ? */
 	enum ftr_type	type;
 	u8		shift;
 	u8		width;
@@ -142,7 +146,9 @@ static inline u64 arm64_ftr_mask(struct arm64_ftr_bits *ftrp)
 
 static inline s64 arm64_ftr_value(struct arm64_ftr_bits *ftrp, u64 val)
 {
-	return cpuid_feature_extract_field_width(val, ftrp->shift, ftrp->width);
+	return ftrp->sign ?
+		cpuid_feature_extract_field_width(val, ftrp->shift, ftrp->width) :
+		cpuid_feature_extract_unsigned_field_width(val, ftrp->shift, ftrp->width);
 }
 
 static inline bool id_aa64mmfr0_mixed_endian_el0(u64 mmfr0)
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c8cf892..0669c63 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -44,8 +44,9 @@ unsigned int compat_elf_hwcap2 __read_mostly;
 
 DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 
-#define ARM64_FTR_BITS(STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
+#define __ARM64_FTR_BITS(SIGNED, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
 	{						\
+		.sign = SIGNED,				\
 		.strict = STRICT,			\
 		.type = TYPE,				\
 		.shift = SHIFT,				\
@@ -53,6 +54,14 @@ DECLARE_BITMAP(cpu_hwcaps, ARM64_NCAPS);
 		.safe_val = SAFE_VAL,			\
 	}
 
+/* Define a feature with signed values */
+#define ARM64_FTR_BITS(STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
+	__ARM64_FTR_BITS(FTR_SIGNED, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL)
+
+/* Define a feature with unsigned value */
+#define U_ARM64_FTR_BITS(STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
+	__ARM64_FTR_BITS(FTR_UNSIGNED, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL)
+
 #define ARM64_FTR_END					\
 	{						\
 		.width = 0,				\
@@ -99,7 +108,7 @@ static struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
 	 * Differing PARange is fine as long as all peripherals and memory are mapped
 	 * within the minimum PARange of all CPUs
 	 */
-	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_PARANGE_SHIFT, 4, 0),
+	U_ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_PARANGE_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
@@ -115,18 +124,18 @@ static struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
 };
 
 static struct arm64_ftr_bits ftr_ctr[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 31, 1, 1),	/* RAO */
+	U_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 31, 1, 1),	/* RAO */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 28, 3, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_HIGHER_SAFE, 24, 4, 0),	/* CWG */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),	/* ERG */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 1),	/* DminLine */
+	U_ARM64_FTR_BITS(FTR_STRICT, FTR_HIGHER_SAFE, 24, 4, 0),	/* CWG */
+	U_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),	/* ERG */
+	U_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 1),	/* DminLine */
 	/*
 	 * Linux can handle differing I-cache policies. Userspace JITs will
 	 * make use of *minLine
 	 */
-	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_EXACT, 14, 2, 0),	/* L1Ip */
+	U_ARM64_FTR_BITS(FTR_NONSTRICT, FTR_EXACT, 14, 2, 0),	/* L1Ip */
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 10, 0),	/* RAZ */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* IminLine */
+	U_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* IminLine */
 	ARM64_FTR_END,
 };
 
@@ -144,12 +153,12 @@ static struct arm64_ftr_bits ftr_id_mmfr0[] = {
 
 static struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
 	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_CTX_CMPS_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_WRPS_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_BRPS_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_PMUVER_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_TRACEVER_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_DEBUGVER_SHIFT, 4, 0x6),
+	U_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_CTX_CMPS_SHIFT, 4, 0),
+	U_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_WRPS_SHIFT, 4, 0),
+	U_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_BRPS_SHIFT, 4, 0),
+	U_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_PMUVER_SHIFT, 4, 0),
+	U_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_TRACEVER_SHIFT, 4, 0),
+	U_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_DEBUGVER_SHIFT, 4, 0x6),
 	ARM64_FTR_END,
 };
 
-- 
1.7.9.5
