From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:39 +0100
Subject: [PATCH v4 32/40] ARM: mm: proc-xsc3: Use new generic struct
	definition macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-33-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-xsc3.S |   90 +++++++++--------------------------------------
 1 files changed, 17 insertions(+), 73 deletions(-)

diff --git a/arch/arm/mm/proc-xsc3.S b/arch/arm/mm/proc-xsc3.S
index 5962136..1508f9b 100644
--- a/arch/arm/mm/proc-xsc3.S
+++ b/arch/arm/mm/proc-xsc3.S
@@ -335,17 +335,8 @@ ENTRY(xsc3_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(xsc3_dma_unmap_area)
 
-ENTRY(xsc3_cache_fns)
-	.long	xsc3_flush_icache_all
-	.long	xsc3_flush_kern_cache_all
-	.long	xsc3_flush_user_cache_all
-	.long	xsc3_flush_user_cache_range
-	.long	xsc3_coherent_kern_range
-	.long	xsc3_coherent_user_range
-	.long	xsc3_flush_kern_dcache_area
-	.long	xsc3_dma_map_area
-	.long	xsc3_dma_unmap_area
-	.long	xsc3_dma_flush_range
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions xsc3
 
 ENTRY(cpu_xsc3_dcache_clean_area)
 1:	mcr	p15, 0, r0, c7, c10, 1		@ clean L1 D line
@@ -503,52 +494,24 @@ xsc3_crval:
 
 	__INITDATA
 
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-
-	.type	xsc3_processor_functions, #object
-ENTRY(xsc3_processor_functions)
-	.word	v5t_early_abort
-	.word	legacy_pabort
-	.word	cpu_xsc3_proc_init
-	.word	cpu_xsc3_proc_fin
-	.word	cpu_xsc3_reset
-	.word	cpu_xsc3_do_idle
-	.word	cpu_xsc3_dcache_clean_area
-	.word	cpu_xsc3_switch_mm
-	.word	cpu_xsc3_set_pte_ext
-	.word	cpu_xsc3_suspend_size
-	.word	cpu_xsc3_do_suspend
-	.word	cpu_xsc3_do_resume
-	.size	xsc3_processor_functions, . - xsc3_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions xsc3, dabort=v5t_early_abort, pabort=legacy_pabort, suspend=1
 
 	.section ".rodata"
 
-	.type	cpu_arch_name, #object
-cpu_arch_name:
-	.asciz	"armv5te"
-	.size	cpu_arch_name, . - cpu_arch_name
-
-	.type	cpu_elf_name, #object
-cpu_elf_name:
-	.asciz	"v5"
-	.size	cpu_elf_name, . - cpu_elf_name
-
-	.type	cpu_xsc3_name, #object
-cpu_xsc3_name:
-	.asciz	"XScale-V3 based processor"
-	.size	cpu_xsc3_name, . - cpu_xsc3_name
+	string	cpu_arch_name, "armv5te"
+	string	cpu_elf_name, "v5"
+	string	cpu_xsc3_name, "XScale-V3 based processor"
 
 	.align
 
 	.section ".proc.info.init", #alloc, #execinstr
 
-	.type	__xsc3_proc_info,#object
-__xsc3_proc_info:
-	.long	0x69056000
-	.long	0xffffe000
+.macro xsc3_proc_info name:req, cpu_val:req, cpu_mask:req
+	.type	__\name\()_proc_info,#object
+__\name\()_proc_info:
+	.long	\cpu_val
+	.long	\cpu_mask
 	.long	PMD_TYPE_SECT | \
 		PMD_SECT_BUFFERABLE | \
 		PMD_SECT_CACHEABLE | \
@@ -566,29 +529,10 @@ __xsc3_proc_info:
 	.long	v4wbi_tlb_fns
 	.long	xsc3_mc_user_fns
 	.long	xsc3_cache_fns
-	.size	__xsc3_proc_info, . - __xsc3_proc_info
+	.size	__\name\()_proc_info, . - __\name\()_proc_info
+.endm
 
-/* Note: PXA935 changed its implementor ID from Intel to Marvell */
+	xsc3_proc_info xsc3, 0x69056000, 0xffffe000
 
-	.type	__xsc3_pxa935_proc_info,#object
-__xsc3_pxa935_proc_info:
-	.long	0x56056000
-	.long	0xffffe000
-	.long	PMD_TYPE_SECT | \
-		PMD_SECT_BUFFERABLE | \
-		PMD_SECT_CACHEABLE | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long	PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b	__xsc3_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long	cpu_xsc3_name
-	.long	xsc3_processor_functions
-	.long	v4wbi_tlb_fns
-	.long	xsc3_mc_user_fns
-	.long	xsc3_cache_fns
-	.size	__xsc3_pxa935_proc_info, . - __xsc3_pxa935_proc_info
+/* Note: PXA935 changed its implementor ID from Intel to Marvell */
+	xsc3_proc_info xsc3_pxa935, 0x56056000, 0xffffe000
-- 
1.7.4.1
