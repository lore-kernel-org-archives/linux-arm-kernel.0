From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 25 Sep 2017 10:05:43 +0100
Subject: [PATCH v3 7/8] ARM: NOMMU: Use more MPU regions to cover memory
In-Reply-To: <1506330344-31556-1-git-send-email-vladimir.murzin@arm.com>
References: <1506330344-31556-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1506330344-31556-8-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PMSAv7 defines curious alignment requirements to the regions:
- size must be power of 2, and
- region start must be aligned to the region size

Because of that we currently adjust lowmem bounds plus we assign
only one MPU region to cover memory all these lead to significant amount of
memory could be wasted. As an example, consider 64Mb of memory at
0x70000000 - it fits alignment requirements nicely; now, imagine that
2Mb of memory is reserved for coherent DMA allocation, so now Linux is
expected to see 62Mb of memory... and here annoying thing happens -
memory gets truncated to 32Mb (we've lost 30Mb!), i.e. MPU layout
looks like:

0: base 0x70000000, size 0x2000000

This patch tries to allocate as much as possible MPU slots to minimise
amount of truncated memory. Moreover, with this patch MPU subregions
starting to get used. MPU subregions allow us reduce the number of MPU
slots used. For example given above, MPU layout looks like:

0: base 0x70000000, size 0x2000000
1: base 0x72000000, size 0x1000000
2: base 0x73000000, size 0x1000000, disable subreg 7 (0x73e00000 - 0x73ffffff)

Where without subregions we'd get:

0: base 0x70000000, size 0x2000000
1: base 0x72000000, size 0x1000000
2: base 0x73000000, size 0x800000
3: base 0x73800000, size 0x400000
4: base 0x73c00000, size 0x200000

To achieve better layout we fist try to cover specified memory as is
(maybe with help of subregions) and if we failed, we truncate memory
to fit alignment requirements (so it occupies one MPU slot) and
perform one more attempt with the reminder, and so on till we either
cover all memory or run out of MPU slots.

Tested-by: Szemz? Andr?s <sza@esh.hu>
Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/include/asm/mpu.h |   5 ++
 arch/arm/mm/pmsa-v7.c      | 190 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 149 insertions(+), 46 deletions(-)

diff --git a/arch/arm/include/asm/mpu.h b/arch/arm/include/asm/mpu.h
index 403462e..5db37a6 100644
--- a/arch/arm/include/asm/mpu.h
+++ b/arch/arm/include/asm/mpu.h
@@ -15,6 +15,11 @@
 /* MPU D/I Size Register fields */
 #define MPU_RSR_SZ		1
 #define MPU_RSR_EN		0
+#define MPU_RSR_SD		8
+
+/* Number of subregions (SD) */
+#define MPU_NR_SUBREGS		8
+#define MPU_MIN_SUBREG_SIZE	256
 
 /* The D/I RSR value for an enabled region spanning the whole of memory */
 #define MPU_RSR_ALL_MEM		63
diff --git a/arch/arm/mm/pmsa-v7.c b/arch/arm/mm/pmsa-v7.c
index 72f1a9f..c1f1fc7 100644
--- a/arch/arm/mm/pmsa-v7.c
+++ b/arch/arm/mm/pmsa-v7.c
@@ -4,6 +4,7 @@
  * ARM uCLinux supporting functions.
  */
 
+#include <linux/bitops.h>
 #include <linux/memblock.h>
 
 #include <asm/cp15.h>
@@ -12,9 +13,20 @@
 
 #include "mm.h"
 
+struct region {
+	phys_addr_t base;
+	phys_addr_t size;
+	unsigned long subreg;
+};
+
+static struct region __initdata mem[MPU_MAX_REGIONS];
+
 static unsigned int __initdata mpu_min_region_order;
 static unsigned int __initdata mpu_max_regions;
 
+static int __init __mpu_min_region_order(void);
+static int __init __mpu_max_regions(void);
+
 #ifndef CONFIG_CPU_V7M
 
 #define DRBAR	__ACCESS_CP15(c6, 0, c1, 0)
@@ -130,19 +142,120 @@ static int __init mpu_present(void)
 	return ((read_cpuid_ext(CPUID_EXT_MMFR0) & MMFR0_PMSA) == MMFR0_PMSAv7);
 }
 
+static bool __init try_split_region(phys_addr_t base, phys_addr_t size, struct region *region)
+{
+	unsigned long  subreg, bslots, sslots;
+	phys_addr_t abase = base & ~(size - 1);
+	phys_addr_t asize = base + size - abase;
+	phys_addr_t p2size = 1 << __fls(asize);
+	phys_addr_t bdiff, sdiff;
+
+	if (p2size != asize)
+		p2size *= 2;
+
+	bdiff = base - abase;
+	sdiff = p2size - asize;
+	subreg = p2size / MPU_NR_SUBREGS;
+
+	if ((bdiff % subreg) || (sdiff % subreg))
+		return false;
+
+	bslots = bdiff / subreg;
+	sslots = sdiff / subreg;
+
+	if (bslots || sslots) {
+		int i;
+
+		if (subreg < MPU_MIN_SUBREG_SIZE)
+			return false;
+
+		if (bslots + sslots > MPU_NR_SUBREGS)
+			return false;
+
+		for (i = 0; i < bslots; i++)
+			_set_bit(i, &region->subreg);
+
+		for (i = 1; i <= sslots; i++)
+			_set_bit(MPU_NR_SUBREGS - i, &region->subreg);
+	}
+
+	region->base = abase;
+	region->size = p2size;
+
+	return true;
+}
+
+static int __init allocate_region(phys_addr_t base, phys_addr_t size,
+				  unsigned int limit, struct region *regions)
+{
+	int count = 0;
+	phys_addr_t diff = size;
+	int attempts = MPU_MAX_REGIONS;
+
+	while (diff) {
+		/* Try cover region as is (maybe with help of subregions) */
+		if (try_split_region(base, size, &regions[count])) {
+			count++;
+			base += size;
+			diff -= size;
+			size = diff;
+		} else {
+			/*
+			 * Maximum aligned region might overflow phys_addr_t
+			 * if "base" is 0. Hence we keep everything below 4G
+			 * until we take the smaller of the aligned region
+			 * size ("asize") and rounded region size ("p2size"),
+			 * one of which is guaranteed to be smaller than the
+			 * maximum physical address.
+			 */
+			phys_addr_t asize = (base - 1) ^ base;
+			phys_addr_t p2size = (1 <<  __fls(diff)) - 1;
+
+			size = asize < p2size ? asize + 1 : p2size + 1;
+		}
+
+		if (count > limit)
+			break;
+
+		if (!attempts)
+			break;
+
+		attempts--;
+	}
+
+	return count;
+}
+
 /* MPU initialisation functions */
 void __init adjust_lowmem_bounds_mpu(void)
 {
 	phys_addr_t phys_offset = PHYS_OFFSET;
-	phys_addr_t aligned_region_size, specified_mem_size, rounded_mem_size;
+	phys_addr_t  specified_mem_size, total_mem_size = 0;
 	struct memblock_region *reg;
 	bool first = true;
 	phys_addr_t mem_start;
 	phys_addr_t mem_end;
+	unsigned int mem_max_regions;
+	int num, i;
 
 	if (!mpu_present())
 		return;
 
+	/* Free-up MPU_PROBE_REGION */
+	mpu_min_region_order = __mpu_min_region_order();
+
+	/* How many regions are supported */
+	mpu_max_regions = __mpu_max_regions();
+
+	mem_max_regions = min((unsigned int)MPU_MAX_REGIONS, mpu_max_regions);
+
+	/* We need to keep one slot for background region */
+	mem_max_regions--;
+
+#ifndef CONFIG_CPU_V7M
+	/* ... and one for vectors */
+	mem_max_regions--;
+#endif
 	for_each_memblock(memory, reg) {
 		if (first) {
 			/*
@@ -168,40 +281,23 @@ void __init adjust_lowmem_bounds_mpu(void)
 		}
 	}
 
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
+	num = allocate_region(mem_start, specified_mem_size, mem_max_regions, mem);
 
-	/* The actual region size is the smaller of the two */
-	aligned_region_size = aligned_region_size < rounded_mem_size
-				? aligned_region_size + 1
-				: rounded_mem_size + 1;
+	for (i = 0; i < num; i++) {
+		unsigned long  subreg = mem[i].size / MPU_NR_SUBREGS;
 
-	if (aligned_region_size != specified_mem_size) {
-		pr_warn("Truncating memory from %pa to %pa (MPU region constraints)",
-				&specified_mem_size, &aligned_region_size);
-		memblock_remove(mem_start + aligned_region_size,
-				specified_mem_size - aligned_region_size);
+		total_mem_size += mem[i].size - subreg * hweight_long(mem[i].subreg);
 
-		mem_end = mem_start + aligned_region_size;
+		pr_debug("MPU: base %pa size %pa disable subregions: %*pbl\n",
+			 &mem[i].base, &mem[i].size, MPU_NR_SUBREGS, &mem[i].subreg);
 	}
 
-	pr_debug("MPU Region from %pa size %pa (end %pa))\n",
-		&phys_offset, &aligned_region_size, &mem_end);
-
+	if (total_mem_size != specified_mem_size) {
+		pr_warn("Truncating memory from %pa to %pa (MPU region constraints)",
+				&specified_mem_size, &total_mem_size);
+		memblock_remove(mem_start + total_mem_size,
+				specified_mem_size - total_mem_size);
+	}
 }
 
 static int __init __mpu_max_regions(void)
@@ -258,7 +354,8 @@ static int __init __mpu_min_region_order(void)
 }
 
 static int __init mpu_setup_region(unsigned int number, phys_addr_t start,
-			unsigned int size_order, unsigned int properties)
+				   unsigned int size_order, unsigned int properties,
+				   unsigned int subregions)
 {
 	u32 size_data;
 
@@ -275,6 +372,7 @@ static int __init mpu_setup_region(unsigned int number, phys_addr_t start,
 
 	/* Writing N to bits 5:1 (RSR_SZ)  specifies region size 2^N+1 */
 	size_data = ((size_order - 1) << MPU_RSR_SZ) | 1 << MPU_RSR_EN;
+	size_data |= subregions << MPU_RSR_SD;
 
 	dsb(); /* Ensure all previous data accesses occur with old mappings */
 	rgnr_write(number);
@@ -308,33 +406,33 @@ static int __init mpu_setup_region(unsigned int number, phys_addr_t start,
 */
 void __init mpu_setup(void)
 {
-	int region = 0, err = 0;
+	int i, region = 0, err = 0;
 
 	if (!mpu_present())
 		return;
 
-	/* Free-up MPU_PROBE_REGION */
-	mpu_min_region_order = __mpu_min_region_order();
-
-	/* How many regions are supported */
-	mpu_max_regions = __mpu_max_regions();
-
-	/* Now setup MPU (order is important) */
+	/* Setup MPU (order is important) */
 
 	/* Background */
 	err |= mpu_setup_region(region++, 0, 32,
-				MPU_ACR_XN | MPU_RGN_STRONGLY_ORDERED | MPU_AP_PL1RW_PL0NA);
+				MPU_ACR_XN | MPU_RGN_STRONGLY_ORDERED | MPU_AP_PL1RW_PL0NA,
+				0);
 
 	/* RAM */
-	err |= mpu_setup_region(region++, PHYS_OFFSET,
-				ilog2(memblock.memory.regions[0].size),
-				MPU_AP_PL1RW_PL0RW | MPU_RGN_NORMAL);
+	for (i = 0; i < ARRAY_SIZE(mem); i++) {
+		if (!mem[i].size)
+			continue;
+
+		err |= mpu_setup_region(region++, mem[i].base, ilog2(mem[i].size),
+					MPU_AP_PL1RW_PL0RW | MPU_RGN_NORMAL,
+					mem[i].subreg);
+	}
 
 	/* Vectors */
 #ifndef CONFIG_CPU_V7M
-	err |= mpu_setup_region(region++, vectors_base,
-				ilog2(2 * PAGE_SIZE),
-				MPU_AP_PL1RW_PL0NA | MPU_RGN_NORMAL);
+	err |= mpu_setup_region(region++, vectors_base, ilog2(2 * PAGE_SIZE),
+				MPU_AP_PL1RW_PL0NA | MPU_RGN_NORMAL,
+				0);
 #endif
 	if (err) {
 		panic("MPU region initialization failure! %d", err);
-- 
1.9.1
