From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 28 Apr 2014 16:58:50 +0200
Subject: [PATCH 7/7] ARM: sunxi: dt: add PRCM clk and reset controller
 subdevices
In-Reply-To: <1398697130-8338-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1398697130-8338-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1398697130-8338-8-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT definitions for PRCM (Power/Reset/Clock Management) clock and reset
controller subdevices.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index ec3253a..83a1634 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -501,6 +501,55 @@
 		prcm at 01f01c00 {
 			compatible = "allwinner,sun6i-a31-prcm";
 			reg = <0x01f01400 0x200>;
+
+			ar100_mux: ar100_mux {
+				compatible = "allwinner,sun6i-a31-ar100-mux-clk";
+				#clock-cells = <0>;
+				clocks = <&osc32k>, <&osc24M>, <&pll6>, <&pll6>;
+			};
+
+			ar100: ar100 {
+				compatible = "allwinner,sun6i-a31-ar100-clk";
+				#clock-cells = <0>;
+				clocks = <&ar100_mux>;
+			};
+
+			ar100_div: ar100_div {
+				compatible = "allwinner,sun6i-a31-ar100-div-clk";
+				#clock-cells = <0>;
+				clocks = <&ar100>;
+			};
+
+			ahb0: ahb0 {
+				compatible = "fixed-factor-clock";
+				#clock-cells = <0>;
+				clock-div = <1>;
+				clock-mult = <1>;
+				clocks = <&ar100_div>;
+				clock-output-names = "ahb0";
+			};
+
+			apb0: apb0 {
+				compatible = "allwinner,sun6i-a31-apb0-clk";
+				#clock-cells = <0>;
+				clocks = <&ahb0>;
+				clock-output-names = "apb0";
+			};
+
+			apb0_gates: apb0_gates {
+				compatible = "allwinner,sun6i-a31-apb0-gates-clk";
+				#clock-cells = <1>;
+				clocks = <&apb0>;
+				clock-output-names = "apb0_pio", "apb0_ir",
+						"apb0_timer01", "apb0_p2wi",
+						"apb0_uart", "apb0_1wire",
+						"apb0_i2c";
+			};
+
+			apb0_rst: apb0_rst {
+				compatible = "allwinner,sun6i-a31-clock-reset";
+				#reset-cells = <1>;
+			};
 		};
 	};
 };
-- 
1.8.3.2
