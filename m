From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 25 Sep 2012 11:56:26 +0200
Subject: [PATCH v2] rtc: i.MX dryice: Add devicetree support
Message-ID: <1348566986-9603-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add devicetree probing, fixing some whitespace damage along the way.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

changes since v1:

- document 'intrerrupts' property as mandatory, because the driver needs it.

 Documentation/devicetree/bindings/rtc/imx-di.txt |   19 +++++++++++++++++++
 drivers/rtc/rtc-imxdi.c                          |   12 +++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/imx-di.txt

diff --git a/Documentation/devicetree/bindings/rtc/imx-di.txt b/Documentation/devicetree/bindings/rtc/imx-di.txt
new file mode 100644
index 0000000..42b92b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/imx-di.txt
@@ -0,0 +1,19 @@
+* i.MX25 dryice Real Time Clock controller
+
+This RTC is part of the i.MX25 dryice module. Documentation for this
+unit is not publically available. This binding only makes use of the
+RTC.
+
+Required properties:
+- compatible: should be "fsl,imx25-rtc"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: interrupt source for the dryice module
+
+Example:
+
+	dryice at 53ffc000 {
+		compatible = "fsl,imx25-dryice", "fsl,imx25-rtc";
+		reg = <0x53ffc000 0x4000>;
+		interrupts = <25>;
+	};
diff --git a/drivers/rtc/rtc-imxdi.c b/drivers/rtc/rtc-imxdi.c
index 891cd6c..b2fe920 100644
--- a/drivers/rtc/rtc-imxdi.c
+++ b/drivers/rtc/rtc-imxdi.c
@@ -493,11 +493,17 @@ static int __devexit dryice_rtc_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id of_dryice_rtc_match[] = {
+	{ .compatible = "fsl,imx25-rtc", },
+	{ },
+};
+
 static struct platform_driver dryice_rtc_driver = {
 	.driver = {
-		   .name = "imxdi_rtc",
-		   .owner = THIS_MODULE,
-		   },
+		.name = "imxdi_rtc",
+		.owner = THIS_MODULE,
+		.of_match_table = of_dryice_rtc_match,
+	},
 	.remove = __devexit_p(dryice_rtc_remove),
 };
 
-- 
1.7.10.4
