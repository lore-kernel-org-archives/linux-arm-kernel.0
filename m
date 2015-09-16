From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 16 Sep 2015 15:21:05 +0100
Subject: [PATCH 07/22] arm64: Keep track of CPU feature registers
In-Reply-To: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
References: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1442413280-31885-8-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

This patch adds an infrastructure to keep track of the CPU feature
registers on the system. For each register, the infrastructure keeps
track of the system wide safe value of the feature bits. Also, tracks
the which fields of a register should be matched strictly across all
the CPUs on the system for the SANITY check infrastructure.

The feature bits are classified as one of SCALAR_MIN, SCALAR_MAX and DISCRETE
depending on the implication of the possible values. This information
is used to decide the safe value for a feature.

SCALAR_MIN - The smaller value is safer
SCALAR_MAX - The bigger value is safer
DISCRETE - We can't decide between the two, so a predefined safe_value is used.

This infrastructure will be later used to make better decisions for:

 - Kernel features (e.g, KVM, Debug)
 - SANITY Check
 - CPU capability
 - ELF HWCAP
 - Exposing CPU Feature register to userspace.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |   49 ++++
 arch/arm64/include/asm/sysreg.h     |  120 ++++++++++
 arch/arm64/kernel/cpufeature.c      |  433 +++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/cpuinfo.c         |    3 +-
 4 files changed, 604 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index aaa84d9..14302e0 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -36,6 +36,38 @@
 #include <asm/cpu.h>
 #include <linux/kernel.h>
 
+/* CPU feature register tracking */
+enum ftr_type {
+	FTR_DISCRETE,
+	FTR_SCALAR_MIN,
+	FTR_SCALAR_MAX,
+};
+
+#define FTR_STRICT	true
+#define FTR_NONSTRICT	false
+
+struct arm64_ftr_bits {
+	bool		strict;		/* CPU Sanity check
+					 *  strict matching required ? */
+	enum ftr_type	type;
+	u8		shift;
+	u8		width;
+	s64		safe_val;	/* safe value for discrete features */
+};
+
+/*
+ * @arm64_ftr_reg - Feature register
+ * @strict_mask 	Bits which should match across all CPUs for sanity.
+ * @sys_val		Safe value across the CPUs (system view)
+ */
+struct arm64_ftr_reg {
+	u32			sys_id;
+	const char*		name;
+	u64			strict_mask;
+	u64			sys_val;
+	struct arm64_ftr_bits*	ftr_bits;
+};
+
 struct arm64_cpu_capabilities {
 	const char *desc;
 	u16 capability;
@@ -83,12 +115,29 @@ static inline int __attribute_const__ cpuid_feature_extract_field(u64 features,
 	return (s64)(features << (64 - 4 - field)) >> (64 - 4);
 }
 
+static inline s64 __attribute_const__
+cpuid_feature_extract_field_width(u64 features, int field, u8 width)
+{
+	return (s64)(features << (64 - width - field)) >> (64 - width);
+}
+
+static inline u64 ftr_mask(struct arm64_ftr_bits *ftrp)
+{
+	return (u64) GENMASK(ftrp->shift + ftrp->width - 1, ftrp->shift);
+}
+
+static inline s64 arm64_ftr_value(struct arm64_ftr_bits *ftrp, u64 val)
+{
+	return cpuid_feature_extract_field_width(val, ftrp->shift, ftrp->width);
+}
+
 static inline bool id_aa64mmfr0_mixed_endian_el0(u64 mmfr0)
 {
 	return cpuid_feature_extract_field(mmfr0, ID_AA64MMFR0_BIGENDEL_SHIFT) == 0x1 ||
 		cpuid_feature_extract_field(mmfr0, ID_AA64MMFR0_BIGENDEL0_SHIFT) == 0x1;
 }
 
+void __init init_cpu_features(struct cpuinfo_arm64 *info);
 void __init setup_cpu_features(void);
 void update_cpu_features(struct cpuinfo_arm64 *info);
 
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 04e11b1..dc72fc6 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -59,6 +59,46 @@
 	 ((crn) << CRn_shift) | ((crm) << CRm_shift) | ((op2) << Op2_shift))
 
 
+#define SYS_MIDR_EL1			sys_reg(3, 0, 0, 0, 0)
+#define SYS_MPIDR_EL1			sys_reg(3, 0, 0, 0, 5)
+#define SYS_REVIDR_EL1			sys_reg(3, 0, 0, 0, 6)
+
+#define SYS_ID_PFR0_EL1			sys_reg(3, 0, 0, 1, 0)
+#define SYS_ID_PFR1_EL1			sys_reg(3, 0, 0, 1, 1)
+#define SYS_ID_DFR0_EL1			sys_reg(3, 0, 0, 1, 2)
+#define SYS_ID_MMFR0_EL1		sys_reg(3, 0, 0, 1, 4)
+#define SYS_ID_MMFR1_EL1		sys_reg(3, 0, 0, 1, 5)
+#define SYS_ID_MMFR2_EL1		sys_reg(3, 0, 0, 1, 6)
+#define SYS_ID_MMFR3_EL1		sys_reg(3, 0, 0, 1, 7)
+
+#define SYS_ID_ISAR0_EL1		sys_reg(3, 0, 0, 2, 0)
+#define SYS_ID_ISAR1_EL1		sys_reg(3, 0, 0, 2, 1)
+#define SYS_ID_ISAR2_EL1		sys_reg(3, 0, 0, 2, 2)
+#define SYS_ID_ISAR3_EL1		sys_reg(3, 0, 0, 2, 3)
+#define SYS_ID_ISAR4_EL1		sys_reg(3, 0, 0, 2, 4)
+#define SYS_ID_ISAR5_EL1		sys_reg(3, 0, 0, 2, 5)
+#define SYS_ID_MMFR4_EL1		sys_reg(3, 0, 0, 2, 6)
+
+#define SYS_MVFR0_EL1			sys_reg(3, 0, 0, 3, 0)
+#define SYS_MVFR1_EL1			sys_reg(3, 0, 0, 3, 1)
+#define SYS_MVFR2_EL1			sys_reg(3, 0, 0, 3, 2)
+
+#define SYS_ID_AA64PFR0_EL1		sys_reg(3, 0, 0, 4, 0)
+#define SYS_ID_AA64PFR1_EL1		sys_reg(3, 0, 0, 4, 1)
+
+#define SYS_ID_AA64DFR0_EL1		sys_reg(3, 0, 0, 5, 0)
+#define SYS_ID_AA64DFR1_EL1		sys_reg(3, 0, 0, 5, 1)
+
+#define SYS_ID_AA64ISAR0_EL1		sys_reg(3, 0, 0, 6, 0)
+#define SYS_ID_AA64ISAR1_EL1		sys_reg(3, 0, 0, 6, 1)
+
+#define SYS_ID_AA64MMFR0_EL1		sys_reg(3, 0, 0, 7, 0)
+#define SYS_ID_AA64MMFR1_EL1		sys_reg(3, 0, 0, 7, 1)
+
+#define SYS_CNTFRQ_EL0			sys_reg(3, 3, 14, 0, 0)
+#define SYS_CTR_EL0			sys_reg(3, 3, 0, 0, 1)
+#define SYS_DCZID_EL0			sys_reg(3, 3, 0, 0, 7)
+
 #define REG_PSTATE_PAN_IMM	sys_reg(0, 0, 4, 0, 4)
 #define SET_PSTATE_PAN(x)	__inst_arm(0xd5000000 |\
 					   (REG_PSTATE_PAN_IMM << 5) |\
@@ -69,8 +109,88 @@
 #define SCTLR_EL1_SED		(0x1 << 8)
 #define SCTLR_EL1_SPAN		(0x1 << 23)
 
+/* id_aa64isar0 */
+#define ID_AA64ISAR0_RDM_SHIFT		28
+#define ID_AA64ISAR0_ATOMICS_SHIFT	20
+#define ID_AA64ISAR0_CRC32_SHIFT	16
+#define ID_AA64ISAR0_SHA2_SHIFT		12
+#define ID_AA64ISAR0_SHA1_SHIFT		8
+#define ID_AA64ISAR0_AES_SHIFT		4
+
+/* id_aa64pfr0 */
+#define ID_AA64PFR0_GIC_SHIFT		24
+#define ID_AA64PFR0_ASIMD_SHIFT		20
+#define ID_AA64PFR0_FP_SHIFT		16
+#define ID_AA64PFR0_EL3_SHIFT		12
+#define ID_AA64PFR0_EL2_SHIFT		8
+#define ID_AA64PFR0_EL1_SHIFT		4
+#define ID_AA64PFR0_EL0_SHIFT		0
+
+#define ID_AA64PFR0_FP_NI		0xf
+#define ID_AA64PFR0_FP_ON		0x0
+#define ID_AA64PFR0_ASIMD_NI		0xf
+#define ID_AA64PFR0_ASIMD_ON		0x0
+#define ID_AA64PFR0_EL1_64BIT_ONLY	0x1
+#define ID_AA64PFR0_EL0_64BIT_ONLY	0x1
+
+/* id_aa64mmfr0 */
+#define ID_AA64MMFR0_TGRAN4_SHIFT	28
+#define ID_AA64MMFR0_TGRAN64_SHIFT	24
+#define ID_AA64MMFR0_TGRAN16_SHIFT	20
 #define ID_AA64MMFR0_BIGENDEL0_SHIFT	16
+#define ID_AA64MMFR0_SNSMEM_SHIFT	12
 #define ID_AA64MMFR0_BIGENDEL_SHIFT	8
+#define ID_AA64MMFR0_ASID_SHIFT		4
+#define ID_AA64MMFR0_PARANGE_SHIFT	0
+
+#define ID_AA64MMFR0_TGRAN4_NI		0xf
+#define ID_AA64MMFR0_TGRAN4_ON		0x0
+#define ID_AA64MMFR0_TGRAN64_NI		0xf
+#define ID_AA64MMFR0_TGRAN64_ON		0x0
+#define ID_AA64MMFR0_TGRAN16_NI		0x0
+#define ID_AA64MMFR0_TGRAN16_ON		0x1
+
+/* id_aa64mmfr1 */
+#define ID_AA64MMFR1_PAN_SHIFT		20
+#define ID_AA64MMFR1_LOR_SHIFT		16
+#define ID_AA64MMFR1_HPD_SHIFT		12
+#define ID_AA64MMFR1_VHE_SHIFT		8
+#define ID_AA64MMFR1_VMIDBITS_SHIFT	4
+#define ID_AA64MMFR1_HADBS_SHIFT	0
+
+/* id_aa64dfr0 */
+#define ID_AA64DFR0_CTX_CMPS_SHIFT	28
+#define ID_AA64DFR0_WRPS_SHIFT		20
+#define ID_AA64DFR0_BRPS_SHIFT		12
+#define ID_AA64DFR0_PMUVER_SHIFT	8
+#define ID_AA64DFR0_TRACEVER_SHIFT	4
+#define ID_AA64DFR0_DEBUGVER_SHIFT	0
+
+#define ID_ISAR5_RDM_SHIFT		24
+#define ID_ISAR5_CRC32_SHIFT		16
+#define ID_ISAR5_SHA2_SHIFT		12
+#define ID_ISAR5_SHA1_SHIFT		8
+#define ID_ISAR5_AES_SHIFT		4
+#define ID_ISAR5_SEVL_SHIFT		0
+
+#define MVFR0_FPROUND_SHIFT		28
+#define MVFR0_FPSHVEC_SHIFT		24
+#define MVFR0_FPSQRT_SHIFT		20
+#define MVFR0_FPDIVIDE_SHIFT		16
+#define MVFR0_FPTRAP_SHIFT		12
+#define MVFR0_FPDP_SHIFT		8
+#define MVFR0_FPSP_SHIFT		4
+#define MVFR0_SIMD_SHIFT		0
+
+#define MVFR1_SIMDFMAC_SHIFT		28
+#define MVFR1_FPHP_SHIFT		24
+#define MVFR1_SIMDHP_SHIFT		20
+#define MVFR1_SIMDSP_SHIFT		16
+#define MVFR1_SIMDINT_SHIFT		12
+#define MVFR1_SIMDLS_SHIFT		8
+#define MVFR1_FPDNAN_SHIFT		4
+#define MVFR1_FPFTZ_SHIFT		0
+
 
 #ifdef __ASSEMBLY__
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 72633b9..9e7d886 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -58,8 +58,441 @@ static void update_mixed_endian_el0_support(struct cpuinfo_arm64 *info)
 	mixed_endian_el0 &= id_aa64mmfr0_mixed_endian_el0(info->reg_id_aa64mmfr0);
 }
 
+#define ARM64_FTR_BITS(ftr_strict, ftr_type, ftr_shift, ftr_width, ftr_safe_val) \
+	{							\
+		.strict = ftr_strict,				\
+		.type = ftr_type,				\
+		.shift = ftr_shift,				\
+		.width = ftr_width,				\
+		.safe_val = ftr_safe_val,			\
+	}
+
+#define ARM64_FTR_END					\
+	{						\
+		.width = 0,				\
+	}
+
+static struct arm64_ftr_bits ftr_id_aa64isar0[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 32, 32, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_AA64ISAR0_RDM_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 24, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, ID_AA64ISAR0_ATOMICS_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, ID_AA64ISAR0_CRC32_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, ID_AA64ISAR0_SHA2_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, ID_AA64ISAR0_SHA1_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, ID_AA64ISAR0_AES_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 0, 4, 0),	// RAZ
+	ARM64_FTR_END,
+};
+
+static struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 32, 32, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 28, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_AA64PFR0_GIC_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, ID_AA64PFR0_ASIMD_SHIFT, 4, ID_AA64PFR0_ASIMD_NI),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, ID_AA64PFR0_FP_SHIFT, 4, ID_AA64PFR0_FP_NI),
+	/* Linux doesn't care about the EL3 */
+	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_DISCRETE, ID_AA64PFR0_EL3_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_AA64PFR0_EL2_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_AA64PFR0_EL1_SHIFT, 4, ID_AA64PFR0_EL1_64BIT_ONLY),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_AA64PFR0_EL0_SHIFT, 4, ID_AA64PFR0_EL0_64BIT_ONLY),
+	ARM64_FTR_END,
+};
+
+static struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 32, 32, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_AA64MMFR0_TGRAN4_SHIFT, 4, ID_AA64MMFR0_TGRAN4_NI),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_AA64MMFR0_TGRAN64_SHIFT, 4, ID_AA64MMFR0_TGRAN64_NI),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_AA64MMFR0_TGRAN16_SHIFT, 4, ID_AA64MMFR0_TGRAN16_NI),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_AA64MMFR0_BIGENDEL0_SHIFT, 4, 0),
+	/* Linux shouldn't care about secure memory */
+	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_DISCRETE, ID_AA64MMFR0_SNSMEM_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_AA64MMFR0_BIGENDEL_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_AA64MMFR0_ASID_SHIFT, 4, 0),
+	/*
+	 * Differing PARange is fine as long as all peripherals and memory are mapped
+	 * within the minimum PARange of all CPUs
+	 */
+	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_SCALAR_MIN, ID_AA64MMFR0_PARANGE_SHIFT, 4, 0),
+	ARM64_FTR_END,
+};
+
+static struct arm64_ftr_bits ftr_id_aa64mmfr1[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 32, 32, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, ID_AA64MMFR1_PAN_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_AA64MMFR1_LOR_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_AA64MMFR1_HPD_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_AA64MMFR1_VHE_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_AA64MMFR1_HADBS_SHIFT, 4, 0),
+	ARM64_FTR_END,
+};
+
+static struct arm64_ftr_bits ftr_ctr[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 31, 1, 1),	// RAO
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 28, 3, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MAX, 24, 4, 0),	// CWG
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, 20, 4, 0),	// ERG
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, 16, 4, 1),	// DminLine
+	/*
+	 * Linux can handle differing I-cache policies. Userspace JITs will
+	 * make use of *minLine
+	 */
+	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_DISCRETE, 14, 2, 0),	// L1Ip
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 4, 10, 0),	// RAZ
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, 0, 4, 0),	// IminLine
+	ARM64_FTR_END,
+};
+
+static struct arm64_ftr_bits ftr_id_mmfr0[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 28, 4, 0),	// InnerShr
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 24, 4, 0),	// FCSE
+	ARM64_FTR_BITS(FTR_NONSTRICT, FTR_SCALAR_MIN, 20, 4, 0),	// AuxReg
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 16, 4, 0),	// TCM
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 12, 4, 0),	// ShareLvl
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 8, 4, 0),	// OuterShr
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 4, 4, 0),	// PMSA
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 0, 4, 0),	// VMSA
+	ARM64_FTR_END,
+};
+
+static struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 32, 32, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, ID_AA64DFR0_CTX_CMPS_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, ID_AA64DFR0_WRPS_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, ID_AA64DFR0_BRPS_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_AA64DFR0_PMUVER_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_AA64DFR0_TRACEVER_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_AA64DFR0_DEBUGVER_SHIFT, 4, 0x6),
+	ARM64_FTR_END,
+};
+
+static struct arm64_ftr_bits ftr_mvfr2[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 8, 24, 0),	// RAZ
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 4, 4, 0),	// FPMisc
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 0, 4, 0),	// SIMDMisc
+	ARM64_FTR_END,
+};
+
+static struct arm64_ftr_bits ftr_dczid[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 5, 27, 0),// RAZ
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 4, 1, 1),	// DZP
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, 0, 4, 0),	// BS
+	ARM64_FTR_END,
+};
+
+
+static struct arm64_ftr_bits ftr_id_isar5[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_ISAR5_RDM_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 20, 4, 0),	// RAZ
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_ISAR5_CRC32_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_ISAR5_SHA2_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_ISAR5_SHA1_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_ISAR5_AES_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, ID_ISAR5_SEVL_SHIFT, 4, 0),
+	ARM64_FTR_END,
+};
+
+static struct arm64_ftr_bits ftr_id_mmfr4[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 8, 24, 0),	// RAZ
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 4, 4, 0),	// ac2
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 0, 4, 0),	// RAZ
+	ARM64_FTR_END,
+};
+
+static struct arm64_ftr_bits ftr_id_pfr0[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 16, 16, 0),	// RAZ
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 12, 4, 0),	// State3
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 8, 4, 0),	// State2
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 4, 4, 0),	// State1
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 0, 4, 0),	// State0
+	ARM64_FTR_END,
+};
+
+/*
+ * Common ftr bits for a 32bit register with all hidden, strict
+ * attributes, with 4bit feature fields and a default safe value of
+ * 0. Covers the following 32bit registers:
+ * id_isar[0-4], id_mmfr[1-3], id_pfr1, mvfr[0-1]
+ */
+static struct arm64_ftr_bits ftr_generic_scalar_32bit[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, 28, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, 24, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, 20, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, 16, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, 12, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, 8, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, 4, 4, 0),
+	ARM64_FTR_BITS(FTR_STRICT, FTR_SCALAR_MIN, 0, 4, 0),
+	ARM64_FTR_END,
+};
+
+static struct arm64_ftr_bits ftr_generic[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 0, 64, 0),
+	ARM64_FTR_END,
+};
+
+static struct arm64_ftr_bits ftr_generic32[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 0, 32, 0),
+	ARM64_FTR_END,
+};
+
+static struct arm64_ftr_bits ftr_aa64raz[] = {
+	ARM64_FTR_BITS(FTR_STRICT, FTR_DISCRETE, 0, 64, 0),
+	ARM64_FTR_END,
+};
+
+#define ARM64_FTR_REG(id, ftr_table)			\
+	[ sys_reg_Op2(id) ] = {				\
+		.sys_id = id,				\
+		.name = #id,				\
+		.ftr_bits = &((ftr_table)[0]),		\
+	}
+
+static struct arm64_ftr_reg crm_1[] = {
+	ARM64_FTR_REG(SYS_ID_PFR0_EL1, ftr_id_pfr0),
+	ARM64_FTR_REG(SYS_ID_PFR1_EL1, ftr_generic_scalar_32bit),
+	ARM64_FTR_REG(SYS_ID_DFR0_EL1, ftr_generic_scalar_32bit),
+	ARM64_FTR_REG(SYS_ID_MMFR0_EL1, ftr_id_mmfr0),
+	ARM64_FTR_REG(SYS_ID_MMFR1_EL1, ftr_generic_scalar_32bit),
+	ARM64_FTR_REG(SYS_ID_MMFR2_EL1, ftr_generic_scalar_32bit),
+	ARM64_FTR_REG(SYS_ID_MMFR3_EL1, ftr_generic_scalar_32bit),
+};
+
+static struct arm64_ftr_reg crm_2[] = {
+	ARM64_FTR_REG(SYS_ID_ISAR0_EL1, ftr_generic_scalar_32bit),
+	ARM64_FTR_REG(SYS_ID_ISAR1_EL1, ftr_generic_scalar_32bit),
+	ARM64_FTR_REG(SYS_ID_ISAR2_EL1, ftr_generic_scalar_32bit),
+	ARM64_FTR_REG(SYS_ID_ISAR3_EL1, ftr_generic_scalar_32bit),
+	ARM64_FTR_REG(SYS_ID_ISAR4_EL1, ftr_generic_scalar_32bit),
+	ARM64_FTR_REG(SYS_ID_ISAR5_EL1, ftr_id_isar5),
+	ARM64_FTR_REG(SYS_ID_MMFR4_EL1, ftr_id_mmfr4),
+};
+
+static struct arm64_ftr_reg crm_3[] = {
+	ARM64_FTR_REG(SYS_MVFR0_EL1, ftr_generic_scalar_32bit),
+	ARM64_FTR_REG(SYS_MVFR1_EL1, ftr_generic_scalar_32bit),
+	ARM64_FTR_REG(SYS_MVFR2_EL1, ftr_mvfr2),
+};
+
+static struct arm64_ftr_reg crm_4[] = {
+	ARM64_FTR_REG(SYS_ID_AA64PFR0_EL1, ftr_id_aa64pfr0),
+	ARM64_FTR_REG(SYS_ID_AA64PFR1_EL1, ftr_aa64raz),
+};
+
+static struct arm64_ftr_reg crm_5[] = {
+	ARM64_FTR_REG(SYS_ID_AA64DFR0_EL1, ftr_id_aa64dfr0),
+	ARM64_FTR_REG(SYS_ID_AA64DFR1_EL1, ftr_generic),
+};
+
+static struct arm64_ftr_reg crm_6[] = {
+	ARM64_FTR_REG(SYS_ID_AA64ISAR0_EL1, ftr_id_aa64isar0),
+	ARM64_FTR_REG(SYS_ID_AA64ISAR1_EL1, ftr_aa64raz),
+};
+
+static struct arm64_ftr_reg crm_7[] = {
+	ARM64_FTR_REG(SYS_ID_AA64MMFR0_EL1, ftr_id_aa64mmfr0),
+	ARM64_FTR_REG(SYS_ID_AA64MMFR1_EL1, ftr_id_aa64mmfr1),
+};
+
+static struct arm64_ftr_reg op1_3[] = {
+	ARM64_FTR_REG(SYS_CTR_EL0, ftr_ctr),
+	ARM64_FTR_REG(SYS_DCZID_EL0, ftr_dczid),
+	ARM64_FTR_REG(SYS_CNTFRQ_EL0, ftr_generic32),
+};
+
+#define ARM64_REG_TABLE(table) 		\
+	{ .n = ARRAY_SIZE(table), .regs = table }
+static struct arm64_reg_table {
+	int n;
+	struct arm64_ftr_reg *regs;
+} op1_0[] = {
+	ARM64_REG_TABLE(crm_1),
+	ARM64_REG_TABLE(crm_2),
+	ARM64_REG_TABLE(crm_3),
+	ARM64_REG_TABLE(crm_4),
+	ARM64_REG_TABLE(crm_5),
+	ARM64_REG_TABLE(crm_6),
+	ARM64_REG_TABLE(crm_7),
+};
+
+/*
+ * get_arm6_sys_reg - Lookup a feature register entry using its
+ * sys_reg() encoding.
+ *
+ * We track only the following space:
+ * Op0 = 3, Op1 = 0, CRn = 0, CRm = [1 - 7], Op2 = [0 - 7]
+ * Op0 = 3, Op1 = 3, CRn = 0, CRm = 0, Op2 = { 1, 7 } 	(CTR, DCZID)
+ * Op0 = 3, Op1 = 3, CRn = 14, CRm = 0, Op2 = 0		(CNTFRQ)
+ *
+ * The space (3, 0, 0, {1-7}, {0-7}) is arranged in a 2D array op1_0,
+ * indexed by CRm and Op2. Since not all CRm's have fully allocated Op2's
+ * arm64_reg_table[CRm-1].n indicates the largest Op2 tracked for CRm.
+ *
+ * Since we have limited number of entries with Op1 = 3, we use linear search
+ * to find the reg.
+ *
+ */
+static struct arm64_ftr_reg* get_arm64_sys_reg(u32 sys_id)
+{
+	int i;
+	u8 op2, crn, crm;
+	u8 op1 = sys_reg_Op1(sys_id);
+
+	if (sys_reg_Op0(sys_id) != 3)
+		return NULL;
+	switch (op1) {
+	case 0:
+
+		crm = sys_reg_CRm(sys_id);
+		op2 = sys_reg_Op2(sys_id);
+		crn = sys_reg_CRn(sys_id);
+		if (crn || !crm || crm > 7)
+			return NULL;
+		if (op2 < op1_0[crm - 1].n &&
+			op1_0[crm - 1].regs[op2].sys_id == sys_id)
+			return &op1_0[crm - 1].regs[op2];
+		return NULL;
+	case 3:
+		for (i = 0; i < ARRAY_SIZE(op1_3); i++)
+			if (op1_3[i].sys_id == sys_id)
+				return &op1_3[i];
+	}
+	return NULL;
+}
+
+static u64 arm64_ftr_set_value(struct arm64_ftr_bits *ftrp, s64 reg, s64 ftr_val)
+{
+	u64 mask = ftr_mask(ftrp);
+
+	reg &= ~mask;
+	reg |= (ftr_val << ftrp->shift) & mask;
+	return reg;
+}
+
+static s64 arm64_ftr_safe_value(struct arm64_ftr_bits *ftrp, s64 new, s64 cur)
+{
+	switch(ftrp->type) {
+	case FTR_DISCRETE:
+		return ftrp->safe_val;
+	case FTR_SCALAR_MIN:
+		return new < cur ? new : cur;
+	case FTR_SCALAR_MAX:
+		return new > cur ? new : cur;
+	}
+
+	BUG();
+	return 0;
+}
+
+/*
+ * Initialise the CPU feature register from Boot CPU values.
+ * Also initiliases the strict_mask for the register.
+ */
+static void __init init_cpu_ftr_reg(u32 sys_reg, u64 new)
+{
+	u64 val = 0;
+	u64 strict_mask = ~0x0ULL;
+	struct arm64_ftr_bits *ftrp;
+	struct arm64_ftr_reg *reg = get_arm64_sys_reg(sys_reg);
+
+	BUG_ON(!reg);
+
+	for(ftrp  = reg->ftr_bits; ftrp->width; ftrp++) {
+		s64 ftr_new = arm64_ftr_value(ftrp, new);
+
+		val = arm64_ftr_set_value(ftrp, val, ftr_new);
+		if (!ftrp->strict)
+			strict_mask &= ~ftr_mask(ftrp);
+	}
+	reg->sys_val = val;
+	reg->strict_mask = strict_mask;
+}
+
+void __init init_cpu_features(struct cpuinfo_arm64 *info)
+{
+	init_cpu_ftr_reg(SYS_CTR_EL0, info->reg_ctr);
+	init_cpu_ftr_reg(SYS_DCZID_EL0, info->reg_dczid);
+	init_cpu_ftr_reg(SYS_CNTFRQ_EL0, info->reg_cntfrq);
+	init_cpu_ftr_reg(SYS_ID_AA64DFR0_EL1, info->reg_id_aa64dfr0);
+	init_cpu_ftr_reg(SYS_ID_AA64DFR1_EL1, info->reg_id_aa64dfr1);
+	init_cpu_ftr_reg(SYS_ID_AA64ISAR0_EL1, info->reg_id_aa64isar0);
+	init_cpu_ftr_reg(SYS_ID_AA64ISAR1_EL1, info->reg_id_aa64isar1);
+	init_cpu_ftr_reg(SYS_ID_AA64MMFR0_EL1, info->reg_id_aa64mmfr0);
+	init_cpu_ftr_reg(SYS_ID_AA64MMFR1_EL1, info->reg_id_aa64mmfr1);
+	init_cpu_ftr_reg(SYS_ID_AA64PFR0_EL1, info->reg_id_aa64pfr0);
+	init_cpu_ftr_reg(SYS_ID_AA64PFR1_EL1, info->reg_id_aa64pfr1);
+	init_cpu_ftr_reg(SYS_ID_DFR0_EL1, info->reg_id_dfr0);
+	init_cpu_ftr_reg(SYS_ID_ISAR0_EL1, info->reg_id_isar0);
+	init_cpu_ftr_reg(SYS_ID_ISAR1_EL1, info->reg_id_isar1);
+	init_cpu_ftr_reg(SYS_ID_ISAR2_EL1, info->reg_id_isar2);
+	init_cpu_ftr_reg(SYS_ID_ISAR3_EL1, info->reg_id_isar3);
+	init_cpu_ftr_reg(SYS_ID_ISAR4_EL1, info->reg_id_isar4);
+	init_cpu_ftr_reg(SYS_ID_ISAR5_EL1, info->reg_id_isar5);
+	init_cpu_ftr_reg(SYS_ID_MMFR0_EL1, info->reg_id_mmfr0);
+	init_cpu_ftr_reg(SYS_ID_MMFR1_EL1, info->reg_id_mmfr1);
+	init_cpu_ftr_reg(SYS_ID_MMFR2_EL1, info->reg_id_mmfr2);
+	init_cpu_ftr_reg(SYS_ID_MMFR3_EL1, info->reg_id_mmfr3);
+	init_cpu_ftr_reg(SYS_ID_PFR0_EL1, info->reg_id_pfr0);
+	init_cpu_ftr_reg(SYS_ID_PFR1_EL1, info->reg_id_pfr1);
+	init_cpu_ftr_reg(SYS_MVFR0_EL1, info->reg_mvfr0);
+	init_cpu_ftr_reg(SYS_MVFR1_EL1, info->reg_mvfr1);
+	init_cpu_ftr_reg(SYS_MVFR2_EL1, info->reg_mvfr2);
+
+	/* This will be removed later, once we start using the infrastructure */
+	update_mixed_endian_el0_support(info);
+}
+
+static void update_cpu_ftr_reg(u32 sys_reg, u64 new)
+{
+	struct arm64_ftr_bits *ftrp;
+	struct arm64_ftr_reg *reg = get_arm64_sys_reg(sys_reg);
+
+	BUG_ON(!reg);
+
+	for(ftrp = reg->ftr_bits; ftrp->width; ftrp++) {
+		s64 ftr_cur = arm64_ftr_value(ftrp, reg->sys_val);
+		s64 ftr_new = arm64_ftr_value(ftrp, new);
+
+		if (ftr_cur == ftr_new)
+			continue;
+		/* Find a safe value */
+		ftr_new = arm64_ftr_safe_value(ftrp, ftr_new, ftr_cur);
+		reg->sys_val = arm64_ftr_set_value(ftrp, reg->sys_val, ftr_new);
+	}
+
+}
+
+/* Update CPU feature register from non-boot CPU */
 void update_cpu_features(struct cpuinfo_arm64 *info)
 {
+	update_cpu_ftr_reg(SYS_CTR_EL0, info->reg_ctr);
+	update_cpu_ftr_reg(SYS_DCZID_EL0, info->reg_dczid);
+	update_cpu_ftr_reg(SYS_CNTFRQ_EL0, info->reg_cntfrq);
+	update_cpu_ftr_reg(SYS_ID_AA64DFR0_EL1, info->reg_id_aa64dfr0);
+	update_cpu_ftr_reg(SYS_ID_AA64DFR1_EL1, info->reg_id_aa64dfr1);
+	update_cpu_ftr_reg(SYS_ID_AA64ISAR0_EL1, info->reg_id_aa64isar0);
+	update_cpu_ftr_reg(SYS_ID_AA64ISAR1_EL1, info->reg_id_aa64isar1);
+	update_cpu_ftr_reg(SYS_ID_AA64MMFR0_EL1, info->reg_id_aa64mmfr0);
+	update_cpu_ftr_reg(SYS_ID_AA64MMFR1_EL1, info->reg_id_aa64mmfr1);
+	update_cpu_ftr_reg(SYS_ID_AA64PFR0_EL1, info->reg_id_aa64pfr0);
+	update_cpu_ftr_reg(SYS_ID_AA64PFR1_EL1, info->reg_id_aa64pfr1);
+	update_cpu_ftr_reg(SYS_ID_DFR0_EL1, info->reg_id_dfr0);
+	update_cpu_ftr_reg(SYS_ID_ISAR0_EL1, info->reg_id_isar0);
+	update_cpu_ftr_reg(SYS_ID_ISAR1_EL1, info->reg_id_isar1);
+	update_cpu_ftr_reg(SYS_ID_ISAR2_EL1, info->reg_id_isar2);
+	update_cpu_ftr_reg(SYS_ID_ISAR3_EL1, info->reg_id_isar3);
+	update_cpu_ftr_reg(SYS_ID_ISAR4_EL1, info->reg_id_isar4);
+	update_cpu_ftr_reg(SYS_ID_ISAR5_EL1, info->reg_id_isar5);
+	update_cpu_ftr_reg(SYS_ID_MMFR0_EL1, info->reg_id_mmfr0);
+	update_cpu_ftr_reg(SYS_ID_MMFR1_EL1, info->reg_id_mmfr1);
+	update_cpu_ftr_reg(SYS_ID_MMFR2_EL1, info->reg_id_mmfr2);
+	update_cpu_ftr_reg(SYS_ID_MMFR3_EL1, info->reg_id_mmfr3);
+	update_cpu_ftr_reg(SYS_ID_PFR0_EL1, info->reg_id_pfr0);
+	update_cpu_ftr_reg(SYS_ID_PFR1_EL1, info->reg_id_pfr1);
+	update_cpu_ftr_reg(SYS_MVFR0_EL1, info->reg_mvfr0);
+	update_cpu_ftr_reg(SYS_MVFR1_EL1, info->reg_mvfr1);
+	update_cpu_ftr_reg(SYS_MVFR2_EL1, info->reg_mvfr2);
+
 	update_mixed_endian_el0_support(info);
 }
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 0dadb69..857aaf0 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -340,7 +340,6 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 
 	check_local_cpu_errata();
 	check_local_cpu_features();
-	update_cpu_features(info);
 }
 
 void cpuinfo_store_cpu(void)
@@ -348,6 +347,7 @@ void cpuinfo_store_cpu(void)
 	struct cpuinfo_arm64 *info = this_cpu_ptr(&cpu_data);
 	__cpuinfo_store_cpu(info);
 	cpuinfo_sanity_check(info);
+	update_cpu_features(info);
 }
 
 void __init cpuinfo_store_boot_cpu(void)
@@ -356,4 +356,5 @@ void __init cpuinfo_store_boot_cpu(void)
 	__cpuinfo_store_cpu(info);
 
 	boot_cpu_data = *info;
+	init_cpu_features(&boot_cpu_data);
 }
-- 
1.7.9.5
