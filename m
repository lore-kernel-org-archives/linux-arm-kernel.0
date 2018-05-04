From: dianders@chromium.org (Douglas Anderson)
Date: Fri,  4 May 2018 15:03:56 -0700
Subject: [PATCH] arm64: dts: qcom: sdm845: Sort nodes in the soc by address
Message-ID: <20180504220356.261711-1-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is pure-churn and should be a no-op.  I'm doing it in the hopes
of reducing merge conflicts.  When things are sorted in a sane way
(and by base address seems sane) then it's less likely that future
patches will cause merge conflicts.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 152 +++++++++++++--------------
 1 file changed, 76 insertions(+), 76 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 486ace9a9e8b..101350743bd2 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -158,32 +158,50 @@
 		ranges = <0 0 0 0xffffffff>;
 		compatible = "simple-bus";
 
-		intc: interrupt-controller at 17a00000 {
-			compatible = "arm,gic-v3";
+		gcc: clock-controller at 100000 {
+			compatible = "qcom,gcc-sdm845";
+			reg = <0x100000 0x1f0000>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
+		geniqup at ac0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0xac0000 0x6000>;
+			clock-names = "m-ahb", "s-ahb";
+			clocks = <&gcc 105>,
+				 <&gcc 106>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-			#interrupt-cells = <3>;
-			interrupt-controller;
-			reg = <0x17a00000 0x10000>,     /* GICD */
-			      <0x17a60000 0x100000>;    /* GICR * 8 */
-			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
 
-			gic-its at 17a40000 {
-				compatible = "arm,gic-v3-its";
-				msi-controller;
-				#msi-cells = <1>;
-				reg = <0x17a40000 0x20000>;
+			uart2: serial at a84000 {
+				compatible = "qcom,geni-debug-uart";
+				reg = <0xa84000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc 89>;
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&qup_uart2_default>;
+				pinctrl-1 = <&qup_uart2_sleep>;
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
-		};
 
-		gcc: clock-controller at 100000 {
-			compatible = "qcom,gcc-sdm845";
-			reg = <0x100000 0x1f0000>;
-			#clock-cells = <1>;
-			#reset-cells = <1>;
-			#power-domain-cells = <1>;
+			i2c10: i2c at a88000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0xa88000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc 91>;
+				pinctrl-names = "default", "sleep";
+				pinctrl-0 = <&qup_i2c10_default>;
+				pinctrl-1 = <&qup_i2c10_sleep>;
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
 		};
 
 		tlmm: pinctrl at 3400000 {
@@ -224,6 +242,45 @@
 			};
 		};
 
+		spmi_bus: spmi at c440000 {
+			compatible = "qcom,spmi-pmic-arb";
+			reg = <0xc440000 0x1100>,
+			      <0xc600000 0x2000000>,
+			      <0xe600000 0x100000>,
+			      <0xe700000 0xa0000>,
+			      <0xc40a000 0x26000>;
+			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
+			interrupt-names = "periph_irq";
+			interrupts = <GIC_SPI 481 IRQ_TYPE_LEVEL_HIGH>;
+			qcom,ee = <0>;
+			qcom,channel = <0>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+			interrupt-controller;
+			#interrupt-cells = <4>;
+			cell-index = <0>;
+		};
+
+		intc: interrupt-controller at 17a00000 {
+			compatible = "arm,gic-v3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x17a00000 0x10000>,     /* GICD */
+			      <0x17a60000 0x100000>;    /* GICR * 8 */
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+
+			gic-its at 17a40000 {
+				compatible = "arm,gic-v3-its";
+				msi-controller;
+				#msi-cells = <1>;
+				reg = <0x17a40000 0x20000>;
+				status = "disabled";
+			};
+		};
+
 		timer at 17c90000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -281,62 +338,5 @@
 				status = "disabled";
 			};
 		};
-
-		spmi_bus: spmi at c440000 {
-			compatible = "qcom,spmi-pmic-arb";
-			reg = <0xc440000 0x1100>,
-			      <0xc600000 0x2000000>,
-			      <0xe600000 0x100000>,
-			      <0xe700000 0xa0000>,
-			      <0xc40a000 0x26000>;
-			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
-			interrupt-names = "periph_irq";
-			interrupts = <GIC_SPI 481 IRQ_TYPE_LEVEL_HIGH>;
-			qcom,ee = <0>;
-			qcom,channel = <0>;
-			#address-cells = <2>;
-			#size-cells = <0>;
-			interrupt-controller;
-			#interrupt-cells = <4>;
-			cell-index = <0>;
-		};
-
-		geniqup at ac0000 {
-			compatible = "qcom,geni-se-qup";
-			reg = <0xac0000 0x6000>;
-			clock-names = "m-ahb", "s-ahb";
-			clocks = <&gcc 105>,
-				 <&gcc 106>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges;
-			status = "disabled";
-
-			uart2: serial at a84000 {
-				compatible = "qcom,geni-debug-uart";
-				reg = <0xa84000 0x4000>;
-				clock-names = "se";
-				clocks = <&gcc 89>;
-				pinctrl-names = "default", "sleep";
-				pinctrl-0 = <&qup_uart2_default>;
-				pinctrl-1 = <&qup_uart2_sleep>;
-				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
-				status = "disabled";
-			};
-
-			i2c10: i2c at a88000 {
-				compatible = "qcom,geni-i2c";
-				reg = <0xa88000 0x4000>;
-				clock-names = "se";
-				clocks = <&gcc 91>;
-				pinctrl-names = "default", "sleep";
-				pinctrl-0 = <&qup_i2c10_default>;
-				pinctrl-1 = <&qup_i2c10_sleep>;
-				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
-				#address-cells = <1>;
-				#size-cells = <0>;
-				status = "disabled";
-			};
-		};
 	};
 };
-- 
2.17.0.441.gb46fe60e1d-goog
