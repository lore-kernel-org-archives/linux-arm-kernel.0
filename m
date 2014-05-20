From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Tue, 20 May 2014 15:22:50 +0200
Subject: [PATCH v3 06/11] ARM: STi: DT: STiH416: 416 DT Entry for clockgen
 A9/DDR/GPU
In-Reply-To: <1400592175-13176-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1400592175-13176-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1400592175-13176-7-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch adds DT entries for clockgen A9/DDR/GPU

Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih416-clock.dtsi | 79 ++++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/stih416-clock.dtsi b/arch/arm/boot/dts/stih416-clock.dtsi
index 0eeadc7..5b4fb83 100644
--- a/arch/arm/boot/dts/stih416-clock.dtsi
+++ b/arch/arm/boot/dts/stih416-clock.dtsi
@@ -25,15 +25,6 @@
 		};
 
 		/*
-		 * ARM Peripheral clock for timers
-		 */
-		arm_periph_clk: arm_periph_clk {
-			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <600000000>;
-		};
-
-		/*
 		 * ClockGenAs on SASG2
 		 */
 		clockgen-a at fee62000 {
@@ -504,6 +495,45 @@
 		};
 
 		/*
+		 * A9 PLL
+		 */
+		clockgen-a9 at fdde08b0 {
+			reg = <0xfdde08b0 0x70>;
+
+			clockgen_a9_pll: clockgen-a9-pll {
+				#clock-cells = <1>;
+				compatible = "st,stih416-plls-c32-a9", "st,clkgen-plls-c32";
+
+				clocks = <&clk_sysin>;
+				clock-output-names = "clockgen-a9-pll-odf";
+			};
+		};
+
+		/*
+		 * ARM CPU related clocks
+		 */
+		clk_m_a9: clk-m-a9 at fdde08ac {
+			#clock-cells = <0>;
+			compatible = "st,stih416-clkgen-a9-mux", "st,clkgen-mux";
+			reg = <0xfdde08ac 0x4>;
+			clocks = <&clockgen_a9_pll 0>,
+				 <&clockgen_a9_pll 0>,
+				 <&clk_m_a0_div1 2>,
+				 <&clk_m_a9_ext2f_div2>;
+		};
+
+		/*
+		 * ARM Peripheral clock for timers
+		 */
+		arm_periph_clk: clk-m-a9-periphs {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+			clocks = <&clk_m_a9>;
+			clock-div = <2>;
+			clock-mult = <1>;
+		};
+
+		/*
 		 * Frequency synthesizers on the SASG2
 		 */
 		clockgen_b0: clockgen-b0 at fee108b4 {
@@ -691,5 +721,36 @@
 					      "clk-m-pix-hdmirx-0",
 					      "clk-m-pix-hdmirx-1";
 		};
+
+		/*
+		 * DDR PLL
+		 */
+		clockgen-ddr at 0xfdde07d8 {
+			reg = <0xfdde07d8 0x110>;
+
+			clockgen_ddr_pll: clockgen-ddr-pll {
+				#clock-cells = <1>;
+				compatible = "st,stih416-plls-c32-ddr", "st,clkgen-plls-c32";
+
+				clocks = <&clk_sysin>;
+				clock-output-names = "clockgen-ddr0",
+						     "clockgen-ddr1";
+			};
+		};
+
+		/*
+		 * GPU PLL
+		 */
+		clockgen-gpu at fd68ff00 {
+			reg = <0xfd68ff00 0x910>;
+
+			clockgen_gpu_pll: clockgen-gpu-pll {
+				#clock-cells = <1>;
+				compatible = "st,stih416-gpu-pll-c32", "st,clkgengpu-pll-c32";
+
+				clocks = <&clk_sysin>;
+				clock-output-names = "clockgen-gpu-pll";
+			};
+		};
 	};
 };
-- 
1.9.1
