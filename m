From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun,  6 Dec 2009 11:38:59 +0200
Subject: [PATCH v2 2/2] ep93xx: added platform side support for TS-72xx WDT
	driver
In-Reply-To: <9a6b3d18f799bd632e0d0f688f998336f073a7ef.1260089508.git.mika.westerberg@iki.fi>
References: <cover.1260089508.git.mika.westerberg@iki.fi>
	<9a6b3d18f799bd632e0d0f688f998336f073a7ef.1260089508.git.mika.westerberg@iki.fi>
Message-ID: <acddf42db5047c878d54ccd6b226e01c52852bca.1260089508.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
---
 arch/arm/mach-ep93xx/include/mach/ts72xx.h |    2 ++
 arch/arm/mach-ep93xx/ts72xx.c              |   21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-ep93xx/include/mach/ts72xx.h b/arch/arm/mach-ep93xx/include/mach/ts72xx.h
index 3bd934e..93107d8 100644
--- a/arch/arm/mach-ep93xx/include/mach/ts72xx.h
+++ b/arch/arm/mach-ep93xx/include/mach/ts72xx.h
@@ -65,6 +65,8 @@
 #define TS72XX_RTC_DATA_PHYS_BASE	0x11700000
 #define TS72XX_RTC_DATA_SIZE		0x00001000
 
+#define TS72XX_WDT_CONTROL_PHYS_BASE	0x23800000
+#define TS72XX_WDT_FEED_PHYS_BASE	0x23c00000
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
index 259f782..fac1ec7 100644
--- a/arch/arm/mach-ep93xx/ts72xx.c
+++ b/arch/arm/mach-ep93xx/ts72xx.c
@@ -166,6 +166,26 @@ static struct platform_device ts72xx_rtc_device = {
 	.num_resources	= 0,
 };
 
+static struct resource ts72xx_wdt_resources[] = {
+	{
+		.start	= TS72XX_WDT_CONTROL_PHYS_BASE,
+		.end	= TS72XX_WDT_CONTROL_PHYS_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= TS72XX_WDT_FEED_PHYS_BASE,
+		.end	= TS72XX_WDT_FEED_PHYS_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device ts72xx_wdt_device = {
+	.name		= "ts72xx-wdt",
+	.id		= -1,
+	.num_resources 	= ARRAY_SIZE(ts72xx_wdt_resources),
+	.resource	= ts72xx_wdt_resources,
+};
+
 static struct ep93xx_eth_data ts72xx_eth_data = {
 	.phy_id		= 1,
 };
@@ -175,6 +195,7 @@ static void __init ts72xx_init_machine(void)
 	ep93xx_init_devices();
 	ts72xx_register_flash();
 	platform_device_register(&ts72xx_rtc_device);
+	platform_device_register(&ts72xx_wdt_device);
 
 	ep93xx_register_eth(&ts72xx_eth_data, 1);
 }
-- 
1.5.6.5
