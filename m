From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:19 +0100
Subject: [PATCH v3 11/40] Subject: ARM: mm: proc-arm1020e: Use the new
	processor struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-12-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-arm1020e.S |   52 +++++-------------------------------------
 1 files changed, 7 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mm/proc-arm1020e.S b/arch/arm/mm/proc-arm1020e.S
index 4ce947c..e2869f1 100644
--- a/arch/arm/mm/proc-arm1020e.S
+++ b/arch/arm/mm/proc-arm1020e.S
@@ -350,17 +350,8 @@ ENTRY(arm1020e_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(arm1020e_dma_unmap_area)
 
-ENTRY(arm1020e_cache_fns)
-	.long	arm1020e_flush_icache_all
-	.long	arm1020e_flush_kern_cache_all
-	.long	arm1020e_flush_user_cache_all
-	.long	arm1020e_flush_user_cache_range
-	.long	arm1020e_coherent_kern_range
-	.long	arm1020e_coherent_user_range
-	.long	arm1020e_flush_kern_dcache_area
-	.long	arm1020e_dma_map_area
-	.long	arm1020e_dma_unmap_area
-	.long	arm1020e_dma_flush_range
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions arm1020e, default=arm1020e
 
 	.align	5
 ENTRY(cpu_arm1020e_dcache_clean_area)
@@ -458,43 +449,14 @@ arm1020e_crval:
 	crval	clear=0x00007f3f, mmuset=0x00003935, ucset=0x00001930
 
 	__INITDATA
-
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-	.type	arm1020e_processor_functions, #object
-arm1020e_processor_functions:
-	.word	v4t_early_abort
-	.word	legacy_pabort
-	.word	cpu_arm1020e_proc_init
-	.word	cpu_arm1020e_proc_fin
-	.word	cpu_arm1020e_reset
-	.word	cpu_arm1020e_do_idle
-	.word	cpu_arm1020e_dcache_clean_area
-	.word	cpu_arm1020e_switch_mm
-	.word	cpu_arm1020e_set_pte_ext
-	.word	0
-	.word	0
-	.word	0
-	.size	arm1020e_processor_functions, . - arm1020e_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions arm1020e, dabort=v4t_early_abort, pabort=legacy_pabort
 
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
-	.type	cpu_arm1020e_name, #object
-cpu_arm1020e_name:
-	.asciz	"ARM1020E"
-	.size	cpu_arm1020e_name, . - cpu_arm1020e_name
+	string	cpu_arch_name, "armv5te"
+	string	cpu_elf_name, "v5"
+	string	cpu_arm1020e_name, "ARM1020E"
 
 	.align
 
-- 
1.7.4.1
