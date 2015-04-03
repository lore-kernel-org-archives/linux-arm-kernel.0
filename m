From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 03 Apr 2015 11:54:22 +0100
Subject: [PATCH 2/7] ARM: cache-v7: shift CLIDR to extract appropriate field
 before masking
In-Reply-To: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
References: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
Message-ID: <E1YdzF0-0008Cj-Dk@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than have code which masks and then shifts, such as:

	mrc     p15, 1, r0, c0, c0, 1
ALT_SMP(ands	r3, r0, #7 << 21)
ALT_UP( ands	r3, r0, #7 << 27)
ALT_SMP(mov	r3, r3, lsr #20)
ALT_UP(	mov	r3, r3, lsr #26)

re-arrange this as a shift and then mask.  The masking is the same for
each field which we want to extract, so this allows the mask to be
shared amongst code paths:

	mrc     p15, 1, r0, c0, c0, 1
ALT_SMP(mov	r3, r0, lsr #20)
ALT_UP(	mov	r3, r0, lsr #26)
	ands	r3, r3, #7 << 1

Use this method for the LoUIS, LoUU and LoC fields.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-v7.S | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 30c81e7d6aaa..d062f8cbb886 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -90,8 +90,9 @@ ENDPROC(v7_flush_icache_all)
 ENTRY(v7_flush_dcache_louis)
 	dmb					@ ensure ordering with previous memory accesses
 	mrc	p15, 1, r0, c0, c0, 1		@ read clidr, r0 = clidr
-	ALT_SMP(ands	r3, r0, #(7 << 21))	@ extract LoUIS from clidr
-	ALT_UP(ands	r3, r0, #(7 << 27))	@ extract LoUU from clidr
+ALT_SMP(mov	r3, r0, lsr #20)		@ move LoUIS into position
+ALT_UP(	mov	r3, r0, lsr #26)		@ move LoUU into position
+	ands	r3, r3, #7 << 1 		@ extract LoU*2 field from clidr
 #ifdef CONFIG_ARM_ERRATA_643719
 	ALT_SMP(mrceq	p15, 0, r2, c0, c0, 0)	@ read main ID register
 	ALT_UP(reteq	lr)			@ LoUU is zero, so nothing to do
@@ -99,10 +100,8 @@ ENTRY(v7_flush_dcache_louis)
 	movteq	r1, #:upper16:0x410fc090
 	biceq	r2, r2, #0x0000000f             @ clear minor revision number
 	teqeq	r2, r1                          @ test for errata affected core and if so...
-	orreqs	r3, #(1 << 21)			@   fix LoUIS value (and set flags state to 'ne')
+	moveqs	r3, #1 << 1			@   fix LoUIS value (and set flags state to 'ne')
 #endif
-	ALT_SMP(mov	r3, r3, lsr #20)	@ r3 = LoUIS * 2
-	ALT_UP(mov	r3, r3, lsr #26)	@ r3 = LoUU * 2
 	reteq	lr				@ return if level == 0
 	mov	r10, #0				@ r10 (starting level) = 0
 	b	flush_levels			@ start flushing cache levels
@@ -120,8 +119,8 @@ ENDPROC(v7_flush_dcache_louis)
 ENTRY(v7_flush_dcache_all)
 	dmb					@ ensure ordering with previous memory accesses
 	mrc	p15, 1, r0, c0, c0, 1		@ read clidr
-	ands	r3, r0, #0x7000000		@ extract loc from clidr
-	mov	r3, r3, lsr #23			@ left align loc bit field
+	mov	r3, r0, lsr #23			@ move LoC into position
+	ands	r3, r3, #7 << 1			@ extract LoC*2 from clidr
 	beq	finished			@ if loc is 0, then no need to clean
 	mov	r10, #0				@ start clean@cache level 0
 flush_levels:
-- 
1.8.3.1
