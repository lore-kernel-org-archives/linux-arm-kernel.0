From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 08 Nov 2012 08:46:17 +0100
Subject: [PATCH 1/7] ARM: omap: remove obsoleted init_consistent_dma_size()
In-Reply-To: <1352360783-17523-1-git-send-email-m.szyprowski@samsung.com>
References: <1352360783-17523-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1352360783-17523-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
CC: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/io.c              |    1 -
 arch/arm/mach-omap2/io.c              |   12 ------------
 arch/arm/plat-omap/common.c           |    7 -------
 arch/arm/plat-omap/include/plat/dma.h |    1 -
 4 files changed, 21 deletions(-)

diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 6a5baab..b3d0fb3 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -134,7 +134,6 @@ void __init omap1_init_early(void)
 	 */
 	omap1_clk_init();
 	omap1_mux_init();
-	omap_init_consistent_dma_size();
 }
 
 void __init omap1_init_late(void)
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4234d28..2597846 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -354,11 +354,6 @@ static int _set_hwmod_postsetup_state(struct omap_hwmod *oh, void *data)
 	return omap_hwmod_set_postsetup_state(oh, *(u8 *)data);
 }
 
-static void __init omap_common_init_early(void)
-{
-	omap_init_consistent_dma_size();
-}
-
 static void __init omap_hwmod_init_postsetup(void)
 {
 	u8 postsetup_state;
@@ -379,7 +374,6 @@ void __init omap2420_init_early(void)
 {
 	omap2_set_globals_242x();
 	omap2xxx_check_revision();
-	omap_common_init_early();
 	omap2xxx_voltagedomains_init();
 	omap242x_powerdomains_init();
 	omap242x_clockdomains_init();
@@ -401,7 +395,6 @@ void __init omap2430_init_early(void)
 {
 	omap2_set_globals_243x();
 	omap2xxx_check_revision();
-	omap_common_init_early();
 	omap2xxx_voltagedomains_init();
 	omap243x_powerdomains_init();
 	omap243x_clockdomains_init();
@@ -428,7 +421,6 @@ void __init omap3_init_early(void)
 	omap2_set_globals_3xxx();
 	omap3xxx_check_revision();
 	omap3xxx_check_features();
-	omap_common_init_early();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
 	omap3xxx_clockdomains_init();
@@ -462,7 +454,6 @@ void __init ti81xx_init_early(void)
 	omap2_set_globals_ti81xx();
 	omap3xxx_check_revision();
 	ti81xx_check_features();
-	omap_common_init_early();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
 	omap3xxx_clockdomains_init();
@@ -520,7 +511,6 @@ void __init am33xx_init_early(void)
 	omap2_set_globals_am33xx();
 	omap3xxx_check_revision();
 	ti81xx_check_features();
-	omap_common_init_early();
 	am33xx_voltagedomains_init();
 	am33xx_powerdomains_init();
 	am33xx_clockdomains_init();
@@ -536,7 +526,6 @@ void __init omap4430_init_early(void)
 	omap2_set_globals_443x();
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
-	omap_common_init_early();
 	omap44xx_voltagedomains_init();
 	omap44xx_powerdomains_init();
 	omap44xx_clockdomains_init();
@@ -558,7 +547,6 @@ void __init omap5_init_early(void)
 {
 	omap2_set_globals_5xxx();
 	omap5xxx_check_revision();
-	omap_common_init_early();
 }
 #endif
 
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 111315a..ab44d34 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -31,13 +31,6 @@ void __init omap_reserve(void)
 	omap_barrier_reserve_memblock();
 }
 
-void __init omap_init_consistent_dma_size(void)
-{
-#ifdef CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE
-	init_consistent_dma_size(CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE << 20);
-#endif
-}
-
 /*
  * Stub function for OMAP2 so that common files
  * continue to build when custom builds are used
diff --git a/arch/arm/plat-omap/include/plat/dma.h b/arch/arm/plat-omap/include/plat/dma.h
index 0a87b05..f1b2ad3 100644
--- a/arch/arm/plat-omap/include/plat/dma.h
+++ b/arch/arm/plat-omap/include/plat/dma.h
@@ -449,7 +449,6 @@ struct omap_system_dma_plat_info {
 	u32 (*dma_read)(int reg, int lch);
 };
 
-extern void __init omap_init_consistent_dma_size(void);
 extern void omap_set_dma_priority(int lch, int dst_port, int priority);
 extern int omap_request_dma(int dev_id, const char *dev_name,
 			void (*callback)(int lch, u16 ch_status, void *data),
-- 
1.7.9.5
