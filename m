From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 03 Apr 2015 11:54:17 +0100
Subject: [PATCH 1/7] ARM: cache-v7: use movw/movt instructions
In-Reply-To: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
References: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
Message-ID: <E1YdzEv-0008Cf-9u@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We always build cache-v7.S for ARMv7, so we can use the ARMv7 16-bit
move instructions to load large constants, rather than using constants
in a literal pool.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-v7.S | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index b966656d2c2d..30c81e7d6aaa 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -36,10 +36,10 @@ ENTRY(v7_invalidate_l1)
        mcr     p15, 2, r0, c0, c0, 0
        mrc     p15, 1, r0, c0, c0, 0
 
-       ldr     r1, =0x7fff
+       movw    r1, #0x7fff
        and     r2, r1, r0, lsr #13
 
-       ldr     r1, =0x3ff
+       movw    r1, #0x3ff
 
        and     r3, r1, r0, lsr #3      @ NumWays - 1
        add     r2, r2, #1              @ NumSets
@@ -95,7 +95,8 @@ ENTRY(v7_flush_dcache_louis)
 #ifdef CONFIG_ARM_ERRATA_643719
 	ALT_SMP(mrceq	p15, 0, r2, c0, c0, 0)	@ read main ID register
 	ALT_UP(reteq	lr)			@ LoUU is zero, so nothing to do
-	ldreq	r1, =0x410fc090                 @ ID of ARM Cortex A9 r0p?
+	movweq	r1, #:lower16:0x410fc090	@ ID of ARM Cortex A9 r0p?
+	movteq	r1, #:upper16:0x410fc090
 	biceq	r2, r2, #0x0000000f             @ clear minor revision number
 	teqeq	r2, r1                          @ test for errata affected core and if so...
 	orreqs	r3, #(1 << 21)			@   fix LoUIS value (and set flags state to 'ne')
@@ -140,10 +141,10 @@ flush_levels:
 #endif
 	and	r2, r1, #7			@ extract the length of the cache lines
 	add	r2, r2, #4			@ add 4 (line length offset)
-	ldr	r4, =0x3ff
+	movw	r4, #0x3ff
 	ands	r4, r4, r1, lsr #3		@ find maximum number on the way size
 	clz	r5, r4				@ find bit position of way size increment
-	ldr	r7, =0x7fff
+	movw	r7, #0x7fff
 	ands	r7, r7, r1, lsr #13		@ extract max number of the index size
 loop1:
 	mov	r9, r7				@ create working copy of max index
-- 
1.8.3.1
