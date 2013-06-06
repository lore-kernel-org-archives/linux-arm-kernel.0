From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu,  6 Jun 2013 11:30:43 +0200
Subject: [PATCH v3 1/2] ARM PJ4B: Add support for errata 4742
In-Reply-To: <1370511044-31900-1-git-send-email-gregory.clement@free-electrons.com>
References: <1370511044-31900-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1370511044-31900-2-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit fixes the regression on Armada 370 (the kernal hang during
boot) introduced by the commit: "ARM: 7691/1: mm: kill unused
TLB_CAN_READ_FROM_L1_CACHE and use ALT_SMP instead".

When coming out of either a Wait for Interrupt (WFI) or a Wait for
Event (WFE) IDLE states, a specific timing sensitivity exists between
the retiring WFI/WFE instructions and the newly issued subsequent
instructions. This sensitivity can result in a CPU hang scenario.  The
workaround is to insert either a Data Synchronization Barrier (DSB) or
Data Memory Barrier (DMB) command immediately after the WFI/WFE
instruction.

This commit was based on the work of Lior Amsalem, but heavily
modified to apply the errata fix dynamically according to the
processor type thanks to the suggestions of Russell King and Nicolas
Pitre.

This commit fixes also the ID and mask for the PJ4B which was too
restrictive and didn't match the CPU of the Armada 370 SoC.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/Kconfig                 | 13 +++++++++++++
 arch/arm/include/asm/glue-proc.h |  9 +++++++++
 arch/arm/mm/proc-v7.S            | 38 +++++++++++++++++++++++++++++++++-----
 3 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 49d993c..95cbe9d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1087,6 +1087,19 @@ if !MMU
 source "arch/arm/Kconfig-nommu"
 endif
 
+config PJ4B_ERRATA_4742
+	bool "PJ4B Errata 4742: IDLE Wake Up Commands can Cause the CPU Core to Cease Operation"
+	depends on CPU_PJ4B && MACH_ARMADA_370
+	help
+	  When coming out of either a Wait for Interrupt (WFI) or a Wait for
+	  Event (WFE) IDLE states, a specific timing sensitivity exists between
+	  the retiring WFI/WFE instructions and the newly issued subsequent
+	  instructions.  This sensitivity can result in a CPU hang scenario.
+	  Workaround:
+	  The software must insert either a Data Synchronization Barrier (DSB)
+	  or Data Memory Barrier (DMB) command immediately after the WFI/WFE
+	  instruction
+
 config ARM_ERRATA_326103
 	bool "ARM errata: FSR write bit incorrect on a SWP to read-only memory"
 	depends on CPU_V6
diff --git a/arch/arm/include/asm/glue-proc.h b/arch/arm/include/asm/glue-proc.h
index ac1dd54..8017e94 100644
--- a/arch/arm/include/asm/glue-proc.h
+++ b/arch/arm/include/asm/glue-proc.h
@@ -230,6 +230,15 @@
 # endif
 #endif
 
+#ifdef CONFIG_CPU_PJ4B
+# ifdef CPU_NAME
+#  undef  MULTI_CPU
+#  define MULTI_CPU
+# else
+#  define CPU_NAME cpu_pj4b
+# endif
+#endif
+
 #ifndef MULTI_CPU
 #define cpu_proc_init			__glue(CPU_NAME,_proc_init)
 #define cpu_proc_fin			__glue(CPU_NAME,_proc_fin)
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 2c73a73..4a4df33 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -342,6 +342,33 @@ __v7_setup:
 	mov	pc, lr				@ return to head.S:__ret
 ENDPROC(__v7_setup)
 
+#ifdef CONFIG_CPU_PJ4B
+.macro globl_equ x, y
+	.globl	\x
+	.equ	\x, \y
+.endm
+	globl_equ	cpu_pj4b_switch_mm,     cpu_v7_switch_mm
+	globl_equ	cpu_pj4b_set_pte_ext,	cpu_v7_set_pte_ext
+	globl_equ	cpu_pj4b_proc_init,	cpu_v7_proc_init
+	globl_equ	cpu_pj4b_proc_fin, 	cpu_v7_proc_fin
+	globl_equ	cpu_pj4b_reset,	   	cpu_v7_reset
+#ifdef CONFIG_PJ4B_ERRATA_4742
+ENTRY(cpu_pj4b_do_idle)
+	dsb					@ WFI may enter a low-power mode
+	wfi
+	dsb					@barrier
+	mov	pc, lr
+ENDPROC(cpu_pj4b_do_idle)
+#else
+	globl_equ	cpu_pj4b_do_idle,  	cpu_v7_do_idle
+#endif
+	globl_equ	cpu_pj4b_dcache_clean_area,	cpu_v7_dcache_clean_area
+	globl_equ	cpu_pj4b_do_suspend,	cpu_v7_do_suspend
+	globl_equ	cpu_pj4b_do_resume,	cpu_v7_do_resume
+	globl_equ	cpu_pj4b_suspend_size,	cpu_v7_suspend_size
+
+#endif
+
 	.align	2
 __v7_setup_stack:
 	.space	4 * 11				@ 11 registers
@@ -350,6 +377,7 @@ __v7_setup_stack:
 
 	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
 	define_processor_functions v7, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
+	define_processor_functions pj4b, dabort=v7_early_abort, pabort=v7_pabort, suspend=1
 
 	.section ".rodata"
 
@@ -362,7 +390,7 @@ __v7_setup_stack:
 	/*
 	 * Standard v7 proc info content
 	 */
-.macro __v7_proc initfunc, mm_mmuflags = 0, io_mmuflags = 0, hwcaps = 0
+.macro __v7_proc initfunc, mm_mmuflags = 0, io_mmuflags = 0, hwcaps = 0, proc_fns = v7_processor_functions
 	ALT_SMP(.long	PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AP_READ | \
 			PMD_SECT_AF | PMD_FLAGS_SMP | \mm_mmuflags)
 	ALT_UP(.long	PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AP_READ | \
@@ -375,7 +403,7 @@ __v7_setup_stack:
 	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB | HWCAP_FAST_MULT | \
 		HWCAP_EDSP | HWCAP_TLS | \hwcaps
 	.long	cpu_v7_name
-	.long	v7_processor_functions
+	.long	\proc_fns
 	.long	v7wbi_tlb_fns
 	.long	v6_user_fns
 	.long	v7_cache_fns
@@ -409,9 +437,9 @@ __v7_ca9mp_proc_info:
 	 */
 	.type   __v7_pj4b_proc_info, #object
 __v7_pj4b_proc_info:
-	.long	0x562f5840
-	.long	0xfffffff0
-	__v7_proc __v7_pj4b_setup
+	.long   0x560f5800
+	.long	0xff0fff00
+	__v7_proc __v7_pj4b_setup, proc_fns = pj4b_processor_functions
 	.size	__v7_pj4b_proc_info, . - __v7_pj4b_proc_info
 
 	/*
-- 
1.8.1.2
