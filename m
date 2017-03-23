From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 23 Mar 2017 15:14:39 +0000
Subject: [PATCH] arm64: cpufeature: Make ID reg accessor naming less
 counterintuitive
Message-ID: <1490282079-2724-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

read_system_reg() can readily be confused with read_sysreg(),
whereas these are really quite different in their meaning.

This patches attempts to reduce the ambiguity be reserving "sysreg"
for the actual system register accessors.

read_system_reg() is instead renamed to read_sanitised_ftr_reg(),
to make it more obvious that the Linux-defined sanitised feature
register cache is being accessed here, not the underlying
architectural system registers.

cpufeature.c's internal __raw_read_system_reg() function is renamed
in line with its actual purpose: a form of read_sysreg() that
indexes on (non-compiletime-constant) encoding rather than symbolic
register name.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

This patch is implemented by a brainless global replace.

defconfig builds without warnings -- I haven't done any testing beyond
that.

 arch/arm64/include/asm/cpufeature.h    |  4 ++--
 arch/arm64/include/asm/hw_breakpoint.h |  4 ++--
 arch/arm64/include/asm/kvm_mmu.h       |  2 +-
 arch/arm64/kernel/cpufeature.c         | 14 +++++++-------
 arch/arm64/kernel/debug-monitors.c     |  2 +-
 arch/arm64/kvm/reset.c                 |  2 +-
 arch/arm64/kvm/sys_regs.c              |  4 ++--
 7 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index f31c48d..e7f84a7 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -226,7 +226,7 @@ void update_cpu_errata_workarounds(void);
 void __init enable_errata_workarounds(void);
 void verify_local_cpu_errata_workarounds(void);
 
-u64 read_system_reg(u32 id);
+u64 read_sanitised_ftr_reg(u32 id);
 
 static inline bool cpu_supports_mixed_endian_el0(void)
 {
@@ -240,7 +240,7 @@ static inline bool system_supports_32bit_el0(void)
 
 static inline bool system_supports_mixed_endian_el0(void)
 {
-	return id_aa64mmfr0_mixed_endian_el0(read_system_reg(SYS_ID_AA64MMFR0_EL1));
+	return id_aa64mmfr0_mixed_endian_el0(read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1));
 }
 
 static inline bool system_supports_fpsimd(void)
diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index b6b167a..4177076 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -149,7 +149,7 @@ static inline void ptrace_hw_copy_thread(struct task_struct *task)
 /* Determine number of BRP registers available. */
 static inline int get_num_brps(void)
 {
-	u64 dfr0 = read_system_reg(SYS_ID_AA64DFR0_EL1);
+	u64 dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
 	return 1 +
 		cpuid_feature_extract_unsigned_field(dfr0,
 						ID_AA64DFR0_BRPS_SHIFT);
@@ -158,7 +158,7 @@ static inline int get_num_brps(void)
 /* Determine number of WRP registers available. */
 static inline int get_num_wrps(void)
 {
-	u64 dfr0 = read_system_reg(SYS_ID_AA64DFR0_EL1);
+	u64 dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
 	return 1 +
 		cpuid_feature_extract_unsigned_field(dfr0,
 						ID_AA64DFR0_WRPS_SHIFT);
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index ed12460..7a5b12c 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -307,7 +307,7 @@ static inline void __kvm_extend_hypmap(pgd_t *boot_hyp_pgd,
 
 static inline unsigned int kvm_get_vmid_bits(void)
 {
-	int reg = read_system_reg(SYS_ID_AA64MMFR1_EL1);
+	int reg = read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
 
 	return (cpuid_feature_extract_unsigned_field(reg, ID_AA64MMFR1_VMIDBITS_SHIFT) == 2) ? 16 : 8;
 }
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index abda8e8..6093b6a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -585,7 +585,7 @@ void update_cpu_features(int cpu,
 	 * If we have AArch32, we care about 32-bit features for compat.
 	 * If the system doesn't support AArch32, don't update them.
 	 */
-	if (id_aa64pfr0_32bit_el0(read_system_reg(SYS_ID_AA64PFR0_EL1)) &&
+	if (id_aa64pfr0_32bit_el0(read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1)) &&
 		id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
 
 		taint |= check_update_ftr_reg(SYS_ID_DFR0_EL1, cpu,
@@ -636,7 +636,7 @@ void update_cpu_features(int cpu,
 			"Unsupported CPU feature variation.\n");
 }
 
-u64 read_system_reg(u32 id)
+u64 read_sanitised_ftr_reg(u32 id)
 {
 	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(id);
 
@@ -649,10 +649,10 @@ u64 read_system_reg(u32 id)
 	case r:		return read_sysreg_s(r)
 
 /*
- * __raw_read_system_reg() - Used by a STARTING cpu before cpuinfo is populated.
+ * __read_sysreg_by_encoding() - Used by a STARTING cpu before cpuinfo is populated.
  * Read the system register on the current CPU
  */
-static u64 __raw_read_system_reg(u32 sys_id)
+static u64 __read_sysreg_by_encoding(u32 sys_id)
 {
 	switch (sys_id) {
 	read_sysreg_case(SYS_ID_PFR0_EL1);
@@ -709,9 +709,9 @@ has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
 
 	WARN_ON(scope == SCOPE_LOCAL_CPU && preemptible());
 	if (scope == SCOPE_SYSTEM)
-		val = read_system_reg(entry->sys_reg);
+		val = read_sanitised_ftr_reg(entry->sys_reg);
 	else
-		val = __raw_read_system_reg(entry->sys_reg);
+		val = __read_sysreg_by_encoding(entry->sys_reg);
 
 	return feature_matches(val, entry);
 }
@@ -761,7 +761,7 @@ static bool hyp_offset_low(const struct arm64_cpu_capabilities *entry,
 
 static bool has_no_fpsimd(const struct arm64_cpu_capabilities *entry, int __unused)
 {
-	u64 pfr0 = read_system_reg(SYS_ID_AA64PFR0_EL1);
+	u64 pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
 
 	return cpuid_feature_extract_signed_field(pfr0,
 					ID_AA64PFR0_FP_SHIFT) < 0;
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 3291356..d618e25 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -36,7 +36,7 @@
 /* Determine debug architecture. */
 u8 debug_monitors_arch(void)
 {
-	return cpuid_feature_extract_unsigned_field(read_system_reg(SYS_ID_AA64DFR0_EL1),
+	return cpuid_feature_extract_unsigned_field(read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1),
 						ID_AA64DFR0_DEBUGVER_SHIFT);
 }
 
diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index d9e9697..561badf 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -60,7 +60,7 @@ static bool cpu_has_32bit_el1(void)
 {
 	u64 pfr0;
 
-	pfr0 = read_system_reg(SYS_ID_AA64PFR0_EL1);
+	pfr0 = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
 	return !!(pfr0 & 0x20);
 }
 
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 0e26f8c..26b0e77 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1183,8 +1183,8 @@ static bool trap_dbgidr(struct kvm_vcpu *vcpu,
 	if (p->is_write) {
 		return ignore_write(vcpu, p);
 	} else {
-		u64 dfr = read_system_reg(SYS_ID_AA64DFR0_EL1);
-		u64 pfr = read_system_reg(SYS_ID_AA64PFR0_EL1);
+		u64 dfr = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
+		u64 pfr = read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1);
 		u32 el3 = !!cpuid_feature_extract_unsigned_field(pfr, ID_AA64PFR0_EL3_SHIFT);
 
 		p->regval = ((((dfr >> ID_AA64DFR0_WRPS_SHIFT) & 0xf) << 28) |
-- 
2.1.4
