From: tixy@yxit.co.uk (Jon Medhurst)
Date: Mon,  8 Aug 2011 15:28:22 +0100
Subject: [PATCH 02/12] ARM: omap: Setup consistent dma size at boot time
In-Reply-To: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
References: <1312813712-22808-1-git-send-email-tixy@yxit.co.uk>
Message-ID: <1312813712-22808-3-git-send-email-tixy@yxit.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jon Medhurst <tixy@yxit.co.uk>
CC: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/io.h     |    2 ++
 arch/arm/plat-omap/include/plat/memory.h |   13 -------------
 arch/arm/mach-omap1/io.c                 |    1 +
 arch/arm/mach-omap2/io.c                 |    2 +-
 arch/arm/plat-omap/io.c                  |    8 ++++++++
 5 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index d72ec85..ebe67ea 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -309,6 +309,8 @@ extern void omap2_init_common_devices(struct omap_sdrc_params *sdrc_cs0,
 void __iomem *omap_ioremap(unsigned long phys, size_t size, unsigned int type);
 void omap_iounmap(volatile void __iomem *addr);
 
+extern void __init omap_init_consistent_dma_size(void);
+
 #endif
 
 #endif
diff --git a/arch/arm/plat-omap/include/plat/memory.h b/arch/arm/plat-omap/include/plat/memory.h
index e6720aa..7f9df6f 100644
--- a/arch/arm/plat-omap/include/plat/memory.h
+++ b/arch/arm/plat-omap/include/plat/memory.h
@@ -85,18 +85,5 @@
 
 #endif	/* CONFIG_ARCH_OMAP15XX */
 
-/* Override the ARM default */
-#ifdef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
-
-#if (CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE == 0)
-#undef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
-#define CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE 2
-#endif
-
-#define CONSISTENT_DMA_SIZE \
-	(((CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE + 1) & ~1) * 1024 * 1024)
-
-#endif
-
 #endif
 
diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 870886a..1cfa1b6 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -121,6 +121,7 @@ void __init omap1_map_common_io(void)
 #endif
 
 	omap_sram_init();
+	omap_init_consistent_dma_size();
 }
 
 /*
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 2ce1ce6..d6d01cb 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -16,7 +16,6 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -250,6 +249,7 @@ static void __init _omap2_map_common_io(void)
 
 	omap2_check_revision();
 	omap_sram_init();
+	omap_init_consistent_dma_size();
 }
 
 #ifdef CONFIG_SOC_OMAP2420
diff --git a/arch/arm/plat-omap/io.c b/arch/arm/plat-omap/io.c
index f1ecfa9..e9b0e23 100644
--- a/arch/arm/plat-omap/io.c
+++ b/arch/arm/plat-omap/io.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/mm.h>
+#include <linux/dma-mapping.h>
 
 #include <plat/omap7xx.h>
 #include <plat/omap1510.h>
@@ -139,3 +140,10 @@ void omap_iounmap(volatile void __iomem *addr)
 		__iounmap(addr);
 }
 EXPORT_SYMBOL(omap_iounmap);
+
+void __init omap_init_consistent_dma_size(void)
+{
+#ifdef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
+	init_consistent_dma_size(CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE << 20);
+#endif
+}
-- 
1.7.2.5
