From: gadiyar@ti.com (Anand Gadiyar)
Date: Fri,  3 Dec 2010 22:56:56 +0530
Subject: [PATCH] omap: remove dead wdt code in plat-omap/devices.c
Message-ID: <1291397216-24301-1-git-send-email-gadiyar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit f2ce62312650 (OMAP: WDT: Split OMAP1 and OMAP2PLUS device
registration) removed omap_init_wdt and related structures from
plat-omap/devices.c. However a subsequent commit or merge
seems to have reintroduced these by accident. The caller of
omap_init_wdt was also removed by that commit, and this did
not get restored. So we have the following build warning now:

  CC      arch/arm/plat-omap/devices.o
arch/arm/plat-omap/devices.c:252: warning: 'omap_init_wdt' defined but not used

Fix this by removing this dead code.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
Couldn't figure out which commit reintroduced this code - git blame
only points to the original commits that added the code years ago.

I suspect it's the DSP bridge commits that got merged via staging.

If someone can debug this mystery for me, that'd be nice.

 arch/arm/plat-omap/devices.c |   40 ----------------------------------------
 1 file changed, 40 deletions(-)

Index: mainline/arch/arm/plat-omap/devices.c
===================================================================
--- mainline.orig/arch/arm/plat-omap/devices.c
+++ mainline/arch/arm/plat-omap/devices.c
@@ -232,46 +232,6 @@ static void omap_init_uwire(void)
 static inline void omap_init_uwire(void) {}
 #endif
 
-/*-------------------------------------------------------------------------*/
-
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
