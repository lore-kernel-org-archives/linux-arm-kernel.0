From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 15 Feb 2018 17:03:24 +0100
Subject: [PATCH 3/3] ARM: dts: stm32: enable USB OTG HS on stm32h743i-eval
In-Reply-To: <1518710604-21632-1-git-send-email-amelie.delaunay@st.com>
References: <1518710604-21632-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1518710604-21632-4-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables USB HS on stm32h743i-eval in OTG (DRD) mode.
The USB connector used will determine the role of USB OTG controller.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/stm32h743i-eval.dts    | 16 ++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
index ee5202d..0f15dfb 100644
--- a/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32h743-pinctrl.dtsi
@@ -188,6 +188,26 @@
 					bias-disable;
 				};
 			};
+
+			usbotg_hs_pins_a: usbotg-hs at 0 {
+				pins {
+					pinmux = <STM32_PINMUX('H', 4, AF10)>,	/* ULPI_NXT */
+							 <STM32_PINMUX('I', 11, AF10)>, /* ULPI_DIR> */
+							 <STM32_PINMUX('C', 0, AF10)>,	/* ULPI_STP> */
+							 <STM32_PINMUX('A', 5, AF10)>,	/* ULPI_CK> */
+							 <STM32_PINMUX('A', 3, AF10)>,	/* ULPI_D0> */
+							 <STM32_PINMUX('B', 0, AF10)>,	/* ULPI_D1> */
+							 <STM32_PINMUX('B', 1, AF10)>,	/* ULPI_D2> */
+							 <STM32_PINMUX('B', 10, AF10)>, /* ULPI_D3> */
+							 <STM32_PINMUX('B', 11, AF10)>, /* ULPI_D4> */
+							 <STM32_PINMUX('B', 12, AF10)>, /* ULPI_D5> */
+							 <STM32_PINMUX('B', 13, AF10)>, /* ULPI_D6> */
+							 <STM32_PINMUX('B', 5, AF10)>;	/* ULPI_D7> */
+					bias-disable;
+					drive-push-pull;
+					slew-rate = <2>;
+				};
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/stm32h743i-eval.dts b/arch/arm/boot/dts/stm32h743i-eval.dts
index 9f0e72c..1c615f6 100644
--- a/arch/arm/boot/dts/stm32h743i-eval.dts
+++ b/arch/arm/boot/dts/stm32h743i-eval.dts
@@ -68,6 +68,14 @@
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
+
+	usbotg_hs_phy: usb-phy {
+		#phy-cells = <0>;
+		compatible = "usb-nop-xceiv";
+		clocks = <&rcc USB1ULPI_CK>;
+		clock-names = "main_clk";
+	};
+
 };
 
 &adc_12 {
@@ -90,3 +98,11 @@
 	status = "okay";
 };
 
+&usbotg_hs {
+	pinctrl-0 = <&usbotg_hs_pins_a>;
+	pinctrl-names = "default";
+	phys = <&usbotg_hs_phy>;
+	phy-names = "usb2-phy";
+	dr_mode = "otg";
+	status = "okay";
+};
-- 
2.7.4
