From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 11 Jul 2017 18:13:09 +0200
Subject: [PATCH 1/2] ARM: dts: stm32: add ADC support on stm32h7
In-Reply-To: <1499789590-13021-1-git-send-email-fabrice.gasnier@st.com>
References: <1499789590-13021-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1499789590-13021-2-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for ADC (Analog to Digital Converter) to STM32H7.
It has 3 ADCs, distributed over two ADC blocks:
- ADC1 and ADC2 @0x40022000
- ADC3 @0x58026000 (instantiated separately)

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32h743.dtsi | 53 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
index 4685629..bc47119 100644
--- a/arch/arm/boot/dts/stm32h743.dtsi
+++ b/arch/arm/boot/dts/stm32h743.dtsi
@@ -74,6 +74,59 @@
 			interrupts = <50>;
 			clocks = <&timer_clk>;
 		};
+
+		adc_12: adc at 40022000 {
+			compatible = "st,stm32h7-adc-core";
+			reg = <0x40022000 0x400>;
+			interrupts = <18>;
+			clocks = <&timer_clk>;
+			clock-names = "bus";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			adc1: adc at 0 {
+				compatible = "st,stm32h7-adc";
+				#io-channel-cells = <1>;
+				reg = <0x0>;
+				interrupt-parent = <&adc_12>;
+				interrupts = <0>;
+				status = "disabled";
+			};
+
+			adc2: adc at 100 {
+				compatible = "st,stm32h7-adc";
+				#io-channel-cells = <1>;
+				reg = <0x100>;
+				interrupt-parent = <&adc_12>;
+				interrupts = <1>;
+				status = "disabled";
+			};
+		};
+
+		adc_3: adc at 58026000 {
+			compatible = "st,stm32h7-adc-core";
+			reg = <0x58026000 0x400>;
+			interrupts = <127>;
+			clocks = <&timer_clk>;
+			clock-names = "bus";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			adc3: adc at 0 {
+				compatible = "st,stm32h7-adc";
+				#io-channel-cells = <1>;
+				reg = <0x0>;
+				interrupt-parent = <&adc_3>;
+				interrupts = <0>;
+				status = "disabled";
+			};
+		};
 	};
 };
 
-- 
1.9.1
