From: steve.capper@arm.com (Steve Capper)
Date: Fri, 17 Nov 2017 11:41:43 +0000
Subject: [PATCH 2/2] arm64: Extend early page table code to allow for larger
 kernels
In-Reply-To: <20171117114143.26577-1-steve.capper@arm.com>
References: <20171117114143.26577-1-steve.capper@arm.com>
Message-ID: <20171117114143.26577-3-steve.capper@arm.com>
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
to cover the mapping [KIMAGE_ADDR + VOFFSET, _end + SZ_2M] to allow
for kaslr.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/include/asm/kernel-pgtable.h |  20 ++++-
 arch/arm64/include/asm/pgtable.h        |   2 +-
 arch/arm64/kernel/head.S                | 148 +++++++++++++++++++++++---------
 arch/arm64/kernel/vmlinux.lds.S         |   1 +
 arch/arm64/mm/mmu.c                     |   3 +-
 5 files changed, 131 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/include/asm/kernel-pgtable.h b/arch/arm64/include/asm/kernel-pgtable.h
index 7803343e5881..04551aa1ca28 100644
--- a/arch/arm64/include/asm/kernel-pgtable.h
+++ b/arch/arm64/include/asm/kernel-pgtable.h
@@ -52,7 +52,25 @@
 #define IDMAP_PGTABLE_LEVELS	(ARM64_HW_PGTABLE_LEVELS(PHYS_MASK_SHIFT))
 #endif
 
-#define SWAPPER_DIR_SIZE	(SWAPPER_PGTABLE_LEVELS * PAGE_SIZE)
+#define EARLY_PGDS(vstart, vend) ((vend >> PGDIR_SHIFT) - (vstart >> PGDIR_SHIFT) + 1)
+
+#if SWAPPER_PGTABLE_LEVELS > 3
+#define EARLY_PUDS(vstart, vend) ((vend >> PUD_SHIFT) - (vstart >> PUD_SHIFT) + 1)
+#else
+#define EARLY_PUDS(vstart, vend) (0)
+#endif
+
+#if SWAPPER_PGTABLE_LEVELS > 2
+#define EARLY_PMDS(vstart, vend) ((vend >> PMD_SHIFT) - (vstart >> PMD_SHIFT) + 1)
+#else
+#define EARLY_PMDS(vstart, vend) (0)
+#endif
+
+#define EARLY_PAGES(vstart, vend) ( 1 			/* PGDIR page */				\
+			+ EARLY_PGDS((vstart), (vend)) 	/* each PGDIR needs a next level page table */	\
+			+ EARLY_PUDS((vstart), (vend))	/* each PUD needs a next level page table */	\
+			+ EARLY_PMDS((vstart), (vend)))	/* each PMD needs a next level page table */
+#define SWAPPER_DIR_SIZE (PAGE_SIZE * EARLY_PAGES(KIMAGE_VADDR + TEXT_OFFSET, _end + SZ_2M))
 #define IDMAP_DIR_SIZE		(IDMAP_PGTABLE_LEVELS * PAGE_SIZE)
 
 #ifdef CONFIG_ARM64_SW_TTBR0_PAN
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index b46e54c2399b..142697e4ba3e 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -667,7 +667,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
-
+extern pgd_t swapper_pg_end[];
 /*
  * Encode and decode a swap entry:
  *	bits 0-1:	present (must be zero)
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 0b243ecaf7ac..44ad2fca93c4 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -169,41 +169,108 @@ ENDPROC(preserve_boot_args)
 	.endm
 
 /*
- * Macro to populate the PGD (and possibily PUD) for the corresponding
- * block entry in the next level (tbl) for the given virtual address.
+ * Macro to populate page table entries, these entries can be pointers to the next level
+ * or last level entries pointing to physical memory.
  *
- * Preserves:	tbl, next, virt
- * Corrupts:	tmp1, tmp2
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
-	.macro	create_pgd_entry, tbl, virt, tmp1, tmp2
-	create_table_entry \tbl, \virt, PGDIR_SHIFT, PTRS_PER_PGD, \tmp1, \tmp2
-#if SWAPPER_PGTABLE_LEVELS > 3
-	create_table_entry \tbl, \virt, PUD_SHIFT, PTRS_PER_PUD, \tmp1, \tmp2
-#endif
-#if SWAPPER_PGTABLE_LEVELS > 2
-	create_table_entry \tbl, \virt, SWAPPER_TABLE_SHIFT, PTRS_PER_PTE, \tmp1, \tmp2
-#endif
+	.macro populate_entries, tbl, rtbl, index, eindex, flags, inc, tmp1
+9999:	orr	\tmp1, \rtbl, \flags	// tmp1 = table entry
+	str	\tmp1, [\tbl, \index, lsl #3]
+	add	\rtbl, \rtbl, \inc	// rtbl = pa next level
+	add	\index, \index, #1
+	cmp	\index, \eindex
+	b.ls	9999b
 	.endm
 
 /*
- * Macro to populate block entries in the page table for the start..end
- * virtual range (inclusive).
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
+ *	count:	On entry: how many entries required in previous level, scales our end index
+ *		On exit: returns how many entries required for next page table level
  *
- * Preserves:	tbl, flags
- * Corrupts:	phys, start, end, pstate
+ * Preserves:	vstart, vend, shift, ptrs
+ * Returns:	istart, iend, count
  */
-	.macro	create_block_map, tbl, flags, phys, start, end
-	lsr	\phys, \phys, #SWAPPER_BLOCK_SHIFT
-	lsr	\start, \start, #SWAPPER_BLOCK_SHIFT
-	and	\start, \start, #PTRS_PER_PTE - 1	// table index
-	orr	\phys, \flags, \phys, lsl #SWAPPER_BLOCK_SHIFT	// table entry
-	lsr	\end, \end, #SWAPPER_BLOCK_SHIFT
-	and	\end, \end, #PTRS_PER_PTE - 1		// table end index
-9999:	str	\phys, [\tbl, \start, lsl #3]		// store the entry
-	add	\start, \start, #1			// next entry
-	add	\phys, \phys, #SWAPPER_BLOCK_SIZE		// next block
-	cmp	\start, \end
-	b.ls	9999b
+	.macro compute_indices, vstart, vend, shift, ptrs, istart, iend, count
+	lsr	\iend, \vend, \shift
+	mov	\istart, \ptrs
+	sub	\istart, \istart, #1
+	and	\iend, \iend, \istart	// iend = (vend >> shift) & (ptrs - 1)
+	mov	\istart, \ptrs
+	sub	\count, \count, #1
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
+	add	\count, \count, #1
+	.endm
+
+/*
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
+ *
+ * Temporaries:	istart, iend, tmp, count, sv - these need to be different registers
+ * Preserves:	vstart, vend, flags
+ * Corrupts:	tbl, rtbl, istart, iend, tmp, count, sv
+ */
+	.macro map_memory, tbl, rtbl, vstart, vend, flags, phys, istart, iend, tmp, count, sv
+	add \rtbl, \tbl, #PAGE_SIZE
+	mov \sv, \rtbl
+	mov \count, #1
+	compute_indices \vstart, \vend, #PGDIR_SHIFT, #PTRS_PER_PGD, \istart, \iend, \count
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
@@ -221,14 +288,16 @@ __create_page_tables:
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
@@ -243,6 +312,7 @@ __create_page_tables:
 	 */
 	adrp	x0, idmap_pg_dir
 	adrp	x3, __idmap_text_start		// __pa(__idmap_text_start)
+	adrp	x4, __idmap_text_end		// __pa(__idmap_text_end)
 
 #ifndef CONFIG_ARM64_VA_BITS_48
 #define EXTRA_SHIFT	(PGDIR_SHIFT + PAGE_SHIFT - 3)
@@ -269,8 +339,7 @@ __create_page_tables:
 	 * this number conveniently equals the number of leading zeroes in
 	 * the physical address of __idmap_text_end.
 	 */
-	adrp	x5, __idmap_text_end
-	clz	x5, x5
+	clz	x5, x4
 	cmp	x5, TCR_T0SZ(VA_BITS)	// default T0SZ small enough?
 	b.ge	1f			// .. then skip additional level
 
@@ -279,14 +348,11 @@ __create_page_tables:
 	dmb	sy
 	dc	ivac, x6		// Invalidate potentially stale cache line
 
-	create_table_entry x0, x3, EXTRA_SHIFT, EXTRA_PTRS, x5, x6
+	create_table_entry x0, x3, EXTRA_SHIFT, EXTRA_PTRS, x10, x11
 1:
 #endif
 
-	create_pgd_entry x0, x3, x5, x6
-	mov	x5, x3				// __pa(__idmap_text_start)
-	adr_l	x6, __idmap_text_end		// __pa(__idmap_text_end)
-	create_block_map x0, x7, x3, x5, x6
+	map_memory x0, x1, x3, x4, x7, x3, x10, x11, x12, x13, x14
 
 	/*
 	 * Map the kernel image (starting with PHYS_OFFSET).
@@ -294,12 +360,13 @@ __create_page_tables:
 	adrp	x0, swapper_pg_dir
 	mov_q	x5, KIMAGE_VADDR + TEXT_OFFSET	// compile time __va(_text)
 	add	x5, x5, x23			// add KASLR displacement
-	create_pgd_entry x0, x5, x3, x6
+
 	adrp	x6, _end			// runtime __pa(_end)
 	adrp	x3, _text			// runtime __pa(_text)
 	sub	x6, x6, x3			// _end - _text
 	add	x6, x6, x5			// runtime __va(_end)
-	create_block_map x0, x7, x3, x5, x6
+
+	map_memory x0, x1, x5, x6, x7, x3, x10, x11, x12, x13, x14
 
 	/*
 	 * Since the page tables have been populated with non-cacheable
@@ -307,7 +374,8 @@ __create_page_tables:
 	 * tables again to remove any speculatively loaded cache lines.
 	 */
 	adrp	x0, idmap_pg_dir
-	ldr	x1, =(IDMAP_DIR_SIZE + SWAPPER_DIR_SIZE + RESERVED_TTBR0_SIZE)
+	adrp	x1, swapper_pg_end
+	sub	x1, x1, x0
 	dmb	sy
 	bl	__inval_dcache_area
 
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 6aa717582f6f..e366a54347a5 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -211,6 +211,7 @@ SECTIONS
 #endif
 	swapper_pg_dir = .;
 	. += SWAPPER_DIR_SIZE;
+	swapper_pg_end = .;
 
 	__pecoff_data_size = ABSOLUTE(. - __initdata_begin);
 	_end = .;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index f1eb15e0e864..758d276e2851 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -612,7 +612,8 @@ void __init paging_init(void)
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
