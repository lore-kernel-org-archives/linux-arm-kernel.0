From: james.morse@arm.com (James Morse)
Date: Thu, 28 Jan 2016 10:42:34 +0000
Subject: [PATCH v4 01/13] arm64: Fold proc-macros.S into assembler.h
In-Reply-To: <1453977766-20907-1-git-send-email-james.morse@arm.com>
References: <1453977766-20907-1-git-send-email-james.morse@arm.com>
Message-ID: <1453977766-20907-2-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geoff Levand <geoff@infradead.org>

To allow the assembler macros defined in arch/arm64/mm/proc-macros.S to
be used outside the mm code move the contents of proc-macros.S to
asm/assembler.h.  Also, delete proc-macros.S, and fix up all references
to proc-macros.S.

Signed-off-by: Geoff Levand <geoff@infradead.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
[rebased, included dcache_by_line_op]
Signed-off-by: James Morse <james.morse@arm.com>
---

This patch is from v13 of kexec

 arch/arm64/include/asm/assembler.h | 70 ++++++++++++++++++++++++++++++-
 arch/arm64/mm/cache.S              |  2 -
 arch/arm64/mm/proc-macros.S        | 86 --------------------------------------
 arch/arm64/mm/proc.S               |  3 --
 4 files changed, 69 insertions(+), 92 deletions(-)
 delete mode 100644 arch/arm64/mm/proc-macros.S

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index bb7b72734c24..137ee5b11eb7 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -1,5 +1,5 @@
 /*
- * Based on arch/arm/include/asm/assembler.h
+ * Based on arch/arm/include/asm/assembler.h, arch/arm/mm/proc-macros.S
  *
  * Copyright (C) 1996-2000 Russell King
  * Copyright (C) 2012 ARM Ltd.
@@ -23,6 +23,8 @@
 #ifndef __ASM_ASSEMBLER_H
 #define __ASM_ASSEMBLER_H
 
+#include <asm/asm-offsets.h>
+#include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 
@@ -205,6 +207,72 @@ lr	.req	x30		// link register
 	.endm
 
 /*
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
+/*
+ * tcr_set_idmap_t0sz - update TCR.T0SZ so that we can load the ID map
+ */
+	.macro	tcr_set_idmap_t0sz, valreg, tmpreg
+#ifndef CONFIG_ARM64_VA_BITS_48
+	ldr_l	\tmpreg, idmap_t0sz
+	bfi	\valreg, \tmpreg, #TCR_T0SZ_OFFSET, #TCR_TxSZ_WIDTH
+#endif
+	.endm
+
+/*
+ * Macro to perform a data cache maintenance for the interval
+ * [kaddr, kaddr + size)
+ *
+ * 	op:		operation passed to dc instruction
+ * 	domain:		domain used in dsb instruciton
+ * 	kaddr:		starting virtual address of the region
+ * 	size:		size of the region
+ * 	Corrupts:	kaddr, size, tmp1, tmp2
+ */
+	.macro dcache_by_line_op op, domain, kaddr, size, tmp1, tmp2
+	dcache_line_size \tmp1, \tmp2
+	add	\size, \kaddr, \size
+	sub	\tmp2, \tmp1, #1
+	bic	\kaddr, \kaddr, \tmp2
+9998:	dc	\op, \kaddr
+	add	\kaddr, \kaddr, \tmp1
+	cmp	\kaddr, \size
+	b.lo	9998b
+	dsb	\domain
+	.endm
+
+/*
  * Annotate a function as position independent, i.e., safe to be called before
  * the kernel virtual mapping is activated.
  */
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 6df07069a025..50ff9ba3a236 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -24,8 +24,6 @@
 #include <asm/cpufeature.h>
 #include <asm/alternative.h>
 
-#include "proc-macros.S"
-
 /*
  *	flush_icache_range(start,end)
  *
diff --git a/arch/arm64/mm/proc-macros.S b/arch/arm64/mm/proc-macros.S
deleted file mode 100644
index 146bd99a7532..000000000000
--- a/arch/arm64/mm/proc-macros.S
+++ /dev/null
@@ -1,86 +0,0 @@
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
-
-/*
- * tcr_set_idmap_t0sz - update TCR.T0SZ so that we can load the ID map
- */
-	.macro	tcr_set_idmap_t0sz, valreg, tmpreg
-#ifndef CONFIG_ARM64_VA_BITS_48
-	ldr_l	\tmpreg, idmap_t0sz
-	bfi	\valreg, \tmpreg, #TCR_T0SZ_OFFSET, #TCR_TxSZ_WIDTH
-#endif
-	.endm
-
-/*
- * Macro to perform a data cache maintenance for the interval
- * [kaddr, kaddr + size)
- *
- * 	op:		operation passed to dc instruction
- * 	domain:		domain used in dsb instruciton
- * 	kaddr:		starting virtual address of the region
- * 	size:		size of the region
- * 	Corrupts: 	kaddr, size, tmp1, tmp2
- */
-	.macro dcache_by_line_op op, domain, kaddr, size, tmp1, tmp2
-	dcache_line_size \tmp1, \tmp2
-	add	\size, \kaddr, \size
-	sub	\tmp2, \tmp1, #1
-	bic	\kaddr, \kaddr, \tmp2
-9998:	dc	\op, \kaddr
-	add	\kaddr, \kaddr, \tmp1
-	cmp	\kaddr, \size
-	b.lo	9998b
-	dsb	\domain
-	.endm
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index a3d867e723b4..3c7d170de822 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -23,11 +23,8 @@
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/hwcap.h>
-#include <asm/pgtable-hwdef.h>
 #include <asm/pgtable.h>
 
-#include "proc-macros.S"
-
 #ifdef CONFIG_ARM64_64K_PAGES
 #define TCR_TG_FLAGS	TCR_TG0_64K | TCR_TG1_64K
 #elif defined(CONFIG_ARM64_16K_PAGES)
-- 
2.6.2
