From: krzysztof.adamski@tieto.com (Krzysztof Adamski)
Date: Tue,  9 Feb 2016 15:58:46 +0100
Subject: [PATCH v4 2/5] dts: sun8i-h3: Add APB0 related clocks and resets
In-Reply-To: <1455029929-18547-1-git-send-email-k@japko.eu>
References: <1455029929-18547-1-git-send-email-k@japko.eu>
Message-ID: <1455029929-18547-3-git-send-email-k@japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

APB0 is bearly mentioned in H3 User Manual and it is only setup in the
Allwinners kernel dump for CIR. I have verified experimentally that the
gate for R_PIO exists and works, though. There are probably other gates
there but I don't know their order right now and I don't have access to
their peripherals on my board to test them.

After some experiments and reviewing how this is organized on other
sunxi SoCs, I couldn't actually find any way to disable clocks for R_PIO
and they are working properly without doing anything so I assume they
are connected straight to the 24Mhz oscillator for now.

Signed-off-by: Krzysztof Adamski <k@japko.eu>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 6f6b4e4..a7b2c53 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -285,6 +285,24 @@
 			clocks = <&osc24M>, <&pll6x2>, <&pll5>;
 			clock-output-names = "mbus";
 		};
+
+		apb0: apb0_clk {
+			compatible = "fixed-factor-clock";
+			#clock-cells = <0>;
+			clock-div = <1>;
+			clock-mult = <1>;
+			clocks = <&osc24M>;
+			clock-output-names = "apb0";
+		};
+
+		apb0_gates: clk at 01f01428 {
+			compatible = "allwinner,sun8i-h3-apb0-gates-clk";
+			reg = <0x01f01428 0x4>;
+			#clock-cells = <1>;
+			clocks = <&apb0>;
+			clock-indices = <0>, <1>;
+			clock-output-names = "apb0_pio", "apb0_ir";
+		};
 	};
 
 	soc {
@@ -502,5 +520,11 @@
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
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
2.1.4
