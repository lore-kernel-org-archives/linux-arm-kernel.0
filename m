From: k@japko.eu (Krzysztof Adamski)
Date: Mon, 22 Feb 2016 14:03:26 +0100
Subject: [PATCH v5 2/4] dts: sun8i-h3: Add APB0 related clocks and resets
In-Reply-To: <1456146208-13890-1-git-send-email-k@japko.eu>
References: <1456146208-13890-1-git-send-email-k@japko.eu>
Message-ID: <1456146208-13890-3-git-send-email-k@japko.eu>
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
 arch/arm/boot/dts/sun8i-h3.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 3ba65c2..1348b69 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -276,6 +276,25 @@
 			clocks = <&osc24M>, <&pll6 1>, <&pll5>;
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
+			compatible = "allwinner,sun8i-h3-apb0-gates-clk",
+				     "allwinner,sun4i-a10-gates-clk";
+			reg = <0x01f01428 0x4>;
+			#clock-cells = <1>;
+			clocks = <&apb0>;
+			clock-indices = <0>, <1>;
+			clock-output-names = "apb0_pio", "apb0_ir";
+		};
 	};
 
 	soc {
@@ -493,5 +512,11 @@
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
