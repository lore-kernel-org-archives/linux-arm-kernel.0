From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:19 +0100
Subject: [PATCH v4 12/40] ARM: mm: proc-arm1022: Use the new processor struct
	macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-13-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-arm1022.S |   52 ++++++--------------------------------------
 1 files changed, 7 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mm/proc-arm1022.S b/arch/arm/mm/proc-arm1022.S
index c8884c5..d283cf3 100644
--- a/arch/arm/mm/proc-arm1022.S
+++ b/arch/arm/mm/proc-arm1022.S
@@ -339,17 +339,8 @@ ENTRY(arm1022_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(arm1022_dma_unmap_area)
 
-ENTRY(arm1022_cache_fns)
-	.long	arm1022_flush_icache_all
-	.long	arm1022_flush_kern_cache_all
-	.long	arm1022_flush_user_cache_all
-	.long	arm1022_flush_user_cache_range
-	.long	arm1022_coherent_kern_range
-	.long	arm1022_coherent_user_range
-	.long	arm1022_flush_kern_dcache_area
-	.long	arm1022_dma_map_area
-	.long	arm1022_dma_unmap_area
-	.long	arm1022_dma_flush_range
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions arm1022
 
 	.align	5
 ENTRY(cpu_arm1022_dcache_clean_area)
@@ -441,43 +432,14 @@ arm1022_crval:
 	crval	clear=0x00007f3f, mmuset=0x00003935, ucset=0x00001930
 
 	__INITDATA
-
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-	.type	arm1022_processor_functions, #object
-arm1022_processor_functions:
-	.word	v4t_early_abort
-	.word	legacy_pabort
-	.word	cpu_arm1022_proc_init
-	.word	cpu_arm1022_proc_fin
-	.word	cpu_arm1022_reset
-	.word	cpu_arm1022_do_idle
-	.word	cpu_arm1022_dcache_clean_area
-	.word	cpu_arm1022_switch_mm
-	.word	cpu_arm1022_set_pte_ext
-	.word	0
-	.word	0
-	.word	0
-	.size	arm1022_processor_functions, . - arm1022_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions arm1022, dabort=v4t_early_abort, pabort=legacy_pabort
 
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
-	.type	cpu_arm1022_name, #object
-cpu_arm1022_name:
-	.asciz	"ARM1022"
-	.size	cpu_arm1022_name, . - cpu_arm1022_name
+	string	cpu_arch_name, "armv5te"
+	string	cpu_elf_name, "v5"
+	string	cpu_arm1022_name, "ARM1022"
 
 	.align
 
-- 
1.7.4.1
