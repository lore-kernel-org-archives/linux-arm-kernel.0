From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 23 Feb 2016 08:56:45 +0100
Subject: [PATCH] arm64: move brk immediate argument definitions to separate
 header
Message-ID: <1456214205-18743-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of reversing the header dependency between asm/bug.h and
asm/debug-monitors.h, split off the brk instruction immediate value
defines into a new header asm/brk-imm.h, and include it from both.

This solves the circular dependency issue that prevents BUG() from
being used in some header files, and keeps the definitions together.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/brk-imm.h        | 25 +++++++++++++++++++++++++
 arch/arm64/include/asm/bug.h            |  2 +-
 arch/arm64/include/asm/debug-monitors.h | 14 +-------------
 3 files changed, 27 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm64/include/asm/brk-imm.h

diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/brk-imm.h
new file mode 100644
index 000000000000..ed693c5bcec0
--- /dev/null
+++ b/arch/arm64/include/asm/brk-imm.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_BRK_IMM_H
+#define __ASM_BRK_IMM_H
+
+/*
+ * #imm16 values used for BRK instruction generation
+ * Allowed values for kgdb are 0x400 - 0x7ff
+ * 0x100: for triggering a fault on purpose (reserved)
+ * 0x400: for dynamic BRK instruction
+ * 0x401: for compile time BRK instruction
+ * 0x800: kernel-mode BUG() and WARN() traps
+ */
+#define FAULT_BRK_IMM			0x100
+#define KGDB_DYN_DBG_BRK_IMM		0x400
+#define KGDB_COMPILED_DBG_BRK_IMM	0x401
+#define BUG_BRK_IMM			0x800
+
+#endif
diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
index 679d49221998..561190d15881 100644
--- a/arch/arm64/include/asm/bug.h
+++ b/arch/arm64/include/asm/bug.h
@@ -18,7 +18,7 @@
 #ifndef _ARCH_ARM64_ASM_BUG_H
 #define _ARCH_ARM64_ASM_BUG_H
 
-#define BUG_BRK_IMM			0x800
+#include <asm/brk-imm.h>
 
 #ifdef CONFIG_GENERIC_BUG
 #define HAVE_ARCH_BUG
diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index e893a1fca9c2..2fcb9b7c876c 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -20,7 +20,7 @@
 
 #include <linux/errno.h>
 #include <linux/types.h>
-#include <asm/bug.h>
+#include <asm/brk-imm.h>
 #include <asm/esr.h>
 #include <asm/insn.h>
 #include <asm/ptrace.h>
@@ -48,18 +48,6 @@
 #define BREAK_INSTR_SIZE		AARCH64_INSN_SIZE
 
 /*
- * #imm16 values used for BRK instruction generation
- * Allowed values for kgbd are 0x400 - 0x7ff
- * 0x100: for triggering a fault on purpose (reserved)
- * 0x400: for dynamic BRK instruction
- * 0x401: for compile time BRK instruction
- * 0x800: kernel-mode BUG() and WARN() traps
- */
-#define FAULT_BRK_IMM			0x100
-#define KGDB_DYN_DBG_BRK_IMM		0x400
-#define KGDB_COMPILED_DBG_BRK_IMM	0x401
-
-/*
  * BRK instruction encoding
  * The #imm16 value should be placed at bits[20:5] within BRK ins
  */
-- 
2.5.0
