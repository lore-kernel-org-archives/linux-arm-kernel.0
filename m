From: rabin@rab.in (Rabin Vincent)
Date: Wed, 31 Mar 2010 23:09:13 +0530
Subject: [PATCH] fix Thumb-2 decompressor
Message-ID: <1270057153-9779-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

98e12b5a6e05413 ("ARM: Fix decompressor's kernel size estimation for
ROM=y") broke the Thumb-2 decompressor because it added an entry in the
LC0 table but didn't adjust the offset the Thumb-2 code uses to load the
SP from that table.  Fix it.

Cc: stable <stable@kernel.org>
Signed-off-by: Rabin Vincent <rabin@rab.in>
---
stable CCd because 98e12b5a was CCd to stable.

Maybe we can use the separate SP load for ARM too, because using SP in the LDM
register list is deprecated.

 arch/arm/boot/compressed/head.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 0f23009..6ab6b33 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -172,7 +172,7 @@ not_angel:
 		adr	r0, LC0
  ARM(		ldmia	r0, {r1, r2, r3, r4, r5, r6, r11, ip, sp})
  THUMB(		ldmia	r0, {r1, r2, r3, r4, r5, r6, r11, ip}	)
- THUMB(		ldr	sp, [r0, #28]				)
+ THUMB(		ldr	sp, [r0, #32]				)
 		subs	r0, r0, r1		@ calculate the delta offset
 
 						@ if delta is zero, we are
-- 
1.7.0
