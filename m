From: james.morse@arm.com (James Morse)
Date: Tue,  2 Feb 2016 17:03:27 +0000
Subject: [PATCH v1 1/5] arm64: cpufeature: Change read_cpuid() to use sysreg's
 mrs_s macro
In-Reply-To: <1454432611-21333-1-git-send-email-james.morse@arm.com>
References: <1454432611-21333-1-git-send-email-james.morse@arm.com>
Message-ID: <1454432611-21333-2-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Older assemblers may not have support for newer feature registers. To get
round this, sysreg.h provides a 'mrs_s' macro that takes a register
encoding and generates the raw instruction.

Change read_cpuid() to use mrs_s in all cases so that new registers
don't have to be a special case. Including sysreg.h means we need to move
the include and definition of read_cpuid() after the #ifndef __ASSEMBLY__
to avoid syntax errors in vmlinux.lds.

Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>

---
 arch/arm64/include/asm/cpufeature.h |  2 +-
 arch/arm64/include/asm/cputype.h    | 20 +++++++------
 arch/arm64/kernel/cpufeature.c      | 58 ++++++++++++++++++-------------------
 arch/arm64/kernel/cpuinfo.c         | 54 +++++++++++++++++-----------------
 arch/arm64/mm/context.c             |  2 +-
 5 files changed, 69 insertions(+), 67 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 8f271b83f910..d28e8b27ee59 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -176,7 +176,7 @@ u64 read_system_reg(u32 id);
 
 static inline bool cpu_supports_mixed_endian_el0(void)
 {
-	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(ID_AA64MMFR0_EL1));
+	return id_aa64mmfr0_mixed_endian_el0(read_cpuid(SYS_ID_AA64MMFR0_EL1));
 }
 
 static inline bool system_supports_mixed_endian_el0(void)
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 1a5949364ed0..71eecd3c5b4e 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -32,12 +32,6 @@
 #define MPIDR_AFFINITY_LEVEL(mpidr, level) \
 	((mpidr >> MPIDR_LEVEL_SHIFT(level)) & MPIDR_LEVEL_MASK)
 
-#define read_cpuid(reg) ({						\
-	u64 __val;							\
-	asm("mrs	%0, " #reg : "=r" (__val));			\
-	__val;								\
-})
-
 #define MIDR_REVISION_MASK	0xf
 #define MIDR_REVISION(midr)	((midr) & MIDR_REVISION_MASK)
 #define MIDR_PARTNUM_SHIFT	4
@@ -77,6 +71,14 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/sysreg.h>
+
+#define read_cpuid(reg) ({						\
+	u64 __val;							\
+	asm("mrs_s	%0, " __stringify(reg) : "=r" (__val));		\
+	__val;								\
+})
+
 /*
  * The CPU ID never changes at run time, so we might as well tell the
  * compiler that it's constant.  Use this function to read the CPU ID
@@ -84,12 +86,12 @@
  */
 static inline u32 __attribute_const__ read_cpuid_id(void)
 {
-	return read_cpuid(MIDR_EL1);
+	return read_cpuid(SYS_MIDR_EL1);
 }
 
 static inline u64 __attribute_const__ read_cpuid_mpidr(void)
 {
-	return read_cpuid(MPIDR_EL1);
+	return read_cpuid(SYS_MPIDR_EL1);
 }
 
 static inline unsigned int __attribute_const__ read_cpuid_implementor(void)
@@ -104,7 +106,7 @@ static inline unsigned int __attribute_const__ read_cpuid_part_number(void)
 
 static inline u32 __attribute_const__ read_cpuid_cachetype(void)
 {
-	return read_cpuid(CTR_EL0);
+	return read_cpuid(SYS_CTR_EL0);
 }
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5c90aa490a2b..a84febc40db2 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -791,35 +791,35 @@ static inline void set_sys_caps_initialised(void)
 static u64 __raw_read_system_reg(u32 sys_id)
 {
 	switch (sys_id) {
-	case SYS_ID_PFR0_EL1:		return (u64)read_cpuid(ID_PFR0_EL1);
-	case SYS_ID_PFR1_EL1:		return (u64)read_cpuid(ID_PFR1_EL1);
-	case SYS_ID_DFR0_EL1:		return (u64)read_cpuid(ID_DFR0_EL1);
-	case SYS_ID_MMFR0_EL1:		return (u64)read_cpuid(ID_MMFR0_EL1);
-	case SYS_ID_MMFR1_EL1:		return (u64)read_cpuid(ID_MMFR1_EL1);
-	case SYS_ID_MMFR2_EL1:		return (u64)read_cpuid(ID_MMFR2_EL1);
-	case SYS_ID_MMFR3_EL1:		return (u64)read_cpuid(ID_MMFR3_EL1);
-	case SYS_ID_ISAR0_EL1:		return (u64)read_cpuid(ID_ISAR0_EL1);
-	case SYS_ID_ISAR1_EL1:		return (u64)read_cpuid(ID_ISAR1_EL1);
-	case SYS_ID_ISAR2_EL1:		return (u64)read_cpuid(ID_ISAR2_EL1);
-	case SYS_ID_ISAR3_EL1:		return (u64)read_cpuid(ID_ISAR3_EL1);
-	case SYS_ID_ISAR4_EL1:		return (u64)read_cpuid(ID_ISAR4_EL1);
-	case SYS_ID_ISAR5_EL1:		return (u64)read_cpuid(ID_ISAR4_EL1);
-	case SYS_MVFR0_EL1:		return (u64)read_cpuid(MVFR0_EL1);
-	case SYS_MVFR1_EL1:		return (u64)read_cpuid(MVFR1_EL1);
-	case SYS_MVFR2_EL1:		return (u64)read_cpuid(MVFR2_EL1);
-
-	case SYS_ID_AA64PFR0_EL1:	return (u64)read_cpuid(ID_AA64PFR0_EL1);
-	case SYS_ID_AA64PFR1_EL1:	return (u64)read_cpuid(ID_AA64PFR0_EL1);
-	case SYS_ID_AA64DFR0_EL1:	return (u64)read_cpuid(ID_AA64DFR0_EL1);
-	case SYS_ID_AA64DFR1_EL1:	return (u64)read_cpuid(ID_AA64DFR0_EL1);
-	case SYS_ID_AA64MMFR0_EL1:	return (u64)read_cpuid(ID_AA64MMFR0_EL1);
-	case SYS_ID_AA64MMFR1_EL1:	return (u64)read_cpuid(ID_AA64MMFR1_EL1);
-	case SYS_ID_AA64ISAR0_EL1:	return (u64)read_cpuid(ID_AA64ISAR0_EL1);
-	case SYS_ID_AA64ISAR1_EL1:	return (u64)read_cpuid(ID_AA64ISAR1_EL1);
-
-	case SYS_CNTFRQ_EL0:		return (u64)read_cpuid(CNTFRQ_EL0);
-	case SYS_CTR_EL0:		return (u64)read_cpuid(CTR_EL0);
-	case SYS_DCZID_EL0:		return (u64)read_cpuid(DCZID_EL0);
+	case SYS_ID_PFR0_EL1:		return read_cpuid(SYS_ID_PFR0_EL1);
+	case SYS_ID_PFR1_EL1:		return read_cpuid(SYS_ID_PFR1_EL1);
+	case SYS_ID_DFR0_EL1:		return read_cpuid(SYS_ID_DFR0_EL1);
+	case SYS_ID_MMFR0_EL1:		return read_cpuid(SYS_ID_MMFR0_EL1);
+	case SYS_ID_MMFR1_EL1:		return read_cpuid(SYS_ID_MMFR1_EL1);
+	case SYS_ID_MMFR2_EL1:		return read_cpuid(SYS_ID_MMFR2_EL1);
+	case SYS_ID_MMFR3_EL1:		return read_cpuid(SYS_ID_MMFR3_EL1);
+	case SYS_ID_ISAR0_EL1:		return read_cpuid(SYS_ID_ISAR0_EL1);
+	case SYS_ID_ISAR1_EL1:		return read_cpuid(SYS_ID_ISAR1_EL1);
+	case SYS_ID_ISAR2_EL1:		return read_cpuid(SYS_ID_ISAR2_EL1);
+	case SYS_ID_ISAR3_EL1:		return read_cpuid(SYS_ID_ISAR3_EL1);
+	case SYS_ID_ISAR4_EL1:		return read_cpuid(SYS_ID_ISAR4_EL1);
+	case SYS_ID_ISAR5_EL1:		return read_cpuid(SYS_ID_ISAR4_EL1);
+	case SYS_MVFR0_EL1:		return read_cpuid(SYS_MVFR0_EL1);
+	case SYS_MVFR1_EL1:		return read_cpuid(SYS_MVFR1_EL1);
+	case SYS_MVFR2_EL1:		return read_cpuid(SYS_MVFR2_EL1);
+
+	case SYS_ID_AA64PFR0_EL1:	return read_cpuid(SYS_ID_AA64PFR0_EL1);
+	case SYS_ID_AA64PFR1_EL1:	return read_cpuid(SYS_ID_AA64PFR0_EL1);
+	case SYS_ID_AA64DFR0_EL1:	return read_cpuid(SYS_ID_AA64DFR0_EL1);
+	case SYS_ID_AA64DFR1_EL1:	return read_cpuid(SYS_ID_AA64DFR0_EL1);
+	case SYS_ID_AA64MMFR0_EL1:	return read_cpuid(SYS_ID_AA64MMFR0_EL1);
+	case SYS_ID_AA64MMFR1_EL1:	return read_cpuid(SYS_ID_AA64MMFR1_EL1);
+	case SYS_ID_AA64ISAR0_EL1:	return read_cpuid(SYS_ID_AA64ISAR0_EL1);
+	case SYS_ID_AA64ISAR1_EL1:	return read_cpuid(SYS_ID_AA64ISAR1_EL1);
+
+	case SYS_CNTFRQ_EL0:		return read_cpuid(SYS_CNTFRQ_EL0);
+	case SYS_CTR_EL0:		return read_cpuid(SYS_CTR_EL0);
+	case SYS_DCZID_EL0:		return read_cpuid(SYS_DCZID_EL0);
 	default:
 		BUG();
 		return 0;
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 212ae6361d8b..76df22272804 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -201,35 +201,35 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
 {
 	info->reg_cntfrq = arch_timer_get_cntfrq();
 	info->reg_ctr = read_cpuid_cachetype();
-	info->reg_dczid = read_cpuid(DCZID_EL0);
+	info->reg_dczid = read_cpuid(SYS_DCZID_EL0);
 	info->reg_midr = read_cpuid_id();
 
-	info->reg_id_aa64dfr0 = read_cpuid(ID_AA64DFR0_EL1);
-	info->reg_id_aa64dfr1 = read_cpuid(ID_AA64DFR1_EL1);
-	info->reg_id_aa64isar0 = read_cpuid(ID_AA64ISAR0_EL1);
-	info->reg_id_aa64isar1 = read_cpuid(ID_AA64ISAR1_EL1);
-	info->reg_id_aa64mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
-	info->reg_id_aa64mmfr1 = read_cpuid(ID_AA64MMFR1_EL1);
-	info->reg_id_aa64pfr0 = read_cpuid(ID_AA64PFR0_EL1);
-	info->reg_id_aa64pfr1 = read_cpuid(ID_AA64PFR1_EL1);
-
-	info->reg_id_dfr0 = read_cpuid(ID_DFR0_EL1);
-	info->reg_id_isar0 = read_cpuid(ID_ISAR0_EL1);
-	info->reg_id_isar1 = read_cpuid(ID_ISAR1_EL1);
-	info->reg_id_isar2 = read_cpuid(ID_ISAR2_EL1);
-	info->reg_id_isar3 = read_cpuid(ID_ISAR3_EL1);
-	info->reg_id_isar4 = read_cpuid(ID_ISAR4_EL1);
-	info->reg_id_isar5 = read_cpuid(ID_ISAR5_EL1);
-	info->reg_id_mmfr0 = read_cpuid(ID_MMFR0_EL1);
-	info->reg_id_mmfr1 = read_cpuid(ID_MMFR1_EL1);
-	info->reg_id_mmfr2 = read_cpuid(ID_MMFR2_EL1);
-	info->reg_id_mmfr3 = read_cpuid(ID_MMFR3_EL1);
-	info->reg_id_pfr0 = read_cpuid(ID_PFR0_EL1);
-	info->reg_id_pfr1 = read_cpuid(ID_PFR1_EL1);
-
-	info->reg_mvfr0 = read_cpuid(MVFR0_EL1);
-	info->reg_mvfr1 = read_cpuid(MVFR1_EL1);
-	info->reg_mvfr2 = read_cpuid(MVFR2_EL1);
+	info->reg_id_aa64dfr0 = read_cpuid(SYS_ID_AA64DFR0_EL1);
+	info->reg_id_aa64dfr1 = read_cpuid(SYS_ID_AA64DFR1_EL1);
+	info->reg_id_aa64isar0 = read_cpuid(SYS_ID_AA64ISAR0_EL1);
+	info->reg_id_aa64isar1 = read_cpuid(SYS_ID_AA64ISAR1_EL1);
+	info->reg_id_aa64mmfr0 = read_cpuid(SYS_ID_AA64MMFR0_EL1);
+	info->reg_id_aa64mmfr1 = read_cpuid(SYS_ID_AA64MMFR1_EL1);
+	info->reg_id_aa64pfr0 = read_cpuid(SYS_ID_AA64PFR0_EL1);
+	info->reg_id_aa64pfr1 = read_cpuid(SYS_ID_AA64PFR1_EL1);
+
+	info->reg_id_dfr0 = read_cpuid(SYS_ID_DFR0_EL1);
+	info->reg_id_isar0 = read_cpuid(SYS_ID_ISAR0_EL1);
+	info->reg_id_isar1 = read_cpuid(SYS_ID_ISAR1_EL1);
+	info->reg_id_isar2 = read_cpuid(SYS_ID_ISAR2_EL1);
+	info->reg_id_isar3 = read_cpuid(SYS_ID_ISAR3_EL1);
+	info->reg_id_isar4 = read_cpuid(SYS_ID_ISAR4_EL1);
+	info->reg_id_isar5 = read_cpuid(SYS_ID_ISAR5_EL1);
+	info->reg_id_mmfr0 = read_cpuid(SYS_ID_MMFR0_EL1);
+	info->reg_id_mmfr1 = read_cpuid(SYS_ID_MMFR1_EL1);
+	info->reg_id_mmfr2 = read_cpuid(SYS_ID_MMFR2_EL1);
+	info->reg_id_mmfr3 = read_cpuid(SYS_ID_MMFR3_EL1);
+	info->reg_id_pfr0 = read_cpuid(SYS_ID_PFR0_EL1);
+	info->reg_id_pfr1 = read_cpuid(SYS_ID_PFR1_EL1);
+
+	info->reg_mvfr0 = read_cpuid(SYS_MVFR0_EL1);
+	info->reg_mvfr1 = read_cpuid(SYS_MVFR1_EL1);
+	info->reg_mvfr2 = read_cpuid(SYS_MVFR2_EL1);
 
 	cpuinfo_detect_icache_policy(info);
 
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index e87f53ff5f58..7275628ba59f 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -187,7 +187,7 @@ switch_mm_fastpath:
 
 static int asids_init(void)
 {
-	int fld = cpuid_feature_extract_field(read_cpuid(ID_AA64MMFR0_EL1), 4);
+	int fld = cpuid_feature_extract_field(read_cpuid(SYS_ID_AA64MMFR0_EL1), 4);
 
 	switch (fld) {
 	default:
-- 
2.6.2
