From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue,  5 Jun 2018 22:17:00 -0700
Subject: [PATCH v2 1/3] arm64: dts: allwinner: a64: add R_I2C controller
In-Reply-To: <20180606051702.6478-1-anarsoul@gmail.com>
References: <20180606051702.6478-1-anarsoul@gmail.com>
Message-ID: <20180606051702.6478-2-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.io>

Allwinner A64 has a I2C controller, which is in the R_ MMIO zone and has
two groups of pinmuxes on PL bank, so it's called R_I2C.

Add support for this I2C controller and the pinmux which doesn't conflict
with RSB.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1b2ef28c42bd..dcf957b2e7c8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -46,6 +46,7 @@
 #include <dt-bindings/clock/sun8i-r-ccu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/sun50i-a64-ccu.h>
+#include <dt-bindings/reset/sun8i-r-ccu.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -655,6 +656,18 @@
 			#reset-cells = <1>;
 		};
 
+		r_i2c: i2c at 1f02400 {
+			compatible = "allwinner,sun50i-a64-i2c",
+				     "allwinner,sun6i-a31-i2c";
+			reg = <0x01f02400 0x400>;
+			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_APB0_I2C>;
+			resets = <&r_ccu RST_APB0_I2C>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		r_pio: pinctrl at 1f02c00 {
 			compatible = "allwinner,sun50i-a64-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
@@ -666,6 +679,17 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+
+			r_i2c_pins: i2c {
+				pins = "PL0", "PL1";
+				function = "s_i2c";
+			};
+
+			r_i2c_pins_a: i2c-a {
+				pins = "PL8", "PL9";
+				function = "s_i2c";
+			};
+
 			r_rsb_pins: rsb {
 				pins = "PL0", "PL1";
 				function = "s_rsb";
-- 
2.17.1
