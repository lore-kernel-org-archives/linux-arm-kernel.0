From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 10 Apr 2015 15:53:52 +0200
Subject: [PATCH v3 08/11] arm64: mm: explicitly bootstrap the linear mapping
In-Reply-To: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1428674035-26603-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1428674035-26603-9-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation of moving the kernel text out of the linear
mapping, ensure that the part of the kernel Image that contains
the statically allocated page tables is made accessible via the
linear mapping before performing the actual mapping of all of
memory. This is needed by the normal mapping routines, that rely
on the linear mapping to walk the page tables while manipulating
them.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/vmlinux.lds.S |  10 +++-
 arch/arm64/mm/mmu.c             | 104 ++++++++++++++++++++++++++++------------
 2 files changed, 81 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 604f285d3832..b7cdf4feb9f1 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -160,8 +160,7 @@ SECTIONS
 
 	BSS_SECTION(0, 0, 0)
 
-	.pgdir (NOLOAD) : {
-		. = ALIGN(PAGE_SIZE);
+	.pgdir (NOLOAD) : ALIGN(SZ_1M) {
 		idmap_pg_dir = .;
 		. += IDMAP_DIR_SIZE;
 		swapper_pg_dir = .;
@@ -187,6 +186,13 @@ ASSERT(__idmap_text_end - (__idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
 	"ID map text too big or misaligned")
 
 /*
+ * The pgdir region needs to be mappable using a single PMD or PUD sized region,
+ * so it should not cross a 512 MB or 1 GB alignment boundary, respectively
+ * (depending on page size). So align to an upper bound of its size.
+ */
+ASSERT(SIZEOF(.pgdir) < ALIGNOF(.pgdir), ".pgdir size exceeds its alignment")
+
+/*
  * If padding is applied before .head.text, virt<->phys conversions will fail.
  */
 ASSERT(_text == (PAGE_OFFSET + TEXT_OFFSET), "HEAD is misaligned")
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c0427b5c90c7..ea35ec911393 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -405,26 +405,83 @@ static void __init bootstrap_mem_region(unsigned long addr,
 	}
 }
 
+static void __init bootstrap_linear_mapping(void)
+{
+	/*
+	 * Bootstrap the linear range that covers swapper_pg_dir so that the
+	 * statically allocated page tables are accessible via the linear
+	 * mapping. This allows us to start using the normal create_mapping()
+	 * logic which relies on the ability to translate physical addresses
+	 * contained in page table entries to virtual addresses using __va().
+	 */
+	static struct mem_bootstrap_region linear_bs_region __pgdir;
+	const phys_addr_t swapper_phys = __pa(swapper_pg_dir);
+	const unsigned long swapper_virt = __phys_to_virt(swapper_phys);
+	struct memblock_region *reg;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	bootstrap_mem_region(swapper_virt, &linear_bs_region, &pmd,
+			     IS_ENABLED(CONFIG_ARM64_64K_PAGES) ? &pte : NULL);
+
+	/* now find the memblock that covers swapper_pg_dir, and clip */
+	for_each_memblock(memory, reg) {
+		phys_addr_t start = reg->base;
+		phys_addr_t end = start + reg->size;
+		unsigned long vstart, vend;
+
+		if (start > swapper_phys || end <= swapper_phys)
+			continue;
+
+#ifdef CONFIG_ARM64_64K_PAGES
+		/* clip the region to PMD size */
+		vstart = max(swapper_virt & PMD_MASK, __phys_to_virt(start));
+		vend = min(round_up(swapper_virt, PMD_SIZE),
+			   __phys_to_virt(end));
+
+		vstart = round_up(vstart, PAGE_SIZE);
+		vend = round_down(vend, PAGE_SIZE);
+
+		pte += pte_index(vstart);
+		do {
+			set_pte(pte++, __pte(__pa(vstart) | PAGE_KERNEL_EXEC));
+			vstart += PAGE_SIZE;
+		} while (vstart < vend);
+#else
+		/* clip the region to PUD size */
+		vstart = max(swapper_virt & PUD_MASK, __phys_to_virt(start));
+		vend = min(round_up(swapper_virt, PUD_SIZE),
+			   __phys_to_virt(end));
+
+		vstart = round_up(vstart, PMD_SIZE);
+		vend = round_down(vend, PMD_SIZE);
+
+		pmd += pmd_index(vstart);
+		do {
+			set_pmd(pmd++,
+				__pmd(__pa(vstart) | PROT_SECT_NORMAL_EXEC));
+			vstart += PMD_SIZE;
+		} while (vstart < vend);
+#endif
+
+		/*
+		 * Temporarily limit the memblock range. We need to do this as
+		 * create_mapping requires puds, pmds and ptes to be allocated
+		 * from memory addressable from the initial direct kernel
+		 * mapping.
+		 */
+		memblock_set_current_limit(__pa(vend));
+
+		return;
+	}
+	BUG();
+}
+
 static void __init map_mem(void)
 {
 	struct memblock_region *reg;
-	phys_addr_t limit;
 
-	/*
-	 * Temporarily limit the memblock range. We need to do this as
-	 * create_mapping requires puds, pmds and ptes to be allocated from
-	 * memory addressable from the initial direct kernel mapping.
-	 *
-	 * The initial direct kernel mapping, located@swapper_pg_dir, gives
-	 * us PUD_SIZE (4K pages) or PMD_SIZE (64K pages) memory starting from
-	 * PHYS_OFFSET (which must be aligned to 2MB as per
-	 * Documentation/arm64/booting.txt).
-	 */
-	if (IS_ENABLED(CONFIG_ARM64_64K_PAGES))
-		limit = PHYS_OFFSET + PMD_SIZE;
-	else
-		limit = PHYS_OFFSET + PUD_SIZE;
-	memblock_set_current_limit(limit);
+	bootstrap_linear_mapping();
 
 	/* map all the memory banks */
 	for_each_memblock(memory, reg) {
@@ -434,21 +491,6 @@ static void __init map_mem(void)
 		if (start >= end)
 			break;
 
-#ifndef CONFIG_ARM64_64K_PAGES
-		/*
-		 * For the first memory bank align the start address and
-		 * current memblock limit to prevent create_mapping() from
-		 * allocating pte page tables from unmapped memory.
-		 * When 64K pages are enabled, the pte page table for the
-		 * first PGDIR_SIZE is already present in swapper_pg_dir.
-		 */
-		if (start < limit)
-			start = ALIGN(start, PMD_SIZE);
-		if (end < limit) {
-			limit = end & PMD_MASK;
-			memblock_set_current_limit(limit);
-		}
-#endif
 		__map_memblock(start, end);
 	}
 
-- 
1.8.3.2
