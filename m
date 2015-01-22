From: yamada.m@jp.panasonic.com (Masahiro Yamada)
Date: Thu, 22 Jan 2015 14:22:58 +0900
Subject: [PATCH] ARM: decompressor: remove unused cache flush code
Message-ID: <1421904178-30882-1-git-send-email-yamada.m@jp.panasonic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As ARM ARM says, the bit 19-16 of ID_MMFR1 is always 0b0000 because
ARMv7 requires a hierarchical cache implementation.
The line "mcr    p15, 0, r10, c7, c14, 0" is not reachable.

Moreover, the v7_flush_dcache_all in arch/arm/mm/cache-v7.S does not
check the ID_MMFR1.

Signed-off-by: Masahiro Yamada <yamada.m@jp.panasonic.com>
---

 arch/arm/boot/compressed/head.S | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 9dff614..32f0d79 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -1085,15 +1085,9 @@ __armv6_mmu_cache_flush:
 __armv7_mmu_cache_flush:
 		tst	r4, #1
 		bne	iflush
-		mrc	p15, 0, r10, c0, c1, 5	@ read ID_MMFR1
-		tst	r10, #0xf << 16		@ hierarchical cache (ARMv7)
+		stmfd	sp!, {r0-r7, r9-r11}
 		mov	r10, #0
-		beq	hierarchical
-		mcr	p15, 0, r10, c7, c14, 0	@ clean+invalidate D
-		b	iflush
-hierarchical:
 		mcr	p15, 0, r10, c7, c10, 5	@ DMB
-		stmfd	sp!, {r0-r7, r9-r11}
 		mrc	p15, 1, r0, c0, c0, 1	@ read clidr
 		ands	r3, r0, #0x7000000	@ extract loc from clidr
 		mov	r3, r3, lsr #23		@ left align loc bit field
-- 
1.9.1
