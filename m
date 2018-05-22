From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 22 May 2018 17:45:37 +0200
Subject: [PATCH v3] ARM: dts: stm32: Add ADC support to stm32mp157c
Message-ID: <1527003937-15999-1-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

stm32mp157c has an ADC block with two physical ADCs.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in v3:
- Add dmas since dmamux1 has been added on top of stm32-next
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index b66f673..66d7496 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -600,6 +600,42 @@
 			clocks = <&rcc DMAMUX>;
 		};
 
+		adc: adc at 48003000 {
+			compatible = "st,stm32mp1-adc-core";
+			reg = <0x48003000 0x400>;
+			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&rcc ADC12>, <&rcc ADC12_K>;
+			clock-names = "bus", "adc";
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+
+			adc1: adc at 0 {
+				compatible = "st,stm32mp1-adc";
+				#io-channel-cells = <1>;
+				reg = <0x0>;
+				interrupt-parent = <&adc>;
+				interrupts = <0>;
+				dmas = <&dmamux1 9 0x400 0x01>;
+				dma-names = "rx";
+				status = "disabled";
+			};
+
+			adc2: adc at 100 {
+				compatible = "st,stm32mp1-adc";
+				#io-channel-cells = <1>;
+				reg = <0x100>;
+				interrupt-parent = <&adc>;
+				interrupts = <1>;
+				dmas = <&dmamux1 10 0x400 0x01>;
+				dma-names = "rx";
+				status = "disabled";
+			};
+		};
+
 		rcc: rcc at 50000000 {
 			compatible = "st,stm32mp1-rcc", "syscon";
 			reg = <0x50000000 0x1000>;
-- 
1.9.1
