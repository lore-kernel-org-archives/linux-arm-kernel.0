From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 26 Jan 2016 10:58:16 +0000
Subject: [PATCH 4/4] arm64: Rename cpuid_feature field extract routines
In-Reply-To: <1453805896-4397-1-git-send-email-suzuki.poulose@arm.com>
References: <1453805896-4397-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1453805896-4397-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a clear understanding of the sign of a feature,
rename the routines to reflect the sign, so that it is not misused.
The cpuid_feature_extract_field() now accepts a 'sign' parameter.

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |   22 ++++++++++++++--------
 arch/arm64/include/asm/kvm_mmu.h    |    2 +-
 arch/arm64/kernel/cpufeature.c      |    2 +-
 arch/arm64/kernel/debug-monitors.c  |    2 +-
 arch/arm64/kvm/sys_regs.c           |    2 +-
 arch/arm64/mm/context.c             |    2 +-
 6 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 5315d2d..5444a77 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -118,15 +118,15 @@ static inline void cpus_set_cap(unsigned int num)
 }
 
 static inline int __attribute_const__
-cpuid_feature_extract_field_width(u64 features, int field, int width)
+cpuid_feature_extract_signed_field_width(u64 features, int field, int width)
 {
 	return (s64)(features << (64 - width - field)) >> (64 - width);
 }
 
 static inline int __attribute_const__
-cpuid_feature_extract_field(u64 features, int field)
+cpuid_feature_extract_signed_field(u64 features, int field)
 {
-	return cpuid_feature_extract_field_width(features, field, 4);
+	return cpuid_feature_extract_signed_field_width(features, field, 4);
 }
 
 static inline unsigned int __attribute_const__
@@ -146,17 +146,23 @@ static inline u64 arm64_ftr_mask(struct arm64_ftr_bits *ftrp)
 	return (u64)GENMASK(ftrp->shift + ftrp->width - 1, ftrp->shift);
 }
 
+static inline int __attribute_const__
+cpuid_feature_extract_field(u64 features, int field, bool sign)
+{
+	return (sign) ?
+		cpuid_feature_extract_signed_field(features, field) :
+		cpuid_feature_extract_unsigned_field(features, field);
+}
+
 static inline s64 arm64_ftr_value(struct arm64_ftr_bits *ftrp, u64 val)
 {
-	return ftrp->sign ?
-		cpuid_feature_extract_field_width(val, ftrp->shift, ftrp->width) :
-		cpuid_feature_extract_unsigned_field_width(val, ftrp->shift, ftrp->width);
+	return (s64)cpuid_feature_extract_field(val, ftrp->shift, ftrp->sign);
 }
 
 static inline bool id_aa64mmfr0_mixed_endian_el0(u64 mmfr0)
 {
-	return cpuid_feature_extract_field(mmfr0, ID_AA64MMFR0_BIGENDEL_SHIFT) == 0x1 ||
-		cpuid_feature_extract_field(mmfr0, ID_AA64MMFR0_BIGENDEL0_SHIFT) == 0x1;
+	return cpuid_feature_extract_unsigned_field(mmfr0, ID_AA64MMFR0_BIGENDEL_SHIFT) == 0x1 ||
+		cpuid_feature_extract_unsigned_field(mmfr0, ID_AA64MMFR0_BIGENDEL0_SHIFT) == 0x1;
 }
 
 void __init setup_cpu_features(void);
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 7364339..2ac4a22 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -307,7 +307,7 @@ static inline unsigned int kvm_get_vmid_bits(void)
 {
 	int reg = read_system_reg(SYS_ID_AA64MMFR1_EL1);
 
-	return (cpuid_feature_extract_field(reg, ID_AA64MMFR1_VMIDBITS_SHIFT) == 2) ? 16 : 8;
+	return (cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR1_VMIDBITS_SHIFT) == 2) ? 16 : 8;
 }
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index ef3409d..f29d63c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -605,7 +605,7 @@ u64 read_system_reg(u32 id)
 static bool
 feature_matches(u64 reg, const struct arm64_cpu_capabilities *entry)
 {
-	int val = cpuid_feature_extract_field(reg, entry->field_pos);
+	int val = cpuid_feature_extract_field(reg, entry->field_pos, entry->sign);
 
 	return val >= entry->min_field_value;
 }
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 8aee3ae..0e9261f 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -34,7 +34,7 @@
 /* Determine debug architecture. */
 u8 debug_monitors_arch(void)
 {
-	return cpuid_feature_extract_field(read_system_reg(SYS_ID_AA64DFR0_EL1),
+	return cpuid_feature_extract_unsigned_field(read_system_reg(SYS_ID_AA64DFR0_EL1),
 						ID_AA64DFR0_DEBUGVER_SHIFT);
 }
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index eec3598..225b65e 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -688,7 +688,7 @@ static bool trap_dbgidr(struct kvm_vcpu *vcpu,
 	} else {
 		u64 dfr = read_system_reg(SYS_ID_AA64DFR0_EL1);
 		u64 pfr = read_system_reg(SYS_ID_AA64PFR0_EL1);
-		u32 el3 = !!cpuid_feature_extract_field(pfr, ID_AA64PFR0_EL3_SHIFT);
+		u32 el3 = !!cpuid_feature_extract_unsigned_field(pfr, ID_AA64PFR0_EL3_SHIFT);
 
 		p->regval = ((((dfr >> ID_AA64DFR0_WRPS_SHIFT) & 0xf) << 28) |
 			     (((dfr >> ID_AA64DFR0_BRPS_SHIFT) & 0xf) << 24) |
diff --git a/arch/arm64/mm/context.c b/arch/arm64/mm/context.c
index 3e6786d..0798a4f 100644
--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -45,7 +45,7 @@ static cpumask_t tlb_flush_pending;
 static u32 get_cpu_asid_bits(void)
 {
 	u32 asid;
-	int fld = cpuid_feature_extract_field(read_cpuid(ID_AA64MMFR0_EL1),
+	int fld = cpuid_feature_extract_unsigned_field(read_cpuid(ID_AA64MMFR0_EL1),
 						ID_AA64MMFR0_ASID_SHIFT);
 
 	switch (fld) {
-- 
1.7.9.5
