From: geoff@infradead.org (Geoff Levand)
Date: Thu, 23 Oct 2014 23:10:58 +0000
Subject: [PATCH 07/10] arm64: Move proc-macros.S to include/asm
In-Reply-To: <cover.1414099246.git.geoff@infradead.org>
References: <cover.1414099246.git.geoff@infradead.org>
Message-ID: <10887b908ca3695a58ded54e8dffa5b7e252d102.1414099246.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow the assembler macros defined in proc-macros.S to be used outside
the mm code move the proc-macros.S file from arch/arm64/mm/ to
arch/arm64/include/asm/ and fix up any preprocessor includes to use the new
file location.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/proc-macros.S | 54 ++++++++++++++++++++++++++++++++++++
 arch/arm64/mm/cache.S                |  3 +-
 arch/arm64/mm/proc-macros.S          | 54 ------------------------------------
 arch/arm64/mm/proc.S                 |  3 +-
 4 files changed, 56 insertions(+), 58 deletions(-)
 create mode 100644 arch/arm64/include/asm/proc-macros.S
 delete mode 100644 arch/arm64/mm/proc-macros.S

diff --git a/arch/arm64/include/asm/proc-macros.S b/arch/arm64/include/asm/proc-macros.S
new file mode 100644
index 0000000..005d29e
--- /dev/null
+++ b/arch/arm64/include/asm/proc-macros.S
@@ -0,0 +1,54 @@
+/*
+ * Based on arch/arm/mm/proc-macros.S
+ *
+ * Copyright (C) 2012 ARM Ltd.
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
+
+#include <asm/asm-offsets.h>
+#include <asm/thread_info.h>
+
+/*
+ * vma_vm_mm - get mm pointer from vma pointer (vma->vm_mm)
+ */
+	.macro	vma_vm_mm, rd, rn
+	ldr	\rd, [\rn, #VMA_VM_MM]
+	.endm
+
+/*
+ * mmid - get context id from mm pointer (mm->context.id)
+ */
+	.macro	mmid, rd, rn
+	ldr	\rd, [\rn, #MM_CONTEXT_ID]
+	.endm
+
+/*
+ * dcache_line_size - get the minimum D-cache line size from the CTR register.
+ */
+	.macro	dcache_line_size, reg, tmp
+	mrs	\tmp, ctr_el0			// read CTR
+	ubfm	\tmp, \tmp, #16, #19		// cache line size encoding
+	mov	\reg, #4			// bytes per word
+	lsl	\reg, \reg, \tmp		// actual cache line size
+	.endm
+
+/*
+ * icache_line_size - get the minimum I-cache line size from the CTR register.
+ */
+	.macro	icache_line_size, reg, tmp
+	mrs	\tmp, ctr_el0			// read CTR
+	and	\tmp, \tmp, #0xf		// cache line size encoding
+	mov	\reg, #4			// bytes per word
+	lsl	\reg, \reg, \tmp		// actual cache line size
+	.endm
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 2366383..4e811a4 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -20,8 +20,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/assembler.h>
-
-#include "proc-macros.S"
+#include <asm/proc-macros.S>
 
 /*
  *	__flush_dcache_all()
diff --git a/arch/arm64/mm/proc-macros.S b/arch/arm64/mm/proc-macros.S
deleted file mode 100644
index 005d29e..0000000
--- a/arch/arm64/mm/proc-macros.S
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * Based on arch/arm/mm/proc-macros.S
- *
- * Copyright (C) 2012 ARM Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <asm/asm-offsets.h>
-#include <asm/thread_info.h>
-
-/*
- * vma_vm_mm - get mm pointer from vma pointer (vma->vm_mm)
- */
-	.macro	vma_vm_mm, rd, rn
-	ldr	\rd, [\rn, #VMA_VM_MM]
-	.endm
-
-/*
- * mmid - get context id from mm pointer (mm->context.id)
- */
-	.macro	mmid, rd, rn
-	ldr	\rd, [\rn, #MM_CONTEXT_ID]
-	.endm
-
-/*
- * dcache_line_size - get the minimum D-cache line size from the CTR register.
- */
-	.macro	dcache_line_size, reg, tmp
-	mrs	\tmp, ctr_el0			// read CTR
-	ubfm	\tmp, \tmp, #16, #19		// cache line size encoding
-	mov	\reg, #4			// bytes per word
-	lsl	\reg, \reg, \tmp		// actual cache line size
-	.endm
-
-/*
- * icache_line_size - get the minimum I-cache line size from the CTR register.
- */
-	.macro	icache_line_size, reg, tmp
-	mrs	\tmp, ctr_el0			// read CTR
-	and	\tmp, \tmp, #0xf		// cache line size encoding
-	mov	\reg, #4			// bytes per word
-	lsl	\reg, \reg, \tmp		// actual cache line size
-	.endm
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 7467199..b767032 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -25,10 +25,9 @@
 #include <asm/hwcap.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/pgtable.h>
+#include <asm/proc-macros.S>
 #include <asm/virt.h>
 
-#include "proc-macros.S"
-
 #ifdef CONFIG_ARM64_64K_PAGES
 #define TCR_TG_FLAGS	TCR_TG0_64K | TCR_TG1_64K
 #else
-- 
1.9.1
