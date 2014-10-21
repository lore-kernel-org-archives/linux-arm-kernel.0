From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 21 Oct 2014 14:49:27 +0800
Subject: [RFC 3/3] ARM: dts: sun9i: Add A80 PRCM clocks and reset control nodes
In-Reply-To: <1413874167-6479-1-git-send-email-wens@csie.org>
References: <1413874167-6479-1-git-send-email-wens@csie.org>
Message-ID: <1413874167-6479-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the PRCM clocks and reset controls to the A80 dtsi.

The list of apbs clock gates is incomplete. Tests show that bits 0~20
are mutable. We will need documents from Allwinner to complete the
support.

Also update clock and reset phandles for r_uart.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 47 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 2a1c10d..1f3da34 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -418,13 +418,58 @@
 			interrupts = <0 36 4>;
 		};
 
+		prcm at 08001400 {
+			compatible = "allwinner,sun9i-a80-prcm";
+			reg = <0x08001400 0x200>;
+
+			cpus_clk: cpus_clk {
+				compatible = "allwinner,sun6i-a31-ar100-clk";
+				#clock-cells = <0>;
+				clocks = <&osc32k>, <&osc24M>, <&pll4>;
+				clock-output-names = "cpus";
+			};
+
+			ahbs: ahbs_clk {
+				compatible = "fixed-factor-clock";
+				#clock-cells = <0>;
+				clock-div = <1>;
+				clock-mult = <1>;
+				clocks = <&cpus_clk>;
+				clock-output-names = "ahbs";
+			};
+
+			apbs: apbs_clk {
+				compatible = "allwinner,sun8i-a23-apb0-clk";
+				#clock-cells = <0>;
+				clocks = <&ahbs>;
+				clock-output-names = "apbs";
+			};
+
+			apbs_gates: apbs_gates_clk {
+				compatible = "allwinner,sun9i-a80-apbs-gates-clk";
+				#clock-cells = <1>;
+				clocks = <&apbs>;
+				clock-output-names = "apbs_pio", "apbs_ir",
+						"apbs_timer", "apbs_rsb",
+						"apbs_uart", "apbs_1wire",
+						"apbs_i2c", "apbs_i2s0",
+						"apbs_i2s1";
+			};
+
+			apbs_rst: apbs_rst {
+				compatible = "allwinner,sun6i-a31-clock-reset";
+				#reset-cells = <1>;
+			};
+		};
+
 		r_uart: serial at 08002800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x08002800 0x400>;
 			interrupts = <0 38 4>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-			clocks = <&osc24M>;
+			clocks = <&apbs_gates 4>;
+			resets = <&apbs_rst 4>;
 			status = "disabled";
 		};
 	};
-- 
2.1.1
