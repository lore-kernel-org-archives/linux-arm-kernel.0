From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:28 +0100
Subject: [PATCH v3 20/40] Subject: ARM: mm: proc-arm925: Use the new processor
	struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-21-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-arm925.S |   88 ++++++++------------------------------------
 1 files changed, 16 insertions(+), 72 deletions(-)

diff --git a/arch/arm/mm/proc-arm925.S b/arch/arm/mm/proc-arm925.S
index 541e477..8650aa3 100644
--- a/arch/arm/mm/proc-arm925.S
+++ b/arch/arm/mm/proc-arm925.S
@@ -372,17 +372,8 @@ ENTRY(arm925_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(arm925_dma_unmap_area)
 
-ENTRY(arm925_cache_fns)
-	.long	arm925_flush_icache_all
-	.long	arm925_flush_kern_cache_all
-	.long	arm925_flush_user_cache_all
-	.long	arm925_flush_user_cache_range
-	.long	arm925_coherent_kern_range
-	.long	arm925_coherent_user_range
-	.long	arm925_flush_kern_dcache_area
-	.long	arm925_dma_map_area
-	.long	arm925_dma_unmap_area
-	.long	arm925_dma_flush_range
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions arm925, default=arm925
 
 ENTRY(cpu_arm925_dcache_clean_area)
 #ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
@@ -487,52 +478,24 @@ arm925_crval:
 	crval	clear=0x00007f3f, mmuset=0x0000313d, ucset=0x00001130
 
 	__INITDATA
-
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-	.type	arm925_processor_functions, #object
-arm925_processor_functions:
-	.word	v4t_early_abort
-	.word	legacy_pabort
-	.word	cpu_arm925_proc_init
-	.word	cpu_arm925_proc_fin
-	.word	cpu_arm925_reset
-	.word   cpu_arm925_do_idle
-	.word	cpu_arm925_dcache_clean_area
-	.word	cpu_arm925_switch_mm
-	.word	cpu_arm925_set_pte_ext
-	.word	0
-	.word	0
-	.word	0
-	.size	arm925_processor_functions, . - arm925_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions arm925, dabort=v4t_early_abort, pabort=legacy_pabort
 
 	.section ".rodata"
 
-	.type	cpu_arch_name, #object
-cpu_arch_name:
-	.asciz	"armv4t"
-	.size	cpu_arch_name, . - cpu_arch_name
-
-	.type	cpu_elf_name, #object
-cpu_elf_name:
-	.asciz	"v4"
-	.size	cpu_elf_name, . - cpu_elf_name
-
-	.type	cpu_arm925_name, #object
-cpu_arm925_name:
-	.asciz	"ARM925T"
-	.size	cpu_arm925_name, . - cpu_arm925_name
+	string	cpu_arch_name, "armv4t"
+	string	cpu_elf_name, "v4"
+	string	cpu_arm925_name, "ARM925T"
 
 	.align
 
 	.section ".proc.info.init", #alloc, #execinstr
 
-	.type	__arm925_proc_info,#object
-__arm925_proc_info:
-	.long	0x54029250
-	.long	0xfffffff0
+.macro arm925_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cache
+	.type	__\name\()_proc_info,#object
+__\name\()_proc_info:
+	.long	\cpu_val
+	.long	\cpu_mask
 	.long   PMD_TYPE_SECT | \
 		PMD_BIT4 | \
 		PMD_SECT_AP_WRITE | \
@@ -550,27 +513,8 @@ __arm925_proc_info:
 	.long	v4wbi_tlb_fns
 	.long	v4wb_user_fns
 	.long	arm925_cache_fns
-	.size	__arm925_proc_info, . - __arm925_proc_info
+	.size	__\name\()_proc_info, . - __\name\()_proc_info
+.endm
 
-	.type	__arm915_proc_info,#object
-__arm915_proc_info:
-	.long	0x54029150
-	.long	0xfffffff0
-	.long   PMD_TYPE_SECT | \
-		PMD_BIT4 | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long   PMD_TYPE_SECT | \
-		PMD_BIT4 | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b	__arm925_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB
-	.long	cpu_arm925_name
-	.long	arm925_processor_functions
-	.long	v4wbi_tlb_fns
-	.long	v4wb_user_fns
-	.long	arm925_cache_fns
-	.size	__arm925_proc_info, . - __arm925_proc_info
+	arm925_proc_info arm925, 0x54029250, 0xfffffff0, cpu_arm925_name
+	arm925_proc_info arm915, 0x54029150, 0xfffffff0, cpu_arm925_name
-- 
1.7.4.1
