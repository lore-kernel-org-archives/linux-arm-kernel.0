From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 24 Jul 2015 10:43:51 +0100
Subject: [RFC PATCH 05/10] arm64: Keep track of CPU feature registers
In-Reply-To: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
References: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1437731037-25795-6-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

This patch adds an infrastructure to keep track of the CPU feature
registers on the system. This patch also consolidates the cpuinfo
SANITY checks which ensures that we don't have conflicting feature
supports across the CPUs.

Each register has a set of feature bits defined by the architecture.
We define the following attributes:

 1) strict - If strict matching is required for the field across the
    all the CPUs for SANITY checks.
 2) visible - If the field is exposed to the userspace (See documentation
    for more details).

The default 'safe' value for the feature is also defined, which will be
used:
 1) To set the value for a 'discrete' feature with conflicting values.
 2) To set the value for an 'invisible' feature for the userspace.

The infrastructure keeps track of the following values for a feature
register:
 - user visible value
 - system wide safe value

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpu.h |  149 ++++++++++++++++
 arch/arm64/kernel/cpuinfo.c  |  399 ++++++++++++++++++++++++++++++++++++++----
 2 files changed, 511 insertions(+), 37 deletions(-)

diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
index a34de72..c7b0b89 100644
--- a/arch/arm64/include/asm/cpu.h
+++ b/arch/arm64/include/asm/cpu.h
@@ -16,10 +16,154 @@
 #ifndef __ASM_CPU_H
 #define __ASM_CPU_H
 
+#include <asm/sysreg.h>
 #include <linux/cpu.h>
 #include <linux/init.h>
 #include <linux/percpu.h>
 
+
+#define SYS_REG(op0, op1, crn, crm, op2) \
+			(sys_reg(op0, op1, crn, crm, op2) >> 5)
+
+#define SYS_ID_PFR0_EL1			SYS_REG(3, 0, 0, 1, 0)
+#define SYS_ID_PFR1_EL1			SYS_REG(3, 0, 0, 1, 1)
+#define SYS_ID_DFR0_EL1			SYS_REG(3, 0, 0, 1, 2)
+#define SYS_ID_MMFR0_EL1		SYS_REG(3, 0, 0, 1, 4)
+#define SYS_ID_MMFR1_EL1		SYS_REG(3, 0, 0, 1, 5)
+#define SYS_ID_MMFR2_EL1		SYS_REG(3, 0, 0, 1, 6)
+#define SYS_ID_MMFR3_EL1		SYS_REG(3, 0, 0, 1, 7)
+
+#define SYS_ID_ISAR0_EL1		SYS_REG(3, 0, 0, 2, 0)
+#define SYS_ID_ISAR1_EL1		SYS_REG(3, 0, 0, 2, 1)
+#define SYS_ID_ISAR2_EL1		SYS_REG(3, 0, 0, 2, 2)
+#define SYS_ID_ISAR3_EL1		SYS_REG(3, 0, 0, 2, 3)
+#define SYS_ID_ISAR4_EL1		SYS_REG(3, 0, 0, 2, 4)
+#define SYS_ID_ISAR5_EL1		SYS_REG(3, 0, 0, 2, 5)
+#define SYS_ID_MMFR4_EL1		SYS_REG(3, 0, 0, 2, 6)
+
+#define SYS_MVFR0_EL1			SYS_REG(3, 0, 0, 3, 0)
+#define SYS_MVFR1_EL1			SYS_REG(3, 0, 0, 3, 1)
+#define SYS_MVFR2_EL1			SYS_REG(3, 0, 0, 3, 2)
+
+#define SYS_ID_AA64PFR0_EL1		SYS_REG(3, 0, 0, 4, 0)
+#define SYS_ID_AA64PFR1_EL1		SYS_REG(3, 0, 0, 4, 1)
+
+#define SYS_ID_AA64DFR0_EL1		SYS_REG(3, 0, 0, 5, 0)
+#define SYS_ID_AA64DFR1_EL1		SYS_REG(3, 0, 0, 5, 1)
+
+#define SYS_ID_AA64ISAR0_EL1		SYS_REG(3, 0, 0, 6, 0)
+#define SYS_ID_AA64ISAR1_EL1		SYS_REG(3, 0, 0, 6, 1)
+
+#define SYS_ID_AA64MMFR0_EL1		SYS_REG(3, 0, 0, 7, 0)
+#define SYS_ID_AA64MMFR1_EL1		SYS_REG(3, 0, 0, 7, 1)
+
+#define SYS_CNTFRQ_EL0			SYS_REG(3, 3, 14, 0, 0)
+#define SYS_CTR_EL0			SYS_REG(3, 3, 0, 0, 1)
+#define SYS_DCZID_EL0			SYS_REG(3, 3, 0, 0, 7)
+
+enum sys_id {
+	sys_cntfrq = SYS_CNTFRQ_EL0,
+	sys_ctr = SYS_CTR_EL0,
+	sys_dczid = SYS_DCZID_EL0,
+
+	sys_id_aa64dfr0 = SYS_ID_AA64DFR0_EL1,
+	sys_id_aa64dfr1 = SYS_ID_AA64DFR1_EL1,
+
+	sys_id_aa64isar0 = SYS_ID_AA64ISAR0_EL1,
+	sys_id_aa64isar1 = SYS_ID_AA64ISAR1_EL1,
+
+	sys_id_aa64mmfr0 = SYS_ID_AA64MMFR0_EL1,
+	sys_id_aa64mmfr1 = SYS_ID_AA64MMFR1_EL1,
+
+	sys_id_aa64pfr0 = SYS_ID_AA64PFR0_EL1,
+	sys_id_aa64pfr1 = SYS_ID_AA64PFR1_EL1,
+
+	sys_id_dfr0 = SYS_ID_DFR0_EL1,
+
+	sys_id_isar0 = SYS_ID_ISAR0_EL1,
+	sys_id_isar1 = SYS_ID_ISAR1_EL1,
+	sys_id_isar2 = SYS_ID_ISAR2_EL1,
+	sys_id_isar3 = SYS_ID_ISAR3_EL1,
+	sys_id_isar4 = SYS_ID_ISAR4_EL1,
+	sys_id_isar5 = SYS_ID_ISAR5_EL1,
+
+	sys_id_mmfr0 = SYS_ID_MMFR0_EL1,
+	sys_id_mmfr1 = SYS_ID_MMFR1_EL1,
+	sys_id_mmfr2 = SYS_ID_MMFR2_EL1,
+	sys_id_mmfr3 = SYS_ID_MMFR3_EL1,
+	sys_id_mmfr4 = SYS_ID_MMFR4_EL1,
+
+	sys_id_pfr0 = SYS_ID_PFR0_EL1,
+	sys_id_pfr1 = SYS_ID_PFR1_EL1,
+
+	sys_mvfr0 = SYS_MVFR0_EL1,
+	sys_mvfr1 = SYS_MVFR1_EL1,
+	sys_mvfr2 = SYS_MVFR2_EL1,
+};
+
+enum ftr_type {
+	FTR_DISCRETE,
+	FTR_SCALAR_MIN,
+	FTR_SCALAR_MAX,
+};
+
+struct arm64_ftr_bits {
+	bool		visible;	/* visible to userspace ? */
+	bool		strict;		/* CPU Sanity check
+					 *  strict matching required ? */
+	enum ftr_type	type;
+	u8		shift;
+	u64		mask;
+	u64		safe_val;	/* user visible safe value */
+};
+
+/*
+ * @arm64_ftr_reg - Feature register
+ * @user_mask 		User visibile bits of val. Rest of them are
+ *			marked as 'not supported' as held in @user_val.
+ * @strict_mask 	Bits which should match across all CPUs for sanity.
+ * @sys_val		Safe value across the CPUs (system view)
+ * @user_val		'Invisible' fields of the sysreg filled with
+ *			 respective 'unsupported' value.
+ */
+struct arm64_ftr_reg {
+	enum sys_id		sys_id;
+	const char*		name;
+	u64			user_mask;
+	u64			strict_mask;
+	u64			sys_val;
+	u64			user_val;
+	struct arm64_ftr_bits*	ftr_bits;
+};
+
+#define FTR_STRICT	true
+#define FTR_NONSTRICT	false
+#define FTR_VISIBLE	true
+#define FTR_HIDDEN	false
+
+#define ARM64_FTR_BITS(ftr_visible, ftr_strict, ftr_type, ftr_shift, ftr_mask, ftr_safe_val)	\
+	{							\
+		.visible = ftr_visible,				\
+		.strict = ftr_strict,				\
+		.type = ftr_type,				\
+		.shift = ftr_shift,				\
+		.mask = ftr_mask,				\
+		.safe_val = ftr_safe_val,			\
+	}
+
+
+#define ARM64_FTR_END					\
+	{						\
+		.mask = 0,				\
+	}
+
+#define ARM64_FTR_REG(id, ftr_table)			\
+	{						\
+		.sys_id = sys_ ## id,			\
+		.name = #id,				\
+		.ftr_bits = &((ftr_table)[0]),		\
+	}
+
 /*
  * Records attributes of an individual CPU.
  */
@@ -64,4 +208,9 @@ void cpuinfo_store_cpu(void);
 void __init cpuinfo_store_boot_cpu(void);
 void __init setup_processor_features(void);
 
+static inline u64 arm64_ftr_value(struct arm64_ftr_bits *ftrp, u64 reg)
+{
+	return ((reg >> ftrp->shift) & ftrp->mask);
+}
+
 #endif /* __ASM_CPU_H */
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index a13468b..ae2a37f 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -31,6 +31,207 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 
+struct arm64_ftr_bits ftr_id_aa64isar0[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 32, 0xffffffffUL, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 20, 0xfffUL, 0),
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_DISCRETE, 16, 0xfUL, 0),	// crc32
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_DISCRETE, 12, 0xfUL, 0),	// sha2
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_DISCRETE, 8, 0xfUL, 0),	// sha1
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_SCALAR_MIN, 4, 0xfUL, 0),	// aes
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 0, 0xfUL, 0),	// RAZ
+	ARM64_FTR_END,
+};
+
+#define id_aa64pfr0_simd_not_implemented	0xf
+#define id_aa64pfr0_fp_not_implemented		0xf
+#define id_aa64pfr0_ELx_64bit_only 		0x1
+struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 32, 0xffffffffUL, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 28, 0xfUL, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 24, 0xfUL, 0),			// GIC
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_DISCRETE, 20, 0xfUL, id_aa64pfr0_simd_not_implemented), 	// simd
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_DISCRETE, 16, 0xfUL, id_aa64pfr0_fp_not_implemented),	// fp
+	/* Linux doesn't care about the EL3 */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_DISCRETE, 12, 0xfUL, 0),			// EL3
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 8, 0xfUL, 0),			// EL2
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 4, 0xfUL, id_aa64pfr0_ELx_64bit_only), // EL1
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 0, 0xfUL, id_aa64pfr0_ELx_64bit_only), // EL0
+	ARM64_FTR_END,
+};
+
+#define id_aa64mmfr0_TGran4k_not_implemented		0xf
+#define id_aa64mmfr0_TGran64k_not_implemented		0xf
+#define id_aa64mmfr0_TGran16k_not_implemented		0x0
+struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 32, 0xffffffffUL, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 28, 0xfUL, id_aa64mmfr0_TGran4k_not_implemented),	// TGran4
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 24, 0xfUL, id_aa64mmfr0_TGran64k_not_implemented),	// TGran64
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 20, 0xfUL, id_aa64mmfr0_TGran16k_not_implemented),	// TGran16
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 16, 0xfUL, 0),		// BigEndEL0
+	/* Linux shouldn't care about secure memory */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_DISCRETE, 12, 0xfUL, 0),		// SNSMem
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 8, 0xfUL, 0),		// BigEndEL
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 4, 0xfUL, 0),		// ASID
+	/*
+	 * Differing PARange is fine as long as all peripherals and memory are mapped
+	 * within the minimum PARange of all CPUs
+	 */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_SCALAR_MIN, 0, 0xfUL, 0),		// PARange
+	ARM64_FTR_END,
+};
+
+struct arm64_ftr_bits ftr_ctr[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 31, 0x1UL, 1),	// RAO
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 28, 0x7UL, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_SCALAR_MAX, 24, 0xfUL, 0),	// CWG
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_SCALAR_MIN, 20, 0xfUL, 0),	// ERG
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_SCALAR_MIN, 16, 0xfUL, 1),	// DminLine
+	/*
+	 * Linux can handle differing I-cache policies. Userspace JITs will
+	 * make use of *minLine
+	 */
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_DISCRETE, 14, 0x3UL, 0),	// L1Ip
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 4, 0x3ffUL, 0),	// RAZ
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_SCALAR_MIN, 0, 0xfUL, 0),	// IminLine
+	ARM64_FTR_END,
+};
+
+struct arm64_ftr_bits ftr_id_mmfr0[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 28, 0xfUL, 0),	// InnerShr
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 24, 0xfUL, 0),	// FCSE
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_SCALAR_MIN, 20, 0xfUL, 0),	// AuxReg
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 16, 0xfUL, 0),	// TCM
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 12, 0xfUL, 0),	// ShareLvl
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 8, 0xfUL, 0),	// OuterShr
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 4, 0xfUL, 0),	// PMSA
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 0, 0xfUL, 0),	// VMSA
+	ARM64_FTR_END,
+};
+
+struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 32, 0xffffffffUL, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_SCALAR_MIN, 28, 0xfUL, 0),	// CTX_CMPs
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_SCALAR_MIN, 20, 0xfUL, 0),	// WRPs
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_SCALAR_MIN, 12, 0xfUL, 0),	// BRPs
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 8, 0xfUL, 0),	// PMUVer
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 4, 0xfUL, 0),	// TraceVer
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 0, 0xfUL, 0x6),	// DebugVer
+	ARM64_FTR_END,
+};
+
+struct arm64_ftr_bits ftr_mvfr2[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 8, 0xffffffUL, 0),	// RAZ
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 4, 0xfUL, 0),	// FPMisc
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 0, 0xfUL, 0),	// SIMDMisc
+	ARM64_FTR_END,
+};
+
+struct arm64_ftr_bits ftr_dczid[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 5, 0x7ffffffUL, 0),// RAZ
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 4, 0x1UL, 1),	// DZP
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_SCALAR_MIN, 0, 0xf, 0),	// BS
+	ARM64_FTR_END,
+};
+
+
+struct arm64_ftr_bits ftr_id_isar5[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 20, 0xfffUL, 0),	// RAZ
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 16, 0xfUL, 0),	// CRC32
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 12, 0xfUL, 0),	// SHA2
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 8, 0xfUL, 0),	// SHA1
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 4, 0xfUL, 0),	// AES
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 0, 0xfUL, 0),	// SEVL
+	ARM64_FTR_END,
+};
+
+struct arm64_ftr_bits ftr_id_mmfr4[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 8, 0xffffffUL, 0),	// RAZ
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 4, 0xfUL, 0),	// ac2
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 0, 0xfUL, 0),	// RAZ
+	ARM64_FTR_END,
+};
+
+struct arm64_ftr_bits ftr_id_pfr0[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 16, 0xffffUL, 0),	// RAZ
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 12, 0xfUL, 0),	// State3
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 8, 0xfUL, 0),	// State2
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 4, 0xfUL, 0),	// State1
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 0, 0xfUL, 0),	// State0
+	ARM64_FTR_END,
+};
+
+/*
+ * Common ftr bits for a 32bit register with all hidden, strict
+ * attributes, with 4bit feature fields and a default safe value of
+ * 0. Covers the following 32bit registers:
+ * id_isar[0-4], id_mmfr[1-3], id_pfr1, mvfr[0-1]
+ */
+struct arm64_ftr_bits ftr_generic_discrete_32bit[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 28, 0xfUL, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 24, 0xfUL, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 20, 0xfUL, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 16, 0xfUL, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 12, 0xfUL, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 8, 0xfUL, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 4, 0xfUL, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 0, 0xfUL, 0),
+	ARM64_FTR_END,
+};
+
+struct arm64_ftr_bits ftr_generic[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 0, ~0x0ULL, 0),
+	ARM64_FTR_END,
+};
+
+struct arm64_ftr_bits ftr_generic32[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_DISCRETE, 0, 0xffffffffUL, 0),
+	ARM64_FTR_END,
+};
+
+struct arm64_ftr_bits ftr_aa64raz[] = {
+	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_DISCRETE, 0, ~0x0ULL, 0),
+	ARM64_FTR_END,
+};
+
+static struct arm64_ftr_reg arm64_regs[] = {
+
+	ARM64_FTR_REG(id_aa64isar0, ftr_id_aa64isar0),
+	ARM64_FTR_REG(id_aa64pfr0, ftr_id_aa64pfr0),
+	ARM64_FTR_REG(id_aa64pfr1, ftr_aa64raz),
+	ARM64_FTR_REG(id_aa64isar1, ftr_aa64raz),
+
+	ARM64_FTR_REG(id_aa64mmfr0, ftr_id_aa64mmfr0),
+	ARM64_FTR_REG(id_aa64dfr0, ftr_id_aa64dfr0),
+	ARM64_FTR_REG(id_aa64dfr1, ftr_generic),
+	ARM64_FTR_REG(id_aa64mmfr1, ftr_generic),
+	ARM64_FTR_REG(ctr, ftr_ctr),
+
+	ARM64_FTR_REG(dczid, ftr_dczid),
+	ARM64_FTR_REG(cntfrq, ftr_generic32),
+
+	ARM64_FTR_REG(id_dfr0, ftr_generic_discrete_32bit),
+	ARM64_FTR_REG(id_isar0, ftr_generic_discrete_32bit),
+	ARM64_FTR_REG(id_isar1, ftr_generic_discrete_32bit),
+	ARM64_FTR_REG(id_isar2, ftr_generic_discrete_32bit),
+	ARM64_FTR_REG(id_isar3, ftr_generic_discrete_32bit),
+	ARM64_FTR_REG(id_isar4, ftr_generic_discrete_32bit),
+	ARM64_FTR_REG(id_isar5, ftr_id_isar5),
+
+	ARM64_FTR_REG(id_mmfr0, ftr_id_mmfr0),
+	ARM64_FTR_REG(id_mmfr1, ftr_generic_discrete_32bit),
+	ARM64_FTR_REG(id_mmfr2, ftr_generic_discrete_32bit),
+	ARM64_FTR_REG(id_mmfr3, ftr_generic_discrete_32bit),
+	ARM64_FTR_REG(id_mmfr4, ftr_id_mmfr4),
+
+	ARM64_FTR_REG(id_pfr0, ftr_id_pfr0),
+	ARM64_FTR_REG(id_pfr1, ftr_generic_discrete_32bit),
+
+	ARM64_FTR_REG(mvfr0, ftr_generic_discrete_32bit),
+	ARM64_FTR_REG(mvfr1, ftr_generic_discrete_32bit),
+	ARM64_FTR_REG(mvfr2, ftr_mvfr2),
+
+};
+
 /*
  * In case the boot CPU is hotpluggable, we record its initial state and
  * current state separately. Certain system registers may contain different
@@ -92,22 +293,146 @@ static void update_cpu_features(struct cpuinfo_arm64 *info)
 	update_mixed_endian_el0_support(info);
 }
 
-static int check_reg_mask(char *name, u64 mask, u64 boot, u64 cur, int cpu)
+static inline int arm64_boot_cpuinfo_initialised(void)
+{
+	return (boot_cpu_data.reg_midr != 0);
+}
+
+static struct arm64_ftr_reg* get_arm64_sys_reg(enum sys_id sys_id)
+{
+	int i;
+
+	for(i = 0; i < ARRAY_SIZE(arm64_regs); i ++)
+		if (arm64_regs[i].sys_id == sys_id)
+			return &arm64_regs[i];
+	return NULL;
+}
+
+static u64 arm64_ftr_set_value(struct arm64_ftr_bits *ftrp, u64 reg, u64 ftr_val)
+{
+	u64 mask = ftrp->mask << ftrp->shift;
+
+	reg &= ~mask;
+	reg |= (ftr_val << ftrp->shift) & mask;
+	return reg;
+}
+
+/*
+ * Initialise the CPU feature register from Boot CPU values.
+ * Also initiliases the user_mask & strict_mask for the register.
+ */
+static void init_cpu_ftr_reg(struct arm64_ftr_reg *reg,  u64 new)
+{
+	struct arm64_ftr_bits *ftrp = reg->ftr_bits;
+	u64 user_mask = 0, strict_mask = ~0x0ULL;
+
+	for(; ftrp->mask; ftrp++) {
+		u64 ftr_new = arm64_ftr_value(ftrp, new);
+
+		reg->sys_val = arm64_ftr_set_value(ftrp, reg->sys_val, ftr_new);
+		if (ftrp->visible)
+			user_mask |= (ftrp->mask << ftrp->shift);
+		else
+			reg->user_val = arm64_ftr_set_value(ftrp, reg->user_val,
+								ftrp->safe_val);
+		if (!ftrp->strict)
+			strict_mask &= ~(ftrp->mask << ftrp->shift);
+	}
+	reg->user_mask = user_mask;
+	reg->strict_mask = strict_mask;
+}
+
+#define INIT_FTR_REG(info, id) \
+		init_cpu_ftr_reg(get_arm64_sys_reg(sys_ ##id), (u64)info->reg_ ##id)
+
+static void init_cpu_ftrs(struct cpuinfo_arm64 *info)
 {
-	if ((boot & mask) == (cur & mask))
+	INIT_FTR_REG(info, ctr);
+	INIT_FTR_REG(info, dczid);
+	INIT_FTR_REG(info, cntfrq);
+	INIT_FTR_REG(info, id_aa64dfr0);
+	INIT_FTR_REG(info, id_aa64dfr1);
+	INIT_FTR_REG(info, id_aa64isar0);
+	INIT_FTR_REG(info, id_aa64isar1);
+	INIT_FTR_REG(info, id_aa64mmfr0);
+	INIT_FTR_REG(info, id_aa64mmfr1);
+	INIT_FTR_REG(info, id_aa64pfr0);
+	INIT_FTR_REG(info, id_aa64pfr1);
+	INIT_FTR_REG(info, id_dfr0);
+	INIT_FTR_REG(info, id_isar0);
+	INIT_FTR_REG(info, id_isar1);
+	INIT_FTR_REG(info, id_isar2);
+	INIT_FTR_REG(info, id_isar3);
+	INIT_FTR_REG(info, id_isar4);
+	INIT_FTR_REG(info, id_isar5);
+	INIT_FTR_REG(info, id_mmfr0);
+	INIT_FTR_REG(info, id_mmfr1);
+	INIT_FTR_REG(info, id_mmfr2);
+	INIT_FTR_REG(info, id_mmfr3);
+	INIT_FTR_REG(info, id_pfr0);
+	INIT_FTR_REG(info, id_pfr1);
+	INIT_FTR_REG(info, mvfr0);
+	INIT_FTR_REG(info, mvfr1);
+	INIT_FTR_REG(info, mvfr2);
+}
+
+static u64 arm64_ftr_safe_value(struct arm64_ftr_bits *ftrp, u64 new, u64 cur)
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
+static void update_cpu_ftr_reg(struct arm64_ftr_reg *reg, u64 new, int cpu)
+{
+	struct arm64_ftr_bits *ftrp = reg->ftr_bits;
+
+	for(; ftrp->mask; ftrp++) {
+
+		u64 ftr_cur = arm64_ftr_value(ftrp, reg->sys_val);
+		u64 ftr_new = arm64_ftr_value(ftrp, new);
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
+static int check_reg_mask(struct arm64_ftr_reg *reg, u64 boot, u64 cur, int cpu)
+{
+
+	if ((boot & reg->strict_mask) == (cur & reg->strict_mask))
 		return 0;
 
 	pr_warn("SANITY CHECK: Unexpected variation in %s. Boot CPU: %#016lx, CPU%d: %#016lx\n",
-		name, (unsigned long)boot, cpu, (unsigned long)cur);
+		reg->name, (unsigned long)boot, cpu, (unsigned long)cur);
 
 	return 1;
 }
 
-#define CHECK_MASK(field, mask, boot, cur, cpu) \
-	check_reg_mask(#field, mask, (boot)->reg_ ## field, (cur)->reg_ ## field, cpu)
-
-#define CHECK(field, boot, cur, cpu) \
-	CHECK_MASK(field, ~0ULL, boot, cur, cpu)
+#define CHECK_CPUINFO(field)			 					\
+	({										\
+		int __rc = 0;								\
+		struct arm64_ftr_reg *__regp = get_arm64_sys_reg(sys_ ## field);	\
+		if (__regp) {								\
+			__rc = check_reg_mask(__regp,					\
+						(boot)->reg_ ## field,			\
+						(cur)->reg_ ## field, cpu);		\
+			update_cpu_ftr_reg(__regp, cur->reg_ ## field, cpu);		\
+		}									\
+		__rc;									\
+	})
 
 /*
  * Verify that CPUs don't have unexpected differences that will cause problems.
@@ -123,17 +448,17 @@ static void cpuinfo_sanity_check(struct cpuinfo_arm64 *cur)
 	 * caches should look identical. Userspace JITs will make use of
 	 * *minLine.
 	 */
-	diff |= CHECK_MASK(ctr, 0xffff3fff, boot, cur, cpu);
+	diff |= CHECK_CPUINFO(ctr);
 
 	/*
 	 * Userspace may perform DC ZVA instructions. Mismatched block sizes
 	 * could result in too much or too little memory being zeroed if a
 	 * process is preempted and migrated between CPUs.
 	 */
-	diff |= CHECK(dczid, boot, cur, cpu);
+	diff |= CHECK_CPUINFO(dczid);
 
 	/* If different, timekeeping will be broken (especially with KVM) */
-	diff |= CHECK(cntfrq, boot, cur, cpu);
+	diff |= CHECK_CPUINFO(cntfrq);
 
 	/*
 	 * The kernel uses self-hosted debug features and expects CPUs to
@@ -141,15 +466,15 @@ static void cpuinfo_sanity_check(struct cpuinfo_arm64 *cur)
 	 * and BRPs to be identical.
 	 * ID_AA64DFR1 is currently RES0.
 	 */
-	diff |= CHECK(id_aa64dfr0, boot, cur, cpu);
-	diff |= CHECK(id_aa64dfr1, boot, cur, cpu);
+	diff |= CHECK_CPUINFO(id_aa64dfr0);
+	diff |= CHECK_CPUINFO(id_aa64dfr1);
 
 	/*
 	 * Even in big.LITTLE, processors should be identical instruction-set
 	 * wise.
 	 */
-	diff |= CHECK(id_aa64isar0, boot, cur, cpu);
-	diff |= CHECK(id_aa64isar1, boot, cur, cpu);
+	diff |= CHECK_CPUINFO(id_aa64isar0);
+	diff |= CHECK_CPUINFO(id_aa64isar1);
 
 	/*
 	 * Differing PARange support is fine as long as all peripherals and
@@ -157,42 +482,42 @@ static void cpuinfo_sanity_check(struct cpuinfo_arm64 *cur)
 	 * Linux should not care about secure memory.
 	 * ID_AA64MMFR1 is currently RES0.
 	 */
-	diff |= CHECK_MASK(id_aa64mmfr0, 0xffffffffffff0ff0, boot, cur, cpu);
-	diff |= CHECK(id_aa64mmfr1, boot, cur, cpu);
+	diff |= CHECK_CPUINFO(id_aa64mmfr0);
+	diff |= CHECK_CPUINFO(id_aa64mmfr1);
 
 	/*
 	 * EL3 is not our concern.
 	 * ID_AA64PFR1 is currently RES0.
 	 */
-	diff |= CHECK_MASK(id_aa64pfr0, 0xffffffffffff0fff, boot, cur, cpu);
-	diff |= CHECK(id_aa64pfr1, boot, cur, cpu);
+	diff |= CHECK_CPUINFO(id_aa64pfr0);
+	diff |= CHECK_CPUINFO(id_aa64pfr1);
 
 	/*
 	 * If we have AArch32, we care about 32-bit features for compat. These
 	 * registers should be RES0 otherwise.
 	 */
-	diff |= CHECK(id_dfr0, boot, cur, cpu);
-	diff |= CHECK(id_isar0, boot, cur, cpu);
-	diff |= CHECK(id_isar1, boot, cur, cpu);
-	diff |= CHECK(id_isar2, boot, cur, cpu);
-	diff |= CHECK(id_isar3, boot, cur, cpu);
-	diff |= CHECK(id_isar4, boot, cur, cpu);
-	diff |= CHECK(id_isar5, boot, cur, cpu);
+	diff |= CHECK_CPUINFO(id_dfr0);
+	diff |= CHECK_CPUINFO(id_isar0);
+	diff |= CHECK_CPUINFO(id_isar1);
+	diff |= CHECK_CPUINFO(id_isar2);
+	diff |= CHECK_CPUINFO(id_isar3);
+	diff |= CHECK_CPUINFO(id_isar4);
+	diff |= CHECK_CPUINFO(id_isar5);
 	/*
 	 * Regardless of the value of the AuxReg field, the AIFSR, ADFSR, and
 	 * ACTLR formats could differ across CPUs and therefore would have to
 	 * be trapped for virtualization anyway.
 	 */
-	diff |= CHECK_MASK(id_mmfr0, 0xff0fffff, boot, cur, cpu);
-	diff |= CHECK(id_mmfr1, boot, cur, cpu);
-	diff |= CHECK(id_mmfr2, boot, cur, cpu);
-	diff |= CHECK(id_mmfr3, boot, cur, cpu);
-	diff |= CHECK(id_pfr0, boot, cur, cpu);
-	diff |= CHECK(id_pfr1, boot, cur, cpu);
+	diff |= CHECK_CPUINFO(id_mmfr0);
+	diff |= CHECK_CPUINFO(id_mmfr1);
+	diff |= CHECK_CPUINFO(id_mmfr2);
+	diff |= CHECK_CPUINFO(id_mmfr3);
+	diff |= CHECK_CPUINFO(id_pfr0);
+	diff |= CHECK_CPUINFO(id_pfr1);
 
-	diff |= CHECK(mvfr0, boot, cur, cpu);
-	diff |= CHECK(mvfr1, boot, cur, cpu);
-	diff |= CHECK(mvfr2, boot, cur, cpu);
+	diff |= CHECK_CPUINFO(mvfr0);
+	diff |= CHECK_CPUINFO(mvfr1);
+	diff |= CHECK_CPUINFO(mvfr2);
 
 	/*
 	 * Mismatched CPU features are a recipe for disaster. Don't even
@@ -239,7 +564,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 	cpuinfo_detect_icache_policy(info);
 
 	check_local_cpu_errata();
-	check_local_cpu_features();
+	cpuinfo_sanity_check(info);
 	update_cpu_features(info);
 }
 
@@ -247,13 +572,13 @@ void cpuinfo_store_cpu(void)
 {
 	struct cpuinfo_arm64 *info = this_cpu_ptr(&cpu_data);
 	__cpuinfo_store_cpu(info);
-	cpuinfo_sanity_check(info);
 }
 
 void __init cpuinfo_store_boot_cpu(void)
 {
 	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, 0);
 	__cpuinfo_store_cpu(info);
+	init_cpu_ftrs(info);
 
 	boot_cpu_data = *info;
 }
-- 
1.7.9.5
