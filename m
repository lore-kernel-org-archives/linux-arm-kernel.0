From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 20 Mar 2015 18:02:54 +0100
Subject: [PATCH] arm64: relax Image placement requirement
Message-ID: <1426870974-4801-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is another possible approach to fixing the current, flawed
EFI Image placement logic: instead of fixing that logic and the
documentation, why not relax the requirement that the kernel
Image not be placed across a 512 MB boundary?

---------------->8-----------------

This patch changes the early page table code so that two adjacent
entries are used to map two pages worth of block entries at the
lowest level, both for idmap_pg_dir and swapper_pg_dir.

The purpose is to allow the kernel Image to cross a 512 MB or 1 GB
alignment boundary (depending on page size), which is something that
is not specifically banned by the current wording of the boot protocol.
(The boot protocol stipulates that the kernel must be placed within
512 MB if the beginning of RAM. However, the beginning of RAM is not
necessarily aligned to 512 MB)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/page.h |  4 ++--
 arch/arm64/kernel/head.S      | 17 +++++++++++++----
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 3d02b1869eb8..d2189c359364 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -43,8 +43,8 @@
 #define SWAPPER_PGTABLE_LEVELS	(CONFIG_ARM64_PGTABLE_LEVELS - 1)
 #endif
 
-#define SWAPPER_DIR_SIZE	(SWAPPER_PGTABLE_LEVELS * PAGE_SIZE)
-#define IDMAP_DIR_SIZE		(3 * PAGE_SIZE)
+#define SWAPPER_DIR_SIZE	((SWAPPER_PGTABLE_LEVELS + 1) * PAGE_SIZE)
+#define IDMAP_DIR_SIZE		(4 * PAGE_SIZE)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 0dbdb4f3634f..9c3f95f30421 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -274,18 +274,21 @@ ENDPROC(preserve_boot_args)
  *	virt:	virtual address
  *	shift:	#imm page table shift
  *	ptrs:	#imm pointers per table page
+ * 	offset:	#imm offset into the lowest translation level, in pages
  *
  * Preserves:	virt
  * Corrupts:	tmp1, tmp2
  * Returns:	tbl -> next level table page address
  */
-	.macro	create_table_entry, tbl, virt, shift, ptrs, tmp1, tmp2
+	.macro	create_table_entry, tbl, virt, shift, ptrs, tmp1, tmp2, offset=0
 	lsr	\tmp1, \virt, #\shift
+	.if	\offset
+	add	\tmp1, \tmp1, #\offset
+	.endif
 	and	\tmp1, \tmp1, #\ptrs - 1	// table index
-	add	\tmp2, \tbl, #PAGE_SIZE
+	add	\tmp2, \tbl, #(\offset + 1) * PAGE_SIZE
 	orr	\tmp2, \tmp2, #PMD_TYPE_TABLE	// address of next table and entry type
 	str	\tmp2, [\tbl, \tmp1, lsl #3]
-	add	\tbl, \tbl, #PAGE_SIZE		// next level table page
 	.endm
 
 /*
@@ -297,9 +300,14 @@ ENDPROC(preserve_boot_args)
  */
 	.macro	create_pgd_entry, tbl, virt, tmp1, tmp2
 	create_table_entry \tbl, \virt, PGDIR_SHIFT, PTRS_PER_PGD, \tmp1, \tmp2
-#if SWAPPER_PGTABLE_LEVELS == 3
+#if SWAPPER_PGTABLE_LEVELS != 3
+	create_table_entry \tbl, \virt, PGDIR_SHIFT, PTRS_PER_PGD, \tmp1, \tmp2, 1
+#else
+	add	\tbl, \tbl, #PAGE_SIZE		// next level table page
 	create_table_entry \tbl, \virt, TABLE_SHIFT, PTRS_PER_PTE, \tmp1, \tmp2
+	create_table_entry \tbl, \virt, TABLE_SHIFT, PTRS_PER_PTE, \tmp1, \tmp2, 1
 #endif
+	add	\tbl, \tbl, #PAGE_SIZE		// next level table page
 	.endm
 
 /*
@@ -396,6 +404,7 @@ __create_page_tables:
 	str_l	x5, idmap_t0sz, x6
 
 	create_table_entry x0, x3, EXTRA_SHIFT, EXTRA_PTRS, x5, x6
+	add	x0, x0, #PAGE_SIZE		// next level table page
 1:
 #endif
 
-- 
1.8.3.2
