From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:40 +0100
Subject: [PATCH v4 33/40] ARM: mm: proc-xscale: Use new generic struct
	definition macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-34-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this patch, xscale_80200_A0_A1 is missing the
icache_flush_all entry, which would result in the wrong functions
being called at run-time.

This patch re-uses xscale_icache_flush_all for
xscale_80200_A0_A1_cache_fns.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-xscale.S |  507 +++++++--------------------------------------
 1 files changed, 76 insertions(+), 431 deletions(-)

diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 42af976..76a80460 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -390,12 +390,12 @@ ENDPROC(xscale_dma_map_area)
  *	- size	- size of region
  *	- dir	- DMA direction
  */
-ENTRY(xscale_dma_a0_map_area)
+ENTRY(xscale_80200_A0_A1_dma_map_area)
 	add	r1, r1, r0
 	teq	r2, #DMA_TO_DEVICE
 	beq	xscale_dma_clean_range
 	b	xscale_dma_flush_range
-ENDPROC(xscale_dma_a0_map_area)
+ENDPROC(xscale_80200_A0_A1_dma_map_area)
 
 /*
  *	dma_unmap_area(start, size, dir)
@@ -407,17 +407,8 @@ ENTRY(xscale_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(xscale_dma_unmap_area)
 
-ENTRY(xscale_cache_fns)
-	.long	xscale_flush_icache_all
-	.long	xscale_flush_kern_cache_all
-	.long	xscale_flush_user_cache_all
-	.long	xscale_flush_user_cache_range
-	.long	xscale_coherent_kern_range
-	.long	xscale_coherent_user_range
-	.long	xscale_flush_kern_dcache_area
-	.long	xscale_dma_map_area
-	.long	xscale_dma_unmap_area
-	.long	xscale_dma_flush_range
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions xscale
 
 /*
  * On stepping A0/A1 of the 80200, invalidating D-cache by line doesn't
@@ -432,16 +423,28 @@ ENTRY(xscale_cache_fns)
  * revision January 22, 2003, available at:
  *     http://www.intel.com/design/iio/specupdt/273415.htm
  */
-ENTRY(xscale_80200_A0_A1_cache_fns)
-	.long	xscale_flush_kern_cache_all
-	.long	xscale_flush_user_cache_all
-	.long	xscale_flush_user_cache_range
-	.long	xscale_coherent_kern_range
-	.long	xscale_coherent_user_range
-	.long	xscale_flush_kern_dcache_area
-	.long	xscale_dma_a0_map_area
-	.long	xscale_dma_unmap_area
-	.long	xscale_dma_flush_range
+.macro a0_alias basename
+	.globl xscale_80200_A0_A1_\basename
+	.type xscale_80200_A0_A1_\basename , %function
+	.equ xscale_80200_A0_A1_\basename , xscale_\basename
+.endm
+
+/*
+ * Most of the cache functions are unchanged for these processor revisions.
+ * Export suitable alias symbols for the unchanged functions:
+ */
+	a0_alias flush_icache_all
+	a0_alias flush_user_cache_all
+	a0_alias flush_kern_cache_all
+	a0_alias flush_user_cache_range
+	a0_alias coherent_kern_range
+	a0_alias coherent_user_range
+	a0_alias flush_kern_dcache_area
+	a0_alias dma_flush_range
+	a0_alias dma_unmap_area
+
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions xscale_80200_A0_A1
 
 ENTRY(cpu_xscale_dcache_clean_area)
 1:	mcr	p15, 0, r0, c7, c10, 1		@ clean D entry
@@ -587,432 +590,74 @@ xscale_crval:
 
 	__INITDATA
 
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-
-	.type	xscale_processor_functions, #object
-ENTRY(xscale_processor_functions)
-	.word	v5t_early_abort
-	.word	legacy_pabort
-	.word	cpu_xscale_proc_init
-	.word	cpu_xscale_proc_fin
-	.word	cpu_xscale_reset
-	.word	cpu_xscale_do_idle
-	.word	cpu_xscale_dcache_clean_area
-	.word	cpu_xscale_switch_mm
-	.word	cpu_xscale_set_pte_ext
-	.word	cpu_xscale_suspend_size
-	.word	cpu_xscale_do_suspend
-	.word	cpu_xscale_do_resume
-	.size	xscale_processor_functions, . - xscale_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions xscale, dabort=v5t_early_abort, pabort=legacy_pabort, suspend=1
 
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
-	.type	cpu_80200_A0_A1_name, #object
-cpu_80200_A0_A1_name:
-	.asciz	"XScale-80200 A0/A1"
-	.size	cpu_80200_A0_A1_name, . - cpu_80200_A0_A1_name
-
-	.type	cpu_80200_name, #object
-cpu_80200_name:
-	.asciz	"XScale-80200"
-	.size	cpu_80200_name, . - cpu_80200_name
-
-	.type	cpu_80219_name, #object
-cpu_80219_name:
-	.asciz	"XScale-80219"
-	.size	cpu_80219_name, . - cpu_80219_name
-
-	.type	cpu_8032x_name, #object
-cpu_8032x_name:
-	.asciz	"XScale-IOP8032x Family"
-	.size	cpu_8032x_name, . - cpu_8032x_name
-
-	.type	cpu_8033x_name, #object
-cpu_8033x_name:
-	.asciz	"XScale-IOP8033x Family"
-	.size	cpu_8033x_name, . - cpu_8033x_name
-
-	.type	cpu_pxa250_name, #object
-cpu_pxa250_name:
-	.asciz	"XScale-PXA250"
-	.size	cpu_pxa250_name, . - cpu_pxa250_name
-
-	.type	cpu_pxa210_name, #object
-cpu_pxa210_name:
-	.asciz	"XScale-PXA210"
-	.size	cpu_pxa210_name, . - cpu_pxa210_name
-
-	.type	cpu_ixp42x_name, #object
-cpu_ixp42x_name:
-	.asciz	"XScale-IXP42x Family"
-	.size	cpu_ixp42x_name, . - cpu_ixp42x_name
-
-	.type	cpu_ixp43x_name, #object
-cpu_ixp43x_name:
-	.asciz	"XScale-IXP43x Family"
-	.size	cpu_ixp43x_name, . - cpu_ixp43x_name
-
-	.type	cpu_ixp46x_name, #object
-cpu_ixp46x_name:
-	.asciz	"XScale-IXP46x Family"
-	.size	cpu_ixp46x_name, . - cpu_ixp46x_name
-
-	.type	cpu_ixp2400_name, #object
-cpu_ixp2400_name:
-	.asciz	"XScale-IXP2400"
-	.size	cpu_ixp2400_name, . - cpu_ixp2400_name
-
-	.type	cpu_ixp2800_name, #object
-cpu_ixp2800_name:
-	.asciz	"XScale-IXP2800"
-	.size	cpu_ixp2800_name, . - cpu_ixp2800_name
-
-	.type	cpu_pxa255_name, #object
-cpu_pxa255_name:
-	.asciz	"XScale-PXA255"
-	.size	cpu_pxa255_name, . - cpu_pxa255_name
-
-	.type	cpu_pxa270_name, #object
-cpu_pxa270_name:
-	.asciz	"XScale-PXA270"
-	.size	cpu_pxa270_name, . - cpu_pxa270_name
+	string	cpu_arch_name, "armv5te"
+	string	cpu_elf_name, "v5"
+
+	string	cpu_80200_A0_A1_name, "XScale-80200 A0/A1"
+	string	cpu_80200_name, "XScale-80200"
+	string	cpu_80219_name, "XScale-80219"
+	string	cpu_8032x_name, "XScale-IOP8032x Family"
+	string	cpu_8033x_name, "XScale-IOP8033x Family"
+	string	cpu_pxa250_name, "XScale-PXA250"
+	string	cpu_pxa210_name, "XScale-PXA210"
+	string	cpu_ixp42x_name, "XScale-IXP42x Family"
+	string	cpu_ixp43x_name, "XScale-IXP43x Family"
+	string	cpu_ixp46x_name, "XScale-IXP46x Family"
+	string	cpu_ixp2400_name, "XScale-IXP2400"
+	string	cpu_ixp2800_name, "XScale-IXP2800"
+	string	cpu_pxa255_name, "XScale-PXA255"
+	string	cpu_pxa270_name, "XScale-PXA270"
 
 	.align
 
 	.section ".proc.info.init", #alloc, #execinstr
 
-	.type	__80200_A0_A1_proc_info,#object
-__80200_A0_A1_proc_info:
-	.long	0x69052000
-	.long	0xfffffffe
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_BUFFERABLE | \
-		PMD_SECT_CACHEABLE | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b	__xscale_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long	cpu_80200_name
-	.long	xscale_processor_functions
-	.long	v4wbi_tlb_fns
-	.long	xscale_mc_user_fns
-	.long	xscale_80200_A0_A1_cache_fns
-	.size	__80200_A0_A1_proc_info, . - __80200_A0_A1_proc_info
-
-	.type	__80200_proc_info,#object
-__80200_proc_info:
-	.long	0x69052000
-	.long	0xfffffff0
-	.long   PMD_TYPE_SECT | \
+.macro xscale_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cache
+	.type	__\name\()_proc_info,#object
+__\name\()_proc_info:
+	.long	\cpu_val
+	.long	\cpu_mask
+	.long	PMD_TYPE_SECT | \
 		PMD_SECT_BUFFERABLE | \
 		PMD_SECT_CACHEABLE | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	.long   PMD_TYPE_SECT | \
+	.long	PMD_TYPE_SECT | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
 	b	__xscale_setup
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long	cpu_80200_name
+	.long	\cpu_name
 	.long	xscale_processor_functions
 	.long	v4wbi_tlb_fns
 	.long	xscale_mc_user_fns
-	.long	xscale_cache_fns
-	.size	__80200_proc_info, . - __80200_proc_info
-
-	.type	__80219_proc_info,#object
-__80219_proc_info:
-	.long	0x69052e20
-	.long	0xffffffe0
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_BUFFERABLE | \
-		PMD_SECT_CACHEABLE | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b	__xscale_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long	cpu_80219_name
-	.long	xscale_processor_functions
-	.long	v4wbi_tlb_fns
-	.long	xscale_mc_user_fns
-	.long	xscale_cache_fns
-	.size	__80219_proc_info, . - __80219_proc_info
-
-	.type	__8032x_proc_info,#object
-__8032x_proc_info:
-	.long	0x69052420
-	.long	0xfffff7e0
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_BUFFERABLE | \
-		PMD_SECT_CACHEABLE | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b	__xscale_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long	cpu_8032x_name
-	.long	xscale_processor_functions
-	.long	v4wbi_tlb_fns
-	.long	xscale_mc_user_fns
-	.long	xscale_cache_fns
-	.size	__8032x_proc_info, . - __8032x_proc_info
-
-	.type	__8033x_proc_info,#object
-__8033x_proc_info:
-	.long	0x69054010
-	.long	0xfffffd30
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_BUFFERABLE | \
-		PMD_SECT_CACHEABLE | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b	__xscale_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long	cpu_8033x_name
-	.long	xscale_processor_functions
-	.long	v4wbi_tlb_fns
-	.long	xscale_mc_user_fns
-	.long	xscale_cache_fns
-	.size	__8033x_proc_info, . - __8033x_proc_info
-
-	.type	__pxa250_proc_info,#object
-__pxa250_proc_info:
-	.long	0x69052100
-	.long	0xfffff7f0
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_BUFFERABLE | \
-		PMD_SECT_CACHEABLE | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b	__xscale_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long	cpu_pxa250_name
-	.long	xscale_processor_functions
-	.long	v4wbi_tlb_fns
-	.long	xscale_mc_user_fns
-	.long	xscale_cache_fns
-	.size	__pxa250_proc_info, . - __pxa250_proc_info
-
-	.type	__pxa210_proc_info,#object
-__pxa210_proc_info:
-	.long	0x69052120
-	.long	0xfffff3f0
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_BUFFERABLE | \
-		PMD_SECT_CACHEABLE | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b	__xscale_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long	cpu_pxa210_name
-	.long	xscale_processor_functions
-	.long	v4wbi_tlb_fns
-	.long	xscale_mc_user_fns
-	.long	xscale_cache_fns
-	.size	__pxa210_proc_info, . - __pxa210_proc_info
-
-	.type	__ixp2400_proc_info, #object
-__ixp2400_proc_info:
-	.long   0x69054190
-	.long   0xfffffff0
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_BUFFERABLE | \
-		PMD_SECT_CACHEABLE | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b       __xscale_setup
-	.long   cpu_arch_name
-	.long   cpu_elf_name
-	.long   HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long   cpu_ixp2400_name
-	.long   xscale_processor_functions
-	.long	v4wbi_tlb_fns
-	.long	xscale_mc_user_fns
-	.long	xscale_cache_fns
-	.size   __ixp2400_proc_info, . - __ixp2400_proc_info                
-
-	.type	__ixp2800_proc_info, #object
-__ixp2800_proc_info:
-	.long   0x690541a0
-	.long   0xfffffff0
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_BUFFERABLE | \
-		PMD_SECT_CACHEABLE | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b       __xscale_setup
-	.long   cpu_arch_name
-	.long   cpu_elf_name
-	.long   HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long   cpu_ixp2800_name
-	.long   xscale_processor_functions
-	.long	v4wbi_tlb_fns
-	.long	xscale_mc_user_fns
-	.long	xscale_cache_fns
-	.size   __ixp2800_proc_info, . - __ixp2800_proc_info                
-
-	.type	__ixp42x_proc_info, #object
-__ixp42x_proc_info:
-	.long   0x690541c0
-	.long   0xffffffc0
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_BUFFERABLE | \
-		PMD_SECT_CACHEABLE | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b       __xscale_setup
-	.long   cpu_arch_name
-	.long   cpu_elf_name
-	.long   HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long   cpu_ixp42x_name
-	.long   xscale_processor_functions
-	.long	v4wbi_tlb_fns
-	.long	xscale_mc_user_fns
-	.long	xscale_cache_fns
-	.size   __ixp42x_proc_info, . - __ixp42x_proc_info                
-
-	.type   __ixp43x_proc_info, #object
-__ixp43x_proc_info:
-	.long   0x69054040
-	.long   0xfffffff0
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_BUFFERABLE | \
-		PMD_SECT_CACHEABLE | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b       __xscale_setup
-	.long   cpu_arch_name
-	.long   cpu_elf_name
-	.long   HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long   cpu_ixp43x_name
-	.long   xscale_processor_functions
-	.long   v4wbi_tlb_fns
-	.long   xscale_mc_user_fns
-	.long   xscale_cache_fns
-	.size   __ixp43x_proc_info, . - __ixp43x_proc_info
-
-	.type	__ixp46x_proc_info, #object
-__ixp46x_proc_info:
-	.long   0x69054200
-	.long   0xffffff00
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_BUFFERABLE | \
-		PMD_SECT_CACHEABLE | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b       __xscale_setup
-	.long   cpu_arch_name
-	.long   cpu_elf_name
-	.long   HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long   cpu_ixp46x_name
-	.long   xscale_processor_functions
-	.long	v4wbi_tlb_fns
-	.long	xscale_mc_user_fns
-	.long	xscale_cache_fns
-	.size   __ixp46x_proc_info, . - __ixp46x_proc_info
-
-	.type	__pxa255_proc_info,#object
-__pxa255_proc_info:
-	.long	0x69052d00
-	.long	0xfffffff0
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_BUFFERABLE | \
-		PMD_SECT_CACHEABLE | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b	__xscale_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long	cpu_pxa255_name
-	.long	xscale_processor_functions
-	.long	v4wbi_tlb_fns
-	.long	xscale_mc_user_fns
-	.long	xscale_cache_fns
-	.size	__pxa255_proc_info, . - __pxa255_proc_info
-
-	.type	__pxa270_proc_info,#object
-__pxa270_proc_info:
-	.long	0x69054110
-	.long	0xfffffff0
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_BUFFERABLE | \
-		PMD_SECT_CACHEABLE | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b	__xscale_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long	cpu_pxa270_name
-	.long	xscale_processor_functions
-	.long	v4wbi_tlb_fns
-	.long	xscale_mc_user_fns
-	.long	xscale_cache_fns
-	.size	__pxa270_proc_info, . - __pxa270_proc_info
-
+	.ifb \cache
+		.long	xscale_cache_fns
+	.else
+		.long	\cache
+	.endif
+	.size	__\name\()_proc_info, . - __\name\()_proc_info
+.endm
+
+	xscale_proc_info 80200_A0_A1, 0x69052000, 0xfffffffe, cpu_80200_name, \
+		cache=xscale_80200_A0_A1_cache_fns
+	xscale_proc_info 80200, 0x69052000, 0xfffffff0, cpu_80200_name
+	xscale_proc_info 80219, 0x69052e20, 0xffffffe0, cpu_80219_name
+	xscale_proc_info 8032x, 0x69052420, 0xfffff7e0, cpu_8032x_name
+	xscale_proc_info 8033x, 0x69054010, 0xfffffd30, cpu_8033x_name
+	xscale_proc_info pxa250, 0x69052100, 0xfffff7f0, cpu_pxa250_name
+	xscale_proc_info pxa210, 0x69052120, 0xfffff3f0, cpu_pxa210_name
+	xscale_proc_info ixp2400, 0x69054190, 0xfffffff0, cpu_ixp2400_name
+	xscale_proc_info ixp2800, 0x690541a0, 0xfffffff0, cpu_ixp2800_name
+	xscale_proc_info ixp42x, 0x690541c0, 0xffffffc0, cpu_ixp42x_name
+	xscale_proc_info ixp43x, 0x69054040, 0xfffffff0, cpu_ixp43x_name
+	xscale_proc_info ixp46x, 0x69054200, 0xffffff00, cpu_ixp46x_name
+	xscale_proc_info pxa255, 0x69052d00, 0xfffffff0, cpu_pxa255_name
+	xscale_proc_info pxa270, 0x69054110, 0xfffffff0, cpu_pxa270_name
-- 
1.7.4.1
