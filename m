From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 03 Apr 2015 11:54:32 +0100
Subject: [PATCH 4/7] ARM: cache-v7: optimise branches in v7_flush_cache_louis
In-Reply-To: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
References: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
Message-ID: <E1YdzFA-0008Cr-Ku@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Optimise the branches such that for the majority of unaffected devices,
we avoid needing to execute the errata work-around code path by
branching to start_flush_levels early.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-v7.S | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 5b5d0c00bca7..793d061b4dce 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -93,17 +93,18 @@ ENTRY(v7_flush_dcache_louis)
 ALT_SMP(mov	r3, r0, lsr #20)		@ move LoUIS into position
 ALT_UP(	mov	r3, r0, lsr #26)		@ move LoUU into position
 	ands	r3, r3, #7 << 1 		@ extract LoU*2 field from clidr
+	bne	start_flush_levels		@ LoU != 0, start flushing
 #ifdef CONFIG_ARM_ERRATA_643719
-	ALT_SMP(mrceq	p15, 0, r2, c0, c0, 0)	@ read main ID register
-	ALT_UP(reteq	lr)			@ LoUU is zero, so nothing to do
-	movweq	r1, #:lower16:0x410fc090	@ ID of ARM Cortex A9 r0p?
-	movteq	r1, #:upper16:0x410fc090
-	biceq	r2, r2, #0x0000000f             @ clear minor revision number
-	teqeq	r2, r1                          @ test for errata affected core and if so...
-	moveqs	r3, #1 << 1			@   fix LoUIS value (and set flags state to 'ne')
+ALT_SMP(mrc	p15, 0, r2, c0, c0, 0)		@ read main ID register
+ALT_UP(	ret	lr)				@ LoUU is zero, so nothing to do
+	movw	r1, #:lower16:0x410fc090	@ ID of ARM Cortex A9 r0p?
+	movt	r1, #:upper16:0x410fc090
+	bic	r2, r2, #0x0000000f             @ clear minor revision number
+	teq	r2, r1                          @ test for errata affected core and if so...
+	moveq	r3, #1 << 1			@   fix LoUIS value
+	beq	start_flush_levels		@   start flushing cache levels
 #endif
-	reteq	lr				@ return if level == 0
-	b	start_flush_levels		@ start flushing cache levels
+	ret	lr
 ENDPROC(v7_flush_dcache_louis)
 
 /*
-- 
1.8.3.1
