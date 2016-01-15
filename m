From: geoff@infradead.org (Geoff Levand)
Date: Fri, 15 Jan 2016 19:18:37 +0000
Subject: [PATCH 03/19] arm64: Add new asm macro copy_page
In-Reply-To: <cover.1452884156.git.geoff@infradead.org>
References: <cover.1452884156.git.geoff@infradead.org>
Message-ID: <f7dcd4d1b5a9b77eaef50f22f4040a26c6b40487.1452884156.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/assembler.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 21979a4..c47a623 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -24,6 +24,7 @@
 #define __ASM_ASSEMBLER_H
 
 #include <asm/asm-offsets.h>
+#include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
@@ -240,6 +241,24 @@ lr	.req	x30		// link register
 	.endm
 
 /*
+ * copy_page - copy src to dest using temp registers t1-t8
+ */
+	.macro copy_page dest:req src:req t1:req t2:req t3:req t4:req t5:req t6:req t7:req t8:req
+1:	ldp	\t1, \t2, [\src]
+	ldp	\t3, \t4, [\src, #16]
+	ldp	\t5, \t6, [\src, #32]
+	ldp	\t7, \t8, [\src, #48]
+	add	\src, \src, #64
+	stnp	\t1, \t2, [\dest]
+	stnp	\t3, \t4, [\dest, #16]
+	stnp	\t5, \t6, [\dest, #32]
+	stnp	\t7, \t8, [\dest, #48]
+	add	\dest, \dest, #64
+	tst	\src, #(PAGE_SIZE - 1)
+	b.ne	1b
+	.endm
+
+/*
  * Annotate a function as position independent, i.e., safe to be called before
  * the kernel virtual mapping is activated.
  */
-- 
2.5.0
