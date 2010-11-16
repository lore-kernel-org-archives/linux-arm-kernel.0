From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 16 Nov 2010 03:25:21 -0700
Subject: [PATCH 3/3] OMAP: wd_timer: remove old, dead probing code
In-Reply-To: <20101116102205.27991.37909.stgit@twilight.localdomain>
References: <20101116102205.27991.37909.stgit@twilight.localdomain>
Message-ID: <20101116102518.27991.38133.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After commit f2ce62312650211f6cf665cd6dc519c334c4071e, watchdog
probing is handled by files in mach-omap1/ and mach-omap2/, and the
plat-omap/devices.c probing code is no longer used.  Remove the dead
code in plat-omap/devices.c.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Charulatha Varadarajan <charu@ti.com>
---
 arch/arm/plat-omap/devices.c |   38 --------------------------------------
 1 files changed, 0 insertions(+), 38 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 6f42a18..f2d6ecc 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -234,44 +234,6 @@ static inline void omap_init_uwire(void) {}
 
 /*-------------------------------------------------------------------------*/
 
-#if	defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)
-
-static struct resource wdt_resources[] = {
-	{
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device omap_wdt_device = {
-	.name	   = "omap_wdt",
-	.id	     = -1,
-	.num_resources	= ARRAY_SIZE(wdt_resources),
-	.resource	= wdt_resources,
-};
-
-static void omap_init_wdt(void)
-{
-	if (cpu_is_omap16xx())
-		wdt_resources[0].start = 0xfffeb000;
-	else if (cpu_is_omap2420())
-		wdt_resources[0].start = 0x48022000; /* WDT2 */
-	else if (cpu_is_omap2430())
-		wdt_resources[0].start = 0x49016000; /* WDT2 */
-	else if (cpu_is_omap343x())
-		wdt_resources[0].start = 0x48314000; /* WDT2 */
-	else if (cpu_is_omap44xx())
-		wdt_resources[0].start = 0x4a314000;
-	else
-		return;
-
-	wdt_resources[0].end = wdt_resources[0].start + 0x4f;
-
-	(void) platform_device_register(&omap_wdt_device);
-}
-#else
-static inline void omap_init_wdt(void) {}
-#endif
-
 #if defined(CONFIG_TIDSPBRIDGE) || defined(CONFIG_TIDSPBRIDGE_MODULE)
 
 static phys_addr_t omap_dsp_phys_mempool_base;
