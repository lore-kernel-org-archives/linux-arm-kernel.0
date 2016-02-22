From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Feb 2016 21:54:28 +0100
Subject: [RFC PATCH 06/10] arm64: mm: use __pa_symbol() not __pa() for section
 boundary symbols
In-Reply-To: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1456174472-30028-7-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boundaries exported by asm/sections.h are relative to the kernel text
and not covered by the linear mapping. So use __pa_symbol() instead of
__pa() (or use __kimg_to_phys() if the virtual address is taken first)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/setup.c |  8 ++++----
 arch/arm64/mm/init.c      |  9 +++++----
 arch/arm64/mm/mmu.c       | 10 +++++-----
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 42371f69def3..bb41ebabe017 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -201,10 +201,10 @@ static void __init request_standard_resources(void)
 	struct memblock_region *region;
 	struct resource *res;
 
-	kernel_code.start   = virt_to_phys(_text);
-	kernel_code.end     = virt_to_phys(_etext - 1);
-	kernel_data.start   = virt_to_phys(_sdata);
-	kernel_data.end     = virt_to_phys(_end - 1);
+	kernel_code.start   = __pa_symbol(_text);
+	kernel_code.end     = __pa_symbol(_etext - 1);
+	kernel_data.start   = __pa_symbol(_sdata);
+	kernel_data.end     = __pa_symbol(_end - 1);
 
 	for_each_memblock(memory, region) {
 		res = alloc_bootmem_low(sizeof(*res));
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 017201982da3..af98bf85ec8e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -181,7 +181,7 @@ void __init arm64_memblock_init(void)
 	 * linear mapping. Take care not to clip the kernel which may be
 	 * high in memory.
 	 */
-	memblock_remove(max(memstart_addr + linear_region_size, __pa(_end)),
+	memblock_remove(max(memstart_addr + linear_region_size, __pa_symbol(_end)),
 			ULLONG_MAX);
 	if (memblock_end_of_DRAM() > linear_region_size)
 		memblock_remove(0, memblock_end_of_DRAM() - linear_region_size);
@@ -193,7 +193,7 @@ void __init arm64_memblock_init(void)
 	 */
 	if (memory_limit != (phys_addr_t)ULLONG_MAX) {
 		memblock_enforce_memory_limit(memory_limit);
-		memblock_add(__pa(_text), (u64)(_end - _text));
+		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
 	}
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
@@ -217,7 +217,7 @@ void __init arm64_memblock_init(void)
 	 * Register the kernel text, kernel data, initrd, and initial
 	 * pagetables with memblock.
 	 */
-	memblock_reserve(__pa(_text), _end - _text);
+	memblock_reserve(__pa_symbol(_text), _end - _text);
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start) {
 		memblock_reserve(initrd_start, initrd_end - initrd_start);
@@ -418,7 +418,8 @@ void __init mem_init(void)
 
 void free_initmem(void)
 {
-	free_initmem_default(0);
+	free_reserved_area(__va(__pa_symbol(__init_begin)),
+			   __va(__pa_symbol(__init_end)), 0, "unused kernel");
 	fixup_init();
 }
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e7340defa085..13517699bea6 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -387,8 +387,8 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
 
 static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end)
 {
-	unsigned long kernel_start = __pa(_stext);
-	unsigned long kernel_end = __pa(_etext);
+	unsigned long kernel_start = __pa_symbol(_stext);
+	unsigned long kernel_end = __pa_symbol(_etext);
 
 	/*
 	 * Take care not to create a writable alias for the
@@ -452,7 +452,7 @@ void mark_rodata_ro(void)
 	if (!IS_ENABLED(CONFIG_DEBUG_RODATA))
 		return;
 
-	create_mapping_late(__pa(_stext), (unsigned long)_stext,
+	create_mapping_late(__pa_symbol(_stext), (unsigned long)_stext,
 				(unsigned long)_etext - (unsigned long)_stext,
 				PAGE_KERNEL_ROX);
 }
@@ -470,7 +470,7 @@ void fixup_init(void)
 static void __init map_kernel_chunk(pgd_t *pgd, void *va_start, void *va_end,
 				    pgprot_t prot, struct vm_struct *vma)
 {
-	phys_addr_t pa_start = __pa(va_start);
+	phys_addr_t pa_start = __kimg_to_phys(va_start);
 	unsigned long size = va_end - va_start;
 
 	BUG_ON(!PAGE_ALIGNED(pa_start));
@@ -517,7 +517,7 @@ static void __init map_kernel(pgd_t *pgd)
 		 */
 		BUG_ON(!IS_ENABLED(CONFIG_ARM64_16K_PAGES));
 		set_pud(pud_set_fixmap_offset(pgd, FIXADDR_START),
-			__pud(__pa(bm_pmd) | PUD_TYPE_TABLE));
+			__pud(__pa_symbol(bm_pmd) | PUD_TYPE_TABLE));
 		pud_clear_fixmap();
 	} else {
 		BUG();
-- 
2.5.0
