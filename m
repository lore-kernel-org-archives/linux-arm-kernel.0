From: james.morse@arm.com (James Morse)
Date: Tue, 18 Oct 2016 11:27:46 +0100
Subject: [PATCH 1/3] arm64: cpufeature: Schedule enable() calls instead of
 calling them via IPI
In-Reply-To: <1476786468-2173-1-git-send-email-james.morse@arm.com>
References: <1476786468-2173-1-git-send-email-james.morse@arm.com>
Message-ID: <1476786468-2173-2-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable() call for a cpufeature/errata is called using on_each_cpu().
This issues a cross-call IPI to get the work done. Implicitly, this
stashes the running PSTATE in SPSR when the CPU receives the IPI, and
restores it when we return. This means an enable() call can never modify
PSTATE.

To allow PAN to do this, change the on_each_cpu() call to use
stop_machine(). This schedules the work on each CPU which allows
us to modify PSTATE.

This involves changing the protype of all the enable() functions.

enable_cpu_capabilities() is called during boot and enables the feature
on all online CPUs. This path now uses stop_machine(). CPU features for
hotplug'd CPUs are enabled by verify_local_cpu_features() which only
acts on the local CPU, and can already modify the running PSTATE as it
is called from secondary_start_kernel().

Reported-by: Tony Thompson <anthony.thompson@arm.com>
Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>

---
The UAO enable call also suffers from this problem, but it is useless
and broken. After this patch it is merely useless, and will be removed,
by a later patch, (replaced with a comment describing what actually
happens).

This patch doesn't apply to linux-stable versions before v4.8 because
it conflicts with every feature introduced since v4.4. If you want this
in stable give me a kick and I will produce versions for v4.4.25 and
v4.7.8 (stable versions since v4.3 when PAN was introduced).

 arch/arm64/include/asm/cpufeature.h |  2 +-
 arch/arm64/include/asm/processor.h  |  6 +++---
 arch/arm64/kernel/cpu_errata.c      |  3 ++-
 arch/arm64/kernel/cpufeature.c      | 10 +++++++++-
 arch/arm64/kernel/traps.c           |  3 ++-
 arch/arm64/mm/fault.c               |  6 ++++--
 6 files changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 758d74fedfad..a27c3245ba21 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -94,7 +94,7 @@ struct arm64_cpu_capabilities {
 	u16 capability;
 	int def_scope;			/* default scope */
 	bool (*matches)(const struct arm64_cpu_capabilities *caps, int scope);
-	void (*enable)(void *);		/* Called on all active CPUs */
+	int (*enable)(void *);		/* Called on all active CPUs */
 	union {
 		struct {	/* To be used for erratum handling only */
 			u32 midr_model;
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index df2e53d3a969..60e34824e18c 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -188,8 +188,8 @@ static inline void spin_lock_prefetch(const void *ptr)
 
 #endif
 
-void cpu_enable_pan(void *__unused);
-void cpu_enable_uao(void *__unused);
-void cpu_enable_cache_maint_trap(void *__unused);
+int cpu_enable_pan(void *__unused);
+int cpu_enable_uao(void *__unused);
+int cpu_enable_cache_maint_trap(void *__unused);
 
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 0150394f4cab..b75e917aac46 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -39,10 +39,11 @@ has_mismatched_cache_line_size(const struct arm64_cpu_capabilities *entry,
 		(arm64_ftr_reg_ctrel0.sys_val & arm64_ftr_reg_ctrel0.strict_mask);
 }
 
-static void cpu_enable_trap_ctr_access(void *__unused)
+static int cpu_enable_trap_ctr_access(void *__unused)
 {
 	/* Clear SCTLR_EL1.UCT */
 	config_sctlr_el1(SCTLR_EL1_UCT, 0);
+	return 0;
 }
 
 #define MIDR_RANGE(model, min, max) \
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d577f263cc4a..c02504ea304b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -19,7 +19,9 @@
 #define pr_fmt(fmt) "CPU features: " fmt
 
 #include <linux/bsearch.h>
+#include <linux/cpumask.h>
 #include <linux/sort.h>
+#include <linux/stop_machine.h>
 #include <linux/types.h>
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
@@ -941,7 +943,13 @@ void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 {
 	for (; caps->matches; caps++)
 		if (caps->enable && cpus_have_cap(caps->capability))
-			on_each_cpu(caps->enable, NULL, true);
+			/*
+			 * Use stop_machine() as it schedules the work allowing
+			 * us to modify PSTATE, instead of on_each_cpu() which
+			 * uses an IPI, giving us a PSTATE that disappears when
+			 * we return.
+			 */
+			stop_machine(caps->enable, NULL, cpu_online_mask);
 }
 
 /*
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 5ff020f8fb7f..e3a9f8da16e5 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -428,9 +428,10 @@ asmlinkage void __exception do_undefinstr(struct pt_regs *regs)
 	force_signal_inject(SIGILL, ILL_ILLOPC, regs, 0);
 }
 
-void cpu_enable_cache_maint_trap(void *__unused)
+int cpu_enable_cache_maint_trap(void *__unused)
 {
 	config_sctlr_el1(SCTLR_EL1_UCI, 0);
+	return 0;
 }
 
 #define __user_cache_maint(insn, address, res)			\
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 53d9159662fe..3e9ff9b0c78d 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -670,9 +670,10 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 NOKPROBE_SYMBOL(do_debug_exception);
 
 #ifdef CONFIG_ARM64_PAN
-void cpu_enable_pan(void *__unused)
+int cpu_enable_pan(void *__unused)
 {
 	config_sctlr_el1(SCTLR_EL1_SPAN, 0);
+	return 0;
 }
 #endif /* CONFIG_ARM64_PAN */
 
@@ -683,8 +684,9 @@ void cpu_enable_pan(void *__unused)
  * We need to enable the feature at runtime (instead of adding it to
  * PSR_MODE_EL1h) as the feature may not be implemented by the cpu.
  */
-void cpu_enable_uao(void *__unused)
+int cpu_enable_uao(void *__unused)
 {
 	asm(SET_PSTATE_UAO(1));
+	return 0;
 }
 #endif /* CONFIG_ARM64_UAO */
-- 
2.8.0.rc3
