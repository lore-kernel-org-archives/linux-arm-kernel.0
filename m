From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Wed, 13 Dec 2017 17:07:19 +0000
Subject: [PATCH 04/10] arm64: head.S: handle 52-bit PAs in PTEs in early page
 table setup
In-Reply-To: <1513184845-8711-1-git-send-email-kristina.martsenko@arm.com>
References: <1513184845-8711-1-git-send-email-kristina.martsenko@arm.com>
Message-ID: <1513184845-8711-5-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The top 4 bits of a 52-bit physical address are positioned at bits
12..15 in page table entries. Introduce a macro to move the bits there,
and change the early ID map and swapper table setup code to use it.

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/pgtable-hwdef.h |  6 ++++++
 arch/arm64/kernel/head.S               | 36 +++++++++++++++++++++++++---------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 2b3104af79d0..c59c69e02036 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -168,6 +168,12 @@
 #define PTE_UXN			(_AT(pteval_t, 1) << 54)	/* User XN */
 #define PTE_HYP_XN		(_AT(pteval_t, 1) << 54)	/* HYP XN */
 
+#ifdef CONFIG_ARM64_PA_BITS_52
+#define PTE_ADDR_LOW		(((_AT(pteval_t, 1) << (48 - PAGE_SHIFT)) - 1) << PAGE_SHIFT)
+#define PTE_ADDR_HIGH		(_AT(pteval_t, 0xf) << 12)
+#define PTE_ADDR_MASK_52	(PTE_ADDR_LOW | PTE_ADDR_HIGH)
+#endif
+
 /*
  * AttrIndx[2:0] encoding (mapping attributes defined in the MAIR* registers).
  */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 0addea3760a6..ddee8b347f60 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -148,6 +148,22 @@ preserve_boot_args:
 ENDPROC(preserve_boot_args)
 
 /*
+ * Macro to arrange a physical address in a page table entry, taking care of
+ * 52-bit addresses.
+ *
+ * Preserves:	phys
+ * Returns:	pte
+ */
+	.macro	phys_to_pte, phys, pte
+#ifdef CONFIG_ARM64_PA_BITS_52
+	orr	\pte, \phys, \phys, lsr #36
+	and	\pte, \pte, #PTE_ADDR_MASK_52
+#else
+	mov	\pte, \phys
+#endif
+	.endm
+
+/*
  * Macro to create a table entry to the next page.
  *
  *	tbl:	page table address
@@ -160,10 +176,11 @@ ENDPROC(preserve_boot_args)
  * Returns:	tbl -> next level table page address
  */
 	.macro	create_table_entry, tbl, virt, shift, ptrs, tmp1, tmp2
+	add	\tmp1, \tbl, #PAGE_SIZE
+	phys_to_pte \tmp1, \tmp2
+	orr	\tmp2, \tmp2, #PMD_TYPE_TABLE	// address of next table and entry type
 	lsr	\tmp1, \virt, #\shift
 	and	\tmp1, \tmp1, #\ptrs - 1	// table index
-	add	\tmp2, \tbl, #PAGE_SIZE
-	orr	\tmp2, \tmp2, #PMD_TYPE_TABLE	// address of next table and entry type
 	str	\tmp2, [\tbl, \tmp1, lsl #3]
 	add	\tbl, \tbl, #PAGE_SIZE		// next level table page
 	.endm
@@ -190,16 +207,17 @@ ENDPROC(preserve_boot_args)
  * virtual range (inclusive).
  *
  * Preserves:	tbl, flags
- * Corrupts:	phys, start, end, pstate
+ * Corrupts:	phys, start, end, tmp
  */
-	.macro	create_block_map, tbl, flags, phys, start, end
-	lsr	\phys, \phys, #SWAPPER_BLOCK_SHIFT
+	.macro	create_block_map, tbl, flags, phys, start, end, tmp
 	lsr	\start, \start, #SWAPPER_BLOCK_SHIFT
 	and	\start, \start, #PTRS_PER_PTE - 1	// table index
-	orr	\phys, \flags, \phys, lsl #SWAPPER_BLOCK_SHIFT	// table entry
+	bic	\phys, \phys, #SWAPPER_BLOCK_SIZE - 1
 	lsr	\end, \end, #SWAPPER_BLOCK_SHIFT
 	and	\end, \end, #PTRS_PER_PTE - 1		// table end index
-9999:	str	\phys, [\tbl, \start, lsl #3]		// store the entry
+9999:	phys_to_pte \phys, \tmp
+	orr	\tmp, \tmp, \flags			// table entry
+	str	\tmp, [\tbl, \start, lsl #3]		// store the entry
 	add	\start, \start, #1			// next entry
 	add	\phys, \phys, #SWAPPER_BLOCK_SIZE		// next block
 	cmp	\start, \end
@@ -286,7 +304,7 @@ __create_page_tables:
 	create_pgd_entry x0, x3, x5, x6
 	mov	x5, x3				// __pa(__idmap_text_start)
 	adr_l	x6, __idmap_text_end		// __pa(__idmap_text_end)
-	create_block_map x0, x7, x3, x5, x6
+	create_block_map x0, x7, x3, x5, x6, x4
 
 	/*
 	 * Map the kernel image (starting with PHYS_OFFSET).
@@ -299,7 +317,7 @@ __create_page_tables:
 	adrp	x3, _text			// runtime __pa(_text)
 	sub	x6, x6, x3			// _end - _text
 	add	x6, x6, x5			// runtime __va(_end)
-	create_block_map x0, x7, x3, x5, x6
+	create_block_map x0, x7, x3, x5, x6, x4
 
 	/*
 	 * Since the page tables have been populated with non-cacheable
-- 
2.1.4
