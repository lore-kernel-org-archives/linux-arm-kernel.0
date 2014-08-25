From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Mon, 25 Aug 2014 16:44:48 +0200
Subject: [RESEND PATCH 4/4] ARM: STi: DT: STiH407: 407 DT Entry for clockgenA9
In-Reply-To: <1408977888-10473-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1408977888-10473-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1408977888-10473-5-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch adds DT entries for clockgen A9

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
---
 arch/arm/boot/dts/stih407-clock.dtsi | 55 ++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index 6e59011..b4318e1 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -24,10 +24,59 @@
 		/*
 		 * ARM Peripheral clock for timers
 		 */
-		arm_periph_clk: arm-periph-clk {
+		arm_periph_clk: clk-m-a9-periphs {
 			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <600000000>;
+			compatible = "fixed-factor-clock";
+
+			clocks = <&clk_m_a9>;
+			clock-div = <2>;
+			clock-mult = <1>;
+		};
+
+		/*
+		 * A9 PLL.
+		 */
+		clockgen-a9 at 92b0000 {
+			compatible = "st,clkgen-c32";
+			reg = <0x92b0000 0xffff>;
+
+			clockgen_a9_pll: clockgen-a9-pll {
+				#clock-cells = <1>;
+				compatible = "st,stih407-plls-c32-a9", "st,clkgen-plls-c32";
+
+				clocks = <&clk_sysin>;
+
+				clock-output-names = "clockgen-a9-pll-odf";
+			};
+		};
+
+		/*
+		 * ARM CPU related clocks.
+		 */
+		clk_m_a9: clk-m-a9 at 92b0000 {
+			#clock-cells = <0>;
+			compatible = "st,stih407-clkgen-a9-mux", "st,clkgen-mux";
+			reg = <0x92b0000 0x10000>;
+
+			clocks = <&clockgen_a9_pll 0>,
+				 <&clockgen_a9_pll 0>,
+				 <&clk_s_c0_flexgen 13>,
+				 <&clk_m_a9_ext2f_div2>;
+		};
+
+		/*
+		 * ARM Peripheral clock for timers
+		 */
+		clk_m_a9_ext2f_div2: clk-m-a9-ext2f-div2s {
+			#clock-cells = <0>;
+			compatible = "fixed-factor-clock";
+
+			clocks = <&clk_s_c0_flexgen 13>;
+
+			clock-output-names = "clk-m-a9-ext2f-div2";
+
+			clock-div = <2>;
+			clock-mult = <1>;
 		};
 
 		/*
-- 
1.9.1
