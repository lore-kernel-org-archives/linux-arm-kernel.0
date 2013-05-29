From: c.hemp@phytec.de (Christian Hemp)
Date: Wed, 29 May 2013 23:06:49 +0200
Subject: [PATCH 2/2] ARM: dts: Phytec phyFLEX-i.MX6 support
In-Reply-To: <1369861609-30408-1-git-send-email-c.hemp@phytec.de>
References: <1369861609-30408-1-git-send-email-c.hemp@phytec.de>
Message-ID: <1369861609-30408-3-git-send-email-c.hemp@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Phytec phyFLEX-i.MX6 board

Signed-off-by: Christian Hemp <c.hemp@phytec.de>
---
 arch/arm/boot/dts/Makefile                 |    1 +
 arch/arm/boot/dts/imx6q-phytec-phyflex.dts |   76 ++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-phytec-phyflex.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4c58951..6ffdaa1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -118,6 +118,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6dl-sabresd.dtb \
 	imx6dl-wandboard.dtb \
 	imx6q-arm2.dtb \
+	imx6q-phytec-phyflex.dtb \
 	imx6q-sabreauto.dtb \
 	imx6q-sabrelite.dtb \
 	imx6q-sabresd.dtb \
diff --git a/arch/arm/boot/dts/imx6q-phytec-phyflex.dts b/arch/arm/boot/dts/imx6q-phytec-phyflex.dts
new file mode 100644
index 0000000..9690691
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-phytec-phyflex.dts
@@ -0,0 +1,76 @@
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
+#include "imx6q.dtsi"
+
+/ {
+	model = "Phytec phyFLEX-i.MX6";
+	compatible = "phytec,phyflex-imx6", "fsl,imx6q";
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
+                pinctrl_hog: hoggrp {
+                        fsl,pins = <
+				MX6Q_PAD_EIM_D23__GPIO3_IO23    0x80000000
+			>;
+		};
+	};
+
+	phyflex {
+		pinctrl_usdhc3_phyflex: usdhc3grp-phyflex {
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
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4_1>;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2_2>;
+	cd-gpios = <&gpio1 4 0>;
+	wp-gpios = <&gpio1 2 0>;
+	status = "okay";
+};
+
+&usdhc3 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_usdhc3_2
+		     &pinctrl_usdhc3_phyflex>;
+        cd-gpios = <&gpio1 27 0>;
+        wp-gpios = <&gpio1 29 0>;
+        status = "okay";
+};
+
-- 
1.7.9.5
