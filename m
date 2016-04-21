From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 21 Apr 2016 09:18:18 +0100
Subject: [PATCH RFC 06/10] ARM: V7M: Implement cache macros for V7M
In-Reply-To: <1461226702-27160-1-git-send-email-vladimir.murzin@arm.com>
References: <1461226702-27160-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1461226702-27160-7-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonathan Austin <jonathan.austin@arm.com>

This commit implements the cache operation macros for V7M, paving the way
for caches to be used on V7 with a future commit.

Because the cache operations in V7M are memory mapped, in most operations an
extra register is required compared to the V7 version, where the type of
operation is encoded in the instruction, not the address that is written to.

Thus, an extra register argument has been added to the cache operation macros,
that is required in V7M but ignored/unused in V7. In almost all cases there
was a spare temporary register, but in places where the register allocation
was tighter the ARM/THUMB macros have been used to avoid clobbering new
registers.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/cache-v7.S         |   41 +++++++-----
 arch/arm/mm/v7-cache-macros.S  |   23 ++++---
 arch/arm/mm/v7m-cache-macros.S |  140 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 179 insertions(+), 25 deletions(-)
 create mode 100644 arch/arm/mm/v7m-cache-macros.S

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 53a802e..a0c89c6 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -17,7 +17,11 @@
 #include <asm/unwind.h>
 
 #include "proc-macros.S"
+#ifdef CONFIG_CPU_V7M
+#include "v7m-cache-macros.S"
+#else
 #include "v7-cache-macros.S"
+#endif
 
 /*
  * The secondary kernel init calls v7_flush_dcache_all before it enables
@@ -35,7 +39,7 @@
 ENTRY(v7_invalidate_l1)
        mov     r0, #0
 
-       write_csselr r0
+       write_csselr r0, r1
        read_ccsidr r0
        movw    r1, #0x7fff
        and     r2, r1, r0, lsr #13
@@ -56,7 +60,7 @@ ENTRY(v7_invalidate_l1)
        mov     r5, r3, lsl r1
        mov     r6, r2, lsl r0
        orr     r5, r5, r6      @ Reg = (Temp<<WayShift)|(NumSets<<SetShift)
-       dcisw   r5
+       dcisw   r5, r6
        bgt     2b
        cmp     r2, #0
        bgt     1b
@@ -131,7 +135,7 @@ flush_levels:
 #ifdef CONFIG_PREEMPT
 	save_and_disable_irqs_notrace r9	@ make cssr&csidr read atomic
 #endif
-	write_csselr r10			@ set current cache level
+	write_csselr r10, r1			@ set current cache level
 	isb					@ isb to sych the new cssr&csidr
 	read_ccsidr r1				@ read the new csidr
 #ifdef CONFIG_PREEMPT
@@ -153,7 +157,8 @@ loop2:
  ARM(	orr	r11, r11, r9, lsl r2	)	@ factor index number into r11
  THUMB(	lsl	r6, r9, r2		)
  THUMB(	orr	r11, r11, r6		)	@ factor index number into r11
-	dccisw r11				@ clean/invalidate by set/way
+ ARM(	dccisw r11			)	@ clean/invalidate by set/way
+ THUMB(	dccisw r11, r6			)	@ clean/invalidate by set/way
 	subs	r9, r9, #1			@ decrement the index
 	bge	loop2
 	subs	r4, r4, #1			@ decrement the way
@@ -164,7 +169,7 @@ skip:
 	bgt	flush_levels
 finished:
 	mov	r10, #0				@ swith back to cache level 0
-	write_csselr r10			@ select current cache level in cssr
+	write_csselr r10, r3			@ select current cache level in cssr
 	dsb	st
 	isb
 	ret	lr
@@ -273,7 +278,7 @@ ENTRY(v7_coherent_user_range)
 	ALT_UP(W(nop))
 #endif
 1:
- USER(	dccmvau	r12 )		@ clean D line to the point of unification
+ USER(	dccmvau	r12, r3 )	@ clean D line to the point of unification
 	add	r12, r12, r2
 	cmp	r12, r1
 	blo	1b
@@ -282,7 +287,7 @@ ENTRY(v7_coherent_user_range)
 	sub	r3, r2, #1
 	bic	r12, r0, r3
 2:
- USER(	icimvau r12 )	@ invalidate I line
+ USER(	icimvau r12, r3 )	@ invalidate I line
 	add	r12, r12, r2
 	cmp	r12, r1
 	blo	2b
@@ -324,7 +329,7 @@ ENTRY(v7_flush_kern_dcache_area)
 	ALT_UP(W(nop))
 #endif
 1:
-	dccimvac r0		@ clean & invalidate D line / unified line
+	dccimvac r0, r3		@ clean & invalidate D line / unified line
 	add	r0, r0, r2
 	cmp	r0, r1
 	blo	1b
@@ -351,16 +356,20 @@ v7_dma_inv_range:
 	ALT_SMP(W(dsb))
 	ALT_UP(W(nop))
 #endif
-	dccimvac r0 ne
+	beq	1f
+ARM(	dccimvac r0		)
+THUMB(	dccimvac r0, r3		)
+THUMB(	sub	r3, r2, #1	)	@ restore r3, corrupted by dccimvac
 
-	tst	r1, r3
+1:	tst	r1, r3
 	bic	r1, r1, r3
-	dccimvac r1 ne
-1:
-	dcimvac r0
+	beq	2f
+	dccimvac r1, r3
+2:
+	dcimvac r0, r3
 	add	r0, r0, r2
 	cmp	r0, r1
-	blo	1b
+	blo	2b
 	dsb	st
 	ret	lr
 ENDPROC(v7_dma_inv_range)
@@ -379,7 +388,7 @@ v7_dma_clean_range:
 	ALT_UP(W(nop))
 #endif
 1:
-	dccmvac r0			@ clean D / U line
+	dccmvac r0, r3			@ clean D / U line
 	add	r0, r0, r2
 	cmp	r0, r1
 	blo	1b
@@ -401,7 +410,7 @@ ENTRY(v7_dma_flush_range)
 	ALT_UP(W(nop))
 #endif
 1:
-	dccimvac r0			 @ clean & invalidate D / U line
+	dccimvac r0, r3			 @ clean & invalidate D / U line
 	add	r0, r0, r2
 	cmp	r0, r1
 	blo	1b
diff --git a/arch/arm/mm/v7-cache-macros.S b/arch/arm/mm/v7-cache-macros.S
index 5212383..60cba98 100644
--- a/arch/arm/mm/v7-cache-macros.S
+++ b/arch/arm/mm/v7-cache-macros.S
@@ -15,6 +15,11 @@
  * Copyright (C) 2012 ARM Limited
  *
  * Author: Jonathan Austin <jonathan.austin@arm.com>
+ *
+ * The 'unused' parameters are to keep the macro signatures in sync with the
+ * V7M versions, which require a tmp register for certain operations (see
+ * v7m-cache-macros.S). GAS supports omitting optional arguments but doesn't
+ * happily ignore additional undefined ones.
  */
 
 .macro	read_ctr, rt
@@ -29,56 +34,56 @@
 	mrc	p15, 1, \rt, c0, c0, 1
 .endm
 
-.macro	write_csselr, rt
+.macro	write_csselr, rt, unused
 	mcr     p15, 2, \rt, c0, c0, 0
 .endm
 
 /*
  * dcisw: invalidate data cache by set/way
  */
-.macro dcisw, rt
+.macro dcisw, rt, unused
 	mcr     p15, 0, \rt, c7, c6, 2
 .endm
 
 /*
  * dccisw: clean and invalidate data cache by set/way
  */
-.macro dccisw, rt
+.macro dccisw, rt, unused
 	mcr	p15, 0, \rt, c7, c14, 2
 .endm
 
 /*
  * dccimvac: Clean and invalidate data cache line by MVA to PoC.
  */
-.macro dccimvac, rt, cond = al
-	mcr\cond	p15, 0, \rt, c7, c14, 1
+.macro dccimvac, rt, unused
+	mcr	p15, 0, \rt, c7, c14, 1
 .endm
 
 /*
  * dcimvac: Invalidate data cache line by MVA to PoC
  */
-.macro dcimvac, rt
+.macro dcimvac, rt, unused
 	mcr	p15, 0, r0, c7, c6, 1
 .endm
 
 /*
  * dccmvau: Clean data cache line by MVA to PoU
  */
-.macro dccmvau, rt
+.macro dccmvau, rt, unused
 	mcr	p15, 0, \rt, c7, c11, 1
 .endm
 
 /*
  * dccmvac: Clean data cache line by MVA to PoC
  */
-.macro dccmvac,  rt
+.macro dccmvac,  rt, unused
 	mcr	p15, 0, \rt, c7, c10, 1
 .endm
 
 /*
  * icimvau: Invalidate instruction caches by MVA to PoU
  */
-.macro icimvau, rt
+.macro icimvau, rt, unused
 	mcr	p15, 0, \rt, c7, c5, 1
 .endm
 
diff --git a/arch/arm/mm/v7m-cache-macros.S b/arch/arm/mm/v7m-cache-macros.S
new file mode 100644
index 0000000..9a07c15
--- /dev/null
+++ b/arch/arm/mm/v7m-cache-macros.S
@@ -0,0 +1,140 @@
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
+#include "asm/v7m.h"
+#include "asm/assembler.h"
+
+/* Generic V7M read/write macros for memory mapped cache operations */
+.macro v7m_cache_read, rt, reg
+	movw	\rt, #:lower16:BASEADDR_V7M_SCB + \reg
+	movt	\rt, #:upper16:BASEADDR_V7M_SCB + \reg
+	ldr     \rt, [\rt]
+.endm
+
+.macro v7m_cacheop, rt, tmp, op
+	movw	\tmp, #:lower16:BASEADDR_V7M_SCB + \op
+	movt	\tmp, #:upper16:BASEADDR_V7M_SCB + \op
+	str	\rt, [\tmp]
+.endm
+
+/* read/write cache properties */
+.macro	read_ctr, rt
+	v7m_cache_read \rt, V7M_SCB_CTR
+.endm
+
+.macro	read_ccsidr, rt
+	v7m_cache_read \rt, V7M_SCB_CCSIDR
+.endm
+
+.macro read_clidr, rt
+	v7m_cache_read \rt, V7M_SCB_CLIDR
+.endm
+
+.macro	write_csselr, rt, tmp
+	v7m_cacheop \rt, \tmp, V7M_SCB_CSSELR
+.endm
+
+/*
+ * dcisw: Invalidate data cache by set/way
+ */
+.macro dcisw, rt, tmp
+	v7m_cacheop \rt, \tmp, V7M_SCB_DCISW
+.endm
+
+/*
+ * dccisw: Clean and invalidate data cache by set/way
+ */
+.macro dccisw, rt, tmp
+	v7m_cacheop \rt, \tmp, V7M_SCB_DCCISW
+.endm
+
+/*
+ * dccimvac: Clean and invalidate data cache line by MVA to PoC.
+ */
+.macro dccimvac, rt, tmp
+	v7m_cacheop \rt, \tmp, V7M_SCB_DCCIMVAC
+.endm
+
+/*
+ * dcimvac: Invalidate data cache line by MVA to PoC
+ */
+.macro dcimvac, rt, tmp
+	v7m_cacheop \rt, \tmp, V7M_SCB_DCIMVAC
+.endm
+
+/*
+ * dccmvau: Clean data cache line by MVA to PoU
+ */
+.macro dccmvau, rt, tmp
+	v7m_cacheop \rt, \tmp, V7M_SCB_DCCMVAU
+.endm
+
+/*
+ * dccmvac: Clean data cache line by MVA to PoC
+ */
+.macro dccmvac,  rt, tmp
+	v7m_cacheop \rt, \tmp, V7M_SCB_DCCMVAC
+.endm
+
+/*
+ * icimvau: Invalidate instruction caches by MVA to PoU
+ */
+.macro icimvau, rt, tmp
+	v7m_cacheop \rt, \tmp, V7M_SCB_ICIMVAU
+.endm
+
+/*
+ * Invalidate the icache, inner shareable if SMP, invalidate BTB for UP.
+ * rt data ignored by ICIALLU(IS), so can be used for the address
+ */
+.macro invalidate_icache, rt
+	v7m_cacheop \rt, \rt, V7M_SCB_ICIALLU
+	mov \rt, #0
+.endm
+
+/*
+ * Invalidate the BTB, inner shareable if SMP.
+ * rt data ignored by BPIALL, so it can be used for the address
+ */
+.macro invalidate_bp, rt
+	v7m_cacheop \rt, \rt, V7M_SCB_BPIALL
+	mov \rt, #0
+.endm
+
+/*
+ * dcache_line_size - get the minimum D-cache line size from the CTR register
+ * on ARMv7.
+ */
+.macro	dcache_line_size, reg, tmp
+	read_ctr \tmp
+	lsr	\tmp, \tmp, #16
+	and	\tmp, \tmp, #0xf		@ cache line size encoding
+	mov	\reg, #4			@ bytes per word
+	mov	\reg, \reg, lsl \tmp		@ actual cache line size
+.endm
+
+/*
+ * icache_line_size - get the minimum I-cache line size from the CTR register
+ * on ARMv7.
+ */
+.macro	icache_line_size, reg, tmp
+	read_ctr \tmp
+	and	\tmp, \tmp, #0xf		@ cache line size encoding
+	mov	\reg, #4			@ bytes per word
+	mov	\reg, \reg, lsl \tmp		@ actual cache line size
+.endm
-- 
1.7.9.5
