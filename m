From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri, 21 Jul 2017 14:12:36 +0100
Subject: [PATCH v2 8/8] ARM: NOMMU: Support MPU in XIP configuration
In-Reply-To: <1500642756-9264-1-git-send-email-vladimir.murzin@arm.com>
References: <1500642756-9264-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1500642756-9264-9-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, there is assumption in early MPU setup code that kernel
image is located in RAM, which is obviously not true for XIP. To run
code from ROM we need to make sure that it is covered by MPU. However,
due to we allocate regions (semi-)dynamically we can run into issue of
trimming region we are running from in case ROM spawns several MPU
regions. To help deal with that the new config option is introduced
which basically allows to construct ROM layout in MPU friendly
fashion.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/Kconfig-nommu            | 15 ++++++++++++++-
 arch/arm/include/asm/mpu.h        |  1 +
 arch/arm/kernel/head-nommu.S      | 10 ++++++++++
 arch/arm/kernel/vmlinux-xip.lds.S |  3 +++
 arch/arm/mm/pmsa-v7.c             | 28 +++++++++++++++++++++++++++-
 5 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig-nommu b/arch/arm/Kconfig-nommu
index 930e000..79c2af7 100644
--- a/arch/arm/Kconfig-nommu
+++ b/arch/arm/Kconfig-nommu
@@ -52,7 +52,7 @@ config REMAP_VECTORS_TO_RAM
 
 config ARM_MPU
        bool 'Use the ARM v7 PMSA Compliant MPU'
-       depends on !XIP_KERNEL && (CPU_V7 || CPU_V7M)
+       depends on CPU_V7 || CPU_V7M
        default y if CPU_V7
        help
          Some ARM systems without an MMU have instead a Memory Protection
@@ -61,3 +61,16 @@ config ARM_MPU
 
          If your CPU has an MPU then you should choose 'y' here unless you
          know that you do not want to use the MPU.
+
+config ARM_MPU_MINALIGN
+	hex "Minimum alignment of MPU region"
+	depends on ARM_MPU && XIP_KERNEL
+	default "0x100000"
+	help
+	  PMSAv7 defines following restrictions to the regions:
+	    * size must be power of 2, and
+	    * region start must be aligned to the region size
+	  With a XIP kernel we need to make sure that (almost) all kernel image
+	  is covered by MPU, so we will not trim region we are running from.
+	  To help with that this option is given. Along with XIP_PHYS_ADDR it
+	  allows to adopt kernel layout to meet aforementioned requirements.
diff --git a/arch/arm/include/asm/mpu.h b/arch/arm/include/asm/mpu.h
index 5db37a6..65699f3 100644
--- a/arch/arm/include/asm/mpu.h
+++ b/arch/arm/include/asm/mpu.h
@@ -41,6 +41,7 @@
 #endif
 
 /* Access permission bits of ACR (only define those that we use)*/
+#define MPU_AP_PL1RO_PL0NA	(0x5 << 8)
 #define MPU_AP_PL1RW_PL0RW	(0x3 << 8)
 #define MPU_AP_PL1RW_PL0R0	(0x2 << 8)
 #define MPU_AP_PL1RW_PL0NA	(0x1 << 8)
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 0d64b8b..5674c2e 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -69,8 +69,13 @@ ENTRY(stext)
 
 #ifdef CONFIG_ARM_MPU
 	/* Calculate the size of a region covering just the kernel */
+#ifndef CONFIG_XIP_KERNEL
 	ldr	r5, =PLAT_PHYS_OFFSET		@ Region start: PHYS_OFFSET
 	ldr     r6, =(_end)			@ Cover whole kernel
+#else
+	ldr	r5, =CONFIG_XIP_PHYS_ADDR	@ ROM start
+	ldr     r6, =(_exiprom)			@ ROM end
+#endif
 	sub	r6, r6, r5			@ Minimum size of region to map
 	clz	r6, r6				@ Region size must be 2^N...
 	rsb	r6, r6, #31			@ ...so round up region size
@@ -237,8 +242,13 @@ M_CLASS(ldr    r0, [r12, #MPU_TYPE])
 	set_region_nr r0, #MPU_RAM_REGION, r12
 	isb
 	/* Full access from PL0, PL1, shared for CONFIG_SMP, cacheable */
+#ifndef CONFIG_XIP_KERNEL
 	ldr	r0, =PLAT_PHYS_OFFSET		@ RAM starts@PHYS_OFFSET
 	ldr	r5,=(MPU_AP_PL1RW_PL0RW | MPU_RGN_NORMAL)
+#else
+	ldr	r0, =CONFIG_XIP_PHYS_ADDR	@ ROM start
+	ldr	r5,=(MPU_AP_PL1RO_PL0NA | MPU_RGN_NORMAL)
+#endif
 
 	setup_region r0, r5, r6, MPU_DATA_SIDE, r12	@ PHYS_OFFSET, shared, enabled
 	beq	1f					@ Memory-map not unified
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 8265b11..b7344d5 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -205,6 +205,9 @@ SECTIONS
 	PERCPU_SECTION(L1_CACHE_BYTES)
 #endif
 
+#ifdef CONFIG_ARM_MPU
+	. = ALIGN(CONFIG_ARM_MPU_MINALIGN);
+#endif
 	_exiprom = .;			/* End of XIP ROM area */
 	__data_loc = ALIGN(4);		/* location in binary */
 	. = PAGE_OFFSET + TEXT_OFFSET;
diff --git a/arch/arm/mm/pmsa-v7.c b/arch/arm/mm/pmsa-v7.c
index c1f1fc7..808384b 100644
--- a/arch/arm/mm/pmsa-v7.c
+++ b/arch/arm/mm/pmsa-v7.c
@@ -10,6 +10,7 @@
 #include <asm/cp15.h>
 #include <asm/cputype.h>
 #include <asm/mpu.h>
+#include <asm/sections.h>
 
 #include "mm.h"
 
@@ -20,6 +21,9 @@ struct region {
 };
 
 static struct region __initdata mem[MPU_MAX_REGIONS];
+#ifdef CONFIG_XIP_KERNEL
+static struct region __initdata xip[MPU_MAX_REGIONS];
+#endif
 
 static unsigned int __initdata mpu_min_region_order;
 static unsigned int __initdata mpu_max_regions;
@@ -229,7 +233,6 @@ static int __init allocate_region(phys_addr_t base, phys_addr_t size,
 /* MPU initialisation functions */
 void __init adjust_lowmem_bounds_mpu(void)
 {
-	phys_addr_t phys_offset = PHYS_OFFSET;
 	phys_addr_t  specified_mem_size, total_mem_size = 0;
 	struct memblock_region *reg;
 	bool first = true;
@@ -256,8 +259,19 @@ void __init adjust_lowmem_bounds_mpu(void)
 	/* ... and one for vectors */
 	mem_max_regions--;
 #endif
+
+#ifdef CONFIG_XIP_KERNEL
+	/* plus some regions to cover XIP ROM */
+	num = allocate_region(CONFIG_XIP_PHYS_ADDR, __pa(_exiprom) - CONFIG_XIP_PHYS_ADDR,
+			      mem_max_regions, xip);
+
+	mem_max_regions -= num;
+#endif
+
 	for_each_memblock(memory, reg) {
 		if (first) {
+			phys_addr_t phys_offset = PHYS_OFFSET;
+
 			/*
 			 * Initially only use memory continuous from
 			 * PHYS_OFFSET */
@@ -418,6 +432,18 @@ void __init mpu_setup(void)
 				MPU_ACR_XN | MPU_RGN_STRONGLY_ORDERED | MPU_AP_PL1RW_PL0NA,
 				0);
 
+#ifdef CONFIG_XIP_KERNEL
+	/* ROM */
+	for (i = 0; i < ARRAY_SIZE(xip); i++) {
+		if (!xip[i].size)
+			continue;
+
+		err |= mpu_setup_region(region++, xip[i].base, ilog2(xip[i].size),
+					MPU_AP_PL1RO_PL0NA | MPU_RGN_NORMAL,
+					xip[i].subreg);
+	}
+#endif
+
 	/* RAM */
 	for (i = 0; i < ARRAY_SIZE(mem); i++) {
 		if (!mem[i].size)
-- 
2.0.0
