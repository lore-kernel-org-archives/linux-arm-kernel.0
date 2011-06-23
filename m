From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:26 +0100
Subject: [PATCH v3 18/40] Subject: ARM: mm: proc-arm920: Use the new processor
	struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-19-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-arm920.S |   53 ++++++---------------------------------------
 1 files changed, 7 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index bf8a1d1..4d850ea 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -315,18 +315,8 @@ ENTRY(arm920_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(arm920_dma_unmap_area)
 
-ENTRY(arm920_cache_fns)
-	.long	arm920_flush_icache_all
-	.long	arm920_flush_kern_cache_all
-	.long	arm920_flush_user_cache_all
-	.long	arm920_flush_user_cache_range
-	.long	arm920_coherent_kern_range
-	.long	arm920_coherent_user_range
-	.long	arm920_flush_kern_dcache_area
-	.long	arm920_dma_map_area
-	.long	arm920_dma_unmap_area
-	.long	arm920_dma_flush_range
-
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions arm920, default=arm920
 #endif
 
 
@@ -450,43 +440,14 @@ arm920_crval:
 	crval	clear=0x00003f3f, mmuset=0x00003135, ucset=0x00001130
 
 	__INITDATA
-
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-	.type	arm920_processor_functions, #object
-arm920_processor_functions:
-	.word	v4t_early_abort
-	.word	legacy_pabort
-	.word	cpu_arm920_proc_init
-	.word	cpu_arm920_proc_fin
-	.word	cpu_arm920_reset
-	.word   cpu_arm920_do_idle
-	.word	cpu_arm920_dcache_clean_area
-	.word	cpu_arm920_switch_mm
-	.word	cpu_arm920_set_pte_ext
-	.word	cpu_arm920_suspend_size
-	.word	cpu_arm920_do_suspend
-	.word	cpu_arm920_do_resume
-	.size	arm920_processor_functions, . - arm920_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions arm920, dabort=v4t_early_abort, pabort=legacy_pabort, suspend=1
 
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
-	.type	cpu_arm920_name, #object
-cpu_arm920_name:
-	.asciz	"ARM920T"
-	.size	cpu_arm920_name, . - cpu_arm920_name
+	string	cpu_arch_name, "armv4t"
+	string	cpu_elf_name, "v4"
+	string	cpu_arm920_name, "ARM920T"
 
 	.align
 
-- 
1.7.4.1
