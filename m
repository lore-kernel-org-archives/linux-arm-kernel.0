From: james.morse@arm.com (James Morse)
Date: Tue,  6 Dec 2016 19:04:52 +0000
Subject: [stable:PATCH 1/3] arm64: cpufeature: Schedule enable() calls instead
 of calling them via IPI [v4.8]
In-Reply-To: <20161206190454.19083-1-james.morse@arm.com>
References: <20161206190454.19083-1-james.morse@arm.com>
Message-ID: <20161206190454.19083-2-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 2a6dcb2b5f3e21592ca8dfa198dcce7bec09b020 upstream.

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
Signed-off-by: Will Deacon <will.deacon@arm.com>

[Removed enable() hunks for A53 workaround]
Signed-off-by: James Morse <james.morse@arm.com>
Cc: <stable@vger.kernel.org> # 4.8.12
---
 arch/arm64/include/asm/cpufeature.h |  2 +-
 arch/arm64/include/asm/processor.h  |  6 +++---
 arch/arm64/kernel/cpufeature.c      | 10 +++++++++-
 arch/arm64/kernel/traps.c           |  3 ++-
 arch/arm64/mm/fault.c               |  6 ++++--
 5 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 7099f26e3702..b96346b943b7 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -90,7 +90,7 @@ struct arm64_cpu_capabilities {
 	u16 capability;
 	int def_scope;			/* default scope */
 	bool (*matches)(const struct arm64_cpu_capabilities *caps, int scope);
-	void (*enable)(void *);		/* Called on all active CPUs */
+	int (*enable)(void *);		/* Called on all active CPUs */
 	union {
 		struct {	/* To be used for erratum handling only */
 			u32 midr_model;
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index ace0a96e7d6e..3be0ab013e35 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -190,8 +190,8 @@ static inline void spin_lock_prefetch(const void *ptr)
 
 #endif
 
-void cpu_enable_pan(void *__unused);
-void cpu_enable_uao(void *__unused);
-void cpu_enable_cache_maint_trap(void *__unused);
+int cpu_enable_pan(void *__unused);
+int cpu_enable_uao(void *__unused);
+int cpu_enable_cache_maint_trap(void *__unused);
 
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 62272eac1352..94a0330f7ec9 100644
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
@@ -936,7 +938,13 @@ void __init enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
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
index 771a01a7fbce..9595d3d9c3db 100644
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
index 05d2bd776c69..2001ebd12666 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -671,9 +671,10 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 NOKPROBE_SYMBOL(do_debug_exception);
 
 #ifdef CONFIG_ARM64_PAN
-void cpu_enable_pan(void *__unused)
+int cpu_enable_pan(void *__unused)
 {
 	config_sctlr_el1(SCTLR_EL1_SPAN, 0);
+	return 0;
 }
 #endif /* CONFIG_ARM64_PAN */
 
@@ -684,8 +685,9 @@ void cpu_enable_pan(void *__unused)
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
2.10.1
