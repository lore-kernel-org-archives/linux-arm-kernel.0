From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Mon, 18 Nov 2013 19:18:58 +0200
Subject: [PATCH 5/6] watchdog: davinci: reuse driver for keystone arch
In-Reply-To: <1384795139-19466-1-git-send-email-ivan.khoronzhuk@ti.com>
References: <1384795139-19466-1-git-send-email-ivan.khoronzhuk@ti.com>
Message-ID: <1384795139-19466-6-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The keystone arch use the same IP watchdog, so add "ti,keystone-wdt"
compatible and correct identity.

The Keystone arch is using clocks in DT and source clock for watchdog
has to be specified, so add this to binding.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 .../devicetree/bindings/watchdog/davinci-wdt.txt   |   11 +++++++++--
 drivers/watchdog/Kconfig                           |    4 ++--
 drivers/watchdog/davinci_wdt.c                     |    3 ++-
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt b/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
index e450134..0f1aa99 100644
--- a/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/davinci-wdt.txt
@@ -1,16 +1,23 @@
-DaVinci Watchdog Timer (WDT) Controller
+Texas Instruments DaVinci/Keystone Watchdog Timer (WDT) Controller
 
 Required properties:
-- compatible : Should be "ti,davinci-wdt"
+- compatible : Should be "ti,davinci-wdt" or "ti,keystone-wdt"
 - reg : Should contain WDT registers location and length
+- clocks : phandle reference to the controller clock.
+	   Required only for Keystone arch. See clock-bindings.txt
 
 Optional properties:
 - timeout-sec : Contains the watchdog timeout in seconds
 
+Documentation:
+Davinci DM646x - http://www.ti.com/lit/ug/spruer5b/spruer5b.pdf
+Keystone - http://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf
+
 Examples:
 
 wdt: wdt at 2320000 {
 	compatible = "ti,davinci-wdt";
 	reg = <0x02320000 0x80>;
 	timeout-sec = <30>;
+	clocks = <&clkwdtimer0>;
 };
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index d7db13d..addfc2c 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -270,12 +270,12 @@ config IOP_WATCHDOG
 
 config DAVINCI_WATCHDOG
 	tristate "DaVinci watchdog"
-	depends on ARCH_DAVINCI
+	depends on ARCH_DAVINCI || ARCH_KEYSTONE
 	select WATCHDOG_CORE
 	select WATCHDOG_NOWAYOUT
 	help
 	  Say Y here if to include support for the watchdog timer
-	  in the DaVinci DM644x/DM646x processors.
+	  in the DaVinci DM644x/DM646x or Keystone processors.
 	  To compile this driver as a module, choose M here: the
 	  module will be called davinci_wdt.
 
diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 55deaf8..a6d365a 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -143,7 +143,7 @@ static unsigned int davinci_wdt_get_timeleft(struct watchdog_device *wdd)
 
 static const struct watchdog_info davinci_wdt_info = {
 	.options = WDIOF_KEEPALIVEPING,
-	.identity = "DaVinci Watchdog",
+	.identity = "DaVinci/Keystone Watchdog",
 };
 
 static const struct watchdog_ops davinci_wdt_ops = {
@@ -212,6 +212,7 @@ static int davinci_wdt_remove(struct platform_device *pdev)
 
 static const struct of_device_id davinci_wdt_of_match[] = {
 	{ .compatible = "ti,davinci-wdt", },
+	{ .compatible = "ti,keystone-wdt", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, davinci_wdt_of_match);
-- 
1.7.9.5
