From: dianders@chromium.org (Douglas Anderson)
Date: Wed, 13 Jun 2018 09:53:51 -0700
Subject: [PATCH v2 1/2] arm64: dts: qcom: sdm845: Add I2C, SPI, and UART9 nodes
Message-ID: <20180613165352.139060-1-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds nodes to SDM845-dtsi for all the I2C ports, all the SPI
ports, and UART9.  Note that I2C / SPI / UART are a bit strange on
sdm845 because each "serial engine" has 4 pins associated with it and
depending on which firmware has been loaded into the serial engine
(loaded by the BIOS) the serial engine can behave like an I2C port, a
SPI port, or a UART.  As per the landed bindings that means that we
need to create one node for each possible mode that the port could be
in.  With 16 serial engines that means 16 x 3 = 48 nodes.

We get away with only creating 33 nodes for now because it seems very
likely that SDM845-based boards will actually all use the same UART
(UART 9) for debug purposes.  While another UART could be used for
something like Bluetooth communication we can cross that path when we
come to it.  Some documentation that I saw implied that using a UART
for "high speed" communications actually needs yet another different
serial engine firmware anyway.

Note that quick measurements adding all these nodes adds <10k of extra
space per dtb that they're included with.  If this becomes a problem
we may need to think of a different way to structure this so that
boards only get the nodes they need (or figure out how to get dtc to
strip 'disabled' nodes).  For now it seems OK.

These nodes were programmatically generated with a fairly dumb python
script.  See http://crosreview.com/1091631 for the source.

NOTE: at the moment SPI chip select doesn't appear to work in my tests
with the latest posted SPI driver.  All testing of SPI with this patch
has been done by hacking SPI to GPIO chip select.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes in v2:
- Got rid of all sleep pinctrl states for now
- Add Bjorn's tags.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 733 +++++++++++++++++++++++++++
 1 file changed, 733 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index cdaabeb3c995..2407d39f74df 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -5,6 +5,7 @@
  * Copyright (c) 2018, The Linux Foundation. All rights reserved.
  */
 
+#include <dt-bindings/clock/qcom,gcc-sdm845.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
@@ -13,6 +14,41 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
+		i2c8 = &i2c8;
+		i2c9 = &i2c9;
+		i2c10 = &i2c10;
+		i2c11 = &i2c11;
+		i2c12 = &i2c12;
+		i2c13 = &i2c13;
+		i2c14 = &i2c14;
+		i2c15 = &i2c15;
+		spi0 = &spi0;
+		spi1 = &spi1;
+		spi2 = &spi2;
+		spi3 = &spi3;
+		spi4 = &spi4;
+		spi5 = &spi5;
+		spi6 = &spi6;
+		spi7 = &spi7;
+		spi8 = &spi8;
+		spi9 = &spi9;
+		spi10 = &spi10;
+		spi11 = &spi11;
+		spi12 = &spi12;
+		spi13 = &spi13;
+		spi14 = &spi14;
+		spi15 = &spi15;
+	};
+
 	chosen { };
 
 	memory at 80000000 {
@@ -206,6 +242,456 @@
 			#power-domain-cells = <1>;
 		};
 
+		qupv3_id_0: geniqup at 8c0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0x8c0000 0x6000>;
+			clock-names = "m-ahb", "s-ahb";
+			clocks = <&gcc GCC_QUPV3_WRAP_0_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_0_S_AHB_CLK>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			i2c0: i2c at 880000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x880000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c0_default>;
+				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi0: spi at 880000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x880000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi0_default>;
+				interrupts = <GIC_SPI 601 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c1: i2c at 884000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x884000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c1_default>;
+				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi1: spi at 884000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x884000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi1_default>;
+				interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c2: i2c at 888000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x888000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c2_default>;
+				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi2: spi at 888000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x888000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi2_default>;
+				interrupts = <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c3: i2c at 88c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x88c000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c3_default>;
+				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi3: spi at 88c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x88c000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi3_default>;
+				interrupts = <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c4: i2c at 890000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x890000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c4_default>;
+				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi4: spi at 890000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x890000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi4_default>;
+				interrupts = <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c5: i2c at 894000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x894000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c5_default>;
+				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi5: spi at 894000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x894000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi5_default>;
+				interrupts = <GIC_SPI 606 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c6: i2c at 898000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x898000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c6_default>;
+				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi6: spi at 898000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x898000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi6_default>;
+				interrupts = <GIC_SPI 607 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c7: i2c at 89c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x89c000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c7_default>;
+				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi7: spi at 89c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x89c000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi7_default>;
+				interrupts = <GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
+		qupv3_id_1: geniqup at ac0000 {
+			compatible = "qcom,geni-se-qup";
+			reg = <0xac0000 0x6000>;
+			clock-names = "m-ahb", "s-ahb";
+			clocks = <&gcc GCC_QUPV3_WRAP_1_M_AHB_CLK>,
+				 <&gcc GCC_QUPV3_WRAP_1_S_AHB_CLK>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			status = "disabled";
+
+			i2c8: i2c at a80000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0xa80000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c8_default>;
+				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi8: spi at a80000 {
+				compatible = "qcom,geni-spi";
+				reg = <0xa80000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S0_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi8_default>;
+				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c9: i2c at a84000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0xa84000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c9_default>;
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi9: spi at a84000 {
+				compatible = "qcom,geni-spi";
+				reg = <0xa84000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi9_default>;
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			uart9: serial at a84000 {
+				compatible = "qcom,geni-debug-uart";
+				reg = <0xa84000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S1_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_uart9_default>;
+				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			i2c10: i2c at a88000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0xa88000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c10_default>;
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi10: spi at a88000 {
+				compatible = "qcom,geni-spi";
+				reg = <0xa88000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S2_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi10_default>;
+				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c11: i2c at a8c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0xa8c000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c11_default>;
+				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi11: spi at a8c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0xa8c000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S3_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi11_default>;
+				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c12: i2c at a90000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0xa90000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c12_default>;
+				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi12: spi at a90000 {
+				compatible = "qcom,geni-spi";
+				reg = <0xa90000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S4_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi12_default>;
+				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c13: i2c at a94000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0xa94000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c13_default>;
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi13: spi at a94000 {
+				compatible = "qcom,geni-spi";
+				reg = <0xa94000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S5_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi13_default>;
+				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c14: i2c at a98000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0xa98000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c14_default>;
+				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi14: spi at a98000 {
+				compatible = "qcom,geni-spi";
+				reg = <0xa98000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S6_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi14_default>;
+				interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			i2c15: i2c at a9c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0xa9c000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_i2c15_default>;
+				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			spi15: spi at a9c000 {
+				compatible = "qcom,geni-spi";
+				reg = <0xa9c000 0x4000>;
+				clock-names = "se";
+				clocks = <&gcc GCC_QUPV3_WRAP1_S7_CLK>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&qup_spi15_default>;
+				interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+		};
+
 		tcsr_mutex_regs: syscon at 1f40000 {
 			compatible = "syscon";
 			reg = <0x1f40000 0x40000>;
@@ -219,6 +705,253 @@
 			#gpio-cells = <2>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
+
+			qup_i2c0_default: qup-i2c0-default {
+				pinmux {
+					pins = "gpio0", "gpio1";
+					function = "qup0";
+				};
+			};
+
+			qup_i2c1_default: qup-i2c1-default {
+				pinmux {
+					pins = "gpio17", "gpio18";
+					function = "qup1";
+				};
+			};
+
+			qup_i2c2_default: qup-i2c2-default {
+				pinmux {
+					pins = "gpio27", "gpio28";
+					function = "qup2";
+				};
+			};
+
+			qup_i2c3_default: qup-i2c3-default {
+				pinmux {
+					pins = "gpio41", "gpio42";
+					function = "qup3";
+				};
+			};
+
+			qup_i2c4_default: qup-i2c4-default {
+				pinmux {
+					pins = "gpio89", "gpio90";
+					function = "qup4";
+				};
+			};
+
+			qup_i2c5_default: qup-i2c5-default {
+				pinmux {
+					pins = "gpio85", "gpio86";
+					function = "qup5";
+				};
+			};
+
+			qup_i2c6_default: qup-i2c6-default {
+				pinmux {
+					pins = "gpio45", "gpio46";
+					function = "qup6";
+				};
+			};
+
+			qup_i2c7_default: qup-i2c7-default {
+				pinmux {
+					pins = "gpio93", "gpio94";
+					function = "qup7";
+				};
+			};
+
+			qup_i2c8_default: qup-i2c8-default {
+				pinmux {
+					pins = "gpio65", "gpio66";
+					function = "qup8";
+				};
+			};
+
+			qup_i2c9_default: qup-i2c9-default {
+				pinmux {
+					pins = "gpio6", "gpio7";
+					function = "qup9";
+				};
+			};
+
+			qup_i2c10_default: qup-i2c10-default {
+				pinmux {
+					pins = "gpio55", "gpio56";
+					function = "qup10";
+				};
+			};
+
+			qup_i2c11_default: qup-i2c11-default {
+				pinmux {
+					pins = "gpio31", "gpio32";
+					function = "qup11";
+				};
+			};
+
+			qup_i2c12_default: qup-i2c12-default {
+				pinmux {
+					pins = "gpio49", "gpio50";
+					function = "qup12";
+				};
+			};
+
+			qup_i2c13_default: qup-i2c13-default {
+				pinmux {
+					pins = "gpio105", "gpio106";
+					function = "qup13";
+				};
+			};
+
+			qup_i2c14_default: qup-i2c14-default {
+				pinmux {
+					pins = "gpio33", "gpio34";
+					function = "qup14";
+				};
+			};
+
+			qup_i2c15_default: qup-i2c15-default {
+				pinmux {
+					pins = "gpio81", "gpio82";
+					function = "qup15";
+				};
+			};
+
+			qup_spi0_default: qup-spi0-default {
+				pinmux {
+					pins = "gpio0", "gpio1",
+					       "gpio2", "gpio3";
+					function = "qup0";
+				};
+			};
+
+			qup_spi1_default: qup-spi1-default {
+				pinmux {
+					pins = "gpio17", "gpio18",
+					       "gpio19", "gpio20";
+					function = "qup1";
+				};
+			};
+
+			qup_spi2_default: qup-spi2-default {
+				pinmux {
+					pins = "gpio27", "gpio28",
+					       "gpio29", "gpio30";
+					function = "qup2";
+				};
+			};
+
+			qup_spi3_default: qup-spi3-default {
+				pinmux {
+					pins = "gpio41", "gpio42",
+					       "gpio43", "gpio44";
+					function = "qup3";
+				};
+			};
+
+			qup_spi4_default: qup-spi4-default {
+				pinmux {
+					pins = "gpio89", "gpio90",
+					       "gpio91", "gpio92";
+					function = "qup4";
+				};
+			};
+
+			qup_spi5_default: qup-spi5-default {
+				pinmux {
+					pins = "gpio85", "gpio86",
+					       "gpio87", "gpio88";
+					function = "qup5";
+				};
+			};
+
+			qup_spi6_default: qup-spi6-default {
+				pinmux {
+					pins = "gpio45", "gpio46",
+					       "gpio47", "gpio48";
+					function = "qup6";
+				};
+			};
+
+			qup_spi7_default: qup-spi7-default {
+				pinmux {
+					pins = "gpio93", "gpio94",
+					       "gpio95", "gpio96";
+					function = "qup7";
+				};
+			};
+
+			qup_spi8_default: qup-spi8-default {
+				pinmux {
+					pins = "gpio65", "gpio66",
+					       "gpio67", "gpio68";
+					function = "qup8";
+				};
+			};
+
+			qup_spi9_default: qup-spi9-default {
+				pinmux {
+					pins = "gpio6", "gpio7",
+					       "gpio4", "gpio5";
+					function = "qup9";
+				};
+			};
+
+			qup_spi10_default: qup-spi10-default {
+				pinmux {
+					pins = "gpio55", "gpio56",
+					       "gpio53", "gpio54";
+					function = "qup10";
+				};
+			};
+
+			qup_spi11_default: qup-spi11-default {
+				pinmux {
+					pins = "gpio31", "gpio32",
+					       "gpio33", "gpio34";
+					function = "qup11";
+				};
+			};
+
+			qup_spi12_default: qup-spi12-default {
+				pinmux {
+					pins = "gpio49", "gpio50",
+					       "gpio51", "gpio52";
+					function = "qup12";
+				};
+			};
+
+			qup_spi13_default: qup-spi13-default {
+				pinmux {
+					pins = "gpio105", "gpio106",
+					       "gpio107", "gpio108";
+					function = "qup13";
+				};
+			};
+
+			qup_spi14_default: qup-spi14-default {
+				pinmux {
+					pins = "gpio33", "gpio34",
+					       "gpio31", "gpio32";
+					function = "qup14";
+				};
+			};
+
+			qup_spi15_default: qup-spi15-default {
+				pinmux {
+					pins = "gpio81", "gpio82",
+					       "gpio83", "gpio84";
+					function = "qup15";
+				};
+			};
+
+			qup_uart9_default: qup-uart9-default {
+				pinmux {
+					pins = "gpio4", "gpio5";
+					function = "qup9";
+				};
+			};
 		};
 
 		spmi_bus: spmi at c440000 {
-- 
2.18.0.rc1.244.gcf134e6275-goog
