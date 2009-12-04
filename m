From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri, 4 Dec 2009 08:35:17 -0500
Subject: [PATCH] [ARM] mmp: support PJ4 core
Message-ID: <mailman.71.1260166740.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marvell PJ4 core is compatible to ARMv6 architecture.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/boot/compressed/head.S |    6 ++++++
 arch/arm/mm/proc-v6.S           |   32 +++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index fa6fbf4..d356af7 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -743,6 +743,12 @@ proc_types:
 		W(b)	__armv4_mmu_cache_off
 		W(b)	__armv6_mmu_cache_flush

+		.word	0x560f5810		@ Marvell PJ4 ARMv6
+		.word	0xff0ffff0
+		W(b)	__armv4_mmu_cache_on
+		W(b)	__armv4_mmu_cache_off
+		W(b)	__armv6_mmu_cache_flush
+
 		.word	0x000f0000		@ new CPU Id
 		.word	0x000f0000
 		W(b)	__armv7_mmu_cache_on
diff --git a/arch/arm/mm/proc-v6.S b/arch/arm/mm/proc-v6.S
index 70f75d2..9d138cc 100644
--- a/arch/arm/mm/proc-v6.S
+++ b/arch/arm/mm/proc-v6.S
@@ -130,9 +130,16 @@ ENTRY(cpu_v6_set_pte_ext)



-
+	.type	cpu_v6_name, #object
 cpu_v6_name:
 	.asciz	"ARMv6-compatible processor"
+	.size	cpu_v6_name, . - cpu_v6_name
+
+	.type	cpu_pj4_name, #object
+cpu_pj4_name:
+	.asciz	"Marvell PJ4 processor"
+	.size	cpu_pj4_name, . - cpu_pj4_name
+
 	.align

 	__INIT
@@ -241,3 +248,26 @@ __v6_proc_info:
 	.long	v6_user_fns
 	.long	v6_cache_fns
 	.size	__v6_proc_info, . - __v6_proc_info
+
+	.type	__pj4_v6_proc_info, #object
+__pj4_v6_proc_info:
+	.long	0x560f5810
+	.long	0xff0ffff0
+	.long   PMD_TYPE_SECT | \
+		PMD_SECT_AP_WRITE | \
+		PMD_SECT_AP_READ | \
+		PMD_FLAGS
+	.long   PMD_TYPE_SECT | \
+		PMD_SECT_XN | \
+		PMD_SECT_AP_WRITE | \
+		PMD_SECT_AP_READ
+	b	__v6_setup
+	.long	cpu_arch_name
+	.long	cpu_elf_name
+	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_JAVA
+	.long	cpu_v6_name
+	.long	v6_processor_functions
+	.long	v6wbi_tlb_fns
+	.long	v6_user_fns
+	.long	v6_cache_fns
+	.size	__pj4_v6_proc_info, . - __pj4_v6_proc_info
-- 
1.5.6.5
