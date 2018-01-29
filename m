From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Jan 2018 11:59:59 +0000
Subject: [PATCH v2 8/9] arm64: assembler: Align phys_to_pte with pte_to_phys
In-Reply-To: <1517227200-20412-1-git-send-email-will.deacon@arm.com>
References: <1517227200-20412-1-git-send-email-will.deacon@arm.com>
Message-ID: <1517227200-20412-9-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pte_to_phys lives in assembler.h and takes its destination register as
the first argument. Move phys_to_pte out of head.S to sit with its
counterpart and rejig it to follow the same calling convention.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/assembler.h | 14 ++++++++++++++
 arch/arm64/kernel/head.S           | 24 ++----------------------
 2 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index e4495ef96058..f311a1ed34d0 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -523,6 +523,20 @@ alternative_endif
 #endif
 	.endm
 
+	.macro	phys_to_pte, pte, phys
+#ifdef CONFIG_ARM64_PA_BITS_52
+	/*
+	 * We assume \phys is 64K aligned and this is guaranteed by only
+	 * supporting this configuration with 64K pages.
+	 */
+	orr	\pte, \phys, \phys, lsr #36
+	and	\pte, \pte, #PTE_ADDR_MASK
+#else
+	mov	\pte, \phys
+#endif
+	.endm
+
+
 	.macro	pte_to_phys, phys, pte
 #ifdef CONFIG_ARM64_PA_BITS_52
 	ror	\phys, \pte, #16
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 341649c08337..25f5b2e400fb 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -148,26 +148,6 @@ preserve_boot_args:
 ENDPROC(preserve_boot_args)
 
 /*
- * Macro to arrange a physical address in a page table entry, taking care of
- * 52-bit addresses.
- *
- * Preserves:	phys
- * Returns:	pte
- */
-	.macro	phys_to_pte, phys, pte
-#ifdef CONFIG_ARM64_PA_BITS_52
-	/*
-	 * We assume \phys is 64K aligned and this is guaranteed by only
-	 * supporting this configuration with 64K pages.
-	 */
-	orr	\pte, \phys, \phys, lsr #36
-	and	\pte, \pte, #PTE_ADDR_MASK
-#else
-	mov	\pte, \phys
-#endif
-	.endm
-
-/*
  * Macro to create a table entry to the next page.
  *
  *	tbl:	page table address
@@ -181,7 +161,7 @@ ENDPROC(preserve_boot_args)
  */
 	.macro	create_table_entry, tbl, virt, shift, ptrs, tmp1, tmp2
 	add	\tmp1, \tbl, #PAGE_SIZE
-	phys_to_pte \tmp1, \tmp2
+	phys_to_pte \tmp2, \tmp1
 	orr	\tmp2, \tmp2, #PMD_TYPE_TABLE	// address of next table and entry type
 	lsr	\tmp1, \virt, #\shift
 	sub	\ptrs, \ptrs, #1
@@ -207,7 +187,7 @@ ENDPROC(preserve_boot_args)
  * Returns:	rtbl
  */
 	.macro populate_entries, tbl, rtbl, index, eindex, flags, inc, tmp1
-.Lpe\@:	phys_to_pte \rtbl, \tmp1
+.Lpe\@:	phys_to_pte \tmp1, \rtbl
 	orr	\tmp1, \tmp1, \flags	// tmp1 = table entry
 	str	\tmp1, [\tbl, \index, lsl #3]
 	add	\rtbl, \rtbl, \inc	// rtbl = pa next level
-- 
2.1.4
