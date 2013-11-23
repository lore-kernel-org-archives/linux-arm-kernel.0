From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 18:34:13 -0500
Subject: [PATCH 3/3] ARM: mm: Remove bootmem code and switch to NO_BOOTMEM
In-Reply-To: <1385249653-9250-1-git-send-email-santosh.shilimkar@ti.com>
References: <1385249653-9250-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1385249653-9250-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now with dma_mask series merged and max*pfn has consistent meaning on ARM
as rest of the arch's thanks to RMK's mega series, lets switch ARM code
to NO_BOOTMEM. With NO_BOOTMEM change, now we use memblock allocator to
reserve space for crash kernel to have one less dependency with nobootmem
allocator wrapper.

Tested with both flat memory and sparse (faked) memory models with highmem
enabled.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/Kconfig        |    1 +
 arch/arm/kernel/setup.c |    2 +-
 arch/arm/mm/init.c      |   58 ++---------------------------------------------
 3 files changed, 4 insertions(+), 57 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c1f1a7e..51411db 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -62,6 +62,7 @@ config ARM
 	select IRQ_FORCED_THREADING
 	select KTIME_SCALAR
 	select MODULES_USE_ELF_REL
+	select NO_BOOTMEM
 	select OLD_SIGACTION
 	select OLD_SIGSUSPEND3
 	select PERF_USE_VMALLOC
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 6a1b8a8..e9f629f 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -817,7 +817,7 @@ static void __init reserve_crashkernel(void)
 	if (ret)
 		return;
 
-	ret = reserve_bootmem(crash_base, crash_size, BOOTMEM_EXCLUSIVE);
+	ret = memblock_reserve(crash_base, crash_size);
 	if (ret < 0) {
 		printk(KERN_WARNING "crashkernel reservation failed - "
 		       "memory is in use (0x%lx)\n", (unsigned long)crash_base);
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index ea66341..6dd66a9 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -145,58 +145,6 @@ static void __init find_limits(unsigned long *min, unsigned long *max_low,
 	*max_high = bank_pfn_end(&mi->bank[mi->nr_banks - 1]);
 }
 
-static void __init arm_bootmem_init(unsigned long start_pfn,
-	unsigned long end_pfn)
-{
-	struct memblock_region *reg;
-	unsigned int boot_pages;
-	phys_addr_t bitmap;
-	pg_data_t *pgdat;
-
-	/*
-	 * Allocate the bootmem bitmap page.  This must be in a region
-	 * of memory which has already been mapped.
-	 */
-	boot_pages = bootmem_bootmap_pages(end_pfn - start_pfn);
-	bitmap = memblock_alloc_base(boot_pages << PAGE_SHIFT, L1_CACHE_BYTES,
-				__pfn_to_phys(end_pfn));
-
-	/*
-	 * Initialise the bootmem allocator, handing the
-	 * memory banks over to bootmem.
-	 */
-	node_set_online(0);
-	pgdat = NODE_DATA(0);
-	init_bootmem_node(pgdat, __phys_to_pfn(bitmap), start_pfn, end_pfn);
-
-	/* Free the lowmem regions from memblock into bootmem. */
-	for_each_memblock(memory, reg) {
-		unsigned long start = memblock_region_memory_base_pfn(reg);
-		unsigned long end = memblock_region_memory_end_pfn(reg);
-
-		if (end >= end_pfn)
-			end = end_pfn;
-		if (start >= end)
-			break;
-
-		free_bootmem(__pfn_to_phys(start), (end - start) << PAGE_SHIFT);
-	}
-
-	/* Reserve the lowmem memblock reserved regions in bootmem. */
-	for_each_memblock(reserved, reg) {
-		unsigned long start = memblock_region_reserved_base_pfn(reg);
-		unsigned long end = memblock_region_reserved_end_pfn(reg);
-
-		if (end >= end_pfn)
-			end = end_pfn;
-		if (start >= end)
-			break;
-
-		reserve_bootmem(__pfn_to_phys(start),
-			        (end - start) << PAGE_SHIFT, BOOTMEM_DEFAULT);
-	}
-}
-
 #ifdef CONFIG_ZONE_DMA
 
 phys_addr_t arm_dma_zone_size __read_mostly;
@@ -236,7 +184,7 @@ void __init setup_dma_zone(const struct machine_desc *mdesc)
 #endif
 }
 
-static void __init arm_bootmem_free(unsigned long min, unsigned long max_low,
+static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
 	unsigned long max_high)
 {
 	unsigned long zone_size[MAX_NR_ZONES], zhole_size[MAX_NR_ZONES];
@@ -396,8 +344,6 @@ void __init bootmem_init(void)
 
 	find_limits(&min, &max_low, &max_high);
 
-	arm_bootmem_init(min, max_low);
-
 	/*
 	 * Sparsemem tries to allocate bootmem in memory_present(),
 	 * so must be done after the fixed reservations
@@ -414,7 +360,7 @@ void __init bootmem_init(void)
 	 * the sparse mem_map arrays initialized by sparse_init()
 	 * for memmap_init_zone(), otherwise all PFNs are invalid.
 	 */
-	arm_bootmem_free(min, max_low, max_high);
+	zone_sizes_init(min, max_low, max_high);
 
 	/*
 	 * This doesn't seem to be used by the Linux memory manager any
-- 
1.7.9.5
