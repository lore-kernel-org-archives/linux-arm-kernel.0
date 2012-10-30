From: tony@atomide.com (Tony Lindgren)
Date: Tue, 30 Oct 2012 16:53:00 -0700
Subject: [PATCH 09/11] ARM: OMAP: Fix relative includes for debug-devices.h
In-Reply-To: <20121030234852.25936.12482.stgit@muffinssi.local>
References: <20121030234852.25936.12482.stgit@muffinssi.local>
Message-ID: <20121030235300.25936.9859.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As discussed on linux-arm-kernel, we want to avoid
relative includes for the arch/arm/*omap* shared code:

http://www.spinics.net/lists/linux-omap/msg80520.html

Let's add plat/debug-devices.h for debug_card_init()
to fix the relative includes.

Note that drivers must not use this header as it will
break build for omap2+ CONFIG_MULTIPLATFORM builds.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-h4.c                  |    2 +-
 arch/arm/plat-omap/debug-devices.c              |    2 +-
 arch/arm/plat-omap/include/plat/debug-devices.h |    7 -------
 3 files changed, 2 insertions(+), 9 deletions(-)
 rename arch/arm/{mach-omap2/debug-devices.h => plat-omap/include/plat/debug-devices.h} (54%)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index bd11b0a..8668c72 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -33,7 +33,7 @@
 #include <asm/mach/map.h>
 
 #include <plat-omap/dma-omap.h>
-#include "debug-devices.h"
+#include <plat/debug-devices.h>
 
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
diff --git a/arch/arm/plat-omap/debug-devices.c b/arch/arm/plat-omap/debug-devices.c
index 5a4678e..b49be51 100644
--- a/arch/arm/plat-omap/debug-devices.c
+++ b/arch/arm/plat-omap/debug-devices.c
@@ -16,7 +16,7 @@
 #include <linux/smc91x.h>
 
 #include <mach/hardware.h>
-#include "../mach-omap2/debug-devices.h"
+#include <plat/debug-devices.h>
 
 /* Many OMAP development platforms reuse the same "debug board"; these
  * platforms include H2, H3, H4, and Perseus2.
diff --git a/arch/arm/mach-omap2/debug-devices.h b/arch/arm/plat-omap/include/plat/debug-devices.h
similarity index 54%
rename from arch/arm/mach-omap2/debug-devices.h
rename to arch/arm/plat-omap/include/plat/debug-devices.h
index a4edbd2..8fc4287 100644
--- a/arch/arm/mach-omap2/debug-devices.h
+++ b/arch/arm/plat-omap/include/plat/debug-devices.h
@@ -1,9 +1,2 @@
-#ifndef _OMAP_DEBUG_DEVICES_H
-#define _OMAP_DEBUG_DEVICES_H
-
-#include <linux/types.h>
-
 /* for TI reference platforms sharing the same debug card */
 extern int debug_card_init(u32 addr, unsigned gpio);
-
-#endif
