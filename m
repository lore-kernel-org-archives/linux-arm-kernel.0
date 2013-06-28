From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 28 Jun 2013 16:50:37 +0200
Subject: [PATCH v3 5/5] ARM: dts: Add device tree support for phycard pca100
In-Reply-To: <1372431037-13519-1-git-send-email-mpa@pengutronix.de>
References: <1372431037-13519-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1372431037-13519-6-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Board files for Phytec phyCARD-S "System on Module" and "Rapid
Development Kit".

Based on patches from:

Steffen Trumtrar <s.trumtrar@pengutronix.de>:
 - Original patch
 - ARM: dts: Set partition offsets for phycard
 - ARM: dts: Use CSPI1 instead of CSPI2 on phycard pca100
 - ARM: imx27-phytec-phycard-S.dts: resize nand partitions

Jan Luebbe <jlu@pengutronix.de>:
 - ARM: dts: Enable bad block table in NAND

Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Jan Luebbe <jlu@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Notes:
    Changes in v3:
     - Fix memory offset
    
    Changes in v2:
     - Remove unnecessary Kconfig nand selection.
     - Style fixes
     - Replace node identifiers with node labels
     - Fix compatibility of cpu node
     - Remove device node for not mainlined dimmer driver
     - Remove nand partition table
     - Remove memory node
     - Splitted board file into "system on module" and "rapid development kit"

 arch/arm/boot/dts/Makefile                       |  2 +
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts | 62 ++++++++++++++++++++
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts | 72 ++++++++++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
 create mode 100644 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b3a8661..707c192 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -105,6 +105,8 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx27-pdk.dtb \
 	imx27-phytec-phycore-som.dtb \
 	imx27-phytec-phycore-rdk.dtb \
+	imx27-phytec-phycard-s-som.dtb \
+	imx27-phytec-phycard-s-rdk.dtb \
 	imx31-bug.dtb \
 	imx51-apf51.dtb \
 	imx51-apf51dev.dtb \
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
new file mode 100644
index 0000000..bf11429
--- /dev/null
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
@@ -0,0 +1,62 @@
+/*
+ * Copyright 2012 Markus Pargmann, Pengutronix
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+#include "imx27-phytec-phycard-s-som.dts"
+
+/ {
+	model = "Phytec pca100 rapid development kit";
+	compatible = "phytec,imx27-pca100-rdk", "phytec,imx27-pca100", "fsl,imx27";
+
+	display: display {
+		model = "Primeview-PD050VL1";
+		native-mode = <&timing0>;
+		bits-per-pixel = <16>;  /* non-standard but required */
+		fsl,pcr = <0xf0c88080>;	/* non-standard but required */
+		display-timings {
+			timing0: 640x480 {
+				hactive = <640>;
+				vactive = <480>;
+				hback-porch = <112>;
+				hfront-porch = <36>;
+				hsync-len = <32>;
+				vback-porch = <33>;
+				vfront-porch = <33>;
+				vsync-len = <2>;
+				clock-frequency = <25000000>;
+			};
+		};
+	};
+};
+
+&imxfb {
+	display = <&display>;
+	status = "okay";
+};
+
+&sdhci2 {
+	cd-gpios = <&gpio3 29 0>;
+	status = "okay";
+};
+
+&uart1 {
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&uart2 {
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&uart3 {
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
new file mode 100644
index 0000000..ec52b6d
--- /dev/null
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-som.dts
@@ -0,0 +1,72 @@
+/*
+ * Copyright 2012 Sascha Hauer, Uwe Kleine-K?nig, Steffen Trumtrar
+ * and Markus Pargmann, Pengutronix
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
+#include "imx27.dtsi"
+
+/ {
+	model = "Phytec pca100";
+	compatible = "phytec,imx27-pca100", "fsl,imx27";
+
+	memory {
+		reg = <0xa0000000 0x08000000>; /* 128MB */
+	};
+};
+
+&cspi1 {
+	fsl,spi-num-chipselects = <2>;
+	cs-gpios = <&gpio4 28 0>,
+		<&gpio4 27 0>;
+	status = "okay";
+};
+
+&fec {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+
+	ioexpander at 41 {
+		compatible = "nxp,pca9536";
+		reg = <0x41>;
+	};
+
+	rtc at 51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+};
+
+&i2c2 {
+	status = "okay";
+
+	lm75 at 4a {
+		compatible = "national,lm75";
+		reg = <0x4a>;
+	};
+
+	rtc at 51 {
+		compatible = "nxp,pcf8563";
+		reg = <0x51>;
+	};
+
+	at24 at 52 {
+		compatible = "at,24c32";
+		pagesize = <32>;
+		reg = <0x52>;
+	};
+};
+
+&owire {
+	status = "okay";
+};
-- 
1.8.2.1
