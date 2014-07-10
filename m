From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 10 Jul 2014 14:47:36 +0800
Subject: [PATCH v3] ARM: save/restore Cortex-A9 CP15 registers on
 suspend/resume
Message-ID: <1404974856-25846-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CP15 diagnostic register holds ARM errata bits on Cortex-A9, so it
needs to be saved/restored on suspend/resume.  Otherwise, the
effectiveness of errata workaround gets lost together with diagnostic
register bit across suspend/resume cycle.  And the CP15 power control
register of Cortex-A9 shares the same problem.

The patch adds a couple of Cortex-A9 specific suspend/resume functions
to save/restore these two Cortex-A9 CP15 registers across the
suspend/resume cycle.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Changes since v2:
 - Skip register restoring if the register is already restored which
   should be the case of secure mode
 - Handle power control register as well

 arch/arm/include/asm/glue-proc.h | 18 +++++++++---------
 arch/arm/mm/proc-v7.S            | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/glue-proc.h b/arch/arm/include/asm/glue-proc.h
index 74a8b84f3cb1..74be7c22035a 100644
--- a/arch/arm/include/asm/glue-proc.h
+++ b/arch/arm/include/asm/glue-proc.h
@@ -221,15 +221,6 @@
 # endif
 #endif
 
-#ifdef CONFIG_CPU_V7
-# ifdef CPU_NAME
-#  undef  MULTI_CPU
-#  define MULTI_CPU
-# else
-#  define CPU_NAME cpu_v7
-# endif
-#endif
-
 #ifdef CONFIG_CPU_V7M
 # ifdef CPU_NAME
 #  undef  MULTI_CPU
@@ -248,6 +239,15 @@
 # endif
 #endif
 
+#ifdef CONFIG_CPU_V7
+/*
+ * Cortex-A9 needs a different suspend/resume function, so we need
+ * multiple CPU support for ARMv7 anyway.
+ */
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+#endif
+
 #ifndef MULTI_CPU
 #define cpu_proc_init			__glue(CPU_NAME,_proc_init)
 #define cpu_proc_fin			__glue(CPU_NAME,_proc_fin)
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 3db2c2f04a30..7e009e7a083d 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -152,6 +152,40 @@ ENTRY(cpu_v7_do_resume)
 ENDPROC(cpu_v7_do_resume)
 #endif
 
+/*
+ * Cortex-A9 processor functions
+ */
+	globl_equ	cpu_ca9mp_proc_init,	cpu_v7_proc_init
+	globl_equ	cpu_ca9mp_proc_fin,	cpu_v7_proc_fin
+	globl_equ	cpu_ca9mp_reset,	cpu_v7_reset
+	globl_equ	cpu_ca9mp_do_idle,	cpu_v7_do_idle
+	globl_equ	cpu_ca9mp_dcache_clean_area, cpu_v7_dcache_clean_area
+	globl_equ	cpu_ca9mp_switch_mm,	cpu_v7_switch_mm
+	globl_equ	cpu_ca9mp_set_pte_ext,	cpu_v7_set_pte_ext
+.globl	cpu_ca9mp_suspend_size
+.equ	cpu_ca9mp_suspend_size, cpu_v7_suspend_size + 4 * 2
+#ifdef CONFIG_ARM_CPU_SUSPEND
+ENTRY(cpu_ca9mp_do_suspend)
+	stmfd	sp!, {r4 - r5}
+	mrc	p15, 0, r4, c15, c0, 1		@ Diagnostic register
+	mrc	p15, 0, r5, c15, c0, 0		@ Power register
+	stmia	r0!, {r4 - r5}
+	ldmfd	sp!, {r4 - r5}
+	b	cpu_v7_do_suspend
+ENDPROC(cpu_ca9mp_do_suspend)
+
+ENTRY(cpu_ca9mp_do_resume)
+	ldmia	r0!, {r4 - r5}
+	mrc	p15, 0, r10, c15, c0, 1		@ Read Diagnostic register
+	teq	r4, r10				@ Already restored?
+	mcrne	p15, 0, r4, c15, c0, 1		@ No, so restore it
+	mrc	p15, 0, r10, c15, c0, 0		@ Read Power register
+	teq	r5, r10				@ Already restored?
+	mcrne	p15, 0, r5, c15, c0, 0		@ No, so restore it
+	b	cpu_v7_do_resume
+ENDPROC(cpu_ca9mp_do_resume)
+#endif
+
 #ifdef CONFIG_CPU_PJ4B
 	globl_equ	cpu_pj4b_switch_mm,     cpu_v7_switch_mm
 	globl_equ	cpu_pj4b_set_pte_ext,	cpu_v7_set_pte_ext
@@ -418,6 +452,7 @@ __v7_setup_stack:
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions v7, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
+	define_processor_functions ca9mp, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
 #ifdef CONFIG_CPU_PJ4B
 	define_processor_functions pj4b, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
 #endif
@@ -470,7 +505,7 @@ __v7_ca5mp_proc_info:
 __v7_ca9mp_proc_info:
 	.long	0x410fc090
 	.long	0xff0ffff0
-	__v7_proc __v7_ca9mp_setup
+	__v7_proc __v7_ca9mp_setup, proc_fns = ca9mp_processor_functions
 	.size	__v7_ca9mp_proc_info, . - __v7_ca9mp_proc_info
 
 #endif	/* CONFIG_ARM_LPAE */
-- 
1.9.1
