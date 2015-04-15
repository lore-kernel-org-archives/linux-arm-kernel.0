From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 15 Apr 2015 17:34:20 +0200
Subject: [PATCH v4 09/13] arm64: mm: explicitly bootstrap the linear mapping
In-Reply-To: <1429112064-19952-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1429112064-19952-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1429112064-19952-10-git-send-email-ard.biesheuvel@linaro.org>
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
 arch/arm64/kernel/vmlinux.lds.S | 18 ++++++++-
 arch/arm64/mm/mmu.c             | 89 +++++++++++++++++++++++++++--------------
 2 files changed, 75 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index ceec4def354b..338eaa7bcbfd 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -68,6 +68,17 @@ PECOFF_FILE_ALIGNMENT = 0x200;
 #define ALIGN_DEBUG_RO_MIN(min)		. = ALIGN(min);
 #endif
 
+/*
+ * The pgdir region needs to be mappable using a single PMD or PUD sized region,
+ * so it should not cross a 512 MB or 1 GB alignment boundary, respectively
+ * (depending on page size). So align to an upper bound of its size.
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
@@ -160,7 +171,7 @@ SECTIONS
 
 	BSS_SECTION(0, 0, 0)
 
-	.pgdir (NOLOAD) : ALIGN(PAGE_SIZE) {
+	.pgdir (NOLOAD) : ALIGN(PGDIR_ALIGN) {
 		idmap_pg_dir = .;
 		. += IDMAP_DIR_SIZE;
 		swapper_pg_dir = .;
@@ -185,6 +196,11 @@ ASSERT(__idmap_text_end - (__idmap_text_start & ~(SZ_4K - 1)) <= SZ_4K,
 	"ID map text too big or misaligned")
 
 /*
+ * Check that the chosen PGDIR_ALIGN value if sufficient.
+ */
+ASSERT(SIZEOF(.pgdir) < ALIGNOF(.pgdir), ".pgdir size exceeds its alignment")
+
+/*
  * If padding is applied before .head.text, virt<->phys conversions will fail.
  */
 ASSERT(_text == (PAGE_OFFSET + TEXT_OFFSET), "HEAD is misaligned")
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index c27ab20a5ba9..93e5a2497f01 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -380,26 +380,68 @@ static void __init bootstrap_early_mapping(unsigned long addr,
 	}
 }
 
+static void __init bootstrap_linear_mapping(unsigned long va_offset)
+{
+	/*
+	 * Bootstrap the linear range that covers swapper_pg_dir so that the
+	 * statically allocated page tables as well as newly allocated ones
+	 * are accessible via the linear mapping.
+	 */
+	static struct bootstrap_pgtables linear_bs_pgtables __pgdir;
+	const phys_addr_t swapper_phys = __pa(swapper_pg_dir);
+	unsigned long swapper_virt = __phys_to_virt(swapper_phys) + va_offset;
+	struct memblock_region *reg;
+
+	bootstrap_early_mapping(swapper_virt, &linear_bs_pgtables,
+				IS_ENABLED(CONFIG_ARM64_64K_PAGES));
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
+		vstart = max(swapper_virt & PMD_MASK,
+			     round_up(__phys_to_virt(start + va_offset),
+				      PAGE_SIZE));
+		vend = min(round_up(swapper_virt, PMD_SIZE),
+			   round_down(__phys_to_virt(end + va_offset),
+				      PAGE_SIZE));
+#else
+		/* clip the region to PUD size */
+		vstart = max(swapper_virt & PUD_MASK,
+			     round_up(__phys_to_virt(start + va_offset),
+				      PMD_SIZE));
+		vend = min(round_up(swapper_virt, PUD_SIZE),
+			   round_down(__phys_to_virt(end + va_offset),
+				      PMD_SIZE));
+#endif
+
+		create_mapping(__pa(vstart - va_offset), vstart, vend - vstart,
+			       PAGE_KERNEL_EXEC);
+
+		/*
+		 * Temporarily limit the memblock range. We need to do this as
+		 * create_mapping requires puds, pmds and ptes to be allocated
+		 * from memory addressable from the early linear mapping.
+		 */
+		memblock_set_current_limit(__pa(vend - va_offset));
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
+	bootstrap_linear_mapping(0);
 
 	/* map all the memory banks */
 	for_each_memblock(memory, reg) {
@@ -409,21 +451,6 @@ static void __init map_mem(void)
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
