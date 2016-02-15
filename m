From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 15 Feb 2016 10:28:32 +0100
Subject: [PATCH] arm64: mark kernel text segment as MEMBLOCK_NOMAP
Message-ID: <1455528512-32491-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 752af28bd711 ("arm64: move kernel image to base of vmalloc area")
moves the mapping of the kernel text and data segments out of the linear
region, and takes care not to create a writable alias of the read-only
kernel text segment by checking each memblock against overlap when the
memblocks are mapped into the linear mapping.

However, it is more correct, and much simpler, to mark the [_stext, _etext]
interval as MEMBLOCK_NOMAP. This will also prevent the interval from being
omitted from the linear region, but this fact will now also be reflected
in the output of pfn_valid(), and so code that expects any pfn_valid()
page to be mapped and accessible (which is a reasonable assumption) does
not get surprised by the text segment being inaccessible via the linear
mapping.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

This should hopefully address the issue reported by James, but I suppose
more work is required on the hibernate side to ensure the unmapped text
region is preserved, since it is no longer covered by the linear mapping.

 arch/arm64/mm/init.c |  1 +
 arch/arm64/mm/mmu.c  | 39 ++------------------
 2 files changed, 4 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 023c41f22b5b..e895fb6ff9dd 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -218,6 +218,7 @@ void __init arm64_memblock_init(void)
 	 * pagetables with memblock.
 	 */
 	memblock_reserve(__pa(_text), _end - _text);
+	memblock_mark_nomap(__pa(_stext), _etext - _stext);
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start) {
 		memblock_reserve(initrd_start, initrd_end - initrd_start);
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 5d7e0b801ab7..5ca2f315ba9d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -352,41 +352,6 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
 			     late_pgtable_alloc);
 }
 
-static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end)
-{
-
-	unsigned long kernel_start = __pa(_stext);
-	unsigned long kernel_end = __pa(_etext);
-
-	/*
-	 * Take care not to create a writable alias for the
-	 * read-only text and rodata sections of the kernel image.
-	 */
-
-	/* No overlap with the kernel text */
-	if (end < kernel_start || start >= kernel_end) {
-		__create_pgd_mapping(pgd, start, __phys_to_virt(start),
-				     end - start, PAGE_KERNEL,
-				     early_pgtable_alloc);
-		return;
-	}
-
-	/*
-	 * This block overlaps the kernel text mapping. Map the portion(s) which
-	 * don't overlap.
-	 */
-	if (start < kernel_start)
-		__create_pgd_mapping(pgd, start,
-				     __phys_to_virt(start),
-				     kernel_start - start, PAGE_KERNEL,
-				     early_pgtable_alloc);
-	if (kernel_end < end)
-		__create_pgd_mapping(pgd, kernel_end,
-				     __phys_to_virt(kernel_end),
-				     end - kernel_end, PAGE_KERNEL,
-				     early_pgtable_alloc);
-}
-
 static void __init map_mem(pgd_t *pgd)
 {
 	struct memblock_region *reg;
@@ -401,7 +366,9 @@ static void __init map_mem(pgd_t *pgd)
 		if (memblock_is_nomap(reg))
 			continue;
 
-		__map_memblock(pgd, start, end);
+		__create_pgd_mapping(pgd, start, __phys_to_virt(start),
+				     end - start, PAGE_KERNEL,
+				     early_pgtable_alloc);
 	}
 }
 
-- 
2.5.0
