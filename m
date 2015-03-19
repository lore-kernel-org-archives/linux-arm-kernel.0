From: geoff@infradead.org (Geoff Levand)
Date: Thu, 19 Mar 2015 20:35:27 +0000
Subject: [PATCH 1/6] arm64: Fold proc-macros.S into assembler.h
In-Reply-To: <cover.1426793116.git.geoff@infradead.org>
References: <cover.1426793116.git.geoff@infradead.org>
Message-ID: <6a3211394b177f731bca81bef9154c1d6d79773d.1426793116.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow the assembler macros defined in arch/arm64/mm/proc-macros.S to be used
outside the mm code move the contents of proc-macros.S to asm/assembler.h.  Also,
delete proc-macros.S, and fix up all references to proc-macros.S.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/assembler.h | 37 +++++++++++++++++++++++++-
 arch/arm64/mm/cache.S              |  2 --
 arch/arm64/mm/proc-macros.S        | 54 --------------------------------------
 arch/arm64/mm/proc.S               |  2 --
 4 files changed, 36 insertions(+), 59 deletions(-)
 delete mode 100644 arch/arm64/mm/proc-macros.S

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 750bac4..47962f6be 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -1,5 +1,5 @@
 /*
- * Based on arch/arm/include/asm/assembler.h
+ * Based on arch/arm/include/asm/assembler.h, arch/arm/mm/proc-macros.S
  *
  * Copyright (C) 1996-2000 Russell King
  * Copyright (C) 2012 ARM Ltd.
@@ -23,6 +23,7 @@
 #ifndef __ASM_ASSEMBLER_H
 #define __ASM_ASSEMBLER_H
 
+#include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 
@@ -159,4 +160,38 @@ lr	.req	x30		// link register
 	orr	\rd, \lbits, \hbits, lsl #32
 	.endm
 
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
+
 #endif	/* __ASM_ASSEMBLER_H */
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 2560e1e..2d7a67c 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -24,8 +24,6 @@
 #include <asm/cpufeature.h>
 #include <asm/alternative-asm.h>
 
-#include "proc-macros.S"
-
 /*
  *	__flush_dcache_all()
  *
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
index 28eebfb..fe69f6e 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -26,8 +26,6 @@
 #include <asm/pgtable-hwdef.h>
 #include <asm/pgtable.h>
 
-#include "proc-macros.S"
-
 #ifdef CONFIG_ARM64_64K_PAGES
 #define TCR_TG_FLAGS	TCR_TG0_64K | TCR_TG1_64K
 #else
-- 
2.1.0
