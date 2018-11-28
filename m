From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 17:30:12 +0800
Subject: [PATCH 14/15] ARM: dts: sun8i: r40: Add RTC device node
In-Reply-To: <20181128093013.24442-1-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
Message-ID: <20181128093013.24442-16-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R40 has an RTC hardware block, which has additional registers
that are not related to RTC or clock functions, and is otherwise
compatible with the H3's RTC.

Add a device node for it, and fix up any references to the LOSC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index a8917f8b1c80..89762dbefe42 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -70,7 +70,7 @@
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
 			clock-accuracy = <20000>;
-			clock-output-names = "osc32k";
+			clock-output-names = "ext-osc32k";
 		};
 	};
 
@@ -315,17 +315,27 @@
 		ccu: clock at 1c20000 {
 			compatible = "allwinner,sun8i-r40-ccu";
 			reg = <0x01c20000 0x400>;
-			clocks = <&osc24M>, <&osc32k>;
+			clocks = <&osc24M>, <&rtc 0>;
 			clock-names = "hosc", "losc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
 
+		rtc: rtc at 1c20400 {
+			compatible = "allwinner,sun8i-r40-rtc",
+				     "allwinner,sun8i-h3-rtc";
+			reg = <0x01c20400 0x400>;
+			interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
+			clock-output-names = "osc32k", "osc32k-out";
+			clocks = <&osc32k>;
+			#clock-cells = <1>;
+		};
+
 		pio: pinctrl at 1c20800 {
 			compatible = "allwinner,sun8i-r40-pinctrl";
 			reg = <0x01c20800 0x400>;
 			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&rtc 0>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			interrupt-controller;
-- 
2.20.0.rc1
