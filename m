From: rabin@rab.in (Rabin Vincent)
Date: Sat, 31 Jul 2010 01:05:23 +0530
Subject: [PATCH] fix Thumb-2 decompressor broken by "Auto calculate ZRELADDR"
Message-ID: <1280518523-5526-1-git-send-email-rabin@rab.in>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"ARM: Auto calculate ZRELADDR and provide option for exceptions" broke the
Thumb-2 decompressor because it removed an entry in the LC0 table but didn't
adjust the offset the Thumb-2 code uses to load the SP from that table.

Fix it, and also change the ARM code to use the separate SP-load since
ARM instructions that include the SP in the LDM register list are
deprecated.

Signed-off-by: Rabin Vincent <rabin@rab.in>
---
 arch/arm/boot/compressed/head.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index abf4d65..47924fc 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -170,9 +170,9 @@ not_angel:
 
 		.text
 		adr	r0, LC0
- ARM(		ldmia	r0, {r1, r2, r3, r5, r6, r11, ip, sp})
+ ARM(		ldmia	r0, {r1, r2, r3, r5, r6, r11, ip})
  THUMB(		ldmia	r0, {r1, r2, r3, r5, r6, r11, ip}	)
- THUMB(		ldr	sp, [r0, #32]				)
+		ldr	sp, [r0, #28]
 #ifdef CONFIG_AUTO_ZRELADDR
 		@ determine final kernel image address
 		and	r4, pc, #0xf8000000
-- 
1.7.1
