From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  9 Jan 2017 17:28:30 +0000
Subject: [PATCH v4 7/9] arm64: cpufeature: Track user visible fields
In-Reply-To: <1483982912-27215-1-git-send-email-suzuki.poulose@arm.com>
References: <1483982912-27215-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1483982912-27215-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Track the user visible fields of a CPU feature register. This will be
used for exposing the value to the userspace. All the user visible
fields of a feature register will be passed on as it is, while the
others would be filled with their respective safe value.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V3:
 - Mark ID_AA64ISAR0_EL1:RDM visible
Changes since V2:
 - Mark DCZID_EL0 fields visible, as the register is already accessible
   to EL0.
---
 arch/arm64/include/asm/cpufeature.h |  11 +++
 arch/arm64/kernel/cpufeature.c      | 189 +++++++++++++++++++-----------------
 arch/arm64/kernel/traps.c           |   2 +-
 3 files changed, 111 insertions(+), 91 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 10d5624..4ce82ed 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -55,8 +55,12 @@ enum ftr_type {
 #define FTR_SIGNED	true	/* Value should be treated as signed */
 #define FTR_UNSIGNED	false	/* Value should be treated as unsigned */
 
+#define FTR_VISIBLE	true	/* Feature visible to the user space */
+#define FTR_HIDDEN	false	/* Feature is hidden from the user */
+
 struct arm64_ftr_bits {
 	bool		sign;	/* Value is signed ? */
+	bool		visible;
 	bool		strict;	/* CPU Sanity check: strict matching required ? */
 	enum ftr_type	type;
 	u8		shift;
@@ -72,7 +76,9 @@ struct arm64_ftr_bits {
 struct arm64_ftr_reg {
 	const char			*name;
 	u64				strict_mask;
+	u64				user_mask;
 	u64				sys_val;
+	u64				user_val;
 	const struct arm64_ftr_bits	*ftr_bits;
 };
 
@@ -172,6 +178,11 @@ static inline u64 arm64_ftr_mask(const struct arm64_ftr_bits *ftrp)
 	return (u64)GENMASK(ftrp->shift + ftrp->width - 1, ftrp->shift);
 }
 
+static inline u64 arm64_ftr_reg_user_value(const struct arm64_ftr_reg *reg)
+{
+	return (reg->user_val | (reg->sys_val & reg->user_mask));
+}
+
 static inline int __attribute_const__
 cpuid_feature_extract_field(u64 features, int field, bool sign)
 {
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index fb519e1..346faec 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -52,9 +52,10 @@ EXPORT_SYMBOL(cpu_hwcaps);
 DEFINE_STATIC_KEY_ARRAY_FALSE(cpu_hwcap_keys, ARM64_NCAPS);
 EXPORT_SYMBOL(cpu_hwcap_keys);
 
-#define __ARM64_FTR_BITS(SIGNED, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
+#define __ARM64_FTR_BITS(SIGNED, VISIBLE, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
 	{						\
 		.sign = SIGNED,				\
+		.visible = VISIBLE,			\
 		.strict = STRICT,			\
 		.type = TYPE,				\
 		.shift = SHIFT,				\
@@ -63,12 +64,12 @@ EXPORT_SYMBOL(cpu_hwcap_keys);
 	}
 
 /* Define a feature with unsigned values */
-#define ARM64_FTR_BITS(STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
-	__ARM64_FTR_BITS(FTR_UNSIGNED, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL)
+#define ARM64_FTR_BITS(VISIBLE, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
+	__ARM64_FTR_BITS(FTR_UNSIGNED, VISIBLE, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL)
 
 /* Define a feature with a signed value */
-#define S_ARM64_FTR_BITS(STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
-	__ARM64_FTR_BITS(FTR_SIGNED, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL)
+#define S_ARM64_FTR_BITS(VISIBLE, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL) \
+	__ARM64_FTR_BITS(FTR_SIGNED, VISIBLE, STRICT, TYPE, SHIFT, WIDTH, SAFE_VAL)
 
 #define ARM64_FTR_END					\
 	{						\
@@ -81,75 +82,75 @@ cpufeature_pan_not_uao(const struct arm64_cpu_capabilities *entry, int __unused)
 
 
 static const struct arm64_ftr_bits ftr_id_aa64isar0[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64ISAR0_RDM_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_ATOMICS_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_CRC32_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_SHA2_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_SHA1_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_AES_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, ID_AA64ISAR0_RDM_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_ATOMICS_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_CRC32_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_SHA2_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_SHA1_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR0_AES_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64PFR0_GIC_SHIFT, 4, 0),
-	S_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_ASIMD_SHIFT, 4, ID_AA64PFR0_ASIMD_NI),
-	S_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_FP_SHIFT, 4, ID_AA64PFR0_FP_NI),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64PFR0_GIC_SHIFT, 4, 0),
+	S_ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_ASIMD_SHIFT, 4, ID_AA64PFR0_ASIMD_NI),
+	S_ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_FP_SHIFT, 4, ID_AA64PFR0_FP_NI),
 	/* Linux doesn't care about the EL3 */
-	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_EXACT, ID_AA64PFR0_EL3_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64PFR0_EL2_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64PFR0_EL1_SHIFT, 4, ID_AA64PFR0_EL1_64BIT_ONLY),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64PFR0_EL0_SHIFT, 4, ID_AA64PFR0_EL0_64BIT_ONLY),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64PFR0_EL3_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64PFR0_EL2_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64PFR0_EL1_SHIFT, 4, ID_AA64PFR0_EL1_64BIT_ONLY),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64PFR0_EL0_SHIFT, 4, ID_AA64PFR0_EL0_64BIT_ONLY),
 	ARM64_FTR_END,
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
-	S_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN4_SHIFT, 4, ID_AA64MMFR0_TGRAN4_NI),
-	S_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN64_SHIFT, 4, ID_AA64MMFR0_TGRAN64_NI),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN16_SHIFT, 4, ID_AA64MMFR0_TGRAN16_NI),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_BIGENDEL0_SHIFT, 4, 0),
+	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN4_SHIFT, 4, ID_AA64MMFR0_TGRAN4_NI),
+	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN64_SHIFT, 4, ID_AA64MMFR0_TGRAN64_NI),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_TGRAN16_SHIFT, 4, ID_AA64MMFR0_TGRAN16_NI),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_BIGENDEL0_SHIFT, 4, 0),
 	/* Linux shouldn't care about secure memory */
-	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_EXACT, ID_AA64MMFR0_SNSMEM_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_BIGENDEL_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_ASID_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_EXACT, ID_AA64MMFR0_SNSMEM_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_BIGENDEL_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR0_ASID_SHIFT, 4, 0),
 	/*
 	 * Differing PARange is fine as long as all peripherals and memory are mapped
 	 * within the minimum PARange of all CPUs
 	 */
-	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_PARANGE_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_PARANGE_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_PAN_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR1_LOR_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR1_HPD_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR1_VHE_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR1_VMIDBITS_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR1_HADBS_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR1_PAN_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR1_LOR_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR1_HPD_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR1_VHE_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR1_VMIDBITS_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR1_HADBS_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_LVA_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_IESB_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_LSM_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_UAO_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_CNP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_LVA_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_IESB_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_LSM_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_UAO_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64MMFR2_CNP_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
 static const struct arm64_ftr_bits ftr_ctr[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 31, 1, 1),	/* RAO */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_HIGHER_SAFE, 24, 4, 0),	/* CWG */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),	/* ERG */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 1),	/* DminLine */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, 31, 1, 1),	/* RAO */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_HIGHER_SAFE, 24, 4, 0),	/* CWG */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),	/* ERG */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 1),	/* DminLine */
 	/*
 	 * Linux can handle differing I-cache policies. Userspace JITs will
 	 * make use of *minLine.
 	 * If we have differing I-cache policies, report it as the weakest - AIVIVT.
 	 */
-	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_EXACT, 14, 2, ICACHE_POLICY_AIVIVT),	/* L1Ip */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* IminLine */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_NONSTRICT, FTR_EXACT, 14, 2, ICACHE_POLICY_AIVIVT),	/* L1Ip */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* IminLine */
 	ARM64_FTR_END,
 };
 
@@ -159,73 +160,73 @@ struct arm64_ftr_reg arm64_ftr_reg_ctrel0 = {
 };
 
 static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
-	S_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 28, 4, 0xf),	/* InnerShr */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 24, 4, 0),	/* FCSE */
-	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_LOWER_SAFE, 20, 4, 0),	/* AuxReg */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 16, 4, 0),	/* TCM */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 12, 4, 0),	/* ShareLvl */
-	S_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 8, 4, 0xf),	/* OuterShr */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 4, 0),	/* PMSA */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 0, 4, 0),	/* VMSA */
+	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 28, 4, 0xf),	/* InnerShr */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 24, 4, 0),	/* FCSE */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, 20, 4, 0),	/* AuxReg */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 16, 4, 0),	/* TCM */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 12, 4, 0),	/* ShareLvl */
+	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 8, 4, 0xf),	/* OuterShr */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 4, 4, 0),	/* PMSA */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 0, 4, 0),	/* VMSA */
 	ARM64_FTR_END,
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 32, 32, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_CTX_CMPS_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_WRPS_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_BRPS_SHIFT, 4, 0),
-	S_ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_PMUVER_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_TRACEVER_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_AA64DFR0_DEBUGVER_SHIFT, 4, 0x6),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 32, 32, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_CTX_CMPS_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_WRPS_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_BRPS_SHIFT, 4, 0),
+	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64DFR0_PMUVER_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64DFR0_TRACEVER_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_AA64DFR0_DEBUGVER_SHIFT, 4, 0x6),
 	ARM64_FTR_END,
 };
 
 static const struct arm64_ftr_bits ftr_mvfr2[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 4, 0),		/* FPMisc */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 0, 4, 0),		/* SIMDMisc */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 4, 4, 0),		/* FPMisc */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 0, 4, 0),		/* SIMDMisc */
 	ARM64_FTR_END,
 };
 
 static const struct arm64_ftr_bits ftr_dczid[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 1, 1),		/* DZP */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* BS */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_EXACT, 4, 1, 1),		/* DZP */
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),	/* BS */
 	ARM64_FTR_END,
 };
 
 
 static const struct arm64_ftr_bits ftr_id_isar5[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_ISAR5_RDM_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_ISAR5_CRC32_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_ISAR5_SHA2_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_ISAR5_SHA1_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_ISAR5_AES_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, ID_ISAR5_SEVL_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_ISAR5_RDM_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_ISAR5_CRC32_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_ISAR5_SHA2_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_ISAR5_SHA1_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_ISAR5_AES_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, ID_ISAR5_SEVL_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
 
 static const struct arm64_ftr_bits ftr_id_mmfr4[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 4, 0),		/* ac2 */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 4, 4, 0),		/* ac2 */
 	ARM64_FTR_END,
 };
 
 static const struct arm64_ftr_bits ftr_id_pfr0[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 12, 4, 0),	/* State3 */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 8, 4, 0),		/* State2 */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 4, 4, 0),		/* State1 */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 0, 4, 0),		/* State0 */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 12, 4, 0),	/* State3 */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 8, 4, 0),		/* State2 */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 4, 4, 0),		/* State1 */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 0, 4, 0),		/* State0 */
 	ARM64_FTR_END,
 };
 
 static const struct arm64_ftr_bits ftr_id_dfr0[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
-	S_ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 24, 4, 0xf),	/* PerfMon */
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 12, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 8, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 4, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
+	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 24, 4, 0xf),	/* PerfMon */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 12, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 8, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 4, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),
 	ARM64_FTR_END,
 };
 
@@ -236,20 +237,20 @@ static const struct arm64_ftr_bits ftr_id_dfr0[] = {
  * id_isar[0-4], id_mmfr[1-3], id_pfr1, mvfr[0-1]
  */
 static const struct arm64_ftr_bits ftr_generic_32bits[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 24, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 12, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 8, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 4, 4, 0),
-	ARM64_FTR_BITS(FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 24, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 12, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 8, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 4, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 0, 4, 0),
 	ARM64_FTR_END,
 };
 
 /* Table for a single 32bit feature value */
 static const struct arm64_ftr_bits ftr_single32[] = {
-	ARM64_FTR_BITS(FTR_STRICT, FTR_EXACT, 0, 32, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_EXACT, 0, 32, 0),
 	ARM64_FTR_END,
 };
 
@@ -397,6 +398,7 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 {
 	u64 val = 0;
 	u64 strict_mask = ~0x0ULL;
+	u64 user_mask = 0;
 	u64 valid_mask = 0;
 
 	const struct arm64_ftr_bits *ftrp;
@@ -413,12 +415,19 @@ static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
 		valid_mask |= ftr_mask;
 		if (!ftrp->strict)
 			strict_mask &= ~ftr_mask;
+		if (ftrp->visible)
+			user_mask |= ftr_mask;
+		else
+			reg->user_val = arm64_ftr_set_value(ftrp,
+							    reg->user_val,
+							    ftrp->safe_val);
 	}
 
 	val &= valid_mask;
 
 	reg->sys_val = val;
 	reg->strict_mask = strict_mask;
+	reg->user_mask = user_mask;
 }
 
 void __init init_cpu_features(struct cpuinfo_arm64 *info)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 5b830be..8187229 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -496,7 +496,7 @@ static void ctr_read_handler(unsigned int esr, struct pt_regs *regs)
 {
 	int rt = (esr & ESR_ELx_SYS64_ISS_RT_MASK) >> ESR_ELx_SYS64_ISS_RT_SHIFT;
 
-	regs->regs[rt] = arm64_ftr_reg_ctrel0.sys_val;
+	regs->regs[rt] = arm64_ftr_reg_user_value(&arm64_ftr_reg_ctrel0);
 	regs->pc += 4;
 }
 
-- 
2.7.4
