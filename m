From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 18 Jul 2011 11:15:21 +0800
Subject: [PATCH] watchdog: imx2_wdt: add device tree probe support
Message-ID: <1310958921-18083-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds device tree probe support for imx2_wdt driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 .../devicetree/bindings/watchdog/fsl-imx-wdt.txt   |   14 ++++++++++++++
 drivers/watchdog/imx2_wdt.c                        |    6 ++++++
 2 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
new file mode 100644
index 0000000..2144af1
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt
@@ -0,0 +1,14 @@
+* Freescale i.MX Watchdog Timer (WDT) Controller
+
+Required properties:
+- compatible : Should be "fsl,<soc>-wdt"
+- reg : Should contain WDT registers location and length
+- interrupts : Should contain WDT interrupt
+
+Examples:
+
+wdt at 73f98000 {
+	compatible = "fsl,imx51-wdt", "fsl,imx21-wdt";
+	reg = <0x73f98000 0x4000>;
+	interrupts = <58>;
+};
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 86f7cac..b8ef2c6 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -329,12 +329,18 @@ static void imx2_wdt_shutdown(struct platform_device *pdev)
 	}
 }
 
+static const struct of_device_id imx2_wdt_dt_ids[] = {
+	{ .compatible = "fsl,imx21-wdt", },
+	{ /* sentinel */ }
+};
+
 static struct platform_driver imx2_wdt_driver = {
 	.remove		= __exit_p(imx2_wdt_remove),
 	.shutdown	= imx2_wdt_shutdown,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = imx2_wdt_dt_ids,
 	},
 };
 
-- 
1.7.4.1
