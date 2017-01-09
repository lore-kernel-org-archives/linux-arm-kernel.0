From: james.morse@arm.com (James Morse)
Date: Mon,  9 Jan 2017 18:14:02 +0000
Subject: [PATCH] arm64: Remove useless UAO IPI and describe how this gets
 enabled
Message-ID: <20170109181402.12883-1-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since its introduction, the UAO enable call was broken, and useless.
commit 2a6dcb2b5f3e ("arm64: cpufeature: Schedule enable() calls instead
of calling them via IPI"), fixed the framework so that these calls
are scheduled, so that they can modify PSTATE.

Now it is just useless. Remove it. UAO is enabled by the code patching
which causes get_user() and friends to use the 'ldtr' family of
instructions. This relies on the PSTATE.UAO bit being set to match
addr_limit, which we do in uao_thread_switch() called via __switch_to().

All that is needed to enable UAO is patch the code, and call schedule().
__apply_alternatives_multi_stop() calls stop_machine() when it modifies
the kernel text to enable the alternatives, (including the UAO code in
uao_thread_switch()). Once stop_machine() has finished __switch_to() is
called to reschedule the original task, this causes PSTATE.UAO to be set
appropriately. An explicit enable() call is not needed.

Reported-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>

==
Sorry, I forgot about this cleanup after the last round of PAN fixes.
---
 arch/arm64/include/asm/processor.h |  1 -
 arch/arm64/kernel/cpufeature.c     |  5 ++++-
 arch/arm64/mm/fault.c              | 14 --------------
 3 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 60e34824e18c..b1bb3bc4f215 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -189,7 +189,6 @@ static inline void spin_lock_prefetch(const void *ptr)
 #endif
 
 int cpu_enable_pan(void *__unused);
-int cpu_enable_uao(void *__unused);
 int cpu_enable_cache_maint_trap(void *__unused);
 
 #endif /* __ASM_PROCESSOR_H */
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c02504ea304b..584bd74e0cc1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -797,7 +797,10 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.sys_reg = SYS_ID_AA64MMFR2_EL1,
 		.field_pos = ID_AA64MMFR2_UAO_SHIFT,
 		.min_field_value = 1,
-		.enable = cpu_enable_uao,
+		/*
+		 * We rely on stop_machine() calling uao_thread_switch() to set
+		 * UAO immediately after patching.
+		 */
 	},
 #endif /* CONFIG_ARM64_UAO */
 #ifdef CONFIG_ARM64_PAN
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 0f8788374815..e9fd27daa0d1 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -685,17 +685,3 @@ int cpu_enable_pan(void *__unused)
 	return 0;
 }
 #endif /* CONFIG_ARM64_PAN */
-
-#ifdef CONFIG_ARM64_UAO
-/*
- * Kernel threads have fs=KERNEL_DS by default, and don't need to call
- * set_fs(), devtmpfs in particular relies on this behaviour.
- * We need to enable the feature at runtime (instead of adding it to
- * PSR_MODE_EL1h) as the feature may not be implemented by the cpu.
- */
-int cpu_enable_uao(void *__unused)
-{
-	asm(SET_PSTATE_UAO(1));
-	return 0;
-}
-#endif /* CONFIG_ARM64_UAO */
-- 
2.10.1
