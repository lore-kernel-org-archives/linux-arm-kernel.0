From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  7 Jul 2011 15:27:21 +0100
Subject: [PATCH v4 14/40] ARM: mm: proc-arm6_7: Use the new processor struct
	macros
In-Reply-To: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
References: <1310048867-14172-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1310048867-14172-15-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-arm6_7.S |  166 +++++++++------------------------------------
 1 files changed, 32 insertions(+), 134 deletions(-)

diff --git a/arch/arm/mm/proc-arm6_7.S b/arch/arm/mm/proc-arm6_7.S
index 5f79dc4..ebc0ca7 100644
--- a/arch/arm/mm/proc-arm6_7.S
+++ b/arch/arm/mm/proc-arm6_7.S
@@ -269,159 +269,57 @@ __arm7_setup:	mov	r0, #0
 
 		__INITDATA
 
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-		.type	arm6_processor_functions, #object
-ENTRY(arm6_processor_functions)
-		.word	cpu_arm6_data_abort
-		.word	legacy_pabort
-		.word	cpu_arm6_proc_init
-		.word	cpu_arm6_proc_fin
-		.word	cpu_arm6_reset
-		.word	cpu_arm6_do_idle
-		.word	cpu_arm6_dcache_clean_area
-		.word	cpu_arm6_switch_mm
-		.word	cpu_arm6_set_pte_ext
-		.word	0
-		.word	0
-		.word	0
-		.size	arm6_processor_functions, . - arm6_processor_functions
-
-/*
- * Purpose : Function pointers used to access above functions - all calls
- *	     come through these
- */
-		.type	arm7_processor_functions, #object
-ENTRY(arm7_processor_functions)
-		.word	cpu_arm7_data_abort
-		.word	legacy_pabort
-		.word	cpu_arm7_proc_init
-		.word	cpu_arm7_proc_fin
-		.word	cpu_arm7_reset
-		.word	cpu_arm7_do_idle
-		.word	cpu_arm7_dcache_clean_area
-		.word	cpu_arm7_switch_mm
-		.word	cpu_arm7_set_pte_ext
-		.word	0
-		.word	0
-		.word	0
-		.size	arm7_processor_functions, . - arm7_processor_functions
+		@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
+		define_processor_functions arm6, dabort=cpu_arm6_data_abort, pabort=legacy_pabort
+		define_processor_functions arm7, dabort=cpu_arm7_data_abort, pabort=legacy_pabort
 
 		.section ".rodata"
 
-		.type	cpu_arch_name, #object
-cpu_arch_name:	.asciz	"armv3"
-		.size	cpu_arch_name, . - cpu_arch_name
-
-		.type	cpu_elf_name, #object
-cpu_elf_name:	.asciz	"v3"
-		.size	cpu_elf_name, . - cpu_elf_name
-
-		.type	cpu_arm6_name, #object
-cpu_arm6_name:	.asciz	"ARM6"
-		.size	cpu_arm6_name, . - cpu_arm6_name
-
-		.type	cpu_arm610_name, #object
-cpu_arm610_name:
-		.asciz	"ARM610"
-		.size	cpu_arm610_name, . - cpu_arm610_name
-
-		.type	cpu_arm7_name, #object
-cpu_arm7_name:	.asciz	"ARM7"
-		.size	cpu_arm7_name, . - cpu_arm7_name
-
-		.type	cpu_arm710_name, #object
-cpu_arm710_name:
-		.asciz	"ARM710"
-		.size	cpu_arm710_name, . - cpu_arm710_name
+		string	cpu_arch_name, "armv3"
+		string	cpu_elf_name, "v3"
+		string	cpu_arm6_name, "ARM6"
+		string	cpu_arm610_name, "ARM610"
+		string	cpu_arm7_name, "ARM7"
+		string	cpu_arm710_name, "ARM710"
 
 		.align
 
 		.section ".proc.info.init", #alloc, #execinstr
 
-		.type	__arm6_proc_info, #object
-__arm6_proc_info:
-		.long	0x41560600
-		.long	0xfffffff0
-		.long	0x00000c1e
+.macro arm67_proc_info name:req, cpu_val:req, cpu_mask:req, cpu_name:req, \
+	cpu_mm_mmu_flags:req, cpu_flush:req, cpu_proc_funcs:req
+		.type	__\name\()_proc_info, #object
+__\name\()_proc_info:
+		.long	\cpu_val
+		.long	\cpu_mask
+		.long	\cpu_mm_mmu_flags
 		.long   PMD_TYPE_SECT | \
 			PMD_BIT4 | \
 			PMD_SECT_AP_WRITE | \
 			PMD_SECT_AP_READ
-		b	__arm6_setup
+		b	\cpu_flush
 		.long	cpu_arch_name
 		.long	cpu_elf_name
 		.long	HWCAP_SWP | HWCAP_26BIT
-		.long	cpu_arm6_name
-		.long	arm6_processor_functions
+		.long	\cpu_name
+		.long	\cpu_proc_funcs
 		.long	v3_tlb_fns
 		.long	v3_user_fns
 		.long	v3_cache_fns
-		.size	__arm6_proc_info, . - __arm6_proc_info
-
-		.type	__arm610_proc_info, #object
-__arm610_proc_info:
-		.long	0x41560610
-		.long	0xfffffff0
-		.long	0x00000c1e
-		.long   PMD_TYPE_SECT | \
-			PMD_BIT4 | \
-			PMD_SECT_AP_WRITE | \
-			PMD_SECT_AP_READ
-		b	__arm6_setup
-		.long	cpu_arch_name
-		.long	cpu_elf_name
-		.long	HWCAP_SWP | HWCAP_26BIT
-		.long	cpu_arm610_name
-		.long	arm6_processor_functions
-		.long	v3_tlb_fns
-		.long	v3_user_fns
-		.long	v3_cache_fns
-		.size	__arm610_proc_info, . - __arm610_proc_info
-
-		.type	__arm7_proc_info, #object
-__arm7_proc_info:
-		.long	0x41007000
-		.long	0xffffff00
-		.long	0x00000c1e
-		.long   PMD_TYPE_SECT | \
-			PMD_BIT4 | \
-			PMD_SECT_AP_WRITE | \
-			PMD_SECT_AP_READ
-		b	__arm7_setup
-		.long	cpu_arch_name
-		.long	cpu_elf_name
-		.long	HWCAP_SWP | HWCAP_26BIT
-		.long	cpu_arm7_name
-		.long	arm7_processor_functions
-		.long	v3_tlb_fns
-		.long	v3_user_fns
-		.long	v3_cache_fns
-		.size	__arm7_proc_info, . - __arm7_proc_info
-
-		.type	__arm710_proc_info, #object
-__arm710_proc_info:
-		.long	0x41007100
-		.long	0xfff8ff00
-		.long   PMD_TYPE_SECT | \
+		.size	__\name\()_proc_info, . - __\name\()_proc_info
+.endm
+
+	arm67_proc_info	arm6,	0x41560600, 0xfffffff0, cpu_arm6_name, \
+		0x00000c1e, __arm6_setup, arm6_processor_functions
+	arm67_proc_info	arm610,	0x41560610, 0xfffffff0, cpu_arm610_name, \
+		0x00000c1e, __arm6_setup, arm6_processor_functions
+	arm67_proc_info	arm7,	0x41007000, 0xffffff00, cpu_arm7_name, \
+		0x00000c1e, __arm7_setup, arm7_processor_functions
+	arm67_proc_info	arm710,	0x41007100, 0xfff8ff00, cpu_arm710_name, \
+			PMD_TYPE_SECT | \
 			PMD_SECT_BUFFERABLE | \
 			PMD_SECT_CACHEABLE | \
 			PMD_BIT4 | \
 			PMD_SECT_AP_WRITE | \
-			PMD_SECT_AP_READ
-		.long   PMD_TYPE_SECT | \
-			PMD_BIT4 | \
-			PMD_SECT_AP_WRITE | \
-			PMD_SECT_AP_READ
-		b	__arm7_setup
-		.long	cpu_arch_name
-		.long	cpu_elf_name
-		.long	HWCAP_SWP | HWCAP_26BIT
-		.long	cpu_arm710_name
-		.long	arm7_processor_functions
-		.long	v3_tlb_fns
-		.long	v3_user_fns
-		.long	v3_cache_fns
-		.size	__arm710_proc_info, . - __arm710_proc_info
+			PMD_SECT_AP_READ, \
+		__arm7_setup, arm7_processor_functions
-- 
1.7.4.1
