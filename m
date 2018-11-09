From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Fri,  9 Nov 2018 09:56:49 +0100
Subject: [PATCH] ARM: dts: BCM5301X: Describe Northstar pins mux controller
Message-ID: <20181109085649.31772-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

This describes hardware & will allow referencing pin functions. The
first usage is UART1 which allows supporting devices using it.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
For the documentation see:
Documentation/devicetree/bindings/pinctrl/brcm,bcm4708-pinmux.txt
---
 arch/arm/boot/dts/bcm5301x.dtsi | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 7a5c188c2676..fd7af943fb0b 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -37,6 +37,8 @@
 			reg = <0x0400 0x100>;
 			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&iprocslow>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinmux_uart1>;
 			status = "disabled";
 		};
 	};
@@ -391,6 +393,48 @@
 		status = "disabled";
 	};
 
+	dmu at 1800c000 {
+		compatible = "simple-bus";
+		ranges = <0 0x1800c000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		cru at 100 {
+			compatible = "simple-bus";
+			reg = <0x100 0x1a4>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			pin-controller at 1c0 {
+				compatible = "brcm,bcm4708-pinmux";
+				reg = <0x1c0 0x24>;
+				reg-names = "cru_gpio_control";
+
+				spi-pins {
+					groups = "spi_grp";
+					function = "spi";
+				};
+
+				i2c {
+					groups = "i2c_grp";
+					function = "i2c";
+				};
+
+				pwm {
+					groups = "pwm0_grp", "pwm1_grp",
+						 "pwm2_grp", "pwm3_grp";
+					function = "pwm";
+				};
+
+				pinmux_uart1: uart1 {
+					groups = "uart1_grp";
+					function = "uart1";
+				};
+			};
+		};
+	};
+
 	lcpll0: lcpll0 at 1800c100 {
 		#clock-cells = <1>;
 		compatible = "brcm,nsp-lcpll0";
-- 
2.13.7
