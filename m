From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:29 +0100
Subject: [PATCH v4 22/40] ARM: mm: proc-arm940: Use the new processor struct
	macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-23-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-arm940.S |   51 ++++++--------------------------------------
 1 files changed, 7 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mm/proc-arm940.S b/arch/arm/mm/proc-arm940.S
index 26aea3f..ac750d5 100644
--- a/arch/arm/mm/proc-arm940.S
+++ b/arch/arm/mm/proc-arm940.S
@@ -264,17 +264,8 @@ ENTRY(arm940_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(arm940_dma_unmap_area)
 
-ENTRY(arm940_cache_fns)
-	.long	arm940_flush_icache_all
-	.long	arm940_flush_kern_cache_all
-	.long	arm940_flush_user_cache_all
-	.long	arm940_flush_user_cache_range
-	.long	arm940_coherent_kern_range
-	.long	arm940_coherent_user_range
-	.long	arm940_flush_kern_dcache_area
-	.long	arm940_dma_map_area
-	.long	arm940_dma_unmap_area
-	.long	arm940_dma_flush_range
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions arm940
 
 	__CPUINIT
 
@@ -348,42 +339,14 @@ __arm940_setup:
 
 	__INITDATA
 
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-	.type	arm940_processor_functions, #object
-ENTRY(arm940_processor_functions)
-	.word	nommu_early_abort
-	.word	legacy_pabort
-	.word	cpu_arm940_proc_init
-	.word	cpu_arm940_proc_fin
-	.word	cpu_arm940_reset
-	.word   cpu_arm940_do_idle
-	.word	cpu_arm940_dcache_clean_area
-	.word	cpu_arm940_switch_mm
-	.word	0		@ cpu_*_set_pte
-	.word	0
-	.word	0
-	.word	0
-	.size	arm940_processor_functions, . - arm940_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions arm940, dabort=nommu_early_abort, pabort=legacy_pabort, nommu=1
 
 	.section ".rodata"
 
-.type	cpu_arch_name, #object
-cpu_arch_name:
-	.asciz	"armv4t"
-	.size	cpu_arch_name, . - cpu_arch_name
-
-	.type	cpu_elf_name, #object
-cpu_elf_name:
-	.asciz	"v4"
-	.size	cpu_elf_name, . - cpu_elf_name
-
-	.type	cpu_arm940_name, #object
-cpu_arm940_name:
-	.ascii	"ARM940T"
-	.size	cpu_arm940_name, . - cpu_arm940_name
+	string	cpu_arch_name, "armv4t"
+	string	cpu_elf_name, "v4"
+	string	cpu_arm940_name, "ARM940T"
 
 	.align
 
-- 
1.7.4.1
