From: steve.capper@arm.com (Steve Capper)
Date: Thu, 11 Jan 2018 10:11:59 +0000
Subject: [PATCH V4 3/3] arm64: Extend early page table code to allow for
 larger kernels
In-Reply-To: <20180111101159.9748-1-steve.capper@arm.com>
References: <20180111101159.9748-1-steve.capper@arm.com>
Message-ID: <20180111101159.9748-4-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the early assembler page table code assumes that precisely
1xpgd, 1xpud, 1xpmd are sufficient to represent the early kernel text
mappings.

Unfortunately this is rarely the case when running with a 16KB granule,
and we also run into limits with 4KB granule when building much larger
kernels.

This patch re-writes the early page table logic to compute indices of
mappings for each level of page table, and if multiple indices are
required, the next-level page table is scaled up accordingly.

Also the required size of the swapper_pg_dir is computed at link time
to cover the mapping [KIMAGE_ADDR + VOFFSET, _end]. When KASLR is
enabled, an extra page is set aside for each level that may require extra
entries at runtime.

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Steve Capper <steve.capper@arm.com>

---
Changed in V4:
local loop variable now unique to macro instatiation,
count logic simplified
---
 arch/arm64/include/asm/kernel-pgtable.h |  47 ++++++++++-
 arch/arm64/include/asm/pgtable.h        |   1 +
 arch/arm64/kernel/head.S                | 144 +++++++++++++++++++++++---------
 arch/arm64/kernel/vmlinux.lds.S         |   1 +
 arch/arm64/mm/mmu.c                     |   3 +-
 5 files changed, 156 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 77a27af01371..82386e860dd2 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -52,7 +52,52 @@
 #define IDMAP_PGTABLE_LEVELS	(ARM64_HW_PGTABLE_LEVELS(PHYS_MASK_SHIFT))
 #endif
 
-#define SWAPPER_DIR_SIZE	(SWAPPER_PGTABLE_LEVELS * PAGE_SIZE)
+
+/*
+ * If KASLR is enabled, then an offset K is added to the kernel address
+ * space. The bottom 21 bits of this offset are zero to guarantee 2MB
+ * alignment for PA and VA.
+ *
+ * For each pagetable level of the swapper, we know that the shift will
+ * be larger than 21 (for the 4KB granule case we use section maps thus
+ * the smallest shift is actually 30) thus there is the possibility that
+ * KASLR can increase the number of pagetable entries by 1, so we make
+ * room for this extra entry.
+ *
+ * Note KASLR cannot increase the number of required entries for a level
+ * by more than one because it increments both the virtual start and end
+ * addresses equally (the extra entry comes from the case where the end
+ * address is just pushed over a boundary and the start address isn't).
+ */
+
+#ifdef CONFIG_RANDOMIZE_BASE
+#define EARLY_KASLR	(1)
+#else
+#define EARLY_KASLR	(0)
+#endif
+
+#define EARLY_ENTRIES(vstart, vend, shift) (((vend) >> (shift)) \
+					- ((vstart) >> (shift)) + 1 + EARLY_KASLR)
+
+#define EARLY_PGDS(vstart, vend) (EARLY_ENTRIES(vstart, vend, PGDIR_SHIFT))
+
+#if SWAPPER_PGTABLE_LEVELS > 3
+#define EARLY_PUDS(vstart, vend) (EARLY_ENTRIES(vstart, vend, PUD_SHIFT))
+#else
+#define EARLY_PUDS(vstart, vend) (0)
+#endif
+
+#if SWAPPER_PGTABLE_LEVELS > 2
+#define EARLY_PMDS(vstart, vend) (EARLY_ENTRIES(vstart, vend, SWAPPER_TABLE_SHIFT))
+#else
+#define EARLY_PMDS(vstart, vend) (0)
+#endif
+
+#define EARLY_PAGES(vstart, vend) ( 1 			/* PGDIR page */				\
+			+ EARLY_PGDS((vstart), (vend)) 	/* each PGDIR needs a next level page table */	\
+			+ EARLY_PUDS((vstart), (vend))	/* each PUD needs a next level page table */	\
+			+ EARLY_PMDS((vstart), (vend)))	/* each PMD needs a next level page table */
+#define SWAPPER_DIR_SIZE (PAGE_SIZE * EARLY_PAGES(KIMAGE_VADDR + TEXT_OFFSET, _end))
 #define IDMAP_DIR_SIZE		(IDMAP_PGTABLE_LEVELS * PAGE_SIZE)
 
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index bfa237e892f1..54b0a8398055 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -706,6 +706,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 #endif
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
+extern pgd_t swapper_pg_end[];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
 extern pgd_t tramp_pg_dir[PTRS_PER_PGD];
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 66f01869e97c..95748a00eb89 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -191,44 +191,109 @@ ENDPROC(preserve_boot_args)
 	.endm
 
 /*
- * Macro to populate the PGD (and possibily PUD) for the corresponding
- * block entry in the next level (tbl) for the given virtual address.
+ * Macro to populate page table entries, these entries can be pointers to the next level
+ * or last level entries pointing to physical memory.
  *
- * Preserves:	tbl, next, virt
- * Corrupts:	ptrs_per_pgd, tmp1, tmp2
+ *	tbl:	page table address
+ *	rtbl:	pointer to page table or physical memory
+ *	index:	start index to write
+ *	eindex:	end index to write - [index, eindex] written to
+ *	flags:	flags for pagetable entry to or in
+ *	inc:	increment to rtbl between each entry
+ *	tmp1:	temporary variable
+ *
+ * Preserves:	tbl, eindex, flags, inc
+ * Corrupts:	index, tmp1
+ * Returns:	rtbl
  */
-	.macro	create_pgd_entry, tbl, virt, ptrs_per_pgd, tmp1, tmp2
-	create_table_entry \tbl, \virt, PGDIR_SHIFT, \ptrs_per_pgd, \tmp1, \tmp2
-#if SWAPPER_PGTABLE_LEVELS > 3
-	mov	\ptrs_per_pgd, PTRS_PER_PUD
-	create_table_entry \tbl, \virt, PUD_SHIFT, \ptrs_per_pgd, \tmp1, \tmp2
-#endif
-#if SWAPPER_PGTABLE_LEVELS > 2
-	mov	\ptrs_per_pgd, PTRS_PER_PTE
-	create_table_entry \tbl, \virt, SWAPPER_TABLE_SHIFT, \ptrs_per_pgd, \tmp1, \tmp2
-#endif
+	.macro populate_entries, tbl, rtbl, index, eindex, flags, inc, tmp1
+.Lpe\@:	phys_to_pte \rtbl, \tmp1
+	orr	\tmp1, \tmp1, \flags	// tmp1 = table entry
+	str	\tmp1, [\tbl, \index, lsl #3]
+	add	\rtbl, \rtbl, \inc	// rtbl = pa next level
+	add	\index, \index, #1
+	cmp	\index, \eindex
+	b.ls	.Lpe\@
+	.endm
+
+/*
+ * Compute indices of table entries from virtual address range. If multiple entries
+ * were needed in the previous page table level then the next page table level is assumed
+ * to be composed of multiple pages. (This effectively scales the end index).
+ *
+ *	vstart:	virtual address of start of range
+ *	vend:	virtual address of end of range
+ *	shift:	shift used to transform virtual address into index
+ *	ptrs:	number of entries in page table
+ *	istart:	index in table corresponding to vstart
+ *	iend:	index in table corresponding to vend
+ *	count:	On entry: how many extra entries were required in previous level, scales
+ *			  our end index.
+ *		On exit: returns how many extra entries required for next page table level
+ *
+ * Preserves:	vstart, vend, shift, ptrs
+ * Returns:	istart, iend, count
+ */
+	.macro compute_indices, vstart, vend, shift, ptrs, istart, iend, count
+	lsr	\iend, \vend, \shift
+	mov	\istart, \ptrs
+	sub	\istart, \istart, #1
+	and	\iend, \iend, \istart	// iend = (vend >> shift) & (ptrs - 1)
+	mov	\istart, \ptrs
+	mul	\istart, \istart, \count
+	add	\iend, \iend, \istart	// iend += (count - 1) * ptrs
+					// our entries span multiple tables
+
+	lsr	\istart, \vstart, \shift
+	mov	\count, \ptrs
+	sub	\count, \count, #1
+	and	\istart, \istart, \count
+
+	sub	\count, \iend, \istart
 	.endm
 
 /*
- * Macro to populate block entries in the page table for the start..end
- * virtual range (inclusive).
+ * Map memory for specified virtual address range. Each level of page table needed supports
+ * multiple entries. If a level requires n entries the next page table level is assumed to be
+ * formed from n pages.
+ *
+ *	tbl:	location of page table
+ *	rtbl:	address to be used for first level page table entry (typically tbl + PAGE_SIZE)
+ *	vstart:	start address to map
+ *	vend:	end address to map - we map [vstart, vend]
+ *	flags:	flags to use to map last level entries
+ *	phys:	physical address corresponding to vstart - physical memory is contiguous
+ *	pgds:	the number of pgd entries
  *
- * Preserves:	tbl, flags
- * Corrupts:	phys, start, end, tmp, pstate
+ * Temporaries:	istart, iend, tmp, count, sv - these need to be different registers
+ * Preserves:	vstart, vend, flags
+ * Corrupts:	tbl, rtbl, istart, iend, tmp, count, sv
  */
-	.macro	create_block_map, tbl, flags, phys, start, end, tmp
-	lsr	\start, \start, #SWAPPER_BLOCK_SHIFT
-	and	\start, \start, #PTRS_PER_PTE - 1	// table index
-	bic	\phys, \phys, #SWAPPER_BLOCK_SIZE - 1
-	lsr	\end, \end, #SWAPPER_BLOCK_SHIFT
-	and	\end, \end, #PTRS_PER_PTE - 1		// table end index
-9999:	phys_to_pte \phys, \tmp
-	orr	\tmp, \tmp, \flags			// table entry
-	str	\tmp, [\tbl, \start, lsl #3]		// store the entry
-	add	\start, \start, #1			// next entry
-	add	\phys, \phys, #SWAPPER_BLOCK_SIZE		// next block
-	cmp	\start, \end
-	b.ls	9999b
+	.macro map_memory, tbl, rtbl, vstart, vend, flags, phys, pgds, istart, iend, tmp, count, sv
+	add \rtbl, \tbl, #PAGE_SIZE
+	mov \sv, \rtbl
+	mov \count, #0
+	compute_indices \vstart, \vend, #PGDIR_SHIFT, \pgds, \istart, \iend, \count
+	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp
+	mov \tbl, \sv
+	mov \sv, \rtbl
+
+#if SWAPPER_PGTABLE_LEVELS > 3
+	compute_indices \vstart, \vend, #PUD_SHIFT, #PTRS_PER_PUD, \istart, \iend, \count
+	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp
+	mov \tbl, \sv
+	mov \sv, \rtbl
+#endif
+
+#if SWAPPER_PGTABLE_LEVELS > 2
+	compute_indices \vstart, \vend, #SWAPPER_TABLE_SHIFT, #PTRS_PER_PMD, \istart, \iend, \count
+	populate_entries \tbl, \rtbl, \istart, \iend, #PMD_TYPE_TABLE, #PAGE_SIZE, \tmp
+	mov \tbl, \sv
+#endif
+
+	compute_indices \vstart, \vend, #SWAPPER_BLOCK_SHIFT, #PTRS_PER_PTE, \istart, \iend, \count
+	bic \count, \phys, #SWAPPER_BLOCK_SIZE - 1
+	populate_entries \tbl, \count, \istart, \iend, \flags, #SWAPPER_BLOCK_SIZE, \tmp
 	.endm
 
 /*
@@ -246,14 +311,16 @@ __create_page_tables:
 	 * dirty cache lines being evicted.
 	 */
 	adrp	x0, idmap_pg_dir
-	ldr	x1, =(IDMAP_DIR_SIZE + SWAPPER_DIR_SIZE + RESERVED_TTBR0_SIZE)
+	adrp	x1, swapper_pg_end
+	sub	x1, x1, x0
 	bl	__inval_dcache_area
 
 	/*
 	 * Clear the idmap and swapper page tables.
 	 */
 	adrp	x0, idmap_pg_dir
-	ldr	x1, =(IDMAP_DIR_SIZE + SWAPPER_DIR_SIZE + RESERVED_TTBR0_SIZE)
+	adrp	x1, swapper_pg_end
+	sub	x1, x1, x0
 1:	stp	xzr, xzr, [x0], #16
 	stp	xzr, xzr, [x0], #16
 	stp	xzr, xzr, [x0], #16
@@ -318,10 +385,10 @@ __create_page_tables:
 #endif
 1:
 	ldr_l	x4, idmap_ptrs_per_pgd
-	create_pgd_entry x0, x3, x4, x5, x6
 	mov	x5, x3				// __pa(__idmap_text_start)
 	adr_l	x6, __idmap_text_end		// __pa(__idmap_text_end)
-	create_block_map x0, x7, x3, x5, x6, x4
+
+	map_memory x0, x1, x3, x6, x7, x3, x4, x10, x11, x12, x13, x14
 
 	/*
 	 * Map the kernel image (starting with PHYS_OFFSET).
@@ -330,12 +397,12 @@ __create_page_tables:
 	mov_q	x5, KIMAGE_VADDR + TEXT_OFFSET	// compile time __va(_text)
 	add	x5, x5, x23			// add KASLR displacement
 	mov	x4, PTRS_PER_PGD
-	create_pgd_entry x0, x5, x4, x3, x6
 	adrp	x6, _end			// runtime __pa(_end)
 	adrp	x3, _text			// runtime __pa(_text)
 	sub	x6, x6, x3			// _end - _text
 	add	x6, x6, x5			// runtime __va(_end)
-	create_block_map x0, x7, x3, x5, x6, x4
+
+	map_memory x0, x1, x5, x6, x7, x3, x4, x10, x11, x12, x13, x14
 
 	/*
 	 * Since the page tables have been populated with non-cacheable
@@ -343,7 +410,8 @@ __create_page_tables:
 	 * tables again to remove any speculatively loaded cache lines.
 	 */
 	adrp	x0, idmap_pg_dir
-	ldr	x1, =(IDMAP_DIR_SIZE + SWAPPER_DIR_SIZE + RESERVED_TTBR0_SIZE)
+	adrp	x1, swapper_pg_end
+	sub	x1, x1, x0
 	dmb	sy
 	bl	__inval_dcache_area
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 4c7112a47469..0221aca6493d 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -230,6 +230,7 @@ SECTIONS
 #endif
 	swapper_pg_dir = .;
 	. += SWAPPER_DIR_SIZE;
+	swapper_pg_end = .;
 
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
 	_end = .;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 4071602031ed..fdac11979bae 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -644,7 +644,8 @@ void __init paging_init(void)
 	 * allocated with it.
 	 */
 	memblock_free(__pa_symbol(swapper_pg_dir) + PAGE_SIZE,
-		      SWAPPER_DIR_SIZE - PAGE_SIZE);
+		      __pa_symbol(swapper_pg_end) - __pa_symbol(swapper_pg_dir)
+		      - PAGE_SIZE);
 }
 
 /*
-- 
2.11.0
