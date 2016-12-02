From: james.morse@arm.com (James Morse)
Date: Fri,  2 Dec 2016 16:42:45 +0000
Subject: [stable:PATCH 1/3] arm64: cpufeature: Schedule enable() calls instead
 of calling them via IPI [v4.4]
In-Reply-To: <20161202164247.19496-1-james.morse@arm.com>
References: <20161202164247.19496-1-james.morse@arm.com>
Message-ID: <20161202164247.19496-2-james.morse@arm.com>
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

[Removed enable() hunks for features/errata v4.4. doesn't have. Changed
 caps->enable arg in enable_cpu_capabilities()]
Signed-off-by: James Morse <james.morse@arm.com>
Cc: <stable@vger.kernel.org> # 4.4.35
---
 arch/arm64/include/asm/cpufeature.h |  2 +-
 arch/arm64/include/asm/processor.h  |  2 +-
 arch/arm64/kernel/cpufeature.c      | 10 +++++++++-
 arch/arm64/mm/fault.c               |  3 ++-
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 8136afc9df0d..8884b5d5f48c 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -77,7 +77,7 @@ struct arm64_cpu_capabilities {
 	const char *desc;
 	u16 capability;
 	bool (*matches)(const struct arm64_cpu_capabilities *);
-	void (*enable)(void *);		/* Called on all active CPUs */
+	int (*enable)(void *);		/* Called on all active CPUs */
 	union {
 		struct {	/* To be used for erratum handling only */
 			u32 midr_model;
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 4acb7ca94fcd..d08559528927 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -186,6 +186,6 @@ static inline void spin_lock_prefetch(const void *x)
 
 #endif
 
-void cpu_enable_pan(void *__unused);
+int cpu_enable_pan(void *__unused);
 
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0669c63281ea..2735bf814592 100644
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
@@ -764,7 +766,13 @@ static void enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 
 	for (i = 0; caps[i].desc; i++)
 		if (caps[i].enable && cpus_have_cap(caps[i].capability))
-			on_each_cpu(caps[i].enable, NULL, true);
+			/*
+			 * Use stop_machine() as it schedules the work allowing
+			 * us to modify PSTATE, instead of on_each_cpu() which
+			 * uses an IPI, giving us a PSTATE that disappears when
+			 * we return.
+			 */
+			stop_machine(caps[i].enable, NULL, cpu_online_mask);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 4c1a118c1d09..d4634e6942ca 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -606,8 +606,9 @@ asmlinkage int __exception do_debug_exception(unsigned long addr,
 }
 
 #ifdef CONFIG_ARM64_PAN
-void cpu_enable_pan(void *__unused)
+int cpu_enable_pan(void *__unused)
 {
 	config_sctlr_el1(SCTLR_EL1_SPAN, 0);
+	return 0;
 }
 #endif /* CONFIG_ARM64_PAN */
-- 
2.10.1
