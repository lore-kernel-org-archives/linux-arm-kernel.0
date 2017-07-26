From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 26 Jul 2017 19:18:24 +0100
Subject: [PATCHv2 1/7] arm64: Add ASM_BUG()
In-Reply-To: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
References: <1501093110-3844-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1501093110-3844-2-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently. we can only use BUG() from C code, though there are
situations where we would like an equivalent mechanism in assembly code.

This patch refactors our BUG() definition such that it can be used in
either C or assembly, in the form of a new ASM_BUG().

The refactoring requires the removal of escape sequences, such as '\n'
and '\t', but these aren't strictly necessary as we can use ';' to
terminate assembler statements.

The low-level assembly is factored out into <asm/asm-bug.h>, with
<asm/bug.h> retained as the C wrapper.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/asm-bug.h | 54 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/bug.h     | 35 +++-----------------------
 2 files changed, 57 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm64/include/asm/asm-bug.h

diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
new file mode 100644
index 0000000..4a0f708
--- /dev/null
+++ b/arch/arm64/include/asm/asm-bug.h
@@ -0,0 +1,54 @@
+#ifndef __ASM_ASM_BUG_H
+/*
+ * Copyright (C) 2017  ARM Limited
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+#define __ASM_ASM_BUG_H
+
+#include <asm/brk-imm.h>
+
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+#define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
+#define __BUGVERBOSE_LOCATION(file, line)			\
+		.pushsection .rodata.str,"aMS", at progbits,1;	\
+	2:	.string file;					\
+		.popsection;					\
+								\
+		.long 2b - 0b;					\
+		.short line;
+#else
+#define _BUGVERBOSE_LOCATION(file, line)
+#endif
+
+#ifdef CONFIG_GENERIC_BUG
+
+#define __BUG_ENTRY(flags) 				\
+		.pushsection __bug_table,"a";		\
+		.align 2;				\
+	0:	.long 1f - 0b;				\
+_BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
+		.short flags; 				\
+		.popsection;				\
+	1:
+#else
+#define __BUG_ENTRY(flags)
+#endif
+
+#define ASM_BUG_FLAGS(flags)				\
+	__BUG_ENTRY(0)					\
+	brk	BUG_BRK_IMM
+
+#define ASM_BUG()	ASM_BUG_FLAGS(0)
+
+#endif /* __ASM_ASM_BUG_H */
diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
index 366448e..d7dc437 100644
--- a/arch/arm64/include/asm/bug.h
+++ b/arch/arm64/include/asm/bug.h
@@ -18,41 +18,12 @@
 #ifndef _ARCH_ARM64_ASM_BUG_H
 #define _ARCH_ARM64_ASM_BUG_H
 
-#include <asm/brk-imm.h>
+#include <linux/stringify.h>
 
-#ifdef CONFIG_DEBUG_BUGVERBOSE
-#define _BUGVERBOSE_LOCATION(file, line) __BUGVERBOSE_LOCATION(file, line)
-#define __BUGVERBOSE_LOCATION(file, line)				\
-		".pushsection .rodata.str,\"aMS\", at progbits,1\n"	\
-	"2:	.string \"" file "\"\n\t"				\
-		".popsection\n\t"					\
-									\
-		".long 2b - 0b\n\t"					\
-		".short " #line "\n\t"
-#else
-#define _BUGVERBOSE_LOCATION(file, line)
-#endif
-
-#ifdef CONFIG_GENERIC_BUG
-
-#define __BUG_ENTRY(flags) 				\
-		".pushsection __bug_table,\"a\"\n\t"	\
-		".align 2\n\t"				\
-	"0:	.long 1f - 0b\n\t"			\
-_BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
-		".short " #flags "\n\t"			\
-		".popsection\n"				\
-	"1:	"
-#else
-#define __BUG_ENTRY(flags) ""
-#endif
+#include <asm/asm-bug.h>
 
 #define __BUG_FLAGS(flags)				\
-	asm volatile (					\
-		__BUG_ENTRY(flags)			\
-		"brk %[imm]" :: [imm] "i" (BUG_BRK_IMM)	\
-	);
-
+	asm volatile (__stringify(ASM_BUG_FLAGS(flags)));
 
 #define BUG() do {					\
 	__BUG_FLAGS(0);					\
-- 
1.9.1
