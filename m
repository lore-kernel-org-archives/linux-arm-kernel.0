From: marek@goldelico.com (Marek Belisko)
Date: Fri, 14 Feb 2014 14:17:40 +0100
Subject: [PATCH 1/2] mfd: twl4030-madc: Add devicetree support.
Message-ID: <1392383861-14169-1-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 .../devicetree/bindings/mfd/twl4030-madc.txt       | 18 +++++++++++++
 drivers/mfd/twl4030-madc.c                         | 31 ++++++++++++++++++++--
 2 files changed, 47 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/twl4030-madc.txt

diff --git a/Documentation/devicetree/bindings/mfd/twl4030-madc.txt b/Documentation/devicetree/bindings/mfd/twl4030-madc.txt
new file mode 100644
index 0000000..9df66ab
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/twl4030-madc.txt
@@ -0,0 +1,18 @@
+Texas Instruments TWL family (twl4030) analog signal conversion monitor module
+
+Required properties:
+- compatible : must be "ti,twl4030-madc"
+- interrupts : interrupt number
+
+Example:
+twl: twl at 48 {
+	reg = <0x48>;
+	interrupts = <7>; /* SYS_NIRQ cascaded to intc */
+	interrupt-parent = <&intc>;
+
+	twl_madc: madc {
+		compatible = "ti,twl4030-madc";
+		interrupts = <1>;
+	};
+};
+
diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
index 4c583e4..9a2bbcf 100644
--- a/drivers/mfd/twl4030-madc.c
+++ b/drivers/mfd/twl4030-madc.c
@@ -695,6 +695,29 @@ static int twl4030_madc_set_power(struct twl4030_madc_data *madc, int on)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static struct twl4030_madc_platform_data *
+	twl4030_madc_of_parse(struct platform_device *pdev)
+{
+	struct twl4030_madc_platform_data *pdata;
+
+	pdata = devm_kzalloc(&pdev->dev,
+			sizeof(struct twl4030_madc_platform_data), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	pdata->irq_line = platform_get_irq(pdev, 0);
+
+	return pdata;
+}
+
+static const struct of_device_id twl4030_madc_dt_match_table[] = {
+	{ .compatible = "ti,twl4030-madc" },
+	{},
+};
+
+#endif
+
 /*
  * Initialize MADC and request for threaded irq
  */
@@ -706,8 +729,11 @@ static int twl4030_madc_probe(struct platform_device *pdev)
 	u8 regval;
 
 	if (!pdata) {
-		dev_err(&pdev->dev, "platform_data not available\n");
-		return -EINVAL;
+		pdata = twl4030_madc_of_parse(pdev);
+		if (!pdata) {
+			dev_err(&pdev->dev, "platform_data not available\n");
+			return -EINVAL;
+		}
 	}
 	madc = kzalloc(sizeof(*madc), GFP_KERNEL);
 	if (!madc)
@@ -807,6 +833,7 @@ static struct platform_driver twl4030_madc_driver = {
 	.driver = {
 		   .name = "twl4030_madc",
 		   .owner = THIS_MODULE,
+		   .of_match_table = of_match_ptr(twl4030_madc_dt_match_table),
 		   },
 };
 
-- 
1.8.3.2
