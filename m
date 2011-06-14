From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 14 Jun 2011 11:58:24 +0100
Subject: [RFC PATCH v2 4/5] ARM: proc-v6: Use new generic struct definition
	macros
In-Reply-To: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
References: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1308049105-16080-5-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-v6.S |   43 +++++--------------------------------------
 1 files changed, 5 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 1d2b845..d7ae4b7 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -170,11 +170,6 @@ cpu_resume_l1_flags:
 #endif
 
 
-	.type	cpu_v6_name, #object
-cpu_v6_name:
-	.asciz	"ARMv6-compatible processor"
-	.size	cpu_v6_name, . - cpu_v6_name
-
 	.align
 
 	__CPUINIT
@@ -237,36 +232,8 @@ __v6_setup:
 v6_crval:
 	crval	clear=0x01e0fb7f, mmuset=0x00c0387d, ucset=0x00c0187c
 
-	__INITDATA
-
-	.type	v6_processor_functions, #object
-ENTRY(v6_processor_functions)
-	.word	v6_early_abort
-	.word	v6_pabort
-	.word	cpu_v6_proc_init
-	.word	cpu_v6_proc_fin
-	.word	cpu_v6_reset
-	.word	cpu_v6_do_idle
-	.word	cpu_v6_dcache_clean_area
-	.word	cpu_v6_switch_mm
-	.word	cpu_v6_set_pte_ext
-	.word	cpu_v6_suspend_size
-	.word	cpu_v6_do_suspend
-	.word	cpu_v6_do_resume
-	.size	v6_processor_functions, . - v6_processor_functions
-
-	.section ".rodata"
-
-	.type	cpu_arch_name, #object
-cpu_arch_name:
-	.asciz	"armv6"
-	.size	cpu_arch_name, . - cpu_arch_name
-
-	.type	cpu_elf_name, #object
-cpu_elf_name:
-	.asciz	"v6"
-	.size	cpu_elf_name, . - cpu_elf_name
-	.align
+	define_processor_functions v6, dabort=v6_early, pabort=v6, suspend=1
+	define_proc_names v6, "armv6", "v6", "ARMv6-compatible processor"
 
 	.section ".proc.info.init", #alloc, #execinstr
 
@@ -292,11 +259,11 @@ __v6_proc_info:
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
 	b	__v6_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
+	.long	v6_arch_name
+	.long	v6_elf_name
 	/* See also feat_v6_fixup() for HWCAP_TLS */
 	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_JAVA|HWCAP_TLS
-	.long	cpu_v6_name
+	.long	v6_cpu_name
 	.long	v6_processor_functions
 	.long	v6wbi_tlb_fns
 	.long	v6_user_fns
-- 
1.7.4.1
