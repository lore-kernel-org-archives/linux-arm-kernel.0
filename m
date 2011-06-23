From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:29 +0100
Subject: [PATCH v3 21/40] Subject: ARM: mm: proc-arm926: Use the new processor
	struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-22-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-arm926.S |   51 ++++++--------------------------------------
 1 files changed, 7 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index 0ed85d9..78c2a0a 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -335,17 +335,8 @@ ENTRY(arm926_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(arm926_dma_unmap_area)
 
-ENTRY(arm926_cache_fns)
-	.long	arm926_flush_icache_all
-	.long	arm926_flush_kern_cache_all
-	.long	arm926_flush_user_cache_all
-	.long	arm926_flush_user_cache_range
-	.long	arm926_coherent_kern_range
-	.long	arm926_coherent_user_range
-	.long	arm926_flush_kern_dcache_area
-	.long	arm926_dma_map_area
-	.long	arm926_dma_unmap_area
-	.long	arm926_dma_flush_range
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions arm926, default=arm926
 
 ENTRY(cpu_arm926_dcache_clean_area)
 #ifndef CONFIG_CPU_DCACHE_WRITETHROUGH
@@ -475,42 +466,14 @@ arm926_crval:
 
 	__INITDATA
 
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-	.type	arm926_processor_functions, #object
-arm926_processor_functions:
-	.word	v5tj_early_abort
-	.word	legacy_pabort
-	.word	cpu_arm926_proc_init
-	.word	cpu_arm926_proc_fin
-	.word	cpu_arm926_reset
-	.word	cpu_arm926_do_idle
-	.word	cpu_arm926_dcache_clean_area
-	.word	cpu_arm926_switch_mm
-	.word	cpu_arm926_set_pte_ext
-	.word	cpu_arm926_suspend_size
-	.word	cpu_arm926_do_suspend
-	.word	cpu_arm926_do_resume
-	.size	arm926_processor_functions, . - arm926_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions arm926, dabort=v5tj_early_abort, pabort=legacy_pabort, suspend=1
 
 	.section ".rodata"
 
-	.type	cpu_arch_name, #object
-cpu_arch_name:
-	.asciz	"armv5tej"
-	.size	cpu_arch_name, . - cpu_arch_name
-
-	.type	cpu_elf_name, #object
-cpu_elf_name:
-	.asciz	"v5"
-	.size	cpu_elf_name, . - cpu_elf_name
-
-	.type	cpu_arm926_name, #object
-cpu_arm926_name:
-	.asciz	"ARM926EJ-S"
-	.size	cpu_arm926_name, . - cpu_arm926_name
+	string	cpu_arch_name, "armv5tej"
+	string	cpu_elf_name, "v5"
+	string	cpu_arm926_name, "ARM926EJ-S"
 
 	.align
 
-- 
1.7.4.1
