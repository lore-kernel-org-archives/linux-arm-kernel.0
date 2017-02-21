From: hsweeten@visionengravers.com (H Hartley Sweeten)
Date: Tue, 21 Feb 2017 11:15:28 -0700
Subject: [PATCH 3/4] ARM: ep93xx: tidy up TS-72xx Watchdog resources
In-Reply-To: <20170221181529.6780-1-hsweeten@visionengravers.com>
References: <20170221181529.6780-1-hsweeten@visionengravers.com>
Message-ID: <20170221181529.6780-4-hsweeten@visionengravers.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ts-72xx watchdog uses two byte sized registers. Tidy up the resource
declaration so that the proper information is shown in /proc/iomem.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
---
 arch/arm/mach-ep93xx/ts72xx.c | 20 +++++++++-----------
 arch/arm/mach-ep93xx/ts72xx.h |  3 ---
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 8a5b6f0..9b62e5c 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -186,24 +186,22 @@ static struct platform_device ts72xx_rtc_device = {
 	.num_resources 	= ARRAY_SIZE(ts72xx_rtc_resources),
 };
 
+/*************************************************************************
+ * Watchdog (in CPLD)
+ *************************************************************************/
+#define TS72XX_WDT_CONTROL_PHYS_BASE	(EP93XX_CS2_PHYS_BASE + 0x03800000)
+#define TS72XX_WDT_FEED_PHYS_BASE	(EP93XX_CS2_PHYS_BASE + 0x03c00000)
+
 static struct resource ts72xx_wdt_resources[] = {
-	{
-		.start	= TS72XX_WDT_CONTROL_PHYS_BASE,
-		.end	= TS72XX_WDT_CONTROL_PHYS_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= TS72XX_WDT_FEED_PHYS_BASE,
-		.end	= TS72XX_WDT_FEED_PHYS_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
+	DEFINE_RES_MEM(TS72XX_WDT_CONTROL_PHYS_BASE, 0x01),
+	DEFINE_RES_MEM(TS72XX_WDT_FEED_PHYS_BASE, 0x01),
 };
 
 static struct platform_device ts72xx_wdt_device = {
 	.name		= "ts72xx-wdt",
 	.id		= -1,
-	.num_resources 	= ARRAY_SIZE(ts72xx_wdt_resources),
 	.resource	= ts72xx_wdt_resources,
+	.num_resources	= ARRAY_SIZE(ts72xx_wdt_resources),
 };
 
 static struct ep93xx_eth_data __initdata ts72xx_eth_data = {
diff --git a/arch/arm/mach-ep93xx/ts72xx.h b/arch/arm/mach-ep93xx/ts72xx.h
index 2255ba2..4e6519b 100644
--- a/arch/arm/mach-ep93xx/ts72xx.h
+++ b/arch/arm/mach-ep93xx/ts72xx.h
@@ -38,9 +38,6 @@
 #define TS72XX_OPTIONS2_TS9420		0x04
 #define TS72XX_OPTIONS2_TS9420_BOOT	0x02
 
-#define TS72XX_WDT_CONTROL_PHYS_BASE	0x23800000
-#define TS72XX_WDT_FEED_PHYS_BASE	0x23c00000
-
 #ifndef __ASSEMBLY__
 
 static inline int ts72xx_model(void)
-- 
2.10.0
