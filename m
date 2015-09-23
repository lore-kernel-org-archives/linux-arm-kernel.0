From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 22 Sep 2015 17:37:40 -0700
Subject: [PATCH v2 4/7] arm64: mm: explicitly bootstrap the linear mapping
In-Reply-To: <1442968663-31843-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1442968663-31843-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1442968663-31843-5-git-send-email-ard.biesheuvel@linaro.org>
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
 arch/arm64/kernel/vmlinux.lds.S |  19 +++-
 arch/arm64/mm/mmu.c             | 109 ++++++++++++++------
 2 files changed, 98 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index ceec4def354b..0b82c4c203fb 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -68,6 +68,18 @@ PECOFF_FILE_ALIGNMENT = 0x200;
 #define ALIGN_DEBUG_RO_MIN(min)		. = ALIGN(min);
 #endif
 
+/*
+ * The pgdir region needs to be mappable using a single PMD or PUD sized region,
+ * so it should not cross a 512 MB or 1 GB alignment boundary, respectively
+ * (depending on page size). So align to a power-of-2 upper bound of the size
+ * of the entire __pgdir section.
+ */
+#if CONFIG_ARM64_PGTABLE_LEVELS == 2
+#define PGDIR_ALIGN	(8 * PAGE_SIZE)
+#else
+#define PGDIR_ALIGN	(16 * PAGE_SIZE)
+#endif
+
 SECTIONS
 {
 	/*
@@ -160,7 +172,7 @@ SECTIONS
 
 	BSS_SECTION(0, 0, 0)
 
-	.pgdir (NOLOAD) : ALIGN(PAGE_SIZE) {
+	.pgdir (NOLOAD) : ALIGN(PGDIR_ALIGN) {
 		idmap_pg_dir = .;
 		. += IDMAP_DIR_SIZE;
 		swapper_pg_dir = .;
@@ -185,6 +197,11 @@ ASSERT(__idmap_text_end - (__idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
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
index 5af804334697..3f99cf1aaa0d 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -380,26 +380,92 @@ static void __init bootstrap_early_mapping(unsigned long addr,
 	}
 }
 
-static void __init map_mem(void)
+/*
+ * Bootstrap a memory mapping in such a way that it does not require allocation
+ * of page tables beyond the ones that were allocated statically by
+ * bootstrap_early_mapping().
+ * This is done by finding the memblock that covers pa_base, and intersecting
+ * it with the naturally aligned 512 MB of 1 GB region (depending on page size)
+ * that covers pa_base as well and (on 4k pages) round it to section size.
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
+	bootstrap_early_mapping(va_base, reg,
+				IS_ENABLED(CONFIG_ARM64_64K_PAGES));
+
+	for_each_memblock(memory, mr) {
+		phys_addr_t start = mr->base;
+		phys_addr_t end = start + mr->size;
+		unsigned long vstart, vend;
+
+		if (start > pa_base || end <= pa_base)
+			continue;
+
+#ifdef CONFIG_ARM64_64K_PAGES
+		/* clip the region to PMD size */
+		vstart = max(va_base & PMD_MASK,
+			     round_up(__phys_to_virt(start) + va_offset,
+				      PAGE_SIZE));
+		vend = min(round_up(va_base + 1, PMD_SIZE),
+			   round_down(__phys_to_virt(end) + va_offset,
+				      PAGE_SIZE));
+#else
+		/* clip the region to PUD size */
+		vstart = max(va_base & PUD_MASK,
+			     round_up(__phys_to_virt(start) + va_offset,
+				      PMD_SIZE));
+		vend = min(round_up(va_base + 1, PUD_SIZE),
+			   round_down(__phys_to_virt(end) + va_offset,
+				      PMD_SIZE));
+#endif
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
-	 *
-	 * The initial direct kernel mapping, located@swapper_pg_dir, gives
-	 * us PUD_SIZE (4K pages) or PMD_SIZE (64K pages) memory starting from
-	 * PHYS_OFFSET (which must be aligned to 2MB as per
-	 * Documentation/arm64/booting.txt).
+	 * memory addressable from the early linear mapping.
 	 */
-	if (IS_ENABLED(CONFIG_ARM64_64K_PAGES))
-		limit = PHYS_OFFSET + PMD_SIZE;
-	else
-		limit = PHYS_OFFSET + PUD_SIZE;
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
@@ -409,21 +475,6 @@ static void __init map_mem(void)
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
1.9.1
