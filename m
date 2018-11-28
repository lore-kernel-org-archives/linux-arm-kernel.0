From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 17:30:10 +0800
Subject: [PATCH 12/15] ARM: dts: sunxi: h3/h5: Fix up RTC device node and
 clock references
In-Reply-To: <20181128093013.24442-1-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
Message-ID: <20181128093013.24442-14-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC module on the H3 was claimed to be the same as on the A31, when
in fact it is not. The A31 does not have an RTC external clock output,
and its internal RC oscillator's average clock rate is not in the same
range. The H5's RTC has some extra crypto-related registers compared to
the H3. Their exact functions are not clear. Also the RTC-VIO regulator
has different settings.

This patch fixes the compatible string and clock properties to conform
to the updated bindings. The device node for the internal oscillator is
removed, as it is internalized into the RTC device. Clock references to
the IOSC and LOSC are also fixed.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>

squash! ARM: dts: sunxi: h3/h5: Fix up RTC device node and clock references
---
 arch/arm/boot/dts/sun8i-h3.dtsi              |  4 +++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi           | 26 ++++++++------------
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi |  4 +++
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 3ecfabb10151..9497d4076e65 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -241,3 +241,7 @@
 &pio {
 	compatible = "allwinner,sun8i-h3-pinctrl";
 };
+
+&rtc {
+	compatible = "allwinner,sun8i-h3-rtc";
+};
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index bce3bf1d6ae5..3cc4366c07fd 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -95,15 +95,7 @@
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
 			clock-accuracy = <50000>;
-			clock-output-names = "osc32k";
-		};
-
-		iosc: internal-osc-clk {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <16000000>;
-			clock-accuracy = <300000000>;
-			clock-output-names = "iosc";
+			clock-output-names = "ext_osc32k";
 		};
 	};
 
@@ -377,7 +369,7 @@
 		ccu: clock at 1c20000 {
 			/* compatible is in per SoC .dtsi file */
 			reg = <0x01c20000 0x400>;
-			clocks = <&osc24M>, <&osc32k>;
+			clocks = <&osc24M>, <&rtc 0>;
 			clock-names = "hosc", "losc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -388,7 +380,7 @@
 			reg = <0x01c20800 0x400>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&rtc 0>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			#gpio-cells = <3>;
@@ -813,17 +805,19 @@
 		};
 
 		rtc: rtc at 1f00000 {
-			compatible = "allwinner,sun6i-a31-rtc";
-			reg = <0x01f00000 0x54>;
+			/* compatible is in per SoC .dtsi file */
+			reg = <0x01f00000 0x400>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			clock-output-names = "osc32k", "osc32k-out", "iosc";
+			clocks = <&osc32k>;
+			#clock-cells = <1>;
 		};
 
 		r_ccu: clock at 1f01400 {
 			compatible = "allwinner,sun8i-h3-r-ccu";
 			reg = <0x01f01400 0x100>;
-			clocks = <&osc24M>, <&osc32k>, <&iosc>,
-				 <&ccu 9>;
+			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>, <&ccu 9>;
 			clock-names = "hosc", "losc", "iosc", "pll-periph";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -861,7 +855,7 @@
 			compatible = "allwinner,sun8i-h3-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>, <&osc32k>;
+			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>, <&rtc 0>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			#gpio-cells = <3>;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index b41dc1aab67d..fe731b35f761 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -172,3 +172,7 @@
 		     <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 	compatible = "allwinner,sun50i-h5-pinctrl";
 };
+
+&rtc {
+	compatible = "allwinner,sun50i-h5-rtc";
+};
-- 
2.20.0.rc1
