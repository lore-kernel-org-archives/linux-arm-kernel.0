From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:56:55 +0200
Subject: =?UTF-8?q?=5BPATCH=2010/22=5D=20arm/dts=3A=20Add=20support=20for=20the=20cpuimx25=20board=20from=20Eukrea=20and=20its=20baseboard=2E?=
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-11-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only the following devices/functionalities were added:
 * Main UART
 * Memory node
 * NAND
 * i2c and its pcf8563
 * Ethernet
 * LCD controller
 * Sound
 * ESDHC

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt     |    4 ++
 arch/arm/boot/dts/eukrea_cpuimx25.dts             |   48 +++++++++++++++++
 arch/arm/boot/dts/eukrea_mbimxsd25-baseboard.dtsi |   59 +++++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 arch/arm/boot/dts/eukrea_cpuimx25.dts
 create mode 100644 arch/arm/boot/dts/eukrea_mbimxsd25-baseboard.dtsi

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index e935d7d..2c19348 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -9,6 +9,10 @@ i.MX25 Product Development Kit
 Required root node properties:
     - compatible = "fsl,imx25-pdk", "fsl,imx25";
 
+i.MX25 Eukrea CPUIMX25 Board.
+Required root node properties:
+    - compatible = "fsl,eukrea_cpuimx25", "fsl,imx25";
+
 i.MX27 Product Development Kit
 Required root node properties:
     - compatible = "fsl,imx27-pdk", "fsl,imx27";
diff --git a/arch/arm/boot/dts/eukrea_cpuimx25.dts b/arch/arm/boot/dts/eukrea_cpuimx25.dts
new file mode 100644
index 0000000..a65243c
--- /dev/null
+++ b/arch/arm/boot/dts/eukrea_cpuimx25.dts
@@ -0,0 +1,48 @@
+/*
+ * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
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
+#include "imx25.dtsi"
+#include "eukrea_mbimxsd25-baseboard.dtsi"
+
+/ {
+	model = "Eukrea CPUIMX25";
+	compatible = "fsl,eukrea_cpuimx25", "fsl,imx25";
+
+	memory {
+		reg = <0x80000000 0x4000000>; /* 64M */
+	};
+};
+
+&fec {
+	phy-mode = "rmii";
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec_1>;
+};
+
+&nfc {
+	nand-bus-width = <8>;
+	nand-ecc-mode = "hw";
+	nand-on-flash-bbt;
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1_1>;
+
+	pcf8563 at 51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
diff --git a/arch/arm/boot/dts/eukrea_mbimxsd25-baseboard.dtsi b/arch/arm/boot/dts/eukrea_mbimxsd25-baseboard.dtsi
new file mode 100644
index 0000000..ffaf657
--- /dev/null
+++ b/arch/arm/boot/dts/eukrea_mbimxsd25-baseboard.dtsi
@@ -0,0 +1,59 @@
+/*
+ * Copyright 2013 Eukr?a Electromatique <denis@eukrea.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include "skeleton.dtsi"
+
+/ {
+	sound {
+		compatible = "fsl,eukrea-tlv320";
+		model = "imx25-eukrea-tlv320aic23";
+		ssi-controller = <&ssi1>;
+		fsl,audio-codec = <&tlv320aic23>;
+		mux-int-port = <1>;
+		mux-ext-port = <5>;
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1_1>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&lcdc {
+	status = "okay";
+};
+
+&audmux {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_audmux_1>;
+};
+
+&ssi1 {
+	fsl,mode = "i2s-slave";
+	status = "okay";
+};
+
+&i2c1 {
+	tlv320aic23: codec at 1a {
+		compatible = "ti,tlv320aic23";
+		reg = <0x1a>;
+	};
+};
+
+&esdhc1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1_1>;
+	cd-gpios = <&gpio1 20>;
+};
-- 
1.7.9.5
