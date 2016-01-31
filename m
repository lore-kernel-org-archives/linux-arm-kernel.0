From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sun, 31 Jan 2016 09:20:58 +0800
Subject: [PATCH 06/14] ARM: dts: sun8i-a83t: Correct low speed oscillator
 clocks
In-Reply-To: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1454203266-4450-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1454203266-4450-7-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen-Yu Tsai <wens@csie.org>

The A83T does not have a 32.768 kHz low speed oscillator, either as
an external crystal or input. It has a 16 MHz RC-based (inaccurate)
internal oscillator, which is then divided by 512 for a clock close
to 32 kHz.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 8d27b63..45b725c 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -118,6 +118,7 @@
 		#size-cells = <1>;
 		ranges;
 
+		/* TODO: PRCM block has a mux for this. */
 		osc24M: osc24M_clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
@@ -125,11 +126,25 @@
 			clock-output-names = "osc24M";
 		};
 
-		osc32k: osc32k_clk {
+		/*
+		 * This is called "internal OSC" in some places.
+		 * It is an internal RC-based oscillator.
+		 * TODO: Its controls are in the PRCM block.
+		 */
+		osc16M: osc16M_clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
-			clock-frequency = <32768>;
-			clock-output-names = "osc32k";
+			clock-frequency = <16000000>;
+			clock-output-names = "osc16M";
+		};
+
+		osc16Md512: osc16Md512_clk {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clock-div = <512>;
+			clock-mult = <1>;
+			clocks = <&osc16M>;
+			clock-output-names = "osc16Md512";
 		};
 	};
 
-- 
1.9.1
