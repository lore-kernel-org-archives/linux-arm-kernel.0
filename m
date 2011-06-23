From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:35 +0100
Subject: [PATCH v3 27/40] Subject: ARM: mm: proc-mohawk: Use the new processor
	struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-28-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NOTE: Even with this patch, this CPU is still broken due the lack
of a suitable flush_icache_all function.

Without this patch, the entries in the cache functions struct are
off by one, which will result in the wrong functions being called
at run-time.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-mohawk.S |   50 ++++++--------------------------------------
 1 files changed, 7 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mm/proc-mohawk.S b/arch/arm/mm/proc-mohawk.S
index 9d4f2ae..e1fad39 100644
--- a/arch/arm/mm/proc-mohawk.S
+++ b/arch/arm/mm/proc-mohawk.S
@@ -288,16 +288,8 @@ ENTRY(mohawk_dma_unmap_area)
 	mov	pc, lr
 ENDPROC(mohawk_dma_unmap_area)
 
-ENTRY(mohawk_cache_fns)
-	.long	mohawk_flush_kern_cache_all
-	.long	mohawk_flush_user_cache_all
-	.long	mohawk_flush_user_cache_range
-	.long	mohawk_coherent_kern_range
-	.long	mohawk_coherent_user_range
-	.long	mohawk_flush_kern_dcache_area
-	.long	mohawk_dma_map_area
-	.long	mohawk_dma_unmap_area
-	.long	mohawk_dma_flush_range
+	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
+	define_cache_functions mohawk, default=mohawk
 
 ENTRY(cpu_mohawk_dcache_clean_area)
 1:	mcr	p15, 0, r0, c7, c10, 1		@ clean D entry
@@ -373,42 +365,14 @@ mohawk_crval:
 
 	__INITDATA
 
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-	.type	mohawk_processor_functions, #object
-mohawk_processor_functions:
-	.word	v5t_early_abort
-	.word	legacy_pabort
-	.word	cpu_mohawk_proc_init
-	.word	cpu_mohawk_proc_fin
-	.word	cpu_mohawk_reset
-	.word	cpu_mohawk_do_idle
-	.word	cpu_mohawk_dcache_clean_area
-	.word	cpu_mohawk_switch_mm
-	.word	cpu_mohawk_set_pte_ext
-	.word	0
-	.word	0
-	.word	0
-	.size	mohawk_processor_functions, . - mohawk_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions mohawk, dabort=v5t_early_abort, pabort=legacy_pabort
 
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
-	.type	cpu_mohawk_name, #object
-cpu_mohawk_name:
-	.asciz	"Marvell 88SV331x"
-	.size	cpu_mohawk_name, . - cpu_mohawk_name
+	string	cpu_arch_name, "armv5te"
+	string	cpu_elf_name, "v5"
+	string	cpu_mohawk_name, "Marvell 88SV331x"
 
 	.align
 
-- 
1.7.4.1
