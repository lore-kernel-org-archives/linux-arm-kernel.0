From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 21 Apr 2016 09:18:17 +0100
Subject: [PATCH RFC 05/10] ARM: Extract cp15 operations from cache flush code
In-Reply-To: <1461226702-27160-1-git-send-email-vladimir.murzin@arm.com>
References: <1461226702-27160-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1461226702-27160-6-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Austin <jonathan.austin@arm.com>

Caches have been added to the V7M architecture. Instead of CP15 operations,
the cache maintenance is done with memory-mapped registers. Other properties
of the cache architecture are the same as V7A/R.

In order to make it possible to use the same cacheflush code on V7A/R and
V7M, this commit separates out the cp15 cache maintenance operations into a
separate, V7A/R specific v7 cache macros file. This is done by introducing
cache macros.

This commit does not introduce any V7M-related code to simplify the process
of verifying that the result of compiling cache-v7.S is identical before and
after this commit.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/cache-v7.S        |   51 ++++++++---------
 arch/arm/mm/proc-macros.S     |   23 --------
 arch/arm/mm/proc-v7.S         |    1 +
 arch/arm/mm/v7-cache-macros.S |  124 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+), 52 deletions(-)
 create mode 100644 arch/arm/mm/v7-cache-macros.S

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index a134d8a..53a802e 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -17,6 +17,7 @@
 #include <asm/unwind.h>
 
 #include "proc-macros.S"
+#include "v7-cache-macros.S"
 
 /*
  * The secondary kernel init calls v7_flush_dcache_all before it enables
@@ -33,9 +34,9 @@
  */
 ENTRY(v7_invalidate_l1)
        mov     r0, #0
-       mcr     p15, 2, r0, c0, c0, 0
-       mrc     p15, 1, r0, c0, c0, 0
 
+       write_csselr r0
+       read_ccsidr r0
        movw    r1, #0x7fff
        and     r2, r1, r0, lsr #13
 
@@ -55,7 +56,7 @@ ENTRY(v7_invalidate_l1)
        mov     r5, r3, lsl r1
        mov     r6, r2, lsl r0
        orr     r5, r5, r6      @ Reg = (Temp<<WayShift)|(NumSets<<SetShift)
-       mcr     p15, 0, r5, c7, c6, 2
+       dcisw   r5
        bgt     2b
        cmp     r2, #0
        bgt     1b
@@ -73,9 +74,7 @@ ENDPROC(v7_invalidate_l1)
  *	r0 - set to 0
  */
 ENTRY(v7_flush_icache_all)
-	mov	r0, #0
-	ALT_SMP(mcr	p15, 0, r0, c7, c1, 0)		@ invalidate I-cache inner shareable
-	ALT_UP(mcr	p15, 0, r0, c7, c5, 0)		@ I+BTB cache invalidate
+	invalidate_icache r0
 	ret	lr
 ENDPROC(v7_flush_icache_all)
 
@@ -89,7 +88,7 @@ ENDPROC(v7_flush_icache_all)
 
 ENTRY(v7_flush_dcache_louis)
 	dmb					@ ensure ordering with previous memory accesses
-	mrc	p15, 1, r0, c0, c0, 1		@ read clidr, r0 = clidr
+	read_clidr r0
 ALT_SMP(mov	r3, r0, lsr #20)		@ move LoUIS into position
 ALT_UP(	mov	r3, r0, lsr #26)		@ move LoUU into position
 	ands	r3, r3, #7 << 1 		@ extract LoU*2 field from clidr
@@ -117,7 +116,7 @@ ENDPROC(v7_flush_dcache_louis)
  */
 ENTRY(v7_flush_dcache_all)
 	dmb					@ ensure ordering with previous memory accesses
-	mrc	p15, 1, r0, c0, c0, 1		@ read clidr
+	read_clidr r0
 	mov	r3, r0, lsr #23			@ move LoC into position
 	ands	r3, r3, #7 << 1			@ extract LoC*2 from clidr
 	beq	finished			@ if loc is 0, then no need to clean
@@ -132,9 +131,9 @@ flush_levels:
 #ifdef CONFIG_PREEMPT
 	save_and_disable_irqs_notrace r9	@ make cssr&csidr read atomic
 #endif
-	mcr	p15, 2, r10, c0, c0, 0		@ select current cache level in cssr
+	write_csselr r10			@ set current cache level
 	isb					@ isb to sych the new cssr&csidr
-	mrc	p15, 1, r1, c0, c0, 0		@ read the new csidr
+	read_ccsidr r1				@ read the new csidr
 #ifdef CONFIG_PREEMPT
 	restore_irqs_notrace r9
 #endif
@@ -154,7 +153,7 @@ loop2:
  ARM(	orr	r11, r11, r9, lsl r2	)	@ factor index number into r11
  THUMB(	lsl	r6, r9, r2		)
  THUMB(	orr	r11, r11, r6		)	@ factor index number into r11
-	mcr	p15, 0, r11, c7, c14, 2		@ clean & invalidate by set/way
+	dccisw r11				@ clean/invalidate by set/way
 	subs	r9, r9, #1			@ decrement the index
 	bge	loop2
 	subs	r4, r4, #1			@ decrement the way
@@ -165,7 +164,7 @@ skip:
 	bgt	flush_levels
 finished:
 	mov	r10, #0				@ swith back to cache level 0
-	mcr	p15, 2, r10, c0, c0, 0		@ select current cache level in cssr
+	write_csselr r10			@ select current cache level in cssr
 	dsb	st
 	isb
 	ret	lr
@@ -186,9 +185,7 @@ ENTRY(v7_flush_kern_cache_all)
  ARM(	stmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
  THUMB(	stmfd	sp!, {r4-r7, r9-r11, lr}	)
 	bl	v7_flush_dcache_all
-	mov	r0, #0
-	ALT_SMP(mcr	p15, 0, r0, c7, c1, 0)	@ invalidate I-cache inner shareable
-	ALT_UP(mcr	p15, 0, r0, c7, c5, 0)	@ I+BTB cache invalidate
+	invalidate_icache r0
  ARM(	ldmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
  THUMB(	ldmfd	sp!, {r4-r7, r9-r11, lr}	)
 	ret	lr
@@ -204,9 +201,7 @@ ENTRY(v7_flush_kern_cache_louis)
  ARM(	stmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
  THUMB(	stmfd	sp!, {r4-r7, r9-r11, lr}	)
 	bl	v7_flush_dcache_louis
-	mov	r0, #0
-	ALT_SMP(mcr	p15, 0, r0, c7, c1, 0)	@ invalidate I-cache inner shareable
-	ALT_UP(mcr	p15, 0, r0, c7, c5, 0)	@ I+BTB cache invalidate
+	invalidate_icache r0
  ARM(	ldmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
  THUMB(	ldmfd	sp!, {r4-r7, r9-r11, lr}	)
 	ret	lr
@@ -278,7 +273,7 @@ ENTRY(v7_coherent_user_range)
 	ALT_UP(W(nop))
 #endif
 1:
- USER(	mcr	p15, 0, r12, c7, c11, 1	)	@ clean D line to the point of unification
+ USER(	dccmvau	r12 )		@ clean D line to the point of unification
 	add	r12, r12, r2
 	cmp	r12, r1
 	blo	1b
@@ -287,13 +282,11 @@ ENTRY(v7_coherent_user_range)
 	sub	r3, r2, #1
 	bic	r12, r0, r3
 2:
- USER(	mcr	p15, 0, r12, c7, c5, 1	)	@ invalidate I line
+ USER(	icimvau r12 )	@ invalidate I line
 	add	r12, r12, r2
 	cmp	r12, r1
 	blo	2b
-	mov	r0, #0
-	ALT_SMP(mcr	p15, 0, r0, c7, c1, 6)	@ invalidate BTB Inner Shareable
-	ALT_UP(mcr	p15, 0, r0, c7, c5, 6)	@ invalidate BTB
+	invalidate_bp r0
 	dsb	ishst
 	isb
 	ret	lr
@@ -331,7 +324,7 @@ ENTRY(v7_flush_kern_dcache_area)
 	ALT_UP(W(nop))
 #endif
 1:
-	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D line / unified line
+	dccimvac r0		@ clean & invalidate D line / unified line
 	add	r0, r0, r2
 	cmp	r0, r1
 	blo	1b
@@ -358,13 +351,13 @@ v7_dma_inv_range:
 	ALT_SMP(W(dsb))
 	ALT_UP(W(nop))
 #endif
-	mcrne	p15, 0, r0, c7, c14, 1		@ clean & invalidate D / U line
+	dccimvac r0 ne
 
 	tst	r1, r3
 	bic	r1, r1, r3
-	mcrne	p15, 0, r1, c7, c14, 1		@ clean & invalidate D / U line
+	dccimvac r1 ne
 1:
-	mcr	p15, 0, r0, c7, c6, 1		@ invalidate D / U line
+	dcimvac r0
 	add	r0, r0, r2
 	cmp	r0, r1
 	blo	1b
@@ -386,7 +379,7 @@ v7_dma_clean_range:
 	ALT_UP(W(nop))
 #endif
 1:
-	mcr	p15, 0, r0, c7, c10, 1		@ clean D / U line
+	dccmvac r0			@ clean D / U line
 	add	r0, r0, r2
 	cmp	r0, r1
 	blo	1b
@@ -408,7 +401,7 @@ ENTRY(v7_dma_flush_range)
 	ALT_UP(W(nop))
 #endif
 1:
-	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D / U line
+	dccimvac r0			 @ clean & invalidate D / U line
 	add	r0, r0, r2
 	cmp	r0, r1
 	blo	1b
diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index c671f34..a82800a 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -66,29 +66,6 @@
 	.endm
 
 /*
- * dcache_line_size - get the minimum D-cache line size from the CTR register
- * on ARMv7.
- */
-	.macro	dcache_line_size, reg, tmp
-	mrc	p15, 0, \tmp, c0, c0, 1		@ read ctr
-	lsr	\tmp, \tmp, #16
-	and	\tmp, \tmp, #0xf		@ cache line size encoding
-	mov	\reg, #4			@ bytes per word
-	mov	\reg, \reg, lsl \tmp		@ actual cache line size
-	.endm
-
-/*
- * icache_line_size - get the minimum I-cache line size from the CTR register
- * on ARMv7.
- */
-	.macro	icache_line_size, reg, tmp
-	mrc	p15, 0, \tmp, c0, c0, 1		@ read ctr
-	and	\tmp, \tmp, #0xf		@ cache line size encoding
-	mov	\reg, #4			@ bytes per word
-	mov	\reg, \reg, lsl \tmp		@ actual cache line size
-	.endm
-
-/*
  * Sanity check the PTE configuration for the code below - which makes
  * certain assumptions about how these bits are laid out.
  */
diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 6fcaac8..c7bcc0c 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -18,6 +18,7 @@
 #include <asm/pgtable.h>
 
 #include "proc-macros.S"
+#include "v7-cache-macros.S"
 
 #ifdef CONFIG_ARM_LPAE
 #include "proc-v7-3level.S"
diff --git a/arch/arm/mm/v7-cache-macros.S b/arch/arm/mm/v7-cache-macros.S
new file mode 100644
index 0000000..5212383
--- /dev/null
+++ b/arch/arm/mm/v7-cache-macros.S
@@ -0,0 +1,124 @@
+/*
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
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) 2012 ARM Limited
+ *
+ * Author: Jonathan Austin <jonathan.austin@arm.com>
+ */
+
+.macro	read_ctr, rt
+	mrc     p15, 0, \rt, c0, c0, 1
+.endm
+
+.macro	read_ccsidr, rt
+	mrc     p15, 1, \rt, c0, c0, 0
+.endm
+
+.macro read_clidr, rt
+	mrc	p15, 1, \rt, c0, c0, 1
+.endm
+
+.macro	write_csselr, rt
+	mcr     p15, 2, \rt, c0, c0, 0
+.endm
+
+/*
+ * dcisw: invalidate data cache by set/way
+ */
+.macro dcisw, rt
+	mcr     p15, 0, \rt, c7, c6, 2
+.endm
+
+/*
+ * dccisw: clean and invalidate data cache by set/way
+ */
+.macro dccisw, rt
+	mcr	p15, 0, \rt, c7, c14, 2
+.endm
+
+/*
+ * dccimvac: Clean and invalidate data cache line by MVA to PoC.
+ */
+.macro dccimvac, rt, cond = al
+	mcr\cond	p15, 0, \rt, c7, c14, 1
+.endm
+
+/*
+ * dcimvac: Invalidate data cache line by MVA to PoC
+ */
+.macro dcimvac, rt
+	mcr	p15, 0, r0, c7, c6, 1
+.endm
+
+/*
+ * dccmvau: Clean data cache line by MVA to PoU
+ */
+.macro dccmvau, rt
+	mcr	p15, 0, \rt, c7, c11, 1
+.endm
+
+/*
+ * dccmvac: Clean data cache line by MVA to PoC
+ */
+.macro dccmvac,  rt
+	mcr	p15, 0, \rt, c7, c10, 1
+.endm
+
+/*
+ * icimvau: Invalidate instruction caches by MVA to PoU
+ */
+.macro icimvau, rt
+	mcr	p15, 0, \rt, c7, c5, 1
+.endm
+
+/*
+ * Invalidate the icache, inner shareable if SMP, invalidate BTB for UP.
+ */
+.macro invalidate_icache, rt
+	mov	\rt, #0
+	ALT_SMP(mcr	p15, 0, \rt, c7, c1, 0)		@ icialluis: I-cache invalidate inner shareable
+	ALT_UP(mcr	p15, 0, \rt, c7, c5, 0)		@ iciallu: I+BTB cache invalidate
+.endm
+
+/*
+ * Invalidate the BTB, inner shareable if SMP.
+ */
+.macro invalidate_bp, rt
+	mov	\rt, #0
+	ALT_SMP(mcr	p15, 0, \rt, c7, c1, 6)		@ bpiallis: invalidate BTB inner shareable
+	ALT_UP(mcr	p15, 0, \rt, c7, c5, 6)		@ bpiall: invalidate BTB
+.endm
+
+/*
+ * dcache_line_size - get the minimum D-cache line size from the CTR register
+ * on ARMv7.
+ */
+	.macro	dcache_line_size, reg, tmp
+	read_ctr \tmp
+	lsr	\tmp, \tmp, #16
+	and	\tmp, \tmp, #0xf		@ cache line size encoding
+	mov	\reg, #4			@ bytes per word
+	mov	\reg, \reg, lsl \tmp		@ actual cache line size
+	.endm
+
+/*
+ * icache_line_size - get the minimum I-cache line size from the CTR register
+ * on ARMv7.
+ */
+	.macro	icache_line_size, reg, tmp
+	read_ctr \tmp
+	and	\tmp, \tmp, #0xf		@ cache line size encoding
+	mov	\reg, #4			@ bytes per word
+	mov	\reg, \reg, lsl \tmp		@ actual cache line size
+	.endm
-- 
1.7.9.5
