From: dave.martin@linaro.org (Dave Martin)
Date: Thu,  9 Jun 2011 18:21:52 +0100
Subject: [RFC PATCH 2/2] ARM: proc-v7: Use the new proc_info declaration macro
In-Reply-To: <1307640112-5360-1-git-send-email-dave.martin@linaro.org>
References: <1307640112-5360-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1307640112-5360-3-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/mm/proc-v7.S |   93 ++++++++++++++++++++-----------------------------
 1 files changed, 38 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index b3b566e..9e8569c 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -171,8 +171,6 @@ ENTRY(cpu_v7_set_pte_ext)
 	mov	pc, lr
 ENDPROC(cpu_v7_set_pte_ext)
 
-cpu_v7_name:
-	.ascii	"ARMv7 Processor"
 	.align
 
 	/*
@@ -421,78 +419,63 @@ ENTRY(v7_processor_functions)
 	.word	0
 	.size	v7_processor_functions, . - v7_processor_functions
 
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
-
-	.section ".proc.info.init", #alloc, #execinstr
-
-	.type   __v7_ca9mp_proc_info, #object
-__v7_ca9mp_proc_info:
-	.long	0x410fc090		@ Required ID value
-	.long	0xff0ffff0		@ Mask for ID
-	ALT_SMP(.long \
+proc_info __v7_ca9mp_proc_info
+	cpu_val		0x410fc090		@ Required ID value
+	cpu_mask	0xff0ffff0		@ Mask for ID
+	__cpu_mm_mmu_flags_smp \
 		PMD_TYPE_SECT | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ | \
-		PMD_FLAGS_SMP)
-	ALT_UP(.long \
+		PMD_FLAGS_SMP
+	__cpu_mm_mmu_flags_up \
 		PMD_TYPE_SECT | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ | \
-		PMD_FLAGS_UP)
-	.long   PMD_TYPE_SECT | \
+		PMD_FLAGS_UP
+	__cpu_io_mmu_flags \
+		PMD_TYPE_SECT | \
 		PMD_SECT_XN | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	W(b)	__v7_ca9mp_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_TLS
-	.long	cpu_v7_name
-	.long	v7_processor_functions
-	.long	v7wbi_tlb_fns
-	.long	v6_user_fns
-	.long	v7_cache_fns
-	.size	__v7_ca9mp_proc_info, . - __v7_ca9mp_proc_info
+	__cpu_flush	W(b)	__v7_ca9mp_setup
+	arch_name	"armv7"
+	elf_name	"v7"
+	elf_hwcap	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_TLS
+	cpu_name	"ARMv7 Processor"
+	proc		v7_processor_functions
+	tlb		v7wbi_tlb_fns
+	user		v6_user_fns
+	cache		v7_cache_fns
+end_proc_info
 
 	/*
 	 * Match any ARMv7 processor core.
 	 */
-	.type	__v7_proc_info, #object
-__v7_proc_info:
-	.long	0x000f0000		@ Required ID value
-	.long	0x000f0000		@ Mask for ID
-	ALT_SMP(.long \
+proc_info __v7_proc_info
+	cpu_val		0x000f0000		@ Required ID value
+	cpu_mask	0x000f0000		@ Mask for ID
+	__cpu_mm_mmu_flags_smp \
 		PMD_TYPE_SECT | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ | \
-		PMD_FLAGS_SMP)
-	ALT_UP(.long \
+		PMD_FLAGS_SMP
+	__cpu_mm_mmu_flags_up \
 		PMD_TYPE_SECT | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ | \
-		PMD_FLAGS_UP)
-	.long   PMD_TYPE_SECT | \
+		PMD_FLAGS_UP
+	__cpu_io_mmu_flags \
+		PMD_TYPE_SECT | \
 		PMD_SECT_XN | \
 		PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ
-	W(b)	__v7_setup
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_TLS
-	.long	cpu_v7_name
-	.long	v7_processor_functions
-	.long	v7wbi_tlb_fns
-	.long	v6_user_fns
-	.long	v7_cache_fns
-	.size	__v7_proc_info, . - __v7_proc_info
+	__cpu_flush	W(b)	__v7_setup
+	arch_name	"armv7"
+	elf_name	"v7"
+	elf_hwcap	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_TLS
+	cpu_name	"ARMv7 Processor"
+	proc		v7_processor_functions
+	tlb		v7wbi_tlb_fns
+	user		v6_user_fns
+	cache		v7_cache_fns
+end_proc_info
-- 
1.7.4.1
