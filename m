From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Jan 2017 16:56:42 +0100
Subject: [PATCH 5/6] ARM: sun8i: a23/a33: Enable the real LOSC and use it
In-Reply-To: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
References: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
Message-ID: <abafc05ec7c784bc6f5ba4ea84007df0fb486d3c.1484927680.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, the LOSC was generated through the RTC internal oscillator, which
was a pretty poor and inaccurate choice.

Now that the RTC properly exposes its internal mux between its oscillator
and the external oscillator, we can use it were relevant.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 597f2fce6c31..e9d98d803dc6 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -109,11 +109,11 @@
 			clock-output-names = "osc24M";
 		};
 
-		osc32k: osc32k_clk {
+		ext_osc32k: ext_osc32k_clk {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
-			clock-output-names = "osc32k";
+			clock-output-names = "ext-osc32k";
 		};
 	};
 
@@ -256,7 +256,7 @@
 
 		ccu: clock at 01c20000 {
 			reg = <0x01c20000 0x400>;
-			clocks = <&osc24M>, <&osc32k>;
+			clocks = <&osc24M>, <&rtc>;
 			clock-names = "hosc", "losc";
 			#clock-cells = <1>;
 			#reset-cells = <1>;
@@ -266,7 +266,7 @@
 			/* compatible gets set in SoC specific dtsi file */
 			reg = <0x01c20800 0x400>;
 			/* interrupts get set in SoC specific dtsi file */
-			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&osc32k>;
+			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&rtc>;
 			clock-names = "apb", "hosc", "losc";
 			gpio-controller;
 			interrupt-controller;
@@ -486,6 +486,9 @@
 			reg = <0x01f00000 0x54>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			clock-output-names = "osc32k";
+			clocks = <&ext_osc32k>;
+			#clock-cells = <0>;
 		};
 
 		nmi_intc: interrupt-controller at 01f00c0c {
@@ -564,7 +567,7 @@
 			compatible = "allwinner,sun8i-a23-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&apb0_gates 0>, <&osc24M>, <&osc32k>;
+			clocks = <&apb0_gates 0>, <&osc24M>, <&rtc>;
 			clock-names = "apb", "hosc", "losc";
 			resets = <&apb0_rst 0>;
 			gpio-controller;
-- 
git-series 0.8.11
