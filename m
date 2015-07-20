From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Tue, 21 Jul 2015 03:33:53 +0800
Subject: [PATCH V2 2/2] ARM: dts: imx6ul: add qspi support
In-Reply-To: <1437420833-22911-1-git-send-email-Frank.Li@freescale.com>
References: <1437420833-22911-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1437420833-22911-2-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

enable qspi support

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---

Change from v1 to v2:
 - update compatible string because local change missed in v1

 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/imx6ul.dtsi          | 13 +++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index 3d676ef..ee2243b 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -44,6 +44,20 @@
 	soc-supply = <&reg_soc>;
 };
 
+&qspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_qspi>;
+	status = "okay";
+
+	flash0: n25q256a at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "micron,n25q256a";
+		spi-max-frequency = <29000000>;
+		reg = <0>;
+	};
+};
+
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -206,6 +220,17 @@
 		>;
 	};
 
+	pinctrl_qspi: qspigrp {
+		fsl,pins = <
+			MX6UL_PAD_NAND_WP_B__QSPI_A_SCLK	0x70a1
+			MX6UL_PAD_NAND_READY_B__QSPI_A_DATA00	0x70a1
+			MX6UL_PAD_NAND_CE0_B__QSPI_A_DATA01	0x70a1
+			MX6UL_PAD_NAND_CE1_B__QSPI_A_DATA02	0x70a1
+			MX6UL_PAD_NAND_CLE__QSPI_A_DATA03	0x70a1
+			MX6UL_PAD_NAND_DQS__QSPI_A_SS0_B	0x70a1
+		>;
+	};
+
 	pinctrl_pwm1: pwm1grp {
 		fsl,pins = <
 			MX6UL_PAD_GPIO1_IO08__PWM1_OUT   0x110b0
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 61507ef..8d3925e 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -592,6 +592,19 @@
 				status = "disabled";
 			};
 
+			qspi: qspi@021e0000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx6ul-qspi", "fsl,imx6sx-qspi";
+				reg = <0x021e0000 0x4000>, <0x60000000 0x10000000>;
+				reg-names = "QuadSPI", "QuadSPI-memory";
+				interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks IMX6UL_CLK_QSPI>,
+					 <&clks IMX6UL_CLK_QSPI>;
+				clock-names = "qspi_en", "qspi";
+				status = "disabled";
+			};
+
 			uart2: serial at 021e8000 {
 				compatible = "fsl,imx6ul-uart",
 					     "fsl,imx6q-uart";
-- 
1.9.1
