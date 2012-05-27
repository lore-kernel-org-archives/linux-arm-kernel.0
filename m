From: marex@denx.de (Marek Vasut)
Date: Sun, 27 May 2012 04:11:29 +0200
Subject: [PATCH] MXS: Add DT binding support into stmp3xxx-rtc
Message-ID: <1338084689-12003-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add simple binding for the stmp3xxx-rtc.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: rtc-linux at googlegroups.com
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 .../devicetree/bindings/rtc/stmp3xxx-rtc.txt       |   20 ++++++++++++++++++++
 arch/arm/boot/dts/imx28.dtsi                       |    1 +
 drivers/rtc/rtc-stmp3xxx.c                         |    8 ++++++++
 3 files changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt

diff --git a/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt b/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt
new file mode 100644
index 0000000..a49dd52
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/stmp3xxx-rtc.txt
@@ -0,0 +1,20 @@
+* STMP3xxx/i.MX28 Time Clock controller
+
+Required properties:
+- compatible: should be one of the following.
+    * "fsl,stmp3xxx-rtc"
+    * "fsl,imx28-rtc"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: Two interrupt numbers to the cpu should be specified. First
+  interrupt number is the rtc rick interupt and second interrupt number
+  is the rtc alarm interrupt. The number of cells representing a interrupt
+  depends on the parent interrupt controller.
+
+Example:
+
+	rtc at 80056000 {
+		compatible = "fsl,imx28-rtc";
+		reg = <0x80056000 2000>;
+		interrupts = <28 29>;
+	};
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index d470276..119f183 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -370,6 +370,7 @@
 			};
 
 			rtc at 80056000 {
+				compatible = "fsl,imx28-rtc";
 				reg = <0x80056000 2000>;
 				interrupts = <28 29>;
 				status = "disabled";
diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index 1028786..dea9764 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
+#include <linux/of_device.h>
 
 #include <mach/common.h>
 
@@ -265,6 +266,12 @@ static int stmp3xxx_rtc_resume(struct platform_device *dev)
 #define stmp3xxx_rtc_resume	NULL
 #endif
 
+static const struct of_device_id rtc_dt_ids[] = {
+	{ .compatible = "fsl,stmp3xxx-rtc", },
+	{ .compatible = "fsl,imx28-rtc", },
+	{ /* sentinel */ }
+};
+
 static struct platform_driver stmp3xxx_rtcdrv = {
 	.probe		= stmp3xxx_rtc_probe,
 	.remove		= stmp3xxx_rtc_remove,
@@ -273,6 +280,7 @@ static struct platform_driver stmp3xxx_rtcdrv = {
 	.driver		= {
 		.name	= "stmp3xxx-rtc",
 		.owner	= THIS_MODULE,
+		.of_match_table = rtc_dt_ids,
 	},
 };
 
-- 
1.7.10
