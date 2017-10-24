From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 24 Oct 2017 18:40:36 +0100
Subject: [PATCH] arm64: asm-bug: Renumber macro local labels to avoid clashes
Message-ID: <1508866836-29574-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently ASM_BUG() and its constituent macros define local
assembler labels 0, 1 and 2 internally, which carries a high risk
of clash with callers' labels and consequent mis-assembly.

This patch gives the labels a big random offset to minimise the
chance of such errors.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/asm-bug.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
index 636e755..b3552c4 100644
--- a/arch/arm64/include/asm/asm-bug.h
+++ b/arch/arm64/include/asm/asm-bug.h
@@ -22,10 +22,10 @@
 #define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
 #define __BUGVERBOSE_LOCATION(file, line)			\
 		.pushsection .rodata.str,"aMS", at progbits,1;	\
-	2:	.string file;					\
+	14472:	.string file;					\
 		.popsection;					\
 								\
-		.long 2b - 0b;					\
+		.long 14472b - 14470b;				\
 		.short line;
 #else
 #define _BUGVERBOSE_LOCATION(file, line)
@@ -36,11 +36,11 @@
 #define __BUG_ENTRY(flags) 				\
 		.pushsection __bug_table,"aw";		\
 		.align 2;				\
-	0:	.long 1f - 0b;				\
+	14470:	.long 14471f - 14470b;			\
 _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
 		.short flags; 				\
 		.popsection;				\
-	1:
+	14471:
 #else
 #define __BUG_ENTRY(flags)
 #endif
-- 
2.1.4
