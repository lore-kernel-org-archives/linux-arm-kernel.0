From: ludovic.Barre@st.com (Ludovic Barre)
Date: Mon, 30 Apr 2018 09:11:21 +0200
Subject: [PATCH 2/2] ARM: dts: stm32: add flash nor support on stm32mp157c
 eval board
In-Reply-To: <1525072281-17472-1-git-send-email-ludovic.Barre@st.com>
References: <1525072281-17472-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1525072281-17472-3-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds flash nor on qspi. Each flash is
connected in quad mode and has its own chip select.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 45 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stm32mp157c-ev1.dts     | 25 +++++++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index 6f044100..9d4c553 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -146,6 +146,51 @@
 				gpio-ranges = <&pinctrl 0 160 8>;
 			};
 
+			qspi_clk_pins_a: qspi-clk-0 {
+				pins {
+					pinmux = <STM32_PINMUX('F', 10, AF9)>; /* QSPI_CLK */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <3>;
+				};
+			};
+
+			qspi_bk1_pins_a: qspi-bk1-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('F', 8, AF10)>, /* QSPI_BK1_IO0 */
+						 <STM32_PINMUX('F', 9, AF10)>, /* QSPI_BK1_IO1 */
+						 <STM32_PINMUX('F', 7, AF9)>, /* QSPI_BK1_IO2 */
+						 <STM32_PINMUX('F', 6, AF9)>; /* QSPI_BK1_IO3 */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <3>;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('B', 6, AF10)>; /* QSPI_BK1_NCS */
+					bias-pull-up;
+					drive-push-pull;
+					slew-rate = <3>;
+				};
+			};
+
+			qspi_bk2_pins_a: qspi-bk2-0 {
+				pins1 {
+					pinmux = <STM32_PINMUX('H', 2, AF9)>, /* QSPI_BK2_IO0 */
+						 <STM32_PINMUX('H', 3, AF9)>, /* QSPI_BK2_IO1 */
+						 <STM32_PINMUX('G', 10, AF11)>, /* QSPI_BK2_IO2 */
+						 <STM32_PINMUX('G', 7, AF11)>; /* QSPI_BK2_IO3 */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <3>;
+				};
+				pins2 {
+					pinmux = <STM32_PINMUX('C', 0, AF10)>; /* QSPI_BK2_NCS */
+					bias-pull-up;
+					drive-push-pull;
+					slew-rate = <3>;
+				};
+			};
+
 			uart4_pins_a: uart4 at 0 {
 				pins1 {
 					pinmux = <STM32_PINMUX('G', 11, AF6)>; /* UART4_TX */
diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 57e6dbc..96c2aee 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -19,3 +19,28 @@
 		serial0 = &uart4;
 	};
 };
+
+&qspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&qspi_clk_pins_a &qspi_bk1_pins_a &qspi_bk2_pins_a>;
+	reg = <0x58003000 0x1000>, <0x70000000 0x4000000>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	flash0: mx66l51235l at 0 {
+		reg = <0>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <108000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+	flash1: mx66l51235l at 1 {
+		reg = <1>;
+		spi-rx-bus-width = <4>;
+		spi-max-frequency = <108000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+};
-- 
2.7.4
