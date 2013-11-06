From: ivan.khoronzhuk@ti.com (ivan.khoronzhuk)
Date: Wed, 6 Nov 2013 13:32:46 +0200
Subject: Fwd: [PATCH 6/8] watchdog: davinci: reuse driver for keystone arch
In-Reply-To: <1383680783-12114-7-git-send-email-ivan.khoronzhuk@ti.com>
References: <1383680783-12114-7-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <527A28DE.4030906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The keystone arch use the same IP watchdog, so add "ti,keystone-wdt"
compatible and correct identity.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 .../devicetree/bindings/watchdog/davinci-wdt.txt   |   11 +++++++++--
 drivers/watchdog/Kconfig                           |    4 ++--
 drivers/watchdog/davinci_wdt.c                     |    3 ++-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt b/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
index 1668b6e..fddced9 100644
--- a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
@@ -1,13 +1,20 @@
-DaVinci Watchdog Timer (WDT) Controller
+Texas Instruments DaVinci/Keystone Watchdog Timer (WDT) Controller
 
 Required properties:
-- compatible : Should be "ti,davinci-wdt"
+
+- compatible:		"ti,davinci-wdt"
+			"ti,keystone-wdt"
+
 - reg : Should contain WDT registers location and length
 
 Optional properties:
 
 - timeout-sec:		Contains the watchdog timeout in seconds
 
+Documentation:
+Davinci DM646x - http://www.ti.com/lit/ug/spruer5b/spruer5b.pdf
+Keystone - http://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf
+
 Examples:
 
 wdt: wdt at 2320000 {
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 2c954b5..a4fe130 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -270,11 +270,11 @@ config IOP_WATCHDOG
 
 config DAVINCI_WATCHDOG
 	tristate "DaVinci watchdog"
-	depends on ARCH_DAVINCI
+	depends on ARCH_DAVINCI || ARCH_KEYSTONE
 	select WATCHDOG_CORE
 	help
 	  Say Y here if to include support for the watchdog timer
-	  in the DaVinci DM644x/DM646x processors.
+	  in the DaVinci DM644x/DM646x or Keystone processors.
 	  To compile this driver as a module, choose M here: the
 	  module will be called davinci_wdt.
 
diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index a371b2d..e51fd2e 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -158,7 +158,7 @@ static unsigned int davinci_wdt_status(struct watchdog_device *wdd)
 
 static const struct watchdog_info davinci_wdt_info = {
 	.options = WDIOF_KEEPALIVEPING,
-	.identity = "DaVinci Watchdog",
+	.identity = "DaVinci/Keystone Watchdog",
 };
 
 static const struct watchdog_ops davinci_wdt_ops = {
@@ -229,6 +229,7 @@ static int davinci_wdt_remove(struct platform_device *pdev)
 
 static const struct of_device_id davinci_wdt_of_match[] = {
 	{ .compatible = "ti,davinci-wdt", },
+	{ .compatible = "ti,keystone-wdt", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, davinci_wdt_of_match);
-- 
1.7.9.5
