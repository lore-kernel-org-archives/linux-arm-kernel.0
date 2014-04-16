From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 16 Apr 2014 08:08:26 -0300
Subject: [PATCH v2] ARM: dts: imx27-pdk: Add PMIC support
Message-ID: <1397646506-6405-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

imx27-pdk has a MC13783 PMIC connected to CSPI2 port.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Place the PMIC IRQ into a separate pingroup.

 arch/arm/boot/dts/imx27-pdk.dts | 57 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index 430b72b..384ca56 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -21,6 +21,48 @@
 	};
 };
 
+&cspi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_cspi2 &pinctrl_pmic>;
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio4 21 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	pmic: mc13783 at 0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "fsl,mc13783";
+		reg = <0>;
+		spi-cs-high;
+		spi-max-frequency = <1000000>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <14 IRQ_TYPE_LEVEL_HIGH>;
+
+		regulators {
+			vgen_reg: vgen {
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vmmc1_reg: vmmc1 {
+				regulator-min-microvolt = <1600000>;
+				regulator-max-microvolt = <3000000>;
+			};
+
+			gpo1_reg: gpo1 {
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			gpo3_reg: gpo3 {
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
+};
 
 &fec {
 	phy-mode = "mii";
@@ -38,6 +80,15 @@
 
 &iomuxc {
 	imx27-pdk {
+		pinctrl_cspi2: cspi2grp {
+			fsl,pins = <
+				MX27_PAD_CSPI2_MISO__CSPI2_MISO 0x0
+				MX27_PAD_CSPI2_MOSI__CSPI2_MOSI 0x0
+				MX27_PAD_CSPI2_SCLK__CSPI2_SCLK 0x0
+				MX27_PAD_CSPI2_SS0__GPIO4_21	0x0 /* SPI2 CS0 */
+			>;
+		};
+
 		pinctrl_fec: fecgrp {
 			fsl,pins = <
 				MX27_PAD_SD3_CMD__FEC_TXD0 0x0
@@ -61,6 +112,12 @@
 			>;
 		};
 
+		pinctrl_pmic: pmicgrp {
+			fsl,pins = <
+				MX27_PAD_TOUT__GPIO3_14		0x0 /* PMIC IRQ */
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX27_PAD_UART1_TXD__UART1_TXD 0x0
-- 
1.8.3.2
