From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:17 +0100
Subject: [PATCH v4 10/40] ARM: mm: proc-arm1020: Use the new processor struct
	macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-11-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-arm1020.S |   45 +++++--------------------------------------
 1 files changed, 6 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mm/proc-arm1020.S b/arch/arm/mm/proc-arm1020.S
index 6c4e7fd..6746966 100644
--- a/arch/arm/mm/proc-arm1020.S
+++ b/arch/arm/mm/proc-arm1020.S
@@ -364,17 +364,8 @@ ENTRY(arm1020_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(arm1020_dma_unmap_area)
 
-ENTRY(arm1020_cache_fns)
-	.long	arm1020_flush_icache_all
-	.long	arm1020_flush_kern_cache_all
-	.long	arm1020_flush_user_cache_all
-	.long	arm1020_flush_user_cache_range
-	.long	arm1020_coherent_kern_range
-	.long	arm1020_coherent_user_range
-	.long	arm1020_flush_kern_dcache_area
-	.long	arm1020_dma_map_area
-	.long	arm1020_dma_unmap_area
-	.long	arm1020_dma_flush_range
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions arm1020
 
 	.align	5
 ENTRY(cpu_arm1020_dcache_clean_area)
@@ -477,38 +468,14 @@ arm1020_crval:
 	crval	clear=0x0000593f, mmuset=0x00003935, ucset=0x00001930
 
 	__INITDATA
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions arm1020, dabort=v4t_early_abort, pabort=legacy_pabort
 
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-	.type	arm1020_processor_functions, #object
-arm1020_processor_functions:
-	.word	v4t_early_abort
-	.word	legacy_pabort
-	.word	cpu_arm1020_proc_init
-	.word	cpu_arm1020_proc_fin
-	.word	cpu_arm1020_reset
-	.word	cpu_arm1020_do_idle
-	.word	cpu_arm1020_dcache_clean_area
-	.word	cpu_arm1020_switch_mm
-	.word	cpu_arm1020_set_pte_ext
-	.word	0
-	.word	0
-	.word	0
-	.size	arm1020_processor_functions, . - arm1020_processor_functions
 
 	.section ".rodata"
 
-	.type	cpu_arch_name, #object
-cpu_arch_name:
-	.asciz	"armv5t"
-	.size	cpu_arch_name, . - cpu_arch_name
-
-	.type	cpu_elf_name, #object
-cpu_elf_name:
-	.asciz	"v5"
-	.size	cpu_elf_name, . - cpu_elf_name
+	string	cpu_arch_name, "armv5t"
+	string	cpu_elf_name, "v5"
 
 	.type	cpu_arm1020_name, #object
 cpu_arm1020_name:
-- 
1.7.4.1
