From: alex.shi@linaro.org (Alex Shi)
Date: Mon, 26 Feb 2018 16:20:20 +0800
Subject: [PATCH 46/52] arm: Add BTB invalidation on switch_mm for Cortex-A9,
 A12 and A17
In-Reply-To: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
References: <1519633227-29832-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519633227-29832-47-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

** Not yet queued for inclusion in mainline **

In order to avoid aliasing attacks against the branch predictor,
some implementations require to invalidate the BTB when switching
from one user context to another.

For this, we reuse the existing implementation for Cortex-A8, and
apply it to A9, A12 and A17.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm/mm/Kconfig          | 17 +++++++++++++++++
 arch/arm/mm/proc-v7-2level.S |  4 ++--
 arch/arm/mm/proc-v7-3level.S |  5 +++++
 arch/arm/mm/proc-v7.S        | 30 ++++++++++++++++++++++++++++--
 4 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index c1799dd..1a5acee 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -1068,3 +1068,20 @@ config DEBUG_ALIGN_RODATA
 	  additional section-aligned split of rodata from kernel text so it
 	  can be made explicitly non-executable. This padding may waste memory
 	  space to gain the additional protection.
+
+config HARDEN_BRANCH_PREDICTOR
+	bool "Harden the branch predictor against aliasing attacks" if EXPERT
+	default y
+	help
+	  Speculation attacks against some high-performance processors rely on
+	  being able to manipulate the branch predictor for a victim context by
+	  executing aliasing branches in the attacker context.  Such attacks
+	  can be partially mitigated against by clearing internal branch
+	  predictor state and limiting the prediction logic in some situations.
+
+	  This config option will take CPU-specific actions to harden the
+	  branch predictor against aliasing attacks and may rely on specific
+	  instruction sequences or control bits being set by the system
+	  firmware.
+
+	  If unsure, say Y.
diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index c6141a5..0422e58b 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -41,7 +41,7 @@
  *	even on Cortex-A8 revisions not affected by 430973.
  *	If IBE is not set, the flush BTAC/BTB won't do anything.
  */
-ENTRY(cpu_ca8_switch_mm)
+ENTRY(cpu_v7_btbinv_switch_mm)
 #ifdef CONFIG_MMU
 	mov	r2, #0
 	mcr	p15, 0, r2, c7, c5, 6		@ flush BTAC/BTB
@@ -66,7 +66,7 @@ ENTRY(cpu_v7_switch_mm)
 #endif
 	bx	lr
 ENDPROC(cpu_v7_switch_mm)
-ENDPROC(cpu_ca8_switch_mm)
+ENDPROC(cpu_v7_btbinv_switch_mm)
 
 /*
  *	cpu_v7_set_pte_ext(ptep, pte)
diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
index 5e5720e..a25450b 100644
--- a/arch/arm/mm/proc-v7-3level.S
+++ b/arch/arm/mm/proc-v7-3level.S
@@ -54,6 +54,10 @@
  * Set the translation table base pointer to be pgd_phys (physical address of
  * the new TTB).
  */
+ENTRY(cpu_v7_btbinv_switch_mm)
+#ifdef CONFIG_MMU
+	mcr	p15, 0, r0, c7, c5, 6			@ flush BTAC/BTB
+#endif
 ENTRY(cpu_v7_switch_mm)
 #ifdef CONFIG_MMU
 	mmid	r2, r2
@@ -64,6 +68,7 @@ ENTRY(cpu_v7_switch_mm)
 #endif
 	ret	lr
 ENDPROC(cpu_v7_switch_mm)
+ENDPROC(cpu_v7_btbinv_switch_mm)
 
 #ifdef __ARMEB__
 #define rl r3
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index d00d52c..ff7018a 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -163,6 +163,7 @@ ENDPROC(cpu_v7_do_resume)
 	globl_equ	cpu_ca8_dcache_clean_area, cpu_v7_dcache_clean_area
 	globl_equ	cpu_ca8_set_pte_ext,	cpu_v7_set_pte_ext
 	globl_equ	cpu_ca8_suspend_size,	cpu_v7_suspend_size
+	globl_equ	cpu_ca8_switch_mm,	cpu_v7_btbinv_switch_mm
 #ifdef CONFIG_ARM_CPU_SUSPEND
 	globl_equ	cpu_ca8_do_suspend,	cpu_v7_do_suspend
 	globl_equ	cpu_ca8_do_resume,	cpu_v7_do_resume
@@ -176,7 +177,11 @@ ENDPROC(cpu_v7_do_resume)
 	globl_equ	cpu_ca9mp_reset,	cpu_v7_reset
 	globl_equ	cpu_ca9mp_do_idle,	cpu_v7_do_idle
 	globl_equ	cpu_ca9mp_dcache_clean_area, cpu_v7_dcache_clean_area
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+	globl_equ	cpu_ca9mp_switch_mm,	cpu_v7_btbinv_switch_mm
+#else
 	globl_equ	cpu_ca9mp_switch_mm,	cpu_v7_switch_mm
+#endif
 	globl_equ	cpu_ca9mp_set_pte_ext,	cpu_v7_set_pte_ext
 .globl	cpu_ca9mp_suspend_size
 .equ	cpu_ca9mp_suspend_size, cpu_v7_suspend_size + 4 * 2
@@ -202,6 +207,26 @@ ENTRY(cpu_ca9mp_do_resume)
 ENDPROC(cpu_ca9mp_do_resume)
 #endif
 
+/*
+ * Cortex-A12/A17
+ */
+	globl_equ	cpu_ca17_proc_init,	cpu_v7_proc_init
+	globl_equ	cpu_ca17_proc_fin,	cpu_v7_proc_fin
+	globl_equ	cpu_ca17_reset,		cpu_v7_reset
+	globl_equ	cpu_ca17_do_idle,	cpu_v7_do_idle
+	globl_equ	cpu_ca17_dcache_clean_area, cpu_v7_dcache_clean_area
+	globl_equ	cpu_ca17_set_pte_ext,	cpu_v7_set_pte_ext
+	globl_equ	cpu_ca17_suspend_size,	cpu_v7_suspend_size
+#ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
+	globl_equ	cpu_ca17_switch_mm,	cpu_v7_btbinv_switch_mm
+#else
+	globl_equ	cpu_ca17_switch_mm,	cpu_v7_switch_mm
+#endif
+#ifdef CONFIG_ARM_CPU_SUSPEND
+	globl_equ	cpu_ca17_do_suspend,	cpu_v7_do_suspend
+	globl_equ	cpu_ca17_do_resume,	cpu_v7_do_resume
+#endif
+
 #ifdef CONFIG_CPU_PJ4B
 	globl_equ	cpu_pj4b_switch_mm,     cpu_v7_switch_mm
 	globl_equ	cpu_pj4b_set_pte_ext,	cpu_v7_set_pte_ext
@@ -543,6 +568,7 @@ __v7_setup_stack:
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions v7, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
+	define_processor_functions ca17, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
 #ifndef CONFIG_ARM_LPAE
 	define_processor_functions ca8, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
 	define_processor_functions ca9mp, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
@@ -653,7 +679,7 @@ __v7_ca7mp_proc_info:
 __v7_ca12mp_proc_info:
 	.long	0x410fc0d0
 	.long	0xff0ffff0
-	__v7_proc __v7_ca12mp_proc_info, __v7_ca12mp_setup
+	__v7_proc __v7_ca12mp_proc_info, __v7_ca12mp_setup, proc_fns = ca17_processor_functions
 	.size	__v7_ca12mp_proc_info, . - __v7_ca12mp_proc_info
 
 	/*
@@ -683,7 +709,7 @@ __v7_b15mp_proc_info:
 __v7_ca17mp_proc_info:
 	.long	0x410fc0e0
 	.long	0xff0ffff0
-	__v7_proc __v7_ca17mp_proc_info, __v7_ca17mp_setup
+	__v7_proc __v7_ca17mp_proc_info, __v7_ca17mp_setup, proc_fns = ca17_processor_functions
 	.size	__v7_ca17mp_proc_info, . - __v7_ca17mp_proc_info
 
 	/*
-- 
2.7.4
