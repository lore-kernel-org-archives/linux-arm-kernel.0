From: padma.v@samsung.com (Padmavathi Venna)
Date: Wed, 12 Jun 2013 13:37:42 +0530
Subject: [PATCH V6 5/6] ARM: dts: Update Samsung I2S documentation
In-Reply-To: <1371024463-303-1-git-send-email-padma.v@samsung.com>
References: <1371024463-303-1-git-send-email-padma.v@samsung.com>
Message-ID: <1371024463-303-6-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates the samsung i2s documentation for pinmux and
clock entries.

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---
 .../devicetree/bindings/sound/samsung-i2s.txt      |   46 ++++++++-----------
 1 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.txt b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
index 3070046..025e66b 100644
--- a/Documentation/devicetree/bindings/sound/samsung-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
@@ -8,6 +8,16 @@ Required SoC Specific Properties:
 - dmas: list of DMA controller phandle and DMA request line ordered pairs.
 - dma-names: identifier string for each DMA request line in the dmas property.
   These strings correspond 1:1 with the ordered pairs in dmas.
+- clocks: Handle to iis clock and RCLK source clk.
+- clock-names:
+  i2s0 uses some base clks from CMU and some are from audio subsystem internal
+  clock controller. The clock names for i2s0 should be "iis", "i2s_opclk0" and
+  "i2s_opclk1" as shown in the example below.
+  i2s1 and i2s2 uses clocks from CMU. The clock names for i2s1 and i2s2 should
+  be "iis" and "i2s_opclk0".
+  "iis" is the i2s bus clock and i2s_opclk0, i2s_opclk1 are sources of the root
+  clk. i2s0 has internal mux to select the source of root clk and i2s1 and i2s2
+  doesn't have any such mux.
 
 Optional SoC Specific Properties:
 
@@ -20,44 +30,26 @@ Optional SoC Specific Properties:
   then this flag is enabled.
 - samsung,idma-addr: Internal DMA register base address of the audio
   sub system(used in secondary sound source).
-
-Required Board Specific Properties:
-
-- gpios: The gpio specifier for data out,data in, LRCLK, CDCLK and SCLK
-  interface lines. The format of the gpio specifier depends on the gpio
-  controller.
-  The syntax of samsung gpio specifier is
-	<[phandle of the gpio controller node]
-	 [pin number within the gpio controller]
-	 [mux function]
-	 [flags and pull up/down]
-	 [drive strength]>
+- pinctrl-0: Should specify pin control groups used for this controller.
+- pinctrl-names: Should contain only one value - "default".
 
 Example:
 
-- SoC Specific Portion:
-
-i2s at 03830000 {
+i2s0: i2s at 03830000 {
 	compatible = "samsung,i2s-v5";
 	reg = <0x03830000 0x100>;
 	dmas = <&pdma0 10
 		&pdma0 9
 		&pdma0 8>;
 	dma-names = "tx", "rx", "tx-sec";
+	clocks = <&clock_audss EXYNOS_I2S_BUS>,
+		<&clock_audss EXYNOS_I2S_BUS>,
+		<&clock_audss EXYNOS_SCLK_I2S>;
+	clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
 	samsung,supports-6ch;
 	samsung,supports-rstclr;
 	samsung,supports-secdai;
 	samsung,idma-addr = <0x03000000>;
-};
-
-- Board Specific Portion:
-
-i2s at 03830000 {
-	gpios = <&gpz 0 2 0 0>, /* I2S_0_SCLK */
-		<&gpz 1 2 0 0>, /* I2S_0_CDCLK */
-		<&gpz 2 2 0 0>, /* I2S_0_LRCK */
-		<&gpz 3 2 0 0>, /* I2S_0_SDI */
-		<&gpz 4 2 0 0>, /* I2S_0_SDO[1] */
-		<&gpz 5 2 0 0>, /* I2S_0_SDO[2] */
-		<&gpz 6 2 0 0>; /* I2S_0_SDO[3] */
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2s0_bus>;
 };
-- 
1.7.4.4
