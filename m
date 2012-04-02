From: stigge@antcom.de (Roland Stigge)
Date: Mon,  2 Apr 2012 14:55:59 +0200
Subject: [PATCH 2/7] rtc: Add device tree support for LPC32xx
In-Reply-To: <1333371364-21347-1-git-send-email-stigge@antcom.de>
References: <1333371364-21347-1-git-send-email-stigge@antcom.de>
Message-ID: <1333371364-21347-3-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds device tree support for rtc-lpc32xx.c

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 Applies to v3.4-rc1

 Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt |   15 +++++++++++++++
 drivers/rtc/rtc-lpc32xx.c                             |   12 +++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

--- /dev/null
+++ linux-2.6/Documentation/devicetree/bindings/rtc/lpc32xx-rtc.txt
@@ -0,0 +1,15 @@
+* NXP LPC32xx SoC Real Time Clock controller
+
+Required properties:
+- compatible: must be "nxp,lpc32xx-rtc"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: The RTC interrupt
+
+Example:
+
+	rtc at 40024000 {
+		compatible = "nxp,lpc32xx-rtc";
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
@@ -386,13 +387,22 @@ static const struct dev_pm_ops lpc32xx_r
 #define LPC32XX_RTC_PM_OPS NULL
 #endif
 
+#ifdef CONFIG_OF
+static const struct of_device_id lpc32xx_rtc_match[] = {
+	{ .compatible = "nxp,lpc32xx-rtc" },
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
 
