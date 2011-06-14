From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 14 Jun 2011 11:58:22 +0100
Subject: [RFC PATCH v2 2/5] ARM: proc-v7: Use new generic struct definition
	macros
In-Reply-To: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
References: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308049105-16080-3-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-v7.S |   46 ++++++++--------------------------------------
 1 files changed, 8 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index b3b566e..c5cf6ea 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -171,8 +171,6 @@ ENTRY(cpu_v7_set_pte_ext)
 	mov	pc, lr
 ENDPROC(cpu_v7_set_pte_ext)
 
-cpu_v7_name:
-	.ascii	"ARMv7 Processor"
 	.align
 
 	/*
@@ -403,36 +401,8 @@ v7_crval:
 __v7_setup_stack:
 	.space	4 * 11				@ 11 registers
 
-	__INITDATA
-
-	.type	v7_processor_functions, #object
-ENTRY(v7_processor_functions)
-	.word	v7_early_abort
-	.word	v7_pabort
-	.word	cpu_v7_proc_init
-	.word	cpu_v7_proc_fin
-	.word	cpu_v7_reset
-	.word	cpu_v7_do_idle
-	.word	cpu_v7_dcache_clean_area
-	.word	cpu_v7_switch_mm
-	.word	cpu_v7_set_pte_ext
-	.word	0
-	.word	0
-	.word	0
-	.size	v7_processor_functions, . - v7_processor_functions
-
-	.section ".rodata"
-
-	.type	cpu_arch_name, #object
-cpu_arch_name:
-	.asciz	"armv7"
-	.size	cpu_arch_name, . - cpu_arch_name
-
-	.type	cpu_elf_name, #object
-cpu_elf_name:
-	.asciz	"v7"
-	.size	cpu_elf_name, . - cpu_elf_name
-	.align
+	define_processor_functions v7, dabort=v7_early, pabort=v7
+	define_proc_names v7, "armv7", "v7", "ARMv7 Processor"
 
 	.section ".proc.info.init", #alloc, #execinstr
 
@@ -455,10 +425,10 @@ __v7_ca9mp_proc_info:
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
 	W(b)	__v7_ca9mp_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
+	.long	v7_arch_name
+	.long	v7_elf_name
 	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_TLS
-	.long	cpu_v7_name
+	.long	v7_cpu_name
 	.long	v7_processor_functions
 	.long	v7wbi_tlb_fns
 	.long	v6_user_fns
@@ -487,10 +457,10 @@ __v7_proc_info:
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
 	W(b)	__v7_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
+	.long	v7_arch_name
+	.long	v7_elf_name
 	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_TLS
-	.long	cpu_v7_name
+	.long	v7_cpu_name
 	.long	v7_processor_functions
 	.long	v7wbi_tlb_fns
 	.long	v6_user_fns
-- 
1.7.4.1
