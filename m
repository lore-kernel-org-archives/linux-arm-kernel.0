From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 25 Sep 2017 10:05:37 +0100
Subject: [PATCH v3 1/8] ARM: NOMMU: Move out MPU setup in separate module
In-Reply-To: <1506330344-31556-1-git-send-email-vladimir.murzin@arm.com>
References: <1506330344-31556-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1506330344-31556-2-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having MPU handling code in dedicated module makes it easier to
enhance/maintain it.

Tested-by: Szemz? Andr?s <sza@esh.hu>
Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/mpu.h |  16 ++-
 arch/arm/mm/Makefile       |   1 +
 arch/arm/mm/nommu.c        | 254 +------------------------------------------
 arch/arm/mm/pmsa-v7.c      | 262 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 276 insertions(+), 257 deletions(-)
 create mode 100644 arch/arm/mm/pmsa-v7.c

diff --git a/arch/arm/include/asm/mpu.h b/arch/arm/include/asm/mpu.h
index c3247cc..edec5cf 100644
--- a/arch/arm/include/asm/mpu.h
+++ b/arch/arm/include/asm/mpu.h
@@ -1,8 +1,6 @@
 #ifndef __ARM_MPU_H
 #define __ARM_MPU_H
 
-#ifdef CONFIG_ARM_MPU
-
 /* MPUIR layout */
 #define MPUIR_nU		1
 #define MPUIR_DREGION		8
@@ -69,8 +67,18 @@ struct mpu_rgn_info {
 };
 extern struct mpu_rgn_info mpu_rgn_info;
 
-#endif /* __ASSEMBLY__ */
+#ifdef CONFIG_ARM_MPU
+
+extern void __init adjust_lowmem_bounds_mpu(void);
+extern void __init mpu_setup(void);
 
-#endif /* CONFIG_ARM_MPU */
+#else
+
+static inline void adjust_lowmem_bounds_mpu(void) {}
+static inline void mpu_setup(void) {}
+
+#endif /* !CONFIG_ARM_MPU */
+
+#endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 950d19b..bdb2ec1 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_MMU)		+= fault-armv.o flush.o idmap.o ioremap.o \
 
 ifneq ($(CONFIG_MMU),y)
 obj-y				+= nommu.o
+obj-$(CONFIG_ARM_MPU)		+= pmsa-v7.o
 endif
 
 obj-$(CONFIG_ARM_PTDUMP)	+= dump.o
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 3b8e728..4c56b56 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -27,259 +27,7 @@
 
 #ifdef CONFIG_ARM_MPU
 struct mpu_rgn_info mpu_rgn_info;
-
-/* Region number */
-static void rgnr_write(u32 v)
-{
-	asm("mcr        p15, 0, %0, c6, c2, 0" : : "r" (v));
-}
-
-/* Data-side / unified region attributes */
-
-/* Region access control register */
-static void dracr_write(u32 v)
-{
-	asm("mcr        p15, 0, %0, c6, c1, 4" : : "r" (v));
-}
-
-/* Region size register */
-static void drsr_write(u32 v)
-{
-	asm("mcr        p15, 0, %0, c6, c1, 2" : : "r" (v));
-}
-
-/* Region base address register */
-static void drbar_write(u32 v)
-{
-	asm("mcr        p15, 0, %0, c6, c1, 0" : : "r" (v));
-}
-
-static u32 drbar_read(void)
-{
-	u32 v;
-	asm("mrc        p15, 0, %0, c6, c1, 0" : "=r" (v));
-	return v;
-}
-/* Optional instruction-side region attributes */
-
-/* I-side Region access control register */
-static void iracr_write(u32 v)
-{
-	asm("mcr        p15, 0, %0, c6, c1, 5" : : "r" (v));
-}
-
-/* I-side Region size register */
-static void irsr_write(u32 v)
-{
-	asm("mcr        p15, 0, %0, c6, c1, 3" : : "r" (v));
-}
-
-/* I-side Region base address register */
-static void irbar_write(u32 v)
-{
-	asm("mcr        p15, 0, %0, c6, c1, 1" : : "r" (v));
-}
-
-static unsigned long irbar_read(void)
-{
-	unsigned long v;
-	asm("mrc        p15, 0, %0, c6, c1, 1" : "=r" (v));
-	return v;
-}
-
-/* MPU initialisation functions */
-void __init adjust_lowmem_bounds_mpu(void)
-{
-	phys_addr_t phys_offset = PHYS_OFFSET;
-	phys_addr_t aligned_region_size, specified_mem_size, rounded_mem_size;
-	struct memblock_region *reg;
-	bool first = true;
-	phys_addr_t mem_start;
-	phys_addr_t mem_end;
-
-	for_each_memblock(memory, reg) {
-		if (first) {
-			/*
-			 * Initially only use memory continuous from
-			 * PHYS_OFFSET */
-			if (reg->base != phys_offset)
-				panic("First memory bank must be contiguous from PHYS_OFFSET");
-
-			mem_start = reg->base;
-			mem_end = reg->base + reg->size;
-			specified_mem_size = reg->size;
-			first = false;
-		} else {
-			/*
-			 * memblock auto merges contiguous blocks, remove
-			 * all blocks afterwards in one go (we can't remove
-			 * blocks separately while iterating)
-			 */
-			pr_notice("Ignoring RAM after %pa, memory at %pa ignored\n",
-				  &mem_end, &reg->base);
-			memblock_remove(reg->base, 0 - reg->base);
-			break;
-		}
-	}
-
-	/*
-	 * MPU has curious alignment requirements: Size must be power of 2, and
-	 * region start must be aligned to the region size
-	 */
-	if (phys_offset != 0)
-		pr_info("PHYS_OFFSET != 0 => MPU Region size constrained by alignment requirements\n");
-
-	/*
-	 * Maximum aligned region might overflow phys_addr_t if phys_offset is
-	 * 0. Hence we keep everything below 4G until we take the smaller of
-	 * the aligned_region_size and rounded_mem_size, one of which is
-	 * guaranteed to be smaller than the maximum physical address.
-	 */
-	aligned_region_size = (phys_offset - 1) ^ (phys_offset);
-	/* Find the max power-of-two sized region that fits inside our bank */
-	rounded_mem_size = (1 <<  __fls(specified_mem_size)) - 1;
-
-	/* The actual region size is the smaller of the two */
-	aligned_region_size = aligned_region_size < rounded_mem_size
-				? aligned_region_size + 1
-				: rounded_mem_size + 1;
-
-	if (aligned_region_size != specified_mem_size) {
-		pr_warn("Truncating memory from %pa to %pa (MPU region constraints)",
-				&specified_mem_size, &aligned_region_size);
-		memblock_remove(mem_start + aligned_region_size,
-				specified_mem_size - aligned_region_size);
-
-		mem_end = mem_start + aligned_region_size;
-	}
-
-	pr_debug("MPU Region from %pa size %pa (end %pa))\n",
-		&phys_offset, &aligned_region_size, &mem_end);
-
-}
-
-static int mpu_present(void)
-{
-	return ((read_cpuid_ext(CPUID_EXT_MMFR0) & MMFR0_PMSA) == MMFR0_PMSAv7);
-}
-
-static int mpu_max_regions(void)
-{
-	/*
-	 * We don't support a different number of I/D side regions so if we
-	 * have separate instruction and data memory maps then return
-	 * whichever side has a smaller number of supported regions.
-	 */
-	u32 dregions, iregions, mpuir;
-	mpuir = read_cpuid(CPUID_MPUIR);
-
-	dregions = iregions = (mpuir & MPUIR_DREGION_SZMASK) >> MPUIR_DREGION;
-
-	/* Check for separate d-side and i-side memory maps */
-	if (mpuir & MPUIR_nU)
-		iregions = (mpuir & MPUIR_IREGION_SZMASK) >> MPUIR_IREGION;
-
-	/* Use the smallest of the two maxima */
-	return min(dregions, iregions);
-}
-
-static int mpu_iside_independent(void)
-{
-	/* MPUIR.nU specifies whether there is *not* a unified memory map */
-	return read_cpuid(CPUID_MPUIR) & MPUIR_nU;
-}
-
-static int mpu_min_region_order(void)
-{
-	u32 drbar_result, irbar_result;
-	/* We've kept a region free for this probing */
-	rgnr_write(MPU_PROBE_REGION);
-	isb();
-	/*
-	 * As per ARM ARM, write 0xFFFFFFFC to DRBAR to find the minimum
-	 * region order
-	*/
-	drbar_write(0xFFFFFFFC);
-	drbar_result = irbar_result = drbar_read();
-	drbar_write(0x0);
-	/* If the MPU is non-unified, we use the larger of the two minima*/
-	if (mpu_iside_independent()) {
-		irbar_write(0xFFFFFFFC);
-		irbar_result = irbar_read();
-		irbar_write(0x0);
-	}
-	isb(); /* Ensure that MPU region operations have completed */
-	/* Return whichever result is larger */
-	return __ffs(max(drbar_result, irbar_result));
-}
-
-static int mpu_setup_region(unsigned int number, phys_addr_t start,
-			unsigned int size_order, unsigned int properties)
-{
-	u32 size_data;
-
-	/* We kept a region free for probing resolution of MPU regions*/
-	if (number > mpu_max_regions() || number == MPU_PROBE_REGION)
-		return -ENOENT;
-
-	if (size_order > 32)
-		return -ENOMEM;
-
-	if (size_order < mpu_min_region_order())
-		return -ENOMEM;
-
-	/* Writing N to bits 5:1 (RSR_SZ)  specifies region size 2^N+1 */
-	size_data = ((size_order - 1) << MPU_RSR_SZ) | 1 << MPU_RSR_EN;
-
-	dsb(); /* Ensure all previous data accesses occur with old mappings */
-	rgnr_write(number);
-	isb();
-	drbar_write(start);
-	dracr_write(properties);
-	isb(); /* Propagate properties before enabling region */
-	drsr_write(size_data);
-
-	/* Check for independent I-side registers */
-	if (mpu_iside_independent()) {
-		irbar_write(start);
-		iracr_write(properties);
-		isb();
-		irsr_write(size_data);
-	}
-	isb();
-
-	/* Store region info (we treat i/d side the same, so only store d) */
-	mpu_rgn_info.rgns[number].dracr = properties;
-	mpu_rgn_info.rgns[number].drbar = start;
-	mpu_rgn_info.rgns[number].drsr = size_data;
-	return 0;
-}
-
-/*
-* Set up default MPU regions, doing nothing if there is no MPU
-*/
-void __init mpu_setup(void)
-{
-	int region_err;
-	if (!mpu_present())
-		return;
-
-	region_err = mpu_setup_region(MPU_RAM_REGION, PHYS_OFFSET,
-					ilog2(memblock.memory.regions[0].size),
-					MPU_AP_PL1RW_PL0RW | MPU_RGN_NORMAL);
-	if (region_err) {
-		panic("MPU region initialization failure! %d", region_err);
-	} else {
-		pr_info("Using ARMv7 PMSA Compliant MPU. "
-			 "Region independence: %s, Max regions: %d\n",
-			mpu_iside_independent() ? "Yes" : "No",
-			mpu_max_regions());
-	}
-}
-#else
-static void adjust_lowmem_bounds_mpu(void) {}
-static void __init mpu_setup(void) {}
-#endif /* CONFIG_ARM_MPU */
+#endif
 
 #ifdef CONFIG_CPU_CP15
 #ifdef CONFIG_CPU_HIGH_VECTOR
diff --git a/arch/arm/mm/pmsa-v7.c b/arch/arm/mm/pmsa-v7.c
new file mode 100644
index 0000000..ee3cf51
--- /dev/null
+++ b/arch/arm/mm/pmsa-v7.c
@@ -0,0 +1,262 @@
+/*
+ *  linux/arch/arm/mm/nommu.c
+ *
+ * ARM uCLinux supporting functions.
+ */
+
+#include <linux/memblock.h>
+
+#include <asm/cp15.h>
+#include <asm/cputype.h>
+#include <asm/mpu.h>
+
+#include "mm.h"
+
+/* Region number */
+static void rgnr_write(u32 v)
+{
+	asm("mcr        p15, 0, %0, c6, c2, 0" : : "r" (v));
+}
+
+/* Data-side / unified region attributes */
+
+/* Region access control register */
+static void dracr_write(u32 v)
+{
+	asm("mcr        p15, 0, %0, c6, c1, 4" : : "r" (v));
+}
+
+/* Region size register */
+static void drsr_write(u32 v)
+{
+	asm("mcr        p15, 0, %0, c6, c1, 2" : : "r" (v));
+}
+
+/* Region base address register */
+static void drbar_write(u32 v)
+{
+	asm("mcr        p15, 0, %0, c6, c1, 0" : : "r" (v));
+}
+
+static u32 drbar_read(void)
+{
+	u32 v;
+	asm("mrc        p15, 0, %0, c6, c1, 0" : "=r" (v));
+	return v;
+}
+/* Optional instruction-side region attributes */
+
+/* I-side Region access control register */
+static void iracr_write(u32 v)
+{
+	asm("mcr        p15, 0, %0, c6, c1, 5" : : "r" (v));
+}
+
+/* I-side Region size register */
+static void irsr_write(u32 v)
+{
+	asm("mcr        p15, 0, %0, c6, c1, 3" : : "r" (v));
+}
+
+/* I-side Region base address register */
+static void irbar_write(u32 v)
+{
+	asm("mcr        p15, 0, %0, c6, c1, 1" : : "r" (v));
+}
+
+static unsigned long irbar_read(void)
+{
+	unsigned long v;
+	asm("mrc        p15, 0, %0, c6, c1, 1" : "=r" (v));
+	return v;
+}
+
+/* MPU initialisation functions */
+void __init adjust_lowmem_bounds_mpu(void)
+{
+	phys_addr_t phys_offset = PHYS_OFFSET;
+	phys_addr_t aligned_region_size, specified_mem_size, rounded_mem_size;
+	struct memblock_region *reg;
+	bool first = true;
+	phys_addr_t mem_start;
+	phys_addr_t mem_end;
+
+	for_each_memblock(memory, reg) {
+		if (first) {
+			/*
+			 * Initially only use memory continuous from
+			 * PHYS_OFFSET */
+			if (reg->base != phys_offset)
+				panic("First memory bank must be contiguous from PHYS_OFFSET");
+
+			mem_start = reg->base;
+			mem_end = reg->base + reg->size;
+			specified_mem_size = reg->size;
+			first = false;
+		} else {
+			/*
+			 * memblock auto merges contiguous blocks, remove
+			 * all blocks afterwards in one go (we can't remove
+			 * blocks separately while iterating)
+			 */
+			pr_notice("Ignoring RAM after %pa, memory at %pa ignored\n",
+				  &mem_end, &reg->base);
+			memblock_remove(reg->base, 0 - reg->base);
+			break;
+		}
+	}
+
+	/*
+	 * MPU has curious alignment requirements: Size must be power of 2, and
+	 * region start must be aligned to the region size
+	 */
+	if (phys_offset != 0)
+		pr_info("PHYS_OFFSET != 0 => MPU Region size constrained by alignment requirements\n");
+
+	/*
+	 * Maximum aligned region might overflow phys_addr_t if phys_offset is
+	 * 0. Hence we keep everything below 4G until we take the smaller of
+	 * the aligned_region_size and rounded_mem_size, one of which is
+	 * guaranteed to be smaller than the maximum physical address.
+	 */
+	aligned_region_size = (phys_offset - 1) ^ (phys_offset);
+	/* Find the max power-of-two sized region that fits inside our bank */
+	rounded_mem_size = (1 <<  __fls(specified_mem_size)) - 1;
+
+	/* The actual region size is the smaller of the two */
+	aligned_region_size = aligned_region_size < rounded_mem_size
+				? aligned_region_size + 1
+				: rounded_mem_size + 1;
+
+	if (aligned_region_size != specified_mem_size) {
+		pr_warn("Truncating memory from %pa to %pa (MPU region constraints)",
+				&specified_mem_size, &aligned_region_size);
+		memblock_remove(mem_start + aligned_region_size,
+				specified_mem_size - aligned_region_size);
+
+		mem_end = mem_start + aligned_region_size;
+	}
+
+	pr_debug("MPU Region from %pa size %pa (end %pa))\n",
+		&phys_offset, &aligned_region_size, &mem_end);
+
+}
+
+static int mpu_present(void)
+{
+	return ((read_cpuid_ext(CPUID_EXT_MMFR0) & MMFR0_PMSA) == MMFR0_PMSAv7);
+}
+
+static int mpu_max_regions(void)
+{
+	/*
+	 * We don't support a different number of I/D side regions so if we
+	 * have separate instruction and data memory maps then return
+	 * whichever side has a smaller number of supported regions.
+	 */
+	u32 dregions, iregions, mpuir;
+	mpuir = read_cpuid(CPUID_MPUIR);
+
+	dregions = iregions = (mpuir & MPUIR_DREGION_SZMASK) >> MPUIR_DREGION;
+
+	/* Check for separate d-side and i-side memory maps */
+	if (mpuir & MPUIR_nU)
+		iregions = (mpuir & MPUIR_IREGION_SZMASK) >> MPUIR_IREGION;
+
+	/* Use the smallest of the two maxima */
+	return min(dregions, iregions);
+}
+
+static int mpu_iside_independent(void)
+{
+	/* MPUIR.nU specifies whether there is *not* a unified memory map */
+	return read_cpuid(CPUID_MPUIR) & MPUIR_nU;
+}
+
+static int mpu_min_region_order(void)
+{
+	u32 drbar_result, irbar_result;
+	/* We've kept a region free for this probing */
+	rgnr_write(MPU_PROBE_REGION);
+	isb();
+	/*
+	 * As per ARM ARM, write 0xFFFFFFFC to DRBAR to find the minimum
+	 * region order
+	*/
+	drbar_write(0xFFFFFFFC);
+	drbar_result = irbar_result = drbar_read();
+	drbar_write(0x0);
+	/* If the MPU is non-unified, we use the larger of the two minima*/
+	if (mpu_iside_independent()) {
+		irbar_write(0xFFFFFFFC);
+		irbar_result = irbar_read();
+		irbar_write(0x0);
+	}
+	isb(); /* Ensure that MPU region operations have completed */
+	/* Return whichever result is larger */
+	return __ffs(max(drbar_result, irbar_result));
+}
+
+static int mpu_setup_region(unsigned int number, phys_addr_t start,
+			unsigned int size_order, unsigned int properties)
+{
+	u32 size_data;
+
+	/* We kept a region free for probing resolution of MPU regions*/
+	if (number > mpu_max_regions() || number == MPU_PROBE_REGION)
+		return -ENOENT;
+
+	if (size_order > 32)
+		return -ENOMEM;
+
+	if (size_order < mpu_min_region_order())
+		return -ENOMEM;
+
+	/* Writing N to bits 5:1 (RSR_SZ)  specifies region size 2^N+1 */
+	size_data = ((size_order - 1) << MPU_RSR_SZ) | 1 << MPU_RSR_EN;
+
+	dsb(); /* Ensure all previous data accesses occur with old mappings */
+	rgnr_write(number);
+	isb();
+	drbar_write(start);
+	dracr_write(properties);
+	isb(); /* Propagate properties before enabling region */
+	drsr_write(size_data);
+
+	/* Check for independent I-side registers */
+	if (mpu_iside_independent()) {
+		irbar_write(start);
+		iracr_write(properties);
+		isb();
+		irsr_write(size_data);
+	}
+	isb();
+
+	/* Store region info (we treat i/d side the same, so only store d) */
+	mpu_rgn_info.rgns[number].dracr = properties;
+	mpu_rgn_info.rgns[number].drbar = start;
+	mpu_rgn_info.rgns[number].drsr = size_data;
+	return 0;
+}
+
+/*
+* Set up default MPU regions, doing nothing if there is no MPU
+*/
+void __init mpu_setup(void)
+{
+	int region_err;
+	if (!mpu_present())
+		return;
+
+	region_err = mpu_setup_region(MPU_RAM_REGION, PHYS_OFFSET,
+					ilog2(memblock.memory.regions[0].size),
+					MPU_AP_PL1RW_PL0RW | MPU_RGN_NORMAL);
+	if (region_err) {
+		panic("MPU region initialization failure! %d", region_err);
+	} else {
+		pr_info("Using ARMv7 PMSA Compliant MPU. "
+			 "Region independence: %s, Max regions: %d\n",
+			mpu_iside_independent() ? "Yes" : "No",
+			mpu_max_regions());
+	}
+}
-- 
1.9.1
