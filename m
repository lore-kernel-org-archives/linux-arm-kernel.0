From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 25 Sep 2017 10:05:44 +0100
Subject: [PATCH v3 8/8] ARM: NOMMU: Support MPU in XIP configuration
In-Reply-To: <1506330344-31556-1-git-send-email-vladimir.murzin@arm.com>
References: <1506330344-31556-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1506330344-31556-9-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, there is assumption in early MPU setup code that kernel
image is located in RAM, which is obviously not true for XIP. To run
code from ROM we need to make sure that it is covered by MPU. However,
due to we allocate regions (semi-)dynamically we can run into issue of
trimming region we are running from in case ROM spawns several MPU
regions. To help deal with that we enforce minimum alignments for start
end end of XIP address space as 1MB and 128Kb correspondingly.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/Kconfig-nommu            |  2 +-
 arch/arm/include/asm/mpu.h        |  3 ++-
 arch/arm/kernel/head-nommu.S      | 20 ++++++++++++++++
 arch/arm/kernel/vmlinux-xip.lds.S | 23 ++++++++++++++++++
 arch/arm/mm/pmsa-v7.c             | 49 +++++++++++++++++++++++++++++++++++----
 5 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/arch/arm/Kconfig-nommu b/arch/arm/Kconfig-nommu
index 930e000..0fad7d9 100644
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
diff --git a/arch/arm/include/asm/mpu.h b/arch/arm/include/asm/mpu.h
index 5db37a6..56ec026 100644
--- a/arch/arm/include/asm/mpu.h
+++ b/arch/arm/include/asm/mpu.h
@@ -41,6 +41,7 @@
 #endif
 
 /* Access permission bits of ACR (only define those that we use)*/
+#define MPU_AP_PL1RO_PL0NA	(0x5 << 8)
 #define MPU_AP_PL1RW_PL0RW	(0x3 << 8)
 #define MPU_AP_PL1RW_PL0R0	(0x2 << 8)
 #define MPU_AP_PL1RW_PL0NA	(0x1 << 8)
@@ -49,7 +50,7 @@
 #define MPU_PROBE_REGION	0
 #define MPU_BG_REGION		1
 #define MPU_RAM_REGION		2
-#define MPU_VECTORS_REGION	3
+#define MPU_ROM_REGION		3
 
 /* Maximum number of regions Linux is interested in */
 #define MPU_MAX_REGIONS		16
diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 8a0718f..2ce4455 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -279,6 +279,26 @@ M_CLASS(ldr    r0, [r12, #MPU_TYPE])
 	setup_region r0, r5, r6, MPU_INSTR_SIDE r12	@ 0x0, BG region, enabled
 2:	isb
 
+#ifdef CONFIG_XIP_KERNEL
+	set_region_nr r0, #MPU_ROM_REGION, r12
+	isb
+
+	ldr	r5,=(MPU_AP_PL1RO_PL0NA | MPU_RGN_NORMAL)
+
+	ldr	r0, =CONFIG_XIP_PHYS_ADDR		@ ROM start
+	ldr     r6, =(_exiprom)				@ ROM end
+	sub	r6, r6, r0				@ Minimum size of region to map
+	clz	r6, r6					@ Region size must be 2^N...
+	rsb	r6, r6, #31				@ ...so round up region size
+	lsl	r6, r6, #MPU_RSR_SZ			@ Put size in right field
+	orr	r6, r6, #(1 << MPU_RSR_EN)		@ Set region enabled bit
+
+	setup_region r0, r5, r6, MPU_DATA_SIDE, r12	@ XIP_PHYS_ADDR, shared, enabled
+	beq	3f					@ Memory-map not unified
+	setup_region r0, r5, r6, MPU_INSTR_SIDE, r12	@ XIP_PHYS_ADDR, shared, enabled
+3:	isb
+#endif
+
 	/* Enable the MPU */
 AR_CLASS(mrc	p15, 0, r0, c1, c0, 0)		@ Read SCTLR
 AR_CLASS(bic	r0, r0, #CR_BR)			@ Disable the 'default mem-map'
diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 8265b11..c6f7056 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -6,6 +6,8 @@
 /* No __ro_after_init data in the .rodata section - which will always be ro */
 #define RO_AFTER_INIT_DATA
 
+#include <linux/sizes.h>
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
 #include <asm/thread_info.h>
@@ -205,6 +207,9 @@ SECTIONS
 	PERCPU_SECTION(L1_CACHE_BYTES)
 #endif
 
+#ifdef CONFIG_ARM_MPU
+	. = ALIGN(SZ_128K);
+#endif
 	_exiprom = .;			/* End of XIP ROM area */
 	__data_loc = ALIGN(4);		/* location in binary */
 	. = PAGE_OFFSET + TEXT_OFFSET;
@@ -322,3 +327,21 @@ ASSERT((__arch_info_end - __arch_info_begin), "no machine record defined")
  */
 ASSERT(__hyp_idmap_text_end - (__hyp_idmap_text_start & PAGE_MASK) <= PAGE_SIZE,
 	"HYP init code too big or misaligned")
+
+#ifdef CONFIG_ARM_MPU
+/*
+ * Due to PMSAv7 restriction on base address and size we have to
+ * enforce minimal alignment restrictions. It was seen that weaker
+ * alignment restriction on _xiprom will likely force XIP address
+ * space spawns multiple MPU regions thus it is likely we run in
+ * situation when we are reprogramming MPU region we run on with
+ * something which doesn't cover reprogramming code itself, so as soon
+ * as we update MPU settings we'd immediately try to execute straight
+ * from background region which is XN.
+ * It seem that alignment in 1M should suit most users.
+ * _exiprom is aligned as 1/8 of 1M so can be covered by subregion
+ * disable
+ */
+ASSERT(!(_xiprom & (SZ_1M - 1)), "XIP start address may cause MPU programming issues")
+ASSERT(!(_exiprom & (SZ_128K - 1)), "XIP end address may cause MPU programming issues")
+#endif
diff --git a/arch/arm/mm/pmsa-v7.c b/arch/arm/mm/pmsa-v7.c
index c1f1fc7..27434d7 100644
--- a/arch/arm/mm/pmsa-v7.c
+++ b/arch/arm/mm/pmsa-v7.c
@@ -7,9 +7,11 @@
 #include <linux/bitops.h>
 #include <linux/memblock.h>
 
+#include <asm/cacheflush.h>
 #include <asm/cp15.h>
 #include <asm/cputype.h>
 #include <asm/mpu.h>
+#include <asm/sections.h>
 
 #include "mm.h"
 
@@ -20,6 +22,9 @@ struct region {
 };
 
 static struct region __initdata mem[MPU_MAX_REGIONS];
+#ifdef CONFIG_XIP_KERNEL
+static struct region __initdata xip[MPU_MAX_REGIONS];
+#endif
 
 static unsigned int __initdata mpu_min_region_order;
 static unsigned int __initdata mpu_max_regions;
@@ -229,7 +234,6 @@ static int __init allocate_region(phys_addr_t base, phys_addr_t size,
 /* MPU initialisation functions */
 void __init adjust_lowmem_bounds_mpu(void)
 {
-	phys_addr_t phys_offset = PHYS_OFFSET;
 	phys_addr_t  specified_mem_size, total_mem_size = 0;
 	struct memblock_region *reg;
 	bool first = true;
@@ -256,8 +260,19 @@ void __init adjust_lowmem_bounds_mpu(void)
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
@@ -355,7 +370,7 @@ static int __init __mpu_min_region_order(void)
 
 static int __init mpu_setup_region(unsigned int number, phys_addr_t start,
 				   unsigned int size_order, unsigned int properties,
-				   unsigned int subregions)
+				   unsigned int subregions, bool need_flush)
 {
 	u32 size_data;
 
@@ -374,6 +389,9 @@ static int __init mpu_setup_region(unsigned int number, phys_addr_t start,
 	size_data = ((size_order - 1) << MPU_RSR_SZ) | 1 << MPU_RSR_EN;
 	size_data |= subregions << MPU_RSR_SD;
 
+	if (need_flush)
+		flush_cache_all();
+
 	dsb(); /* Ensure all previous data accesses occur with old mappings */
 	rgnr_write(number);
 	isb();
@@ -416,7 +434,28 @@ void __init mpu_setup(void)
 	/* Background */
 	err |= mpu_setup_region(region++, 0, 32,
 				MPU_ACR_XN | MPU_RGN_STRONGLY_ORDERED | MPU_AP_PL1RW_PL0NA,
-				0);
+				0, false);
+
+#ifdef CONFIG_XIP_KERNEL
+	/* ROM */
+	for (i = 0; i < ARRAY_SIZE(xip); i++) {
+		/*
+                 * In case we overwrite RAM region we set earlier in
+                 * head-nommu.S (which is cachable) all subsequent
+                 * data access till we setup RAM bellow would be done
+                 * with BG region (which is uncachable), thus we need
+                 * to clean and invalidate cache.
+		 */
+		bool need_flush = region == MPU_RAM_REGION;
+
+		if (!xip[i].size)
+			continue;
+
+		err |= mpu_setup_region(region++, xip[i].base, ilog2(xip[i].size),
+					MPU_AP_PL1RO_PL0NA | MPU_RGN_NORMAL,
+					xip[i].subreg, need_flush);
+	}
+#endif
 
 	/* RAM */
 	for (i = 0; i < ARRAY_SIZE(mem); i++) {
@@ -425,14 +464,14 @@ void __init mpu_setup(void)
 
 		err |= mpu_setup_region(region++, mem[i].base, ilog2(mem[i].size),
 					MPU_AP_PL1RW_PL0RW | MPU_RGN_NORMAL,
-					mem[i].subreg);
+					mem[i].subreg, false);
 	}
 
 	/* Vectors */
 #ifndef CONFIG_CPU_V7M
 	err |= mpu_setup_region(region++, vectors_base, ilog2(2 * PAGE_SIZE),
 				MPU_AP_PL1RW_PL0NA | MPU_RGN_NORMAL,
-				0);
+				0, false);
 #endif
 	if (err) {
 		panic("MPU region initialization failure! %d", err);
-- 
1.9.1
