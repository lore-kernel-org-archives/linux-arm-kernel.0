From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:27 +0100
Subject: [PATCH v3 19/40] Subject: ARM: mm: proc-arm922: Use the new processor
	struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-20-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-arm922.S |   53 ++++++---------------------------------------
 1 files changed, 7 insertions(+), 46 deletions(-)

diff --git a/arch/arm/mm/proc-arm922.S b/arch/arm/mm/proc-arm922.S
index 95ba1fc..41ae409 100644
--- a/arch/arm/mm/proc-arm922.S
+++ b/arch/arm/mm/proc-arm922.S
@@ -317,18 +317,8 @@ ENTRY(arm922_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(arm922_dma_unmap_area)
 
-ENTRY(arm922_cache_fns)
-	.long	arm922_flush_icache_all
-	.long	arm922_flush_kern_cache_all
-	.long	arm922_flush_user_cache_all
-	.long	arm922_flush_user_cache_range
-	.long	arm922_coherent_kern_range
-	.long	arm922_coherent_user_range
-	.long	arm922_flush_kern_dcache_area
-	.long	arm922_dma_map_area
-	.long	arm922_dma_unmap_area
-	.long	arm922_dma_flush_range
-
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions arm922, default=arm922
 #endif
 
 
@@ -420,43 +410,14 @@ arm922_crval:
 	crval	clear=0x00003f3f, mmuset=0x00003135, ucset=0x00001130
 
 	__INITDATA
-
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-	.type	arm922_processor_functions, #object
-arm922_processor_functions:
-	.word	v4t_early_abort
-	.word	legacy_pabort
-	.word	cpu_arm922_proc_init
-	.word	cpu_arm922_proc_fin
-	.word	cpu_arm922_reset
-	.word   cpu_arm922_do_idle
-	.word	cpu_arm922_dcache_clean_area
-	.word	cpu_arm922_switch_mm
-	.word	cpu_arm922_set_pte_ext
-	.word	0
-	.word	0
-	.word	0
-	.size	arm922_processor_functions, . - arm922_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions arm922, dabort=v4t_early_abort, pabort=legacy_pabort
 
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
-	.type	cpu_arm922_name, #object
-cpu_arm922_name:
-	.asciz	"ARM922T"
-	.size	cpu_arm922_name, . - cpu_arm922_name
+	string	cpu_arch_name, "armv4t"
+	string	cpu_elf_name, "v4"
+	string	cpu_arm922_name, "ARM922T"
 
 	.align
 
-- 
1.7.4.1
