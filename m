From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 17:30:13 +0800
Subject: [PATCH 15/15] arm64: dts: allwinner: a64: Fix up RTC device node and
 clock references
In-Reply-To: <20181128093013.24442-1-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
Message-ID: <20181128093013.24442-17-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC module on the A64 was claimed to be the same as on the A31, when
in fact it is not. It is actually compatible to the H3's RTC. The A64's
RTC has some extra crypto-related registers which the H3's does not, but
the exact function of these is not clear.

This patch fixes the compatible string and clock properties to conform
to the updated bindings. The device node for the internal oscillator is
removed, as it is internalized into the RTC device. Clock references to
the IOSC and LOSC are also fixed.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 22 ++++++-------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 384c417cb7a2..a729dcc63038 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -139,15 +139,7 @@
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
 		clock-frequency = <32768>;
-		clock-output-names = "osc32k";
-	};
-
-	iosc: internal-osc-clk {
-		#clock-cells = <0>;
-		compatible = "fixed-clock";
-		clock-frequency = <16000000>;
-		clock-accuracy = <300000000>;
-		clock-output-names = "iosc";
+		clock-output-names = "ext-osc32k";
 	};
 
 	psci {
@@ -514,7 +506,7 @@
 		ccu: clock at 1c20000 {
 			compatible = "allwinner,sun50i-a64-ccu";
 			reg = <0x01c20000 0x400>;
-			clocks = <&osc24M>, <&osc32k>;
+			clocks = <&osc24M>, <&rtc 0>;
 			clock-names = "hosc", "losc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -944,11 +936,12 @@
 		};
 
 		rtc: rtc at 1f00000 {
-			compatible = "allwinner,sun6i-a31-rtc";
-			reg = <0x01f00000 0x54>;
+			compatible = "allwinner,sun50i-a64-rtc",
+				     "allwinner,sun8i-h3-rtc";
+			reg = <0x01f00000 0x400>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
-			clock-output-names = "rtc-osc32k", "rtc-osc32k-out";
+			clock-output-names = "osc32k", "osc32k-out", "iosc";
 			clocks = <&osc32k>;
 			#clock-cells = <1>;
 		};
@@ -965,8 +958,7 @@
 		r_ccu: clock at 1f01400 {
 			compatible = "allwinner,sun50i-a64-r-ccu";
 			reg = <0x01f01400 0x100>;
-			clocks = <&osc24M>, <&osc32k>, <&iosc>,
-				 <&ccu 11>;
+			clocks = <&osc24M>, <&rtc 0>, <&rtc 2>, <&ccu 11>;
 			clock-names = "hosc", "losc", "iosc", "pll-periph";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
-- 
2.20.0.rc1
