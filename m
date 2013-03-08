From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Fri,  8 Mar 2013 08:41:38 +0100
Subject: [PATCH] ARM: imx: Add support for the Armadeus Systems APF51Dev
 docking board
Message-ID: <1362728498-28151-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The APF51Dev is a docking board for an APF51 SOM

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/imx51-apf51dev.dtsp | 75 +++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx51-apf51dev.dtsp

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c62558..3b9d646 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -90,6 +90,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx27-pdk.dtb \
 	imx31-bug.dtb \
 	imx51-apf51.dtb \
+	imx51-apf51dev.dtb \
 	imx51-babbage.dtb \
 	imx53-ard.dtb \
 	imx53-evk.dtb \
diff --git a/arch/arm/boot/dts/imx51-apf51dev.dtsp b/arch/arm/boot/dts/imx51-apf51dev.dtsp
new file mode 100644
index 0000000..cf02bff
--- /dev/null
+++ b/arch/arm/boot/dts/imx51-apf51dev.dtsp
@@ -0,0 +1,75 @@
+/*
+ * Copyright 2013 Armadeus Systems - <support@armadeus.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/* APF51Dev is a docking board for the APF51 SOM */
+#include "imx51-apf51.dtsp"
+
+/ {
+	model = "Armadeus Systems APF51Dev docking/development board";
+	compatible = "armadeus,imx51-apf51dev", "armadeus,imx51-apf51", "fsl,imx51";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		user-key {
+			label = "user";
+			gpios = <&gpio1 3 0>;
+			linux,code = <256>; /* BTN_0 */
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		user {
+			label = "Heartbeat";
+			gpios = <&gpio1 2 0>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1_1>;
+	cd-gpios = <&gpio2 29 0>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&esdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc2_1>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	hog {
+		pinctrl_hog: hoggrp {
+			fsl,pins = <
+				MX51_PAD_EIM_EB2__GPIO2_22   0x0C5
+				MX51_PAD_EIM_EB3__GPIO2_23   0x0C5
+				MX51_PAD_EIM_CS4__GPIO2_29   0x100
+				MX51_PAD_NANDF_D13__GPIO3_27 0x0C5
+				MX51_PAD_NANDF_D12__GPIO3_28 0x0C5
+				MX51_PAD_CSPI1_SS0__GPIO4_24 0x0C5
+				MX51_PAD_CSPI1_SS1__GPIO4_25 0x0C5
+				MX51_PAD_GPIO1_2__GPIO1_2    0x0C5
+				MX51_PAD_GPIO1_3__GPIO1_3    0x0C5
+			>;
+		};
+	};
+};
-- 
1.8.1.5
