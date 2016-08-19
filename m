From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 19 Aug 2016 15:42:26 +0800
Subject: [PATCH v6 4/4] ARM: dts: sun9i: Switch to the AC100 RTC clock outputs
 for osc32k
In-Reply-To: <20160819074226.16636-1-wens@csie.org>
References: <20160819074226.16636-1-wens@csie.org>
Message-ID: <20160819074226.16636-5-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 32.768 kHz clock inside the A80 SoC is fed from an external source,
typically the AC100 RTC module.

Make the osc32k placeholder a fixed-factor clock so board dts files can
specify its source.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v5:

  - Added "clk-div" and "clk-mult" fixed-factor-clock properties to osc32k
    placeholder.

Changes since v4: none
Changes since v3: none
Changes since v2: none
Changes since v1: none
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts |  5 +++++
 arch/arm/boot/dts/sun9i-a80-optimus.dts     |  5 +++++
 arch/arm/boot/dts/sun9i-a80.dtsi            | 11 +++++------
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index cf2f4b72a841..04b014603659 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -103,6 +103,11 @@
 	allwinner,drive = <SUN4I_PINCTRL_40_MA>;
 };
 
+&osc32k {
+	/* osc32k input is from AC100 */
+	clocks = <&ac100_rtc 0>;
+};
+
 &pio {
 	led_pins_cubieboard4: led-pins at 0 {
 		allwinner,pins = "PH6", "PH17";
diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index e35c06c162a7..fd874ded890e 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -152,6 +152,11 @@
 	status = "okay";
 };
 
+&osc32k {
+	/* osc32k input is from AC100 */
+	clocks = <&ac100_rtc 0>;
+};
+
 &pio {
 	led_pins_optimus: led-pins at 0 {
 		allwinner,pins = "PH0", "PH1";
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index f68b3242b33a..24e3cac4f571 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -148,15 +148,14 @@
 
 		/*
 		 * The 32k clock is from an external source, normally the
-		 * AC100 codec/RTC chip. This clock is by default enabled
-		 * and clocked at 32768 Hz, from the oscillator connected
-		 * to the AC100. It is configurable, but no such driver or
-		 * bindings exist yet.
+		 * AC100 codec/RTC chip. This serves as a placeholder for
+		 * board dts files to specify the source.
 		 */
 		osc32k: osc32k_clk {
 			#clock-cells = <0>;
-			compatible = "fixed-clock";
-			clock-frequency = <32768>;
+			compatible = "fixed-factor-clock";
+			clock-div = <1>;
+			clock-mult = <1>;
 			clock-output-names = "osc32k";
 		};
 
-- 
2.9.3
