From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 03 Apr 2015 11:54:37 +0100
Subject: [PATCH 5/7] ARM: cache-v7: optimise test for Cortex A9 r0pX devices
In-Reply-To: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
References: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
Message-ID: <E1YdzFF-0008Cv-OH@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eliminate one unnecessary instruction from this test by pre-shifting
the Cortex A9 ID - we can shift the actual ID in the teq instruction
thereby losing the pX bit of the ID at no cost.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-v7.S | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 793d061b4dce..a134d8a13d00 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -97,10 +97,9 @@ ALT_UP(	mov	r3, r0, lsr #26)		@ move LoUU into position
 #ifdef CONFIG_ARM_ERRATA_643719
 ALT_SMP(mrc	p15, 0, r2, c0, c0, 0)		@ read main ID register
 ALT_UP(	ret	lr)				@ LoUU is zero, so nothing to do
-	movw	r1, #:lower16:0x410fc090	@ ID of ARM Cortex A9 r0p?
-	movt	r1, #:upper16:0x410fc090
-	bic	r2, r2, #0x0000000f             @ clear minor revision number
-	teq	r2, r1                          @ test for errata affected core and if so...
+	movw	r1, #:lower16:(0x410fc090 >> 4)	@ ID of ARM Cortex A9 r0p?
+	movt	r1, #:upper16:(0x410fc090 >> 4)
+	teq	r1, r2, lsr #4			@ test for errata affected core and if so...
 	moveq	r3, #1 << 1			@   fix LoUIS value
 	beq	start_flush_levels		@   start flushing cache levels
 #endif
-- 
1.8.3.1
