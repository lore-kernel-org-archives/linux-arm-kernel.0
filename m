From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 19 Apr 2011 16:58:51 +0300
Subject: [PATCH] OMAP: Remove reserve_sram calls to omapfb
Message-ID: <mailman.204.1303222626.1530.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes calls from arch/arm/plat-omap/sram.c to
omapfb_reserve_sram() and omap_vram_reserve_sram(), effectively
disabling SRAM support for the old and new display drivers.

SRAM code in the display drivers will be removed in separate patches.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/sram.c |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index a3f50b3..e10eeed 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/io.h>
-#include <linux/omapfb.h>
 
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>
@@ -32,7 +31,6 @@
 #include <plat/vram.h>
 
 #include "sram.h"
-#include "fb.h"
 
 /* XXX These "sideways" includes are a sign that something is wrong */
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
@@ -170,17 +168,6 @@ static void __init omap_detect_sram(void)
 			omap_sram_size = 0x4000;
 		}
 	}
-	reserved = omapfb_reserve_sram(omap_sram_start, omap_sram_base,
-				       omap_sram_size,
-				       omap_sram_start + SRAM_BOOTLOADER_SZ,
-				       omap_sram_size - SRAM_BOOTLOADER_SZ);
-	omap_sram_size -= reserved;
-
-	reserved = omap_vram_reserve_sram(omap_sram_start, omap_sram_base,
-			omap_sram_size,
-			omap_sram_start + SRAM_BOOTLOADER_SZ,
-			omap_sram_size - SRAM_BOOTLOADER_SZ);
-	omap_sram_size -= reserved;
 
 	omap_sram_ceil = omap_sram_base + omap_sram_size;
 }
-- 
1.7.1
