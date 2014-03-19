From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:58 +0100
Subject: [PATCH 61/62] ARM: sunxi: fix build for THUMB2_KERNEL
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-62-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building an SMP kernel for the sunxi platform with THUMB2 instructions
fails with this error at the moment:

headsmp.S:7: Error: Thumb encoding does not support an immediate here -- `msr cpsr_fsxc,#0xd3'

This changes the code to use a register for loading the
value instead, which works in both ARM and THUMB mode.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-sunxi/headsmp.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/headsmp.S b/arch/arm/mach-sunxi/headsmp.S
index a10d494..a8e0fef 100644
--- a/arch/arm/mach-sunxi/headsmp.S
+++ b/arch/arm/mach-sunxi/headsmp.S
@@ -4,6 +4,7 @@
         .section ".text.head", "ax"
 
 ENTRY(sun6i_secondary_startup)
-	msr	cpsr_fsxc, #0xd3
+	mov	r0, #0xd3
+	msr	cpsr_fsxc, r0
 	b	secondary_startup
 ENDPROC(sun6i_secondary_startup)
-- 
1.8.3.2
