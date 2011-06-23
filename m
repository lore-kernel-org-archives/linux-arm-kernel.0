From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 23 Jun 2011 18:50:23 +0100
Subject: [PATCH v3 15/40] Subject: ARM: mm: proc-arm720: Use the new processor
	struct macros
In-Reply-To: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308851448-25139-16-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-arm720.S |   85 +++++++++------------------------------------
 1 files changed, 17 insertions(+), 68 deletions(-)

diff --git a/arch/arm/mm/proc-arm720.S b/arch/arm/mm/proc-arm720.S
index 7a06e59..55f4e29 100644
--- a/arch/arm/mm/proc-arm720.S
+++ b/arch/arm/mm/proc-arm720.S
@@ -169,46 +169,15 @@ arm720_crval:
 	crval	clear=0x00002f3f, mmuset=0x0000213d, ucset=0x00000130
 
 		__INITDATA
-
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-		.type	arm720_processor_functions, #object
-ENTRY(arm720_processor_functions)
-		.word	v4t_late_abort
-		.word	legacy_pabort
-		.word	cpu_arm720_proc_init
-		.word	cpu_arm720_proc_fin
-		.word	cpu_arm720_reset
-		.word	cpu_arm720_do_idle
-		.word	cpu_arm720_dcache_clean_area
-		.word	cpu_arm720_switch_mm
-		.word	cpu_arm720_set_pte_ext
-		.word	0
-		.word	0
-		.word	0
-		.size	arm720_processor_functions, . - arm720_processor_functions
+	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+	define_processor_functions arm720, dabort=v4t_late_abort, pabort=legacy_pabort
 
 		.section ".rodata"
 
-		.type	cpu_arch_name, #object
-cpu_arch_name:	.asciz	"armv4t"
-		.size	cpu_arch_name, . - cpu_arch_name
-
-		.type	cpu_elf_name, #object
-cpu_elf_name:	.asciz	"v4"
-		.size	cpu_elf_name, . - cpu_elf_name
-
-		.type	cpu_arm710_name, #object
-cpu_arm710_name:
-		.asciz	"ARM710T"
-		.size	cpu_arm710_name, . - cpu_arm710_name
-
-		.type	cpu_arm720_name, #object
-cpu_arm720_name:
-		.asciz	"ARM720T"
-		.size	cpu_arm720_name, . - cpu_arm720_name
+	string	cpu_arch_name, "armv4t"
+	string	cpu_elf_name, "v4"
+	string	cpu_arm710_name, "ARM710T"
+	string	cpu_arm720_name, "ARM720T"
 
 		.align
 
@@ -218,10 +187,11 @@ cpu_arm720_name:
 	
 		.section ".proc.info.init", #alloc, #execinstr
 
-		.type	__arm710_proc_info, #object
-__arm710_proc_info:
-		.long	0x41807100				@ cpu_val
-		.long	0xffffff00				@ cpu_mask
+.macro arm720_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, cpu_flush:req
+		.type	__\name\()_proc_info,#object
+__\name\()_proc_info:
+		.long	\cpu_val
+		.long	\cpu_mask
 		.long   PMD_TYPE_SECT | \
 			PMD_SECT_BUFFERABLE | \
 			PMD_SECT_CACHEABLE | \
@@ -232,38 +202,17 @@ __arm710_proc_info:
 			PMD_BIT4 | \
 			PMD_SECT_AP_WRITE | \
 			PMD_SECT_AP_READ
-		b	__arm710_setup				@ cpu_flush
+		b	\cpu_flush				@ cpu_flush
 		.long	cpu_arch_name				@ arch_name
 		.long	cpu_elf_name				@ elf_name
 		.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB	@ elf_hwcap
-		.long	cpu_arm710_name				@ name
+		.long	\cpu_name
 		.long	arm720_processor_functions
 		.long	v4_tlb_fns
 		.long	v4wt_user_fns
 		.long	v4_cache_fns
-		.size	__arm710_proc_info, . - __arm710_proc_info
+		.size	__\name\()_proc_info, . - __\name\()_proc_info
+.endm
 
-		.type	__arm720_proc_info, #object
-__arm720_proc_info:
-		.long	0x41807200				@ cpu_val
-		.long	0xffffff00				@ cpu_mask
-		.long   PMD_TYPE_SECT | \
-			PMD_SECT_BUFFERABLE | \
-			PMD_SECT_CACHEABLE | \
-			PMD_BIT4 | \
-			PMD_SECT_AP_WRITE | \
-			PMD_SECT_AP_READ
-		.long   PMD_TYPE_SECT | \
-			PMD_BIT4 | \
-			PMD_SECT_AP_WRITE | \
-			PMD_SECT_AP_READ
-		b	__arm720_setup				@ cpu_flush
-		.long	cpu_arch_name				@ arch_name
-		.long	cpu_elf_name				@ elf_name
-		.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB	@ elf_hwcap
-		.long	cpu_arm720_name				@ name
-		.long	arm720_processor_functions
-		.long	v4_tlb_fns
-		.long	v4wt_user_fns
-		.long	v4_cache_fns
-		.size	__arm720_proc_info, . - __arm720_proc_info
+	arm720_proc_info arm710, 0x41807100, 0xffffff00, cpu_arm710_name, __arm710_setup
+	arm720_proc_info arm720, 0x41807200, 0xffffff00, cpu_arm720_name, __arm720_setup
-- 
1.7.4.1
