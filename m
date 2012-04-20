From: stigge@antcom.de (Roland Stigge)
Date: Fri, 20 Apr 2012 21:53:11 +0200
Subject: [PATCH v4] rtc: Add device tree support for LPC32xx
Message-ID: <1334951591-1323-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree support for rtc-lpc32xx.c

Signed-off-by: Roland Stigge <stigge@antcom.de>

---

Applies to v3.4-rc3

Changes since v3:
* Changed "compatible" strings to non-wildcard versions

 Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt |   16 ++++++++++++++++
 drivers/rtc/rtc-lpc32xx.c                             |   15 ++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

--- /dev/null
+++ linux-2.6/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt
@@ -0,0 +1,16 @@
+* NXP LPC32xx SoC Real Time Clock controller
+
+Required properties:
+- compatible: must be "nxp,lpc3220-rtc", "nxp,lpc3230-rtc", "nxp,lpc3240-rtc"
+  or "nxp,lpc3250-rtc"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: The RTC interrupt
+
+Example:
+
+	rtc at 40024000 {
+		compatible = "nxp,lpc3250-rtc";
+		reg = <0x40024000 0x1000>;
+		interrupts = <52 0>;
+	};
--- linux-2.6.orig/drivers/rtc/rtc-lpc32xx.c
+++ linux-2.6/drivers/rtc/rtc-lpc32xx.c
@@ -19,6 +19,7 @@
 #include <linux/rtc.h>
 #include <linux/slab.h>
 #include <linux/io.h>
+#include <linux/of.h>
 
 /*
  * Clock and Power control register offsets
@@ -386,13 +387,25 @@ static const struct dev_pm_ops lpc32xx_r
 #define LPC32XX_RTC_PM_OPS NULL
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id lpc32xx_rtc_match[] = {
+	{ .compatible = "nxp,lpc3220-rtc" },
+	{ .compatible = "nxp,lpc3230-rtc" },
+	{ .compatible = "nxp,lpc3240-rtc" },
+	{ .compatible = "nxp,lpc3250-rtc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lpc32xx_rtc_match);
+#endif
+
 static struct platform_driver lpc32xx_rtc_driver = {
 	.probe		= lpc32xx_rtc_probe,
 	.remove		= __devexit_p(lpc32xx_rtc_remove),
 	.driver = {
 		.name	= RTC_NAME,
 		.owner	= THIS_MODULE,
-		.pm	= LPC32XX_RTC_PM_OPS
+		.pm	= LPC32XX_RTC_PM_OPS,
+		.of_match_table = of_match_ptr(lpc32xx_rtc_match),
 	},
 };
 
