From: plaes@plaes.org (Priit Laes)
Date: Sun, 19 Feb 2017 22:28:01 +0200
Subject: [PATCH 4/4] arm: dts: imx: Basic board definition for Parvus Duracor
 C310
In-Reply-To: <20170219202801.2082-1-plaes@plaes.org>
References: <20170219202801.2082-1-plaes@plaes.org>
Message-ID: <20170219202801.2082-5-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DuraCOR 310 is a tactical mission computer based on a
low-power four-core NXP i.MX6 Quad Arm processor equipped
with a rugged Flash disk and PCIe-Mini Card I/O expansion slots.

Add initial board support with CAN, eMMC, I2C, PCI, SATA, UART
and USB enabled.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/imx6q-parvus-duracor-310.dts | 119 +++++++++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-parvus-duracor-310.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 01d178a..542375c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -397,6 +397,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6q-nitrogen6_max.dtb \
 	imx6q-nitrogen6_som2.dtb \
 	imx6q-novena.dtb \
+	imx6q-parvus-duracor-310.dtb \
 	imx6q-phytec-pbab01.dtb \
 	imx6q-rex-pro.dtb \
 	imx6q-sabreauto.dtb \
diff --git a/arch/arm/boot/dts/imx6q-parvus-duracor-310.dts b/arch/arm/boot/dts/imx6q-parvus-duracor-310.dts
new file mode 100644
index 0000000..07344ad
--- /dev/null
+++ b/arch/arm/boot/dts/imx6q-parvus-duracor-310.dts
@@ -0,0 +1,119 @@
+/*
+ * Copyright 2017 Priit Laes <plaes@plaes.org>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of
+ *     the License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+/dts-v1/;
+#include "imx6q-smarc-sam6xi.dtsi"
+
+/ {
+	model = "Parvus Duracor 310";
+	compatible = "parvus-duracor,c310", "kontron,imx6-smx6", "fsl,imx6q";
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* CAN1 enable line */
+		can1_en_reg: regulator at 102 {
+			compatible = "regulator-fixed";
+			reg = <102>;
+			regulator-name = "CAN1_EN";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		/* CAN2 enable line */
+		can2_en_reg: regulator at 103 {
+			compatible = "regulator-fixed";
+			reg = <103>;
+			regulator-name = "CAN2_EN";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+	};
+};
+
+&can1 {
+	xceiver-supply = <&can1_en_reg>;
+	status = "okay";
+};
+
+&can2 {
+	xceiver-supply = <&can2_en_reg>;
+	status = "okay";
+};
+
+&i2c3 {
+	status ="okay";
+
+	pm_eeprom: at24 at 50 {
+		compatible = "at24,24c32";
+		pagesize = <8>;
+		reg = <0x50>;
+	};
+};
+
+&fec {
+	status = "okay";
+};
+
+&pcie {
+	status = "okay";
+};
+
+&sata {
+	status = "okay";
+};
+
+&uart1 {
+	status = "okay";
+};
+
+&usbh1 {
+	status = "okay";
+};
+
+&usdhc4 {
+	/* eMMC */
+	status = "okay";
+};
-- 
2.9.3
