From: yaojun8558363@gmail.com (Jun Yao)
Date: Wed, 18 Jul 2018 18:17:22 +0800
Subject: [RESEND PATCH v4 1/6] arm64/mm: Introduce init_pg_dir
In-Reply-To: <20180718101727.10787-1-yaojun8558363@gmail.com>
References: <20180718101727.10787-1-yaojun8558363@gmail.com>
Message-ID: <20180718101727.10787-2-yaojun8558363@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add init_pg_dir to vmlinux.lds.S and boiler-plate
clearing/cleaning/invalidating it in head.S.

Signed-off-by: Jun Yao <yaojun8558363@gmail.com>
---
 arch/arm64/include/asm/assembler.h | 29 +++++++++++++++++++++++++++++
 arch/arm64/kernel/head.S           | 22 +++++++++++++++-------
 arch/arm64/kernel/vmlinux.lds.S    |  8 ++++++++
 3 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 0bcc98dbba56..eb363a915c0e 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -456,6 +456,35 @@ USER(\label, ic	ivau, \tmp2)			// invalidate I line PoU
 	b.ne	9998b
 	.endm
 
+/*
+ * clear_page - clear one page
+ *
+ *	start:	page aligned virtual address
+ */
+	.macro clear_page, start:req
+9996:	stp	xzr, xzr, [\start], #16
+	stp	xzr, xzr, [\start], #16
+	stp	xzr, xzr, [\start], #16
+	stp	xzr, xzr, [\start], #16
+	tst	\start, #(PAGE_SIZE - 1)
+	b.ne	9996b
+	.endm
+
+/*
+ * clear_pages - clear contiguous pages
+ *
+ *	start, end: page aligend virtual addresses
+ */
+	.macro clear_pages, start:req, end:req
+	sub	\end, \end, \start
+	lsr	\end, \end, #(PAGE_SHIFT)
+9997:	cbz	\end, 9998f
+	clear_page \start
+	sub	\end, \end, #1
+	b	9997b
+9998:
+	.endm
+
 /*
  * Annotate a function as position independent, i.e., safe to be called before
  * the kernel virtual mapping is activated.
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index b0853069702f..2c83a8c47e3f 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -295,18 +295,21 @@ __create_page_tables:
 	sub	x1, x1, x0
 	bl	__inval_dcache_area
 
+	adrp	x0, init_pg_dir
+	adrp	x1, init_pg_end
+	sub	x1, x1, x0
+	bl	__inval_dcache_area
+
 	/*
 	 * Clear the idmap and swapper page tables.
 	 */
 	adrp	x0, idmap_pg_dir
 	adrp	x1, swapper_pg_end
-	sub	x1, x1, x0
-1:	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	stp	xzr, xzr, [x0], #16
-	subs	x1, x1, #64
-	b.ne	1b
+	clear_pages x0, x1
+
+	adrp	x0, init_pg_dir
+	adrp	x1, init_pg_end
+	clear_pages x0, x1
 
 	mov	x7, SWAPPER_MM_MMUFLAGS
 
@@ -395,6 +398,11 @@ __create_page_tables:
 	dmb	sy
 	bl	__inval_dcache_area
 
+	adrp	x0, init_pg_dir
+	adrp	x1, init_pg_end
+	sub	x1, x1, x0
+	bl	__inval_dcache_area
+
 	ret	x28
 ENDPROC(__create_page_tables)
 	.ltorg
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 605d1b60469c..61d7cee3eaa6 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -68,6 +68,12 @@ jiffies = jiffies_64;
 #define TRAMP_TEXT
 #endif
 
+#define INIT_PG_TABLES					\
+	. = ALIGN(PAGE_SIZE);                           \
+	init_pg_dir = .;                                \
+	. += SWAPPER_DIR_SIZE;                          \
+	init_pg_end = .;
+
 /*
  * The size of the PE/COFF section that covers the kernel image, which
  * runs from stext to _edata, must be a round multiple of the PE/COFF
@@ -161,6 +167,8 @@ SECTIONS
 	__inittext_end = .;
 	__initdata_begin = .;
 
+	INIT_PG_TABLES
+
 	.init.data : {
 		INIT_DATA
 		INIT_SETUP(16)
-- 
2.17.1
