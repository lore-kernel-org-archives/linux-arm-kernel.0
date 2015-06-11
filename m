From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 11 Jun 2015 16:29:22 +0100
Subject: [PATCH 08/10] arm64/debug: Move BRK types to a separate header
In-Reply-To: <1434036566-9848-1-git-send-email-Dave.Martin@arm.com>
References: <1434036566-9848-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1434036566-9848-9-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch creates a new header <asm/brk.h> for the purpose of
enumerating all breakpoint types used by the kernel.

Having a clear place for this information should reduce maintenance
headaches.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/brk.h            |   31 +++++++++++++++++++++++++++++++
 arch/arm64/include/asm/debug-monitors.h |   12 +-----------
 2 files changed, 32 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/include/asm/brk.h

diff --git a/arch/arm64/include/asm/brk.h b/arch/arm64/include/asm/brk.h
new file mode 100644
index 0000000..99b8dfb
--- /dev/null
+++ b/arch/arm64/include/asm/brk.h
@@ -0,0 +1,31 @@
+/*
+ * Enumeration of AArch64 software breakpoint types
+ * Copyright (C) 2012-2015  ARM Limited
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
+#ifndef _ARCH_ARM64_ASM_BRK_H
+#define _ARCH_ARM64_ASM_BRK_H
+
+/*
+ * #imm16 values used for BRK instruction generation
+ * Allowed values for kgbd are 0x400 - 0x7ff
+ * 0x100: for triggering a fault on purpose (reserved)
+ * 0x400: for dynamic BRK instruction
+ * 0x401: for compile time BRK instruction
+ */
+#define FAULT_BRK_IMM			0x100
+#define KGDB_DYN_DBG_BRK_IMM		0x400
+#define KGDB_COMPILED_DBG_BRK_IMM	0x401
+
+#endif /* ! _ARCH_ARM64_ASM_BRK_H */
diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 6a17fb8..78611ee 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -18,6 +18,7 @@
 
 #ifdef __KERNEL__
 
+#include <asm/brk.h>
 #include <asm/esr.h>
 #include <asm/insn.h>
 
@@ -44,17 +45,6 @@
 #define BREAK_INSTR_SIZE		AARCH64_INSN_SIZE
 
 /*
- * #imm16 values used for BRK instruction generation
- * Allowed values for kgbd are 0x400 - 0x7ff
- * 0x100: for triggering a fault on purpose (reserved)
- * 0x400: for dynamic BRK instruction
- * 0x401: for compile time BRK instruction
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
1.7.10.4
