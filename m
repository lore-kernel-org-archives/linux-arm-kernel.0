From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 03 Apr 2015 11:54:48 +0100
Subject: [PATCH 7/7] ARM: cache-v7: further cleanups (and fix?)
In-Reply-To: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
References: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
Message-ID: <E1YdzFQ-0008D3-08@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-v7.S | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index a134d8a13d00..51d6a336bac2 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -88,22 +88,20 @@ ENDPROC(v7_flush_icache_all)
  */
 
 ENTRY(v7_flush_dcache_louis)
-	dmb					@ ensure ordering with previous memory accesses
 	mrc	p15, 1, r0, c0, c0, 1		@ read clidr, r0 = clidr
 ALT_SMP(mov	r3, r0, lsr #20)		@ move LoUIS into position
 ALT_UP(	mov	r3, r0, lsr #26)		@ move LoUU into position
-	ands	r3, r3, #7 << 1 		@ extract LoU*2 field from clidr
-	bne	start_flush_levels		@ LoU != 0, start flushing
 #ifdef CONFIG_ARM_ERRATA_643719
-ALT_SMP(mrc	p15, 0, r2, c0, c0, 0)		@ read main ID register
-ALT_UP(	ret	lr)				@ LoUU is zero, so nothing to do
+ALT_SMP(ands	r3, r3, #7 << 1)		@ extract LoU*2 field from clidr
+ALT_UP(	b	start_flush_levels)
+	bne	start_flush_levels		@ LoU != 0, start flushing
+	mrc	p15, 0, r2, c0, c0, 0		@ read main ID register
 	movw	r1, #:lower16:(0x410fc090 >> 4)	@ ID of ARM Cortex A9 r0p?
 	movt	r1, #:upper16:(0x410fc090 >> 4)
 	teq	r1, r2, lsr #4			@ test for errata affected core and if so...
-	moveq	r3, #1 << 1			@   fix LoUIS value
-	beq	start_flush_levels		@   start flushing cache levels
+	moveq	r3, #1 << 1			@ fix LoUIS value (and set flags state to 'ne')
 #endif
-	ret	lr
+	b	start_flush_levels		@ start flushing cache levels
 ENDPROC(v7_flush_dcache_louis)
 
 /*
@@ -116,12 +114,12 @@ ENDPROC(v7_flush_dcache_louis)
  *	- mm    - mm_struct describing address space
  */
 ENTRY(v7_flush_dcache_all)
-	dmb					@ ensure ordering with previous memory accesses
 	mrc	p15, 1, r0, c0, c0, 1		@ read clidr
 	mov	r3, r0, lsr #23			@ move LoC into position
-	ands	r3, r3, #7 << 1			@ extract LoC*2 from clidr
-	beq	finished			@ if loc is 0, then no need to clean
 start_flush_levels:
+	dmb					@ ensure ordering with previous memory accesses
+	ands	r3, r3, #7 << 1			@ extract field from clidr
+	beq	finished			@ if loc is 0, then no need to clean
 	mov	r10, #0				@ start clean@cache level 0
 flush_levels:
 	add	r2, r10, r10, lsr #1		@ work out 3x current cache level
-- 
1.8.3.1
