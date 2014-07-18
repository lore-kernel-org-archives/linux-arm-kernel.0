From: list-09_linux_arm@tqsc.de (Markus Niebel)
Date: Fri, 18 Jul 2014 13:23:17 +0200
Subject: [PATCH] watchdog: imx2_wdt: add support for WDOG_B signal generation
Message-ID: <1405682597-22936-1-git-send-email-list-09_linux_arm@tqsc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Niebel <Markus.Niebel@tq-group.com>

Watchdog unit of i.MX supports output of a signal at
watchdog shutdown. This feature can be useful to signal an
external supevisor that a watchdog reset occured.
Support this feature as an option via devicetree.

Signed-off-by: Markus Niebel <Markus.Niebel@tq-group.com>
---
 .../devicetree/bindings/watchdog/fsl-imx-wdt.txt   |    3 +++
 drivers/watchdog/imx2_wdt.c                        |    9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
index 2144af1..cb759cd 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
@@ -5,6 +5,9 @@ Required properties:
 - reg : Should contain WDT registers location and length
 - interrupts : Should contain WDT interrupt
 
+Optional properties:
+- fsl,use-wre: set if watchdog reset out (WDOG_B) signal shall be asserted
+
 Examples:
 
 wdt at 73f98000 {
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 9d4874f..6497711 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -58,6 +58,7 @@ struct imx2_wdt_device {
 	struct regmap *regmap;
 	struct timer_list timer;	/* Pings the watchdog when closed */
 	struct watchdog_device wdog;
+	unsigned int use_wre:1;		/* enable WRE feature */
 };
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -88,7 +89,10 @@ static inline void imx2_wdt_setup(struct watchdog_device *wdog)
 	/* Strip the old watchdog Time-Out value */
 	val &= ~IMX2_WDT_WCR_WT;
 	/* Generate reset if WDOG times out */
-	val &= ~IMX2_WDT_WCR_WRE;
+	if (wdev->use_wre)
+		val |= IMX2_WDT_WCR_WRE;
+	else
+		val &= ~IMX2_WDT_WCR_WRE;
 	/* Keep Watchdog Disabled */
 	val &= ~IMX2_WDT_WCR_WDE;
 	/* Set the watchdog's Time-Out value */
@@ -219,6 +223,9 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 		return PTR_ERR(wdev->clk);
 	}
 
+	(of_property_read_bool(pdev->dev.of_node, "fsl,use-wre"))
+		wdev->use_wre = 1;
+
 	wdog			= &wdev->wdog;
 	wdog->info		= &imx2_wdt_info;
 	wdog->ops		= &imx2_wdt_ops;
-- 
1.7.9.5
