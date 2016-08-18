From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 18 Aug 2016 13:45:59 +0100
Subject: [PATCH v2 7/8] ARM: V7M: Indirect proc_info construction for V7M CPUs
In-Reply-To: <1471524360-31554-1-git-send-email-vladimir.murzin@arm.com>
References: <1471524360-31554-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1471524360-31554-8-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Austin <jonathan.austin@arm.com>

This patch copies the method used for V7A/R CPUs to specify differing
processor info for different cores.

This patch differentiates Cortex-M3 and Cortex-M4 and leaves a fallback case
for any other V7M processors.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/proc-v7m.S |   46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 11f5816..796a983 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -132,6 +132,40 @@ ENDPROC(__v7m_setup)
 
 	.section ".proc.info.init", #alloc
 
+.macro __v7m_proc name, initfunc, cache_fns = nop_cache_fns, hwcaps = 0,  proc_fns = v7m_processor_functions
+	.long	0			/* proc_info_list.__cpu_mm_mmu_flags */
+	.long	0			/* proc_info_list.__cpu_io_mmu_flags */
+	initfn	\initfunc, \name
+	.long	cpu_arch_name
+	.long	cpu_elf_name
+	.long	HWCAP_HALF | HWCAP_THUMB | HWCAP_FAST_MULT | \hwcaps
+	.long	cpu_v7m_name
+	.long   \proc_fns
+	.long	0			/* proc_info_list.tlb */
+	.long	0			/* proc_info_list.user */
+	.long	\cache_fns
+.endm
+
+	/*
+	 * Match ARM Cortex-M4 processor.
+	 */
+	.type	__v7m_cm4_proc_info, #object
+__v7m_cm4_proc_info:
+	.long	0x410fc240		/* ARM Cortex-M4 0xC24 */
+	.long	0xff0ffff0		/* Mask off revision, patch release */
+	__v7m_proc __v7m_cm4_proc_info, __v7m_setup, hwcaps = HWCAP_EDSP
+	.size	__v7m_cm4_proc_info, . - __v7m_cm4_proc_info
+
+	/*
+	 * Match ARM Cortex-M3 processor.
+	 */
+	.type	__v7m_cm3_proc_info, #object
+__v7m_cm3_proc_info:
+	.long	0x410fc230		/* ARM Cortex-M3 0xC23 */
+	.long	0xff0ffff0		/* Mask off revision, patch release */
+	__v7m_proc __v7m_cm3_proc_info, __v7m_setup
+	.size	__v7m_cm3_proc_info, . - __v7m_cm3_proc_info
+
 	/*
 	 * Match any ARMv7-M processor core.
 	 */
@@ -139,16 +173,6 @@ ENDPROC(__v7m_setup)
 __v7m_proc_info:
 	.long	0x000f0000		@ Required ID value
 	.long	0x000f0000		@ Mask for ID
-	.long   0			@ proc_info_list.__cpu_mm_mmu_flags
-	.long   0			@ proc_info_list.__cpu_io_mmu_flags
-	initfn	__v7m_setup, __v7m_proc_info	@ proc_info_list.__cpu_flush
-	.long	cpu_arch_name
-	.long	cpu_elf_name
-	.long	HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT
-	.long	cpu_v7m_name
-	.long	v7m_processor_functions	@ proc_info_list.proc
-	.long	0			@ proc_info_list.tlb
-	.long	0			@ proc_info_list.user
-	.long	nop_cache_fns		@ proc_info_list.cache
+	__v7m_proc __v7m_proc_info, __v7m_setup
 	.size	__v7m_proc_info, . - __v7m_proc_info
 
-- 
1.7.9.5
