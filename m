From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 23 Jan 2018 12:27:54 +0000
Subject: [PATCH 01/16] arm64: capabilities: Update prototype for enable call
 back
In-Reply-To: <20180123122809.16269-1-suzuki.poulose@arm.com>
References: <20180123122809.16269-1-suzuki.poulose@arm.com>
Message-ID: <20180123122809.16269-2-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dave Martin <dave.martin@arm.com>

We issue the enable() call back for all CPU hwcaps capabilities
available on the system, on all the CPUs. So far we have ignored
the argument passed to the call back, which had a prototype to
accept a "void *" for use with on_each_cpu() and later with
stop_machine(). However, with commit 0a0d111d40fd1
("arm64: cpufeature: Pass capability structure to ->enable callback"),
there are some users of the argument who wants the matching capability
struct pointer where there are multiple matching criteria for a single
capability. Update the prototype for enable to accept a const pointer.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: James Morse <james.morse@arm.com>
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Dave Martin <dave.martin@arm.com>
[ Rebased to for-next/core converting more users ]
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |  3 ++-
 arch/arm64/include/asm/fpsimd.h     |  4 +++-
 arch/arm64/include/asm/processor.h  |  7 ++++---
 arch/arm64/kernel/cpu_errata.c      | 14 ++++++--------
 arch/arm64/kernel/cpufeature.c      | 16 ++++++++++++----
 arch/arm64/kernel/fpsimd.c          |  3 ++-
 arch/arm64/kernel/traps.c           |  3 ++-
 arch/arm64/mm/fault.c               |  2 +-
 8 files changed, 32 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index ac67cfc2585a..cefbd685292c 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -97,7 +97,8 @@ struct arm64_cpu_capabilities {
 	u16 capability;
 	int def_scope;			/* default scope */
 	bool (*matches)(const struct arm64_cpu_capabilities *caps, int scope);
-	int (*enable)(void *);		/* Called on all active CPUs */
+	/* Called on all active CPUs for all  "available" capabilities */
+	int (*enable)(const struct arm64_cpu_capabilities *caps);
 	union {
 		struct {	/* To be used for erratum handling only */
 			u32 midr_model;
diff --git a/arch/arm64/include/asm/fpsimd.h b/arch/arm64/include/asm/fpsimd.h
index 8857a0f0d0f7..2a4b5fc681a3 100644
--- a/arch/arm64/include/asm/fpsimd.h
+++ b/arch/arm64/include/asm/fpsimd.h
@@ -83,7 +83,9 @@ extern void sve_save_state(void *state, u32 *pfpsr);
 extern void sve_load_state(void const *state, u32 const *pfpsr,
 			   unsigned long vq_minus_1);
 extern unsigned int sve_get_vl(void);
-extern int sve_kernel_enable(void *);
+
+struct arm64_cpu_capabilities;
+extern int sve_kernel_enable(const struct arm64_cpu_capabilities *__unused);
 
 extern int __ro_after_init sve_max_vl;
 
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index cee4ae25a5d1..ff4c753a75fe 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -34,6 +34,7 @@
 #include <linux/string.h>
 
 #include <asm/alternative.h>
+#include <asm/cpufeature.h>
 #include <asm/fpsimd.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/lse.h>
@@ -214,9 +215,9 @@ static inline void spin_lock_prefetch(const void *ptr)
 
 #endif
 
-int cpu_enable_pan(void *__unused);
-int cpu_enable_cache_maint_trap(void *__unused);
-int cpu_clear_disr(void *__unused);
+int cpu_enable_pan(const struct arm64_cpu_capabilities *__unused);
+int cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused);
+int cpu_clear_disr(const struct arm64_cpu_capabilities *__unused);
 
 /* Userspace interface for PR_SVE_{SET,GET}_VL prctl()s: */
 #define SVE_SET_VL(arg)	sve_set_current_vl(arg)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 54e41dfe41f6..9ae0d7e395cf 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -53,7 +53,8 @@ has_mismatched_cache_line_size(const struct arm64_cpu_capabilities *entry,
 		(arm64_ftr_reg_ctrel0.sys_val & arm64_ftr_reg_ctrel0.strict_mask);
 }
 
-static int cpu_enable_trap_ctr_access(void *__unused)
+static int cpu_enable_trap_ctr_access(
+	const struct arm64_cpu_capabilities *__unused)
 {
 	/* Clear SCTLR_EL1.UCT */
 	config_sctlr_el1(SCTLR_EL1_UCT, 0);
@@ -144,10 +145,8 @@ static void  install_bp_hardening_cb(const struct arm64_cpu_capabilities *entry,
 
 #include <linux/psci.h>
 
-static int enable_psci_bp_hardening(void *data)
+static int enable_psci_bp_hardening(const struct arm64_cpu_capabilities *entry)
 {
-	const struct arm64_cpu_capabilities *entry = data;
-
 	if (psci_ops.get_version)
 		install_bp_hardening_cb(entry,
 				       (bp_hardening_cb_t)psci_ops.get_version,
@@ -169,10 +168,9 @@ static void qcom_link_stack_sanitization(void)
 		     : "=&r" (tmp));
 }
 
-static int qcom_enable_link_stack_sanitization(void *data)
+static int qcom_enable_link_stack_sanitization(
+			const struct arm64_cpu_capabilities *entry)
 {
-	const struct arm64_cpu_capabilities *entry = data;
-
 	install_bp_hardening_cb(entry, qcom_link_stack_sanitization,
 				__qcom_hyp_sanitize_link_stack_start,
 				__qcom_hyp_sanitize_link_stack_end);
@@ -376,7 +374,7 @@ void verify_local_cpu_errata_workarounds(void)
 	for (; caps->matches; caps++) {
 		if (cpus_have_cap(caps->capability)) {
 			if (caps->enable)
-				caps->enable((void *)caps);
+				caps->enable(caps);
 		} else if (caps->matches(caps, SCOPE_LOCAL_CPU)) {
 			pr_crit("CPU%d: Requires work around for %s, not detected"
 					" at boot time\n",
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 5612d6f46331..6a8dfdc532b1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -887,7 +887,7 @@ static int __init parse_kpti(char *str)
 __setup("kpti=", parse_kpti);
 #endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
-static int cpu_copy_el2regs(void *__unused)
+static int cpu_copy_el2regs(const struct arm64_cpu_capabilities *__unused)
 {
 	/*
 	 * Copy register values that aren't redirected by hardware.
@@ -1183,6 +1183,14 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 	}
 }
 
+
+static int __enable_cpu_capability(void *arg)
+{
+	const struct arm64_cpu_capabilities *cap = arg;
+
+	return cap->enable(cap);
+}
+
 /*
  * Run through the enabled capabilities and enable() it on all active
  * CPUs
@@ -1205,7 +1213,7 @@ void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 			 * uses an IPI, giving us a PSTATE that disappears when
 			 * we return.
 			 */
-			stop_machine(caps->enable, (void *)caps, cpu_online_mask);
+			stop_machine(__enable_cpu_capability, (void *)caps, cpu_online_mask);
 		}
 	}
 }
@@ -1249,7 +1257,7 @@ verify_local_cpu_features(const struct arm64_cpu_capabilities *caps_list)
 			cpu_die_early();
 		}
 		if (caps->enable)
-			caps->enable((void *)caps);
+			caps->enable(caps);
 	}
 }
 
@@ -1472,7 +1480,7 @@ static int __init enable_mrs_emulation(void)
 
 core_initcall(enable_mrs_emulation);
 
-int cpu_clear_disr(void *__unused)
+int cpu_clear_disr(const struct arm64_cpu_capabilities *__unused)
 {
 	/* Firmware may have left a deferred SError in this register. */
 	write_sysreg_s(0, SYS_DISR_EL1);
diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 55fb544072f6..4d7eff33c643 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -40,6 +40,7 @@
 #include <linux/sysctl.h>
 
 #include <asm/fpsimd.h>
+#include <asm/cpufeature.h>
 #include <asm/cputype.h>
 #include <asm/simd.h>
 #include <asm/sigcontext.h>
@@ -757,7 +758,7 @@ static void __init sve_efi_setup(void)
  * Enable SVE for EL1.
  * Intended for use by the cpufeatures code during CPU boot.
  */
-int sve_kernel_enable(void *__always_unused p)
+int sve_kernel_enable(const struct arm64_cpu_capabilities *__always_unused p)
 {
 	write_sysreg(read_sysreg(CPACR_EL1) | CPACR_EL1_ZEN_EL1EN, CPACR_EL1);
 	isb();
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index bbb0fde2780e..296fab8e5c67 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -38,6 +38,7 @@
 
 #include <asm/atomic.h>
 #include <asm/bug.h>
+#include <asm/cpufeature.h>
 #include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
 #include <asm/esr.h>
@@ -374,7 +375,7 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
 }
 
-int cpu_enable_cache_maint_trap(void *__unused)
+int cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
 {
 	config_sctlr_el1(SCTLR_EL1_UCI, 0);
 	return 0;
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 0e671ddf4855..937f89d2c353 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -813,7 +813,7 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 NOKPROBE_SYMBOL(do_debug_exception);
 
 #ifdef CONFIG_ARM64_PAN
-int cpu_enable_pan(void *__unused)
+int cpu_enable_pan(const struct arm64_cpu_capabilities *__unused)
 {
 	/*
 	 * We modify PSTATE. This won't work from irq context as the PSTATE
-- 
2.13.6
