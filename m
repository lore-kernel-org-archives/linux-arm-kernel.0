From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  9 Dec 2015 12:44:55 +0000
Subject: [RFC PATCH 20/20] arm64: mm: create new fine-grained mappings at boot
In-Reply-To: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
References: <1449665095-20774-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1449665095-20774-21-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At boot we may change the granularity of the tables mapping the kernel
(by splitting or making sections). This may happen when we create the
linear mapping (in __map_memblock), or at any point we try to apply
fine-grained permissions to the kernel (e.g. fixup_executable,
mark_rodata_ro, fixup_init).

Changing the active page tables in this manner may result in multiple
entries for the same address being allocated into TLBs, risking problems
such as TLB conflict aborts or issues derived from the amalgamation of
TLB entries. Generally, a break-before-make (BBM) approach is necessary
to avoid conflicts, but we cannot do this for the kernel tables as it
risks unmapping text or data being used to do so.

Instead, we can create a new set of tables from scratch in the safety of
the existing mappings, and subsequently migrate over to these using the
new cpu_replace_ttbr1 helper, which avoids the two sets of tables being
active simultaneously.

To avoid issues when we later modify permissions of the page tables
(e.g. in fixup_init), we must create the page tables at a granularity
such that later modification does not result in splitting of tables.

This patch applies this strategy, creating a new set of fine-grained
page tables from scratch, and safely migrating to them.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c | 146 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 84 insertions(+), 62 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c20a1ce..aa4f381 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -322,49 +322,41 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
 	__create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, late_alloc);
 }
 
-#ifdef CONFIG_DEBUG_RODATA
-static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
+static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end)
 {
+
+	unsigned long kernel_start = __pa(_stext);
+	unsigned long kernel_end = __pa(_end);
+
 	/*
-	 * Set up the executable regions using the existing section mappings
-	 * for now. This will get more fine grained later once all memory
-	 * is mapped
+	 * The kernel itself is mapped at page granularity. Map all other
+	 * memory, making sure we don't overwrite the existing kernel mappings.
 	 */
-	unsigned long kernel_x_start = round_down(__pa(_stext), SWAPPER_BLOCK_SIZE);
-	unsigned long kernel_x_end = round_up(__pa(__init_end), SWAPPER_BLOCK_SIZE);
-
-	if (end < kernel_x_start) {
-		create_mapping(start, __phys_to_virt(start),
-			end - start, PAGE_KERNEL);
-	} else if (start >= kernel_x_end) {
-		create_mapping(start, __phys_to_virt(start),
-			end - start, PAGE_KERNEL);
-	} else {
-		if (start < kernel_x_start)
-			create_mapping(start, __phys_to_virt(start),
-				kernel_x_start - start,
-				PAGE_KERNEL);
-		create_mapping(kernel_x_start,
-				__phys_to_virt(kernel_x_start),
-				kernel_x_end - kernel_x_start,
-				PAGE_KERNEL_EXEC);
-		if (kernel_x_end < end)
-			create_mapping(kernel_x_end,
-				__phys_to_virt(kernel_x_end),
-				end - kernel_x_end,
-				PAGE_KERNEL);
+
+	/* No overlap with the kernel. */
+	if (end < kernel_start || start >= kernel_end) {
+		__create_pgd_mapping(pgd, start, __phys_to_virt(start),
+				     end - start, PAGE_KERNEL, early_alloc);
+		return;
 	}
 
+	/*
+	 * This block overlaps the kernel mapping. Map the portion(s) which
+	 * don't overlap.
+	 */
+	if (start < kernel_start)
+		__create_pgd_mapping(pgd, start,
+				     __phys_to_virt(start),
+				     kernel_start - start, PAGE_KERNEL,
+				     early_alloc);
+	if (kernel_end < end)
+		__create_pgd_mapping(pgd, kernel_end,
+				     __phys_to_virt(kernel_end),
+				     end - kernel_end, PAGE_KERNEL,
+				     early_alloc);
 }
-#else
-static void __init __map_memblock(phys_addr_t start, phys_addr_t end)
-{
-	create_mapping(start, __phys_to_virt(start), end - start,
-			PAGE_KERNEL_EXEC);
-}
-#endif
 
-static void __init map_mem(void)
+static void __init map_mem(pgd_t *pgd)
 {
 	struct memblock_region *reg;
 
@@ -376,33 +368,10 @@ static void __init map_mem(void)
 		if (start >= end)
 			break;
 
-		__map_memblock(start, end);
+		__map_memblock(pgd, start, end);
 	}
 }
 
-static void __init fixup_executable(void)
-{
-#ifdef CONFIG_DEBUG_RODATA
-	/* now that we are actually fully mapped, make the start/end more fine grained */
-	if (!IS_ALIGNED((unsigned long)_stext, SWAPPER_BLOCK_SIZE)) {
-		unsigned long aligned_start = round_down(__pa(_stext),
-							 SWAPPER_BLOCK_SIZE);
-
-		create_mapping(aligned_start, __phys_to_virt(aligned_start),
-				__pa(_stext) - aligned_start,
-				PAGE_KERNEL);
-	}
-
-	if (!IS_ALIGNED((unsigned long)__init_end, SWAPPER_BLOCK_SIZE)) {
-		unsigned long aligned_end = round_up(__pa(__init_end),
-							  SWAPPER_BLOCK_SIZE);
-		create_mapping(__pa(__init_end), (unsigned long)__init_end,
-				aligned_end - __pa(__init_end),
-				PAGE_KERNEL);
-	}
-#endif
-}
-
 #ifdef CONFIG_DEBUG_RODATA
 void mark_rodata_ro(void)
 {
@@ -420,14 +389,67 @@ void fixup_init(void)
 			PAGE_KERNEL);
 }
 
+static void __init map_kernel_chunk(pgd_t *pgd, void *va_start, void *va_end, pgprot_t prot)
+{
+	phys_addr_t pa_start = __pa(va_start);
+	unsigned long size = va_end - va_start;
+
+	BUG_ON(!PAGE_ALIGNED(pa_start));
+	BUG_ON(!PAGE_ALIGNED(size));
+
+	__create_pgd_mapping(pgd, pa_start, (unsigned long)va_start, size, prot, early_alloc);
+}
+
+/*
+ * Create fine-grained mappings for the kernel.
+ */
+static void __init map_kernel(pgd_t *pgd)
+{
+
+	map_kernel_chunk(pgd, _stext, _etext, PAGE_KERNEL_EXEC);
+	map_kernel_chunk(pgd, __init_begin, __init_end, PAGE_KERNEL_EXEC);
+	map_kernel_chunk(pgd, _data, _end, PAGE_KERNEL);
+
+	/*
+	 * The fixmap falls in a separate pgd to the kernel, and doesn't live
+	 * in the carveout for the swapper_pg_dir. We can simply re-use the
+	 * existing dir for the fixmap.
+	 */
+	set_pgd(pgd_offset_raw(pgd, FIXADDR_START), *pgd_offset_k(FIXADDR_START));
+
+	/* TODO: either copy or initialise KASAN here */
+}
+
+
 /*
  * paging_init() sets up the page tables, initialises the zone memory
  * maps and sets up the zero page.
  */
 void __init paging_init(void)
 {
-	map_mem();
-	fixup_executable();
+	phys_addr_t pgd_phys = early_alloc();
+	pgd_t *pgd = pgd_fixmap(pgd_phys);
+
+	map_kernel(pgd);
+	map_mem(pgd);
+
+	/*
+	 * HACK: ensure that we use the original swapper_pg_dir pgd so that:
+	 * - secondaries get the right stack in secondary_entry
+	 * - cpu_switch_mm can validate the pgd handed to it
+	 */
+	cpu_replace_ttbr1(__va(pgd_phys));
+	memcpy(swapper_pg_dir, pgd, PAGE_SIZE);
+	cpu_replace_ttbr1(swapper_pg_dir);
+
+	/*
+	 * TODO: this leaves the swapper_pgdir pud & pmd unused but not free.
+	 * It would be better if we could avoid the hack above and free the
+	 * entire swapper_pg_dir region in one go (e.g. by placing it in
+	 * .init).
+	 */
+	pgd_fixmap_unmap();
+	memblock_free(pgd_phys, PAGE_SIZE);
 
 	bootmem_init();
 }
-- 
1.9.1
