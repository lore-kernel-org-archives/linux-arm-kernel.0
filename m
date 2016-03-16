From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Thu, 17 Mar 2016 00:04:30 +0800
Subject: [PATCH v4 07/13] ARM: dts: sun8i-a83t: Add PRCM related clocks and
 resets
In-Reply-To: <1458144276-31108-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1458144276-31108-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1458144276-31108-8-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds A83T PRCM related clocks, clock resets.

As a83t apb0 gates clock support is added earlier, this enables it.
Apart from apb0 gates, other added clocks are compatible with
earlier sun8i socs.

Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 44 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index a44d4dc..691bbf1 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -267,6 +267,44 @@
 					     "mmc2_output",
 					     "mmc2_sample";
 		};
+
+		cpus_clk: clk at 01f01400 {
+			compatible = "allwinner,sun9i-a80-cpus-clk";
+			reg = <0x01f01400 0x4>;
+			#clock-cells = <0>;
+			clocks = <&osc16Md512>, <&osc24M>, <&pll6>, <&osc16M>;
+			clock-output-names = "cpus";
+		};
+
+		ahb0: ahb0_clk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-div = <1>;
+			clock-mult = <1>;
+			clocks = <&cpus_clk>;
+			clock-output-names = "ahb0";
+		};
+
+		apb0: clk at 01f0140c {
+			compatible = "allwinner,sun8i-a23-apb0-clk";
+			reg = <0x01f0140c 0x4>;
+			#clock-cells = <0>;
+			clocks = <&ahb0>;
+			clock-output-names = "apb0";
+		};
+
+		apb0_gates: clk at 01f01428 {
+			compatible = "allwinner,sun8i-a83t-apb0-gates-clk";
+			reg = <0x01f01428 0x4>;
+			#clock-cells = <1>;
+			clocks = <&apb0>;
+			clock-indices = <0>, <1>,
+					<2>, <3>,
+					<4>, <6>, <7>;
+			clock-output-names = "apb0_pio", "apb0_ir",
+					"apb0_timer", "apb0_rsb",
+					"apb0_uart", "apb0_i2c0", "apb0_twd";
+		};
 	};
 
 	soc {
@@ -421,5 +459,11 @@
 			#interrupt-cells = <3>;
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
+
+		apb0_reset: reset at 01f014b0 {
+			reg = <0x01f014b0 0x4>;
+			compatible = "allwinner,sun6i-a31-clock-reset";
+			#reset-cells = <1>;
+		};
 	};
 };
-- 
1.9.1
