From: james.morse@arm.com (James Morse)
Date: Wed, 27 Apr 2016 17:47:10 +0100
Subject: [PATCH v9 11/14] arm64: Add new asm macro copy_page
In-Reply-To: <1461775633-29715-1-git-send-email-james.morse@arm.com>
References: <1461775633-29715-1-git-send-email-james.morse@arm.com>
Message-ID: <1461775633-29715-12-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geoff Levand <geoff@infradead.org>

Kexec and hibernate need to copy pages of memory, but may not have all
of the kernel mapped, and are unable to call copy_page().

Add a simplistic copy_page() macro, that can be inlined in these
situations. lib/copy_page.S provides a bigger better version, but
uses more registers.

Signed-off-by: Geoff Levand <geoff@infradead.org>
[Changed asm label to 9998, added commit message]
Signed-off-by: James Morse <james.morse@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/assembler.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 3b3812a3e8b9..10b017c4bdd8 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -24,6 +24,7 @@
 #define __ASM_ASSEMBLER_H
 
 #include <asm/asm-offsets.h>
+#include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
@@ -280,6 +281,24 @@ lr	.req	x30		// link register
 	.endm
 
 /*
+ * copy_page - copy src to dest using temp registers t1-t8
+ */
+	.macro copy_page dest:req src:req t1:req t2:req t3:req t4:req t5:req t6:req t7:req t8:req
+9998:	ldp	\t1, \t2, [\src]
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
+	b.ne	9998b
+	.endm
+
+/*
  * Annotate a function as position independent, i.e., safe to be called before
  * the kernel virtual mapping is activated.
  */
-- 
2.8.0.rc3
