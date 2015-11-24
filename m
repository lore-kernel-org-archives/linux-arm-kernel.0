From: geoff@infradead.org (Geoff Levand)
Date: Tue, 24 Nov 2015 22:25:33 +0000
Subject: [PATCH v12 01/16] arm64: Fold proc-macros.S into assembler.h
In-Reply-To: <cover.1448403503.git.geoff@infradead.org>
References: <cover.1448403503.git.geoff@infradead.org>
Message-ID: <a9d2131ff127fb8841a136e66ca5962304bb57e7.1448403503.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To allow the assembler macros defined in arch/arm64/mm/proc-macros.S to be used
outside the mm code move the contents of proc-macros.S to asm/assembler.h.  Also,
delete proc-macros.S, and fix up all references to proc-macros.S.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/include/asm/assembler.h | 48 +++++++++++++++++++++++++++-
 arch/arm64/kvm/hyp-init.S          |  1 -
 arch/arm64/mm/cache.S              |  2 --
 arch/arm64/mm/proc-macros.S        | 64 --------------------------------------
 arch/arm64/mm/proc.S               |  3 --
 5 files changed, 47 insertions(+), 71 deletions(-)
 delete mode 100644 arch/arm64/mm/proc-macros.S

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 12eff92..21979a4 100644
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
 
@@ -194,6 +196,50 @@ lr	.req	x30		// link register
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
  * Annotate a function as position independent, i.e., safe to be called before
  * the kernel virtual mapping is activated.
  */
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 178ba22..2e67a48 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -20,7 +20,6 @@
 #include <asm/assembler.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_mmu.h>
-#include <asm/pgtable-hwdef.h>
 
 	.text
 	.pushsection	.hyp.idmap.text, "ax"
diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index cfa44a6..f49041d 100644
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
index 4c4d93c..0000000
--- a/arch/arm64/mm/proc-macros.S
+++ /dev/null
@@ -1,64 +0,0 @@
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
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index cacecc4..7ab3a90 100644
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
2.5.0
