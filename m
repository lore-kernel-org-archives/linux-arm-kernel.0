From: axel.lin@ingics.com (Axel Lin)
Date: Sun, 07 Oct 2012 16:00:37 +0800
Subject: [PATCH] ARM: OMAP: Fix dependency for OMAP_DEBUG_LEDS
Message-ID: <1349596837.15349.2.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes below build error:
  LD      init/built-in.o
arch/arm/plat-omap/built-in.o: In function `fpga_probe':
arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
arch/arm/plat-omap/debug-leds.c:113: undefined reference to `led_classdev_register'
arch/arm/plat-omap/built-in.o:arch/arm/plat-omap/debug-leds.c:113: more undefined references to `led_classdev_register' follow
make: *** [vmlinux] Error 1

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Bryan,
I think this issue is introduced by commit dafbead
"ARM: mach-omap1: retire custom LED code".

Regards,
Axel

 arch/arm/plat-omap/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index ca83a76..3281377 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -42,7 +42,7 @@ config OMAP_DEBUG_DEVICES
 	  For debug cards on TI reference boards.
 
 config OMAP_DEBUG_LEDS
-	def_bool y if NEW_LEDS
+	default y if LEDS_CLASS
 	depends on OMAP_DEBUG_DEVICES
 
 config POWER_AVS_OMAP
-- 
1.7.9.5
