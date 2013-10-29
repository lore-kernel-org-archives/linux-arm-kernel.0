From: valentin@compulab.co.il (Valentin Raevsky)
Date: Tue, 29 Oct 2013 14:11:43 +0200
Subject: [PATCH] ARM: dts: Add initial support for cm-fx6.
Message-ID: <1383048703-2101-1-git-send-email-valentin@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add initial support for cm-fx6 module.

cm-fx6 is a module based on mx6q SoC with the following features:
- Up to 4GB of DDR3
- 1 LCD/DVI output port
- 1 HDMI output port
- 2 LVDS LCD ports
- Gigabit Ethernet
- Analog Audio
- CAN
- SATA
- NAND
- PCIE

This patch allows to boot up the module, configures the serial console,
the Ethernet adapter and the heartbeat led.

cm-fx6 is embedded inside the Utilite computer.

Signed-off-by: Valentin Raevsky <valentin@compulab.co.il>
Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---

Shawn, can this still be applied for 3.13 ?

 arch/arm/boot/dts/Makefile         |    1 +
 arch/arm/boot/dts/imx6q-cm-fx6.dts |   53 ++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-cm-fx6.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 641b3c9..87ca7ca 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -131,6 +131,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx6q-sabrelite.dtb \
 	imx6q-sabresd.dtb \
 	imx6q-sbc6x.dtb \
+	imx6q-cm-fx6.dtb \
 	imx6sl-evk.dtb \
 	vf610-twr.dtb
 dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
new file mode 100644
index 0000000..2419751
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -0,0 +1,53 @@
+/*
+ * Copyright 2013 CompuLab Ltd.
+ *
+ * Author: Valentin Raevsky <valentin@compulab.co.il>
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
+	model = "CompuLab CM-FX6";
+	compatible = "compulab,cm-fx6", "fsl,imx6q";
+
+	memory {
+		reg = <0x10000000 0x80000000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		heartbeat-led {
+			label = "Heartbeat";
+			gpios = <&gpio2 31 0>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet_1>;
+	phy-mode = "rgmii";
+	status = "okay";
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand_1>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart4_1>;
+	status = "okay";
+};
-- 
1.7.9.5
