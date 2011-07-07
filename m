From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:20 +0100
Subject: [PATCH v4 13/40] ARM: mm: proc-arm1026: Use the new processor struct
	macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-14-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-arm1026.S |   53 +++++--------------------------------------
 1 files changed, 7 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mm/proc-arm1026.S b/arch/arm/mm/proc-arm1026.S
index 4136846..678a1ce 100644
--- a/arch/arm/mm/proc-arm1026.S
+++ b/arch/arm/mm/proc-arm1026.S
@@ -333,17 +333,8 @@ ENTRY(arm1026_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(arm1026_dma_unmap_area)
 
-ENTRY(arm1026_cache_fns)
-	.long	arm1026_flush_icache_all
-	.long	arm1026_flush_kern_cache_all
-	.long	arm1026_flush_user_cache_all
-	.long	arm1026_flush_user_cache_range
-	.long	arm1026_coherent_kern_range
-	.long	arm1026_coherent_user_range
-	.long	arm1026_flush_kern_dcache_area
-	.long	arm1026_dma_map_area
-	.long	arm1026_dma_unmap_area
-	.long	arm1026_dma_flush_range
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions arm1026
 
 	.align	5
 ENTRY(cpu_arm1026_dcache_clean_area)
@@ -436,45 +427,15 @@ arm1026_crval:
 	crval	clear=0x00007f3f, mmuset=0x00003935, ucset=0x00001934
 
 	__INITDATA
-
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-	.type	arm1026_processor_functions, #object
-arm1026_processor_functions:
-	.word	v5t_early_abort
-	.word	legacy_pabort
-	.word	cpu_arm1026_proc_init
-	.word	cpu_arm1026_proc_fin
-	.word	cpu_arm1026_reset
-	.word	cpu_arm1026_do_idle
-	.word	cpu_arm1026_dcache_clean_area
-	.word	cpu_arm1026_switch_mm
-	.word	cpu_arm1026_set_pte_ext
-	.word	0
-	.word	0
-	.word	0
-	.size	arm1026_processor_functions, . - arm1026_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions arm1026, dabort=v5t_early_abort, pabort=legacy_pabort
 
 	.section .rodata
 
-	.type	cpu_arch_name, #object
-cpu_arch_name:
-	.asciz	"armv5tej"
-	.size	cpu_arch_name, . - cpu_arch_name
-
-	.type	cpu_elf_name, #object
-cpu_elf_name:
-	.asciz	"v5"
-	.size	cpu_elf_name, . - cpu_elf_name
+	string	cpu_arch_name, "armv5tej"
+	string	cpu_elf_name, "v5"
 	.align
-
-	.type	cpu_arm1026_name, #object
-cpu_arm1026_name:
-	.asciz	"ARM1026EJ-S"
-	.size	cpu_arm1026_name, . - cpu_arm1026_name
-
+	string	cpu_arm1026_name, "ARM1026EJ-S"
 	.align
 
 	.section ".proc.info.init", #alloc, #execinstr
-- 
1.7.4.1
