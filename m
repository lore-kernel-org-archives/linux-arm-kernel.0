From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 23 Jun 2013 12:32:29 +0400
Subject: [PATCH v2 3/3] rtc: mxc_rtc: Add DT support
In-Reply-To: <1371976349-18679-1-git-send-email-shc_work@mail.ru>
References: <1371976349-18679-1-git-send-email-shc_work@mail.ru>
Message-ID: <1371976349-18679-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings for the mxc_rtc driver and read the device
configuration from the DT node at probe time if available.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 Documentation/devicetree/bindings/rtc/mxc-rtc.txt | 21 ++++++++++++++++++
 drivers/rtc/rtc-mxc.c                             | 27 +++++++++++++++++++----
 2 files changed, 44 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/mxc-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/mxc-rtc.txt b/Documentation/devicetree/bindings/rtc/mxc-rtc.txt
new file mode 100644
index 0000000..ad8b0b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/mxc-rtc.txt
@@ -0,0 +1,21 @@
+* i.MX Real Time Clock controller
+
+This binding supports the following chips: i.MX1, i.MX27, i.MX31, i.MX35
+
+Required properties:
+- compatible: should be: "fsl,imx1-rtc" or "fsl,imx21-rtc"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: rtc alarm interrupt
+- clocks : Should contain the rtc and ipg clocks, in the order
+  determined by the clock-names property.
+
+Example:
+
+rtc at 10007000 {
+	compatible = "fsl,imx27-rtc", "fsl,imx21-rtc";
+	reg = <0x10007000 0x1000>;
+	interrupts = <22>;
+	clocks = <&clks 2>, <&clks 33>;
+	clock-names = "rtc", "ipg";
+};
diff --git a/drivers/rtc/rtc-mxc.c b/drivers/rtc/rtc-mxc.c
index b4da99c..b60ede2 100644
--- a/drivers/rtc/rtc-mxc.c
+++ b/drivers/rtc/rtc-mxc.c
@@ -13,6 +13,8 @@
 #include <linux/rtc.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 
@@ -351,7 +353,16 @@ static int mxc_rtc_probe(struct platform_device *pdev)
 	/* Disable all interrupts */
 	writew(0, pdata->ioaddr + RTC_RTCIENR);
 
-	pdata->devtype = pdev->id_entry->driver_data;
+	if (pdev->dev.of_node) {
+		struct platform_driver *pdrv = container_of(pdev->dev.driver,
+						struct platform_driver, driver);
+		const struct of_device_id *of_id =
+			of_match_device(pdrv->driver.of_match_table, &pdev->dev);
+
+		pdata->devtype = (enum imx_rtc_type)of_id->data;
+	} else
+		pdata->devtype = pdev->id_entry->driver_data;
+
 	platform_set_drvdata(pdev, pdata);
 
 	pdata->rtc_ops.open		= mxc_rtc_open;
@@ -422,6 +433,13 @@ static int __maybe_unused mxc_rtc_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(mxc_rtc_pm_ops, mxc_rtc_suspend, mxc_rtc_resume);
 
+static const struct of_device_id mxc_rtc_dt_ids[] = {
+	{ .compatible = "fsl,imx1-rtc", .data = (void *)IMX1_RTC, },
+	{ .compatible = "fsl,imx21-rtc", .data = (void *)IMX21_RTC, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mxc_rtc_dt_ids);
+
 static const struct platform_device_id mxc_rtc_id_table[] = {
 	{ .name = "imx1-rtc", .driver_data = IMX1_RTC, },
 	{ .name = "imx21-rtc", .driver_data = IMX21_RTC, },
@@ -431,9 +449,10 @@ MODULE_DEVICE_TABLE(platform, mxc_rtc_id_table);
 
 static struct platform_driver mxc_rtc_driver = {
 	.driver = {
-		   .name	= "mxc_rtc",
-		   .owner	= THIS_MODULE,
-		   .pm		= &mxc_rtc_pm_ops,
+		   .name		= "mxc_rtc",
+		   .owner		= THIS_MODULE,
+		   .of_match_table	= mxc_rtc_dt_ids,
+		   .pm			= &mxc_rtc_pm_ops,
 	},
 	.probe		= mxc_rtc_probe,
 	.remove		= mxc_rtc_remove,
-- 
1.8.1.5
