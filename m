From: yibin.gong@nxp.com (Robin Gong)
Date: Wed, 21 Mar 2018 18:38:18 +0800
Subject: [PATCH v1] ARM: dts: imx6qdl-sabreauto: add ecspi dts for sabreauto
 board
Message-ID: <1521628698-1178-1-git-send-email-yibin.gong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DIN pin of SPI-NOR muxed with I2C3_SDA which connected to one gpio expand
chip, thus have to disable all those module which compacted by those gpios
if enable SPI-NOR support on Sabreauto board.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm/boot/dts/Makefile                   |  2 ++
 arch/arm/boot/dts/imx6dl-sabreauto-ecspi.dts | 47 +++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6q-sabreauto-ecspi.dts  | 48 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi     |  1 +
 4 files changed, 98 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-sabreauto-ecspi.dts
 create mode 100644 arch/arm/boot/dts/imx6q-sabreauto-ecspi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4fe209c..4a814bb 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -406,6 +406,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-rex-basic.dtb \
 	imx6dl-riotboard.dtb \
 	imx6dl-sabreauto.dtb \
+	imx6dl-sabreauto-ecspi.dtb \
 	imx6dl-sabrelite.dtb \
 	imx6dl-sabresd.dtb \
 	imx6dl-savageboard.dtb \
@@ -478,6 +479,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-pistachio.dtb \
 	imx6q-rex-pro.dtb \
 	imx6q-sabreauto.dtb \
+	imx6q-sabreauto-ecspi.dtb \
 	imx6q-sabrelite.dtb \
 	imx6q-sabresd.dtb \
 	imx6q-savageboard.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-sabreauto-ecspi.dts b/arch/arm/boot/dts/imx6dl-sabreauto-ecspi.dts
new file mode 100644
index 0000000..80d018d
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-sabreauto-ecspi.dts
@@ -0,0 +1,47 @@
+/*
+ * Copyright (C) 2014 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "imx6dl-sabreauto.dts"
+
+&gpio5 {
+	eim_d18_steered {
+		gpio-hog;
+		gpios = <4 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "ecspi1_din";
+	};
+};
+
+&ecspi1 {
+	status = "okay";
+};
+
+&can2 {
+	/* max7310_c on i2c3 is gone */
+	status = "disabled";
+};
+
+&i2c3 {
+	/* pin conflict with ecspi1 */
+	status = "disabled";
+};
+
+&uart3 {
+	/* the uart3 depends on the i2c3, so disable it too. */
+	status = "disabled";
+};
+
+&usbh1 {
+	/* max7310_b on i2c3 is gone */
+	status = "disabled";
+};
+
+&usbotg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6q-sabreauto-ecspi.dts b/arch/arm/boot/dts/imx6q-sabreauto-ecspi.dts
new file mode 100644
index 0000000..cb7f38e
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-sabreauto-ecspi.dts
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2014 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "imx6q-sabreauto.dts"
+
+&gpio5 {
+	eim_d18_steered {
+		gpio-hog;
+		gpios = <4 GPIO_ACTIVE_LOW>;
+		output-high;
+		line-name = "ecspi1_din";
+	};
+};
+
+&ecspi1 {
+	status = "okay";
+};
+
+&can2 {
+	/* max7310_c on i2c3 is gone */
+	status = "disabled";
+};
+
+&i2c3 {
+	/* pin conflict with ecspi1 */
+	status = "disabled";
+};
+
+&uart3 {
+	/* the uart3 depends on the i2c3, so disable it too. */
+	status = "disabled";
+};
+
+&usbh1 {
+	/* max7310_b on i2c3 is gone */
+	status = "disabled";
+};
+
+&usbotg {
+	/* max7310_c on i2c3 is gone */
+	status = "okay";
+	dr_mode = "peripheral";
+};
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 54b0139..b83efc3 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -375,6 +375,7 @@
 				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15 0x80000000
 				MX6QDL_PAD_SD2_DAT2__GPIO1_IO13  0x80000000
 				MX6QDL_PAD_GPIO_18__SD3_VSELECT 0x17059
+				MX6QDL_PAD_EIM_A24__GPIO5_IO04   0x80000000
 			>;
 		};
 
-- 
2.7.4
