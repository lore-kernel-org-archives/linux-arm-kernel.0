From: c.hemp@phytec.de (Christian Hemp)
Date: Tue, 11 Jun 2013 19:48:22 +0200
Subject: [PATCH v2 2/2] ARM: dts: Phytec imx6q pfla02 and pbab01 support
In-Reply-To: <1370972902-23934-1-git-send-email-c.hemp@phytec.de>
References: <1370972902-23934-1-git-send-email-c.hemp@phytec.de>
Message-ID: <1370972902-23934-3-git-send-email-c.hemp@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for imx6q Phytec phyFLEX-i.MX6 Quad (aka pfla02 and pbab01).
 - Module pfla02
 - Carrier-Board pbab01

Signed-off-by: Christian Hemp <c.hemp@phytec.de>
---
 arch/arm/boot/dts/Makefile                 |    1 +
 arch/arm/boot/dts/imx6q-phytec-pbab01.dts  |   34 +++++++++++++
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi |   75 ++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-phytec-pbab01.dts
 create mode 100644 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 314fb9d..e0dd08b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -119,6 +119,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6dl-sabresd.dtb \
 	imx6dl-wandboard.dtb \
 	imx6q-arm2.dtb \
+	imx6q-phytec-pbab01.dtb \
 	imx6q-sabreauto.dtb \
 	imx6q-sabrelite.dtb \
 	imx6q-sabresd.dtb \
diff --git a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
new file mode 100644
index 0000000..7d37ec6
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
@@ -0,0 +1,34 @@
+/*
+ * Copyright 2013 Christian Hemp, Phytec Messtechnik GmbH
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+#include "imx6q-phytec-pfla02.dtsi"
+
+/ {
+	model = "Phytec phyFLEX-i.MX6 Quad Carrier-Board";
+	compatible = "phytec,imx6q-pbab01", "phytec,imx6q-pfla02", "fsl,imx6q";
+};
+
+&fec {
+	status = "okay";
+};
+
+&uart4 {
+	status = "okay";
+};
+
+&usdhc2 {
+	status = "okay";
+};
+
+&usdhc3 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
new file mode 100644
index 0000000..0ea1af4
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
@@ -0,0 +1,75 @@
+/*
+ * Copyright 2013 Christian Hemp, Phytec Messtechnik GmbH
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include "imx6q.dtsi"
+
+/ {
+	model = "Phytec phyFLEX-i.MX6 Ouad";
+	compatible = "phytec,imx6q-pfla02", "fsl,imx6q";
+
+	memory {
+		reg = <0x10000000 0x80000000>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX6Q_PAD_EIM_D23__GPIO3_IO23    0x80000000
+			>;
+		};
+	};
+
+	pfla02 {
+		pinctrl_usdhc3_pfla02: usdhc3grp-pfla02 {
+			fsl,pins = <
+				MX6Q_PAD_ENET_RXD0__GPIO1_IO27  0x80000000
+				MX6Q_PAD_ENET_TXD1__GPIO1_IO29  0x80000000
+			>;
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet_3>;
+	phy-mode = "rgmii";
+	phy-reset-gpios = <&gpio3 23 0>;
+	status = "disabled";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4_1>;
+	status = "disabled";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2_2>;
+	cd-gpios = <&gpio1 4 0>;
+	wp-gpios = <&gpio1 2 0>;
+	status = "disabled";
+};
+
+&usdhc3 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_usdhc3_2
+		     &pinctrl_usdhc3_pfla02>;
+        cd-gpios = <&gpio1 27 0>;
+        wp-gpios = <&gpio1 29 0>;
+        status = "disabled";
+};
+
-- 
1.7.9.5
