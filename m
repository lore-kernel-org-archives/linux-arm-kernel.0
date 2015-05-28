From: tharvey@gateworks.com (Tim Harvey)
Date: Thu, 28 May 2015 15:54:36 -0700
Subject: [PATCH 1/2] watchdog: imx2_wdt: add external reset support via
 'ext-reset' dt property
In-Reply-To: <1432853677-5150-1-git-send-email-tharvey@gateworks.com>
References: <1432853677-5150-1-git-send-email-tharvey@gateworks.com>
Message-ID: <1432853677-5150-2-git-send-email-tharvey@gateworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IMX6 watchdog supports assertion of a signal (WDOG_B) which
can be pinmux'd to an external pin. This is typically used for boards that
have PMIC's in control of the IMX6 power rails. In fact, failure to use
such an external reset on boards with external PMIC's can result in various
hangs due to the IMX6 not being fully reset [1] as well as the board failing
to reset because its PMIC has not been reset to provide adequate voltate for
the CPU when comming out of reset at 800Mhz.

This uses a new device-tree property 'ext-reset' to indicate the board has
such a reset and to cause the watchdog to be configured to assert WDOG_B
instead of an internal reset both on a watchdog timeout and in system_restart.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333689.html

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 .../devicetree/bindings/watchdog/fsl-imx-wdt.txt       |  2 ++
 drivers/watchdog/imx2_wdt.c                            | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
index 8dab6fd..14e04ac 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
@@ -9,6 +9,8 @@ Optional property:
 - big-endian: If present the watchdog device's registers are implemented
   in big endian mode, otherwise in native mode(same with CPU), for more
   detail please see: Documentation/devicetree/bindings/regmap/regmap.txt.
+- ext-reset: If present the watchdog device is configured to assert its
+  external reset (WDOG_B) instead of issuing a software reset.
 
 Examples:
 
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 5e6d808..9ffd516 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -41,6 +41,8 @@
 
 #define IMX2_WDT_WCR		0x00		/* Control Register */
 #define IMX2_WDT_WCR_WT		(0xFF << 8)	/* -> Watchdog Timeout Field */
+#define IMX2_WDT_WCR_WDA	(1 << 5)	/* -> External reset Assert */
+#define IMX2_WDT_WCR_SRS	(1 << 4)	/* -> Software Reset Signal */
 #define IMX2_WDT_WCR_WRE	(1 << 3)	/* -> WDOG Reset Enable */
 #define IMX2_WDT_WCR_WDE	(1 << 2)	/* -> Watchdog Enable */
 #define IMX2_WDT_WCR_WDZST	(1 << 0)	/* -> Watchdog timer Suspend */
@@ -65,6 +67,7 @@ struct imx2_wdt_device {
 	struct timer_list timer;	/* Pings the watchdog when closed */
 	struct watchdog_device wdog;
 	struct notifier_block restart_handler;
+	bool ext_reset;
 };
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -86,10 +89,17 @@ static const struct watchdog_info imx2_wdt_info = {
 static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
 				void *cmd)
 {
-	unsigned int wcr_enable = IMX2_WDT_WCR_WDE;
+	unsigned int wcr_enable;
 	struct imx2_wdt_device *wdev = container_of(this,
 						    struct imx2_wdt_device,
 						    restart_handler);
+
+	if (!wdev->ext_reset)
+		wcr_enable = IMX2_WDT_WCR_WDE;
+	/* Use external reset */
+	else
+		wcr_enable = IMX2_WDT_WCR_WDE | IMX2_WDT_WCR_SRS;
+
 	/* Assert SRS signal */
 	regmap_write(wdev->regmap, 0, wcr_enable);
 	/*
@@ -120,7 +130,10 @@ static inline void imx2_wdt_setup(struct watchdog_device *wdog)
 	/* Strip the old watchdog Time-Out value */
 	val &= ~IMX2_WDT_WCR_WT;
 	/* Generate reset if WDOG times out */
-	val &= ~IMX2_WDT_WCR_WRE;
+	if (!wdev->ext_reset)
+		val &= ~IMX2_WDT_WCR_WRE;
+	else
+		val |= IMX2_WDT_WCR_WRE;	/* assert WDOG_B on time-out */
 	/* Keep Watchdog Disabled */
 	val &= ~IMX2_WDT_WCR_WDE;
 	/* Set the watchdog's Time-Out value */
@@ -262,6 +275,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	regmap_read(wdev->regmap, IMX2_WDT_WRSR, &val);
 	wdog->bootstatus = val & IMX2_WDT_WRSR_TOUT ? WDIOF_CARDRESET : 0;
 
+	wdev->ext_reset = of_property_read_bool(pdev->dev.of_node, "ext-reset");
 	wdog->timeout = clamp_t(unsigned, timeout, 1, IMX2_WDT_MAX_TIME);
 	if (wdog->timeout != timeout)
 		dev_warn(&pdev->dev, "Initial timeout out of range! Clamped from %u to %u\n",
-- 
1.9.1
