From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:30 +0100
Subject: [PATCH v4 23/40] ARM: mm: proc-arm946: Use the new processor struct
	macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-24-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-arm946.S |   53 ++++++---------------------------------------
 1 files changed, 7 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mm/proc-arm946.S b/arch/arm/mm/proc-arm946.S
index 8063345..f8f7ea3 100644
--- a/arch/arm/mm/proc-arm946.S
+++ b/arch/arm/mm/proc-arm946.S
@@ -306,18 +306,8 @@ ENTRY(arm946_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(arm946_dma_unmap_area)
 
-ENTRY(arm946_cache_fns)
-	.long	arm946_flush_icache_all
-	.long	arm946_flush_kern_cache_all
-	.long	arm946_flush_user_cache_all
-	.long	arm946_flush_user_cache_range
-	.long	arm946_coherent_kern_range
-	.long	arm946_coherent_user_range
-	.long	arm946_flush_kern_dcache_area
-	.long	arm946_dma_map_area
-	.long	arm946_dma_unmap_area
-	.long	arm946_dma_flush_range
-
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions arm946
 
 ENTRY(cpu_arm946_dcache_clean_area)
 #ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
@@ -403,43 +393,14 @@ __arm946_setup:
 
 	__INITDATA
 
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-	.type	arm946_processor_functions, #object
-ENTRY(arm946_processor_functions)
-	.word	nommu_early_abort
-	.word	legacy_pabort
-	.word	cpu_arm946_proc_init
-	.word	cpu_arm946_proc_fin
-	.word	cpu_arm946_reset
-	.word   cpu_arm946_do_idle
-
-	.word	cpu_arm946_dcache_clean_area
-	.word	cpu_arm946_switch_mm
-	.word	0		@ cpu_*_set_pte
-	.word	0
-	.word	0
-	.word	0
-	.size	arm946_processor_functions, . - arm946_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions arm946, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
 
 	.section ".rodata"
 
-	.type	cpu_arch_name, #object
-cpu_arch_name:
-	.asciz	"armv5te"
-	.size	cpu_arch_name, . - cpu_arch_name
-
-	.type	cpu_elf_name, #object
-cpu_elf_name:
-	.asciz	"v5t"
-	.size	cpu_elf_name, . - cpu_elf_name
-
-	.type	cpu_arm946_name, #object
-cpu_arm946_name:
-	.ascii	"ARM946E-S"
-	.size	cpu_arm946_name, . - cpu_arm946_name
+	string	cpu_arch_name, "armv5te"
+	string	cpu_elf_name, "v5t"
+	string	cpu_arm946_name, "ARM946E-S"
 
 	.align
 
-- 
1.7.4.1
