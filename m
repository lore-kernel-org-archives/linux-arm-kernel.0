From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 May 2015 10:36:42 +0200
Subject: [PATCH] ARM: zx: fix building with CONFIG_THUMB2_KERNEL
Message-ID: <2771121.xOQTA4CzPC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added zx platform causes a build error when
CONFIG_THUMB2_KERNEL is enabled:

arch/arm/mach-zx/headsmp.S:16: Error: invalid immediate for address calculation (value = 0x00000004)

I'm assuming that the ROM code that is calling these entry
points runs in ARM mode, so there would be another problem
in the same file, and we can solve both problems at once
by adding a '.arm' statement that will make zx_resume_jump
and zx_secondary_startup both be built as ARM code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Hi Jun,

This patch fixes a build error with mach-zx, but I don't know if it's
actually correct. Can you check if the machine correctly boots
with this patch enabled and CONFIG_THUMB2_KERNEL=y set in the .config?

diff --git a/arch/arm/mach-zx/headsmp.S b/arch/arm/mach-zx/headsmp.S
index c0fece0c3955..a1aa4028389f 100644
--- a/arch/arm/mach-zx/headsmp.S
+++ b/arch/arm/mach-zx/headsmp.S
@@ -10,6 +10,7 @@
 #include <linux/linkage.h>
 
 	.align 3
+	.arm
 
 /* It runs from physical address */
 ENTRY(zx_resume_jump)
