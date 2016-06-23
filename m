From: megous@megous.com (megous at megous.com)
Date: Thu, 23 Jun 2016 21:20:58 +0200
Subject: [PATCH 08/14] ARM: dts: sun8i: Add r_twi I2C controller
In-Reply-To: <20160623192104.18720-1-megous@megous.com>
References: <20160623192104.18720-1-megous@megous.com>
Message-ID: <20160623192104.18720-9-megous@megous.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ondrej Jirman <megous@megous.com>

H3 SoC contains I2C controller optionally available
on the PL0 and PL1 pins. This patch makes this controller
available.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 82faefc..8d86f57 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -320,8 +320,9 @@
 			reg = <0x01f01428 0x4>;
 			#clock-cells = <1>;
 			clocks = <&apb0>;
-			clock-indices = <0>, <1>;
-			clock-output-names = "apb0_pio", "apb0_ir";
+			clock-indices = <0>, <1>, <6>;
+			clock-output-names = "apb0_pio", "apb0_ir", "apb0_i2c";
+
 		};
 
 		ir_clk: ir_clk at 01f01454 {
@@ -666,6 +667,20 @@
 			status = "disabled";
 		};
 
+		r_twi: i2c at 01f02400 {
+			compatible = "allwinner,sun6i-a31-i2c";
+			reg = <0x01f02400 0x400>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&r_twi_pins_a>;
+			clocks = <&apb0_gates 6>;
+			clock-frequency = <100000>;
+			resets = <&apb0_reset 6>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		gic: interrupt-controller at 01c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
@@ -717,6 +732,13 @@
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
+
+			r_twi_pins_a: r_twi at 0 {
+				allwinner,pins = "PL0", "PL1";
+				allwinner,function = "s_twi";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
 		};
 	};
 };
-- 
2.9.0
