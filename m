From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 31 May 2018 23:28:59 -0700
Subject: [PATCH 1/3] arm64: allwinner: a64: add R_I2C controller
In-Reply-To: <20180601062901.8052-1-anarsoul@gmail.com>
References: <20180601062901.8052-1-anarsoul@gmail.com>
Message-ID: <20180601062901.8052-2-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.io>

Allwinner A64 has a I2C controller, which is in the R_ MMIO zone and has
two groups of pinmuxes on PL bank, so it's called R_I2C.

Add support for this I2C controller and the pinmux which doesn't conflict
with RSB.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1b2ef28c42bd..b5e903ccf0ec 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -46,6 +46,7 @@
 #include <dt-bindings/clock/sun8i-r-ccu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/reset/sun50i-a64-ccu.h>
+#include <dt-bindings/reset/sun8i-r-ccu.h>
 
 / {
 	interrupt-parent = <&gic>;
@@ -655,6 +656,17 @@
 			#reset-cells = <1>;
 		};
 
+		r_i2c: i2c at 1f02400 {
+			compatible = "allwinner,sun6i-a31-i2c";
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
@@ -670,6 +682,11 @@
 				pins = "PL0", "PL1";
 				function = "s_rsb";
 			};
+
+			r_i2c_pins_a: i2c-a {
+				pins = "PL8", "PL9";
+				function = "s_i2c";
+			};
 		};
 
 		r_rsb: rsb at 1f03400 {
-- 
2.17.1
