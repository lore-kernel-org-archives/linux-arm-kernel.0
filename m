From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Mar 2012 01:44:28 -0400
Subject: [PATCH 2/2] remove the debugging restrictions in devicemaps_init()
In-Reply-To: <1331876668-32492-1-git-send-email-nico@fluxnic.net>
References: <1331876668-32492-1-git-send-email-nico@fluxnic.net>
Message-ID: <1331876668-32492-3-git-send-email-nico@fluxnic.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

More code is getting involved through devicemaps_init() these days,
including calls to printk() or BUG().  Not being able to access any
device to print out debugging information and only being presented with
a silent kernel crash in that case has become a major inconvenience
lately.

By having the active page table separate from the one being initialized,
it is possible to preserve the initial debug mapping that was set in
head.S until the final page table is ready.  Because there exists some
code that installs a partial mapping in order to probe the hardware
before installing additional mappings, it is necessary to set up the
vector mapping early which enables the fault handler to copy some of
the newly created mappings into our page table copy as needed.

This patch implements such a temporary page table copy only for
non LPAE configurations at the moment.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mm/mmu.c |   95 +++++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 71 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index f77f1dbbdf..80e3a5410f 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -987,16 +987,47 @@ void __init arm_mm_memblock_reserve(void)
 #endif
 }
 
+#if defined(CONFIG_DEBUG_LL) && !defined(CONFIG_ARM_LPAE)
+
+/*
+ * The debug mappings will be cleared from the initial page table by
+ * devicemaps_init(), and eventually recreated via mdesc->map_io().
+ * To allow for debug devices to always remain accessible, we switch to
+ * a temporary copy of the current page table while the final one is being
+ * manipulated, and switch back once the final mappings are in place.
+ */
+static pgd_t * __init install_temp_mm(void)
+{
+	pgd_t *temp_pgd = early_alloc(PTRS_PER_PGD * sizeof(pgd_t));
+	pgd_t *init_pgd = pgd_offset_k(0);
+
+	/* copy vector and kernel space mappings */
+	pgd_val(temp_pgd[0]) = pgd_val(init_pgd[0]);
+	memcpy(temp_pgd + USER_PTRS_PER_PGD, init_pgd + USER_PTRS_PER_PGD,
+	       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+	clean_dcache_area(temp_pgd, PTRS_PER_PGD * sizeof(pgd_t));
+	cpu_switch_mm(temp_pgd, &init_mm);
+	return temp_pgd;
+}
+
+static void __init remove_temp_mm(pgd_t *temp_pgd)
+{
+	cpu_switch_mm(init_mm.pgd, &init_mm);
+	memblock_free(__pa(temp_pgd), PTRS_PER_PGD * sizeof(pgd_t));
+}
+
+#else
+#define install_temp_mm()	(NULL)
+#define remove_temp_mm(mm)	do { (void)(mm); } while (0)
+#endif
+
 /*
- * Set up the device mappings.  Since we clear out the page tables for all
- * mappings above VMALLOC_START, we will remove any debug device mappings.
- * This means you have to be careful how you debug this function, or any
- * called function.  This means you can't use any function or debugging
- * method which may touch any device, otherwise the kernel _will_ crash.
+ * Set up the device mappings.
  */
 static void __init devicemaps_init(struct machine_desc *mdesc)
 {
 	struct map_desc map;
+	pgd_t *temp_pgd;
 	unsigned long addr;
 	void *vectors;
 
@@ -1004,10 +1035,41 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
 	 * Allocate the vector page early.
 	 */
 	vectors = early_alloc(PAGE_SIZE);
-
 	early_trap_init(vectors);
 
-	for (addr = VMALLOC_START; addr; addr += PMD_SIZE)
+	/*
+	 * Create a mapping for the machine vectors at the high-vectors
+	 * location (0xffff0000).  If we aren't using high-vectors, also
+	 * create a mapping at the low-vectors virtual address.
+	 */
+	pmd_clear(pmd_off_k(0xffff0000));
+	map.pfn = __phys_to_pfn(virt_to_phys(vectors));
+	map.virtual = 0xffff0000;
+	map.length = PAGE_SIZE;
+	map.type = MT_HIGH_VECTORS;
+	create_mapping(&map);
+
+	if (!vectors_high()) {
+		map.virtual = 0;
+		map.type = MT_LOW_VECTORS;
+		create_mapping(&map);
+	}
+
+	/*
+	 * After this point, any missing entry in our temp mm will be
+	 * populated via do_translation_fault().  This may happen if
+	 * some platform code needs to install a partial mapping to
+	 * probe the hardware in order to install more mappings.
+	 */
+	temp_pgd = install_temp_mm();
+
+	/*
+	 * Clear out the page tables for all mappings above VMALLOC_START
+	 * while preserving the high vector mapping.
+	 */
+	for (addr = VMALLOC_START; 
+	     addr < (0xffff0000UL & PMD_MASK);
+	     addr += PMD_SIZE)
 		pmd_clear(pmd_off_k(addr));
 
 	/*
@@ -1041,28 +1103,13 @@ static void __init devicemaps_init(struct machine_desc *mdesc)
 #endif
 
 	/*
-	 * Create a mapping for the machine vectors at the high-vectors
-	 * location (0xffff0000).  If we aren't using high-vectors, also
-	 * create a mapping@the low-vectors virtual address.
-	 */
-	map.pfn = __phys_to_pfn(virt_to_phys(vectors));
-	map.virtual = 0xffff0000;
-	map.length = PAGE_SIZE;
-	map.type = MT_HIGH_VECTORS;
-	create_mapping(&map);
-
-	if (!vectors_high()) {
-		map.virtual = 0;
-		map.type = MT_LOW_VECTORS;
-		create_mapping(&map);
-	}
-
-	/*
 	 * Ask the machine support to map in the statically mapped devices.
 	 */
 	if (mdesc->map_io)
 		mdesc->map_io();
 
+	remove_temp_mm(temp_pgd);
+
 	/*
 	 * Finally flush the caches and tlb to ensure that we're in a
 	 * consistent state wrt the writebuffer.  This also ensures that
-- 
1.7.9.rc2
