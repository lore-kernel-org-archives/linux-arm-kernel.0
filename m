From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:37 +0100
Subject: [PATCH v3 29/40] Subject: ARM: mm: proc-sa1100: Use the new processor
	struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-30-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-sa1100.S |   84 +++++++++-----------------------------------
 1 files changed, 17 insertions(+), 67 deletions(-)

diff --git a/arch/arm/mm/proc-sa1100.S b/arch/arm/mm/proc-sa1100.S
index 184a9c9..c7e08ca 100644
--- a/arch/arm/mm/proc-sa1100.S
+++ b/arch/arm/mm/proc-sa1100.S
@@ -236,59 +236,28 @@ sa1100_crval:
 	__INITDATA
 
 /*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-
-/*
  * SA1100 and SA1110 share the same function calls
  */
-	.type	sa1100_processor_functions, #object
-ENTRY(sa1100_processor_functions)
-	.word	v4_early_abort
-	.word	legacy_pabort
-	.word	cpu_sa1100_proc_init
-	.word	cpu_sa1100_proc_fin
-	.word	cpu_sa1100_reset
-	.word	cpu_sa1100_do_idle
-	.word	cpu_sa1100_dcache_clean_area
-	.word	cpu_sa1100_switch_mm
-	.word	cpu_sa1100_set_pte_ext
-	.word	cpu_sa1100_suspend_size
-	.word	cpu_sa1100_do_suspend
-	.word	cpu_sa1100_do_resume
-	.size	sa1100_processor_functions, . - sa1100_processor_functions
-
-	.section ".rodata"
-
-	.type	cpu_arch_name, #object
-cpu_arch_name:
-	.asciz	"armv4"
-	.size	cpu_arch_name, . - cpu_arch_name
 
-	.type	cpu_elf_name, #object
-cpu_elf_name:
-	.asciz	"v4"
-	.size	cpu_elf_name, . - cpu_elf_name
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions sa1100, dabort=v4_early_abort, pabort=legacy_pabort, suspend=1
 
-	.type	cpu_sa1100_name, #object
-cpu_sa1100_name:
-	.asciz	"StrongARM-1100"
-	.size	cpu_sa1100_name, . - cpu_sa1100_name
+	.section ".rodata"
 
-	.type	cpu_sa1110_name, #object
-cpu_sa1110_name:
-	.asciz	"StrongARM-1110"
-	.size	cpu_sa1110_name, . - cpu_sa1110_name
+	string	cpu_arch_name, "armv4"
+	string	cpu_elf_name, "v4"
+	string	cpu_sa1100_name, "StrongARM-1100"
+	string	cpu_sa1110_name, "StrongARM-1110"
 
 	.align
 
 	.section ".proc.info.init", #alloc, #execinstr
 
-	.type	__sa1100_proc_info,#object
-__sa1100_proc_info:
-	.long	0x4401a110
-	.long	0xfffffff0
+.macro sa1100_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req
+	.type	__\name\()_proc_info,#object
+__\name\()_proc_info:
+	.long	\cpu_val
+	.long	\cpu_mask
 	.long   PMD_TYPE_SECT | \
 		PMD_SECT_BUFFERABLE | \
 		PMD_SECT_CACHEABLE | \
@@ -301,32 +270,13 @@ __sa1100_proc_info:
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_26BIT | HWCAP_FAST_MULT
-	.long	cpu_sa1100_name
+	.long	\cpu_name
 	.long	sa1100_processor_functions
 	.long	v4wb_tlb_fns
 	.long	v4_mc_user_fns
 	.long	v4wb_cache_fns
-	.size	__sa1100_proc_info, . - __sa1100_proc_info
+	.size	__\name\()_proc_info, . - __\name\()_proc_info
+.endm
 
-	.type	__sa1110_proc_info,#object
-__sa1110_proc_info:
-	.long	0x6901b110
-	.long	0xfffffff0
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_BUFFERABLE | \
-		PMD_SECT_CACHEABLE | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	.long   PMD_TYPE_SECT | \
-		PMD_SECT_AP_WRITE | \
-		PMD_SECT_AP_READ
-	b	__sa1100_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_26BIT | HWCAP_FAST_MULT
-	.long	cpu_sa1110_name
-	.long	sa1100_processor_functions
-	.long	v4wb_tlb_fns
-	.long	v4_mc_user_fns
-	.long	v4wb_cache_fns
-	.size	__sa1110_proc_info, . - __sa1110_proc_info
+	sa1100_proc_info sa1100, 0x4401a110, 0xfffffff0, cpu_sa1100_name
+	sa1100_proc_info sa1110, 0x6901b110, 0xfffffff0, cpu_sa1110_name
-- 
1.7.4.1
