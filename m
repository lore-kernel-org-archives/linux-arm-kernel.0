From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 16 Nov 2015 12:23:15 +0100
Subject: [PATCH v3 4/7] arm64: mm: explicitly bootstrap the linear mapping
In-Reply-To: <1447672998-20981-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1447672998-20981-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1447672998-20981-5-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation of moving the kernel text out of the linear
mapping, ensure that the part of the kernel Image that contains
the statically allocated page tables is made accessible via the
linear mapping before performing the actual mapping of all of
memory. This is needed by the normal mapping routines, that rely
on the linear mapping to walk the page tables while manipulating
them.

In addition, explicitly map the start of DRAM and set the memblock
limit so that all early memblock allocations are done from a region
that is guaranteed to be mapped.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/vmlinux.lds.S | 18 +++-
 arch/arm64/mm/mmu.c             | 93 +++++++++++++++-----
 2 files changed, 86 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 87a596246ec7..63fca196c09e 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -72,6 +72,17 @@ PECOFF_FILE_ALIGNMENT = 0x200;
 #define ALIGN_DEBUG_RO_MIN(min)		. = ALIGN(min);
 #endif
 
+/*
+ * The pgdir region needs to be mappable using a single PMD or PUD sized region,
+ * so align it to a power-of-2 upper bound of its size. 16k/4 levels needs 20
+ * pages at the most, every other config needs at most 16 pages.
+ */
+#if defined(CONFIG_ARM64_16K_PAGES) && CONFIG_ARM64_PGTABLE_LEVELS == 4
+#define PGDIR_ALIGN	(32 * PAGE_SIZE)
+#else
+#define PGDIR_ALIGN	(16 * PAGE_SIZE)
+#endif
+
 SECTIONS
 {
 	/*
@@ -164,7 +175,7 @@ SECTIONS
 
 	BSS_SECTION(0, 0, 0)
 
-	.pgdir (NOLOAD) : ALIGN(PAGE_SIZE) {
+	.pgdir (NOLOAD) : ALIGN(PGDIR_ALIGN) {
 		idmap_pg_dir = .;
 		. += IDMAP_DIR_SIZE;
 		swapper_pg_dir = .;
@@ -189,6 +200,11 @@ ASSERT(__idmap_text_end - (__idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
 	"ID map text too big or misaligned")
 
 /*
+ * Check that the chosen PGDIR_ALIGN value is sufficient.
+ */
+ASSERT(SIZEOF(.pgdir) <= ALIGNOF(.pgdir), ".pgdir size exceeds its alignment")
+
+/*
  * If padding is applied before .head.text, virt<->phys conversions will fail.
  */
 ASSERT(_text == (PAGE_OFFSET + TEXT_OFFSET), "HEAD is misaligned")
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 4f397a87c2be..81bb49eaa1a3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -434,23 +434,86 @@ static void __init bootstrap_early_mapping(unsigned long addr,
 	}
 }
 
-static void __init map_mem(void)
+/*
+ * Bootstrap a memory mapping in such a way that it does not require allocation
+ * of page tables beyond the ones that were allocated statically by
+ * bootstrap_early_mapping().
+ * This is done by finding the memblock that covers pa_base, and intersecting
+ * it with the naturally aligned 512 MB, 32 MB or 1 GB region (depending on page
+ * size) that covers pa_base as well and (on 4k pages) round it to section size.
+ */
+static unsigned long __init bootstrap_region(struct bootstrap_pgtables *reg,
+					     phys_addr_t pa_base,
+					     unsigned long va_offset)
 {
-	struct memblock_region *reg;
-	phys_addr_t limit;
+	unsigned long va_base = __phys_to_virt(pa_base) + va_offset;
+	struct memblock_region *mr;
+
+	bootstrap_early_mapping(va_base, reg, !ARM64_SWAPPER_USES_SECTION_MAPS);
+
+	for_each_memblock(memory, mr) {
+		phys_addr_t start = mr->base;
+		phys_addr_t end = start + mr->size;
+		unsigned long vstart, vend;
+
+		if (start > pa_base || end <= pa_base)
+			continue;
+
+		/* clip the region to PMD size */
+		vstart = max(round_down(va_base, 1 << SWAPPER_TABLE_SHIFT),
+			     round_up(__phys_to_virt(start) + va_offset,
+				      SWAPPER_BLOCK_SIZE));
+		vend = min(round_up(va_base + 1, 1 << SWAPPER_TABLE_SHIFT),
+			   round_down(__phys_to_virt(end) + va_offset,
+				      SWAPPER_BLOCK_SIZE));
+
+		create_mapping(__pa(vstart - va_offset), vstart, vend - vstart,
+			       PAGE_KERNEL_EXEC);
+
+		return vend;
+	}
+	return 0;
+}
+
+/*
+ * Bootstrap the linear ranges that cover the start of DRAM and swapper_pg_dir
+ * so that the statically allocated page tables as well as newly allocated ones
+ * are accessible via the linear mapping.
+ */
+static void __init bootstrap_linear_mapping(unsigned long va_offset)
+{
+	static struct bootstrap_pgtables __pgdir bs_pgdir_low, bs_pgdir_high;
+	unsigned long vend;
+
+	/* Bootstrap the mapping for the beginning of RAM */
+	vend = bootstrap_region(&bs_pgdir_low, memblock_start_of_DRAM(),
+				va_offset);
+	BUG_ON(vend == 0);
 
 	/*
 	 * Temporarily limit the memblock range. We need to do this as
 	 * create_mapping requires puds, pmds and ptes to be allocated from
-	 * memory addressable from the initial direct kernel mapping.
+	 * memory addressable from the early linear mapping.
 	 *
 	 * The initial direct kernel mapping, located@swapper_pg_dir, gives
 	 * us PUD_SIZE (with SECTION maps) or PMD_SIZE (without SECTION maps,
 	 * memory starting from PHYS_OFFSET (which must be aligned to 2MB as
 	 * per Documentation/arm64/booting.txt).
 	 */
-	limit = PHYS_OFFSET + SWAPPER_INIT_MAP_SIZE;
-	memblock_set_current_limit(limit);
+	memblock_set_current_limit(__pa(vend - va_offset));
+
+	/* Bootstrap the linear mapping of the kernel image */
+	vend = bootstrap_region(&bs_pgdir_high, __pa(swapper_pg_dir),
+				va_offset);
+	if (vend == 0)
+		panic("Kernel image not covered by memblock");
+}
+
+static void __init map_mem(void)
+{
+	struct memblock_region *reg;
+
+	bootstrap_linear_mapping(0);
 
 	/* map all the memory banks */
 	for_each_memblock(memory, reg) {
@@ -460,24 +523,6 @@ static void __init map_mem(void)
 		if (start >= end)
 			break;
 
-		if (ARM64_SWAPPER_USES_SECTION_MAPS) {
-			/*
-			 * For the first memory bank align the start address and
-			 * current memblock limit to prevent create_mapping() from
-			 * allocating pte page tables from unmapped memory. With
-			 * the section maps, if the first block doesn't end on section
-			 * size boundary, create_mapping() will try to allocate a pte
-			 * page, which may be returned from an unmapped area.
-			 * When section maps are not used, the pte page table for the
-			 * current limit is already present in swapper_pg_dir.
-			 */
-			if (start < limit)
-				start = ALIGN(start, SECTION_SIZE);
-			if (end < limit) {
-				limit = end & SECTION_MASK;
-				memblock_set_current_limit(limit);
-			}
-		}
 		__map_memblock(start, end);
 	}
 
-- 
1.9.1
