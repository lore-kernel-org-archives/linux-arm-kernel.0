From: diego.dorta@nxp.com (Diego Dorta)
Date: Wed, 22 Jun 2016 16:37:09 -0300
Subject: [PATCH v2 3/4] ARM: dts: imx7d-sdb: Add support for touchscreen
In-Reply-To: <1466624230-16191-1-git-send-email-diego.dorta@nxp.com>
References: <1466624230-16191-1-git-send-email-diego.dorta@nxp.com>
Message-ID: <1466624230-16191-3-git-send-email-diego.dorta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for tsc2046 touchscreen.

Signed-off-by: Diego Dorta <diego.dorta@nxp.com>
---
Changes since v1:
- Merged pinctrl_ecspi3 and pinctrl_ecspi3_cs in one pinctrl.
- Used GPIO_ACTIVE_HIGH macro for polarity.
- Put the unit-address for 'reg' property.
- Replaced 'linux,wakeup' for 'wakeup-source'.

 arch/arm/boot/dts/imx7d-sdb.dts | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 8f6a539..6bd8203 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -111,6 +111,32 @@
 	arm-supply = <&sw1a_reg>;
 };
 
+&ecspi3 {
+	fsl,spi-num-chipselects = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi3>;
+	cs-gpios = <&gpio5 9 GPIO_ACTIVE_HIGH>;
+	status = "okay";
+
+	tsc2046 at 0 {
+		compatible = "ti,tsc2046";
+		reg = <0>;
+		spi-max-frequency = <1000000>;
+		pinctrl-names ="default";
+		pinctrl-0 = <&pinctrl_tsc2046_pendown>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <29 0>;
+		pendown-gpio = <&gpio2 29 GPIO_ACTIVE_HIGH>;
+		ti,x-min = /bits/ 16 <0>;
+		ti,x-max = /bits/ 16 <0>;
+		ti,y-min = /bits/ 16 <0>;
+		ti,y-max = /bits/ 16 <0>;
+		ti,pressure-max = /bits/ 16 <0>;
+		ti,x-plat-ohms = /bits/ 16 <400>;
+		wakeup-source;
+	};
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet1>;
@@ -363,6 +389,15 @@
 	pinctrl-0 = <&pinctrl_hog>;
 
 	imx7d-sdb {
+		pinctrl_ecspi3: ecspi3grp {
+			fsl,pins = <
+				MX7D_PAD_SAI2_TX_SYNC__ECSPI3_MISO	0x2
+				MX7D_PAD_SAI2_TX_BCLK__ECSPI3_MOSI	0x2
+				MX7D_PAD_SAI2_RX_DATA__ECSPI3_SCLK	0x2
+				MX7D_PAD_SD2_CD_B__GPIO5_IO9		0x59
+			>;
+		};
+
 		pinctrl_enet1: enet1grp {
 			fsl,pins = <
 				MX7D_PAD_GPIO1_IO10__ENET1_MDIO			0x3
@@ -474,6 +509,12 @@
 			>;
 		};
 
+		pinctrl_tsc2046_pendown: tsc2046_pendown {
+			fsl,pins = <
+				MX7D_PAD_EPDC_BDR1__GPIO2_IO29		0x59
+			>;
+		};
+
 		pinctrl_uart1: uart1grp {
 			fsl,pins = <
 				MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX	0x79
-- 
2.7.4
