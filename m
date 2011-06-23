From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:34 +0100
Subject: [PATCH v3 26/40] Subject: ARM: mm: proc-feroceon: Use the new
	processor struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-27-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-feroceon.S |  186 ++++++++-----------------------------------
 1 files changed, 33 insertions(+), 153 deletions(-)

diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index d3883ee..8b08e10 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -411,29 +411,12 @@ ENTRY(feroceon_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(feroceon_dma_unmap_area)
 
-ENTRY(feroceon_cache_fns)
-	.long	feroceon_flush_icache_all
-	.long	feroceon_flush_kern_cache_all
-	.long	feroceon_flush_user_cache_all
-	.long	feroceon_flush_user_cache_range
-	.long	feroceon_coherent_kern_range
-	.long	feroceon_coherent_user_range
-	.long	feroceon_flush_kern_dcache_area
-	.long	feroceon_dma_map_area
-	.long	feroceon_dma_unmap_area
-	.long	feroceon_dma_flush_range
-
-ENTRY(feroceon_range_cache_fns)
-	.long	feroceon_flush_icache_all
-	.long	feroceon_flush_kern_cache_all
-	.long	feroceon_flush_user_cache_all
-	.long	feroceon_flush_user_cache_range
-	.long	feroceon_coherent_kern_range
-	.long	feroceon_coherent_user_range
-	.long	feroceon_range_flush_kern_dcache_area
-	.long	feroceon_range_dma_map_area
-	.long	feroceon_dma_unmap_area
-	.long	feroceon_range_dma_flush_range
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions feroceon, default=feroceon
+	define_cache_functions feroceon_range, default=feroceon, \
+		flush_kern_dcache_area=feroceon_range_flush_kern_dcache_area, \
+		dma_map_area=feroceon_range_dma_map_area, \
+		dma_flush_range=feroceon_range_dma_flush_range
 
 	.align	5
 ENTRY(cpu_feroceon_dcache_clean_area)
@@ -539,93 +522,27 @@ feroceon_crval:
 
 	__INITDATA
 
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-	.type	feroceon_processor_functions, #object
-feroceon_processor_functions:
-	.word	v5t_early_abort
-	.word	legacy_pabort
-	.word	cpu_feroceon_proc_init
-	.word	cpu_feroceon_proc_fin
-	.word	cpu_feroceon_reset
-	.word	cpu_feroceon_do_idle
-	.word	cpu_feroceon_dcache_clean_area
-	.word	cpu_feroceon_switch_mm
-	.word	cpu_feroceon_set_pte_ext
-	.word	0
-	.word	0
-	.word	0
-	.size	feroceon_processor_functions, . - feroceon_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions feroceon, dabort=v5t_early_abort, pabort=legacy_pabort
 
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
-	.type	cpu_feroceon_name, #object
-cpu_feroceon_name:
-	.asciz	"Feroceon"
-	.size	cpu_feroceon_name, . - cpu_feroceon_name
-
-	.type	cpu_88fr531_name, #object
-cpu_88fr531_name:
-	.asciz	"Feroceon 88FR531-vd"
-	.size	cpu_88fr531_name, . - cpu_88fr531_name
-
-	.type	cpu_88fr571_name, #object
-cpu_88fr571_name:
-	.asciz	"Feroceon 88FR571-vd"
-	.size	cpu_88fr571_name, . - cpu_88fr571_name
-
-	.type	cpu_88fr131_name, #object
-cpu_88fr131_name:
-	.asciz	"Feroceon 88FR131"
-	.size	cpu_88fr131_name, . - cpu_88fr131_name
+	string	cpu_arch_name, "armv5te"
+	string	cpu_elf_name, "v5"
+	string	cpu_feroceon_name, "Feroceon"
+	string	cpu_88fr531_name, "Feroceon 88FR531-vd"
+	string	cpu_88fr571_name, "Feroceon 88FR571-vd"
+	string	cpu_88fr131_name, "Feroceon 88FR131"
 
 	.align
 
 	.section ".proc.info.init", #alloc, #execinstr
 
-#ifdef CONFIG_CPU_FEROCEON_OLD_ID
-	.type	__feroceon_old_id_proc_info,#object
-__feroceon_old_id_proc_info:
-	.long	0x41009260
-	.long	0xff00fff0
-	.long	PMD_TYPE_SECT | \
-		PMD_SECT_BUFFERABLE | \
-		PMD_SECT_CACHEABLE | \
-		PMD_BIT4 | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long	PMD_TYPE_SECT | \
-		PMD_BIT4 | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b	__feroceon_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long	cpu_feroceon_name
-	.long	feroceon_processor_functions
-	.long	v4wbi_tlb_fns
-	.long	feroceon_user_fns
-	.long	feroceon_cache_fns
-	.size	__feroceon_old_id_proc_info, . - __feroceon_old_id_proc_info
-#endif
-
-	.type	__88fr531_proc_info,#object
-__88fr531_proc_info:
-	.long	0x56055310
-	.long	0xfffffff0
+.macro feroceon_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cache:req
+	.type	__\name\()_proc_info,#object
+__\name\()_proc_info:
+	.long	\cpu_val
+	.long	\cpu_mask
 	.long	PMD_TYPE_SECT | \
 		PMD_SECT_BUFFERABLE | \
 		PMD_SECT_CACHEABLE | \
@@ -640,59 +557,22 @@ __88fr531_proc_info:
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long	cpu_88fr531_name
+	.long	\cpu_name
 	.long	feroceon_processor_functions
 	.long	v4wbi_tlb_fns
 	.long	feroceon_user_fns
-	.long	feroceon_cache_fns
-	.size	__88fr531_proc_info, . - __88fr531_proc_info
+	.long	\cache
+	 .size	__\name\()_proc_info, . - __\name\()_proc_info
+.endm
 
-	.type	__88fr571_proc_info,#object
-__88fr571_proc_info:
-	.long	0x56155710
-	.long	0xfffffff0
-	.long	PMD_TYPE_SECT | \
-		PMD_SECT_BUFFERABLE | \
-		PMD_SECT_CACHEABLE | \
-		PMD_BIT4 | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long	PMD_TYPE_SECT | \
-		PMD_BIT4 | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b	__feroceon_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long	cpu_88fr571_name
-	.long	feroceon_processor_functions
-	.long	v4wbi_tlb_fns
-	.long	feroceon_user_fns
-	.long	feroceon_range_cache_fns
-	.size	__88fr571_proc_info, . - __88fr571_proc_info
+#ifdef CONFIG_CPU_FEROCEON_OLD_ID
+	feroceon_proc_info feroceon_old_id, 0x41009260, 0xff00fff0, \
+		cpu_name=cpu_feroceon_name, cache=feroceon_cache_fns
+#endif
 
-	.type	__88fr131_proc_info,#object
-__88fr131_proc_info:
-	.long	0x56251310
-	.long	0xfffffff0
-	.long	PMD_TYPE_SECT | \
-		PMD_SECT_BUFFERABLE | \
-		PMD_SECT_CACHEABLE | \
-		PMD_BIT4 | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long	PMD_TYPE_SECT | \
-		PMD_BIT4 | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b	__feroceon_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
-	.long	cpu_88fr131_name
-	.long	feroceon_processor_functions
-	.long	v4wbi_tlb_fns
-	.long	feroceon_user_fns
-	.long	feroceon_range_cache_fns
-	.size	__88fr131_proc_info, . - __88fr131_proc_info
+	feroceon_proc_info 88fr531, 0x56055310, 0xfffffff0, cpu_88fr531_name, \
+		cache=feroceon_cache_fns
+	feroceon_proc_info 88fr571, 0x56155710, 0xfffffff0, cpu_88fr571_name, \
+		cache=feroceon_range_cache_fns
+	feroceon_proc_info 88fr131, 0x56251310, 0xfffffff0, cpu_88fr131_name, \
+		cache=feroceon_range_cache_fns
-- 
1.7.4.1
