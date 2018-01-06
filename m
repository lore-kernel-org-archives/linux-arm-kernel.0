From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat,  6 Jan 2018 10:48:20 -0800
Subject: [PATCH 1/2] ARM: Add BTB invalidation on switch_mm for Brahma-B15
In-Reply-To: <20180106120907.26701-2-marc.zyngier@arm.com>
References: <20180106120907.26701-2-marc.zyngier@arm.com>
Message-ID: <20180106184820.11929-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/cputype.h | 4 ++++
 arch/arm/mm/proc-v7.S          | 4 ++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/cputype.h b/arch/arm/include/asm/cputype.h
index cb546425da8a..48bf5639214a 100644
--- a/arch/arm/include/asm/cputype.h
+++ b/arch/arm/include/asm/cputype.h
@@ -62,6 +62,7 @@
 	((mpidr >> (MPIDR_LEVEL_BITS * level)) & MPIDR_LEVEL_MASK)
 
 #define ARM_CPU_IMP_ARM			0x41
+#define ARM_CPU_IMP_BRCM		0x42
 #define ARM_CPU_IMP_DEC			0x44
 #define ARM_CPU_IMP_INTEL		0x69
 
@@ -82,6 +83,9 @@
 /* DEC implemented cores */
 #define ARM_CPU_PART_SA1100		0x4400a110
 
+/* Broadcom implemented cores */
+#define ARM_CPU_PART_BRAHMA_B15		0x420000f0
+
 /* Intel implemented cores */
 #define ARM_CPU_PART_SA1110		0x6900b110
 #define ARM_CPU_REV_SA1110_A0		0
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 47c1ae4e3041..0cf3e497f988 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -159,7 +159,7 @@ ENDPROC(cpu_v7_do_resume)
 #endif
 
 /*
- * Cortex-A8/A12/A15/A17 that require a BTB invalidation on switch_mm
+ * Cortex-A8/A12/A15/A17, Brahma-B15 that require a BTB invalidation on switch_mm
  */
 	globl_equ	cpu_v7_btbinv_proc_init,	cpu_v7_proc_init
 	globl_equ	cpu_v7_btbinv_proc_fin,		cpu_v7_proc_fin
@@ -678,7 +678,7 @@ __v7_ca15mp_proc_info:
 __v7_b15mp_proc_info:
 	.long	0x420f00f0
 	.long	0xff0ffff0
-	__v7_proc __v7_b15mp_proc_info, __v7_b15mp_setup, cache_fns = b15_cache_fns
+	__v7_proc __v7_b15mp_proc_info, __v7_b15mp_setup, cache_fns = b15_cache_fns, proc_fns = v7_btbinv_processor_functions
 	.size	__v7_b15mp_proc_info, . - __v7_b15mp_proc_info
 
 	/*
-- 
2.14.1
