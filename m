From: wens@csie.org (Chen-Yu Tsai)
Date: Thu,  3 Jul 2014 22:55:48 +0800
Subject: [PATCH v3 8/9] ARM: sun8i: Add PRCM clock and reset controller nodes
 to the DTSI
In-Reply-To: <1404399349-20237-1-git-send-email-wens@csie.org>
References: <1404399349-20237-1-git-send-email-wens@csie.org>
Message-ID: <1404399349-20237-9-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With sun8i PRCM support available, we can add the PRCM clock and
reset controller nodes to the DTSI. Also update R_UART's clock
phandle and add it's reset control phandle.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 48 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 79c4083..e10c708 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -262,13 +262,59 @@
 			interrupts = <1 9 0xf04>;
 		};
 
+		prcm at 01f01400 {
+			compatible = "allwinner,sun8i-a23-prcm";
+			reg = <0x01f01400 0x200>;
+
+			ar100: ar100_clk {
+				compatible = "fixed-factor-clock";
+				#clock-cells = <0>;
+				clock-div = <1>;
+				clock-mult = <1>;
+				clocks = <&osc24M>;
+				clock-output-names = "ar100";
+			};
+
+			ahb0: ahb0_clk {
+				compatible = "fixed-factor-clock";
+				#clock-cells = <0>;
+				clock-div = <1>;
+				clock-mult = <1>;
+				clocks = <&ar100>;
+				clock-output-names = "ahb0";
+			};
+
+			apb0: apb0_clk {
+				compatible = "allwinner,sun8i-a23-apb0-clk";
+				#clock-cells = <0>;
+				clocks = <&ahb0>;
+				clock-output-names = "apb0";
+			};
+
+			apb0_gates: apb0_gates_clk {
+				compatible = "allwinner,sun8i-a23-apb0-gates-clk";
+				#clock-cells = <1>;
+				clocks = <&apb0>;
+				clock-indices = <0>, <2>, <3>, <4>, <6>;
+				clock-output-names = "apb0_pio", "apb0_timer",
+						"apb0_rsb", "apb0_uart",
+						"apb0_i2c";
+			};
+
+			apb0_rst: apb0_rst {
+				compatible = "allwinner,sun6i-a31-clock-reset";
+				#reset-cells = <1>;
+			};
+		};
+
 		r_uart: serial at 01f02800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01f02800 0x400>;
 			interrupts = <0 38 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc24M>;
+			clocks = <&apb0_gates 4>;
+			resets = <&apb0_rst 4>;
 			status = "disabled";
 		};
 	};
-- 
2.0.1
