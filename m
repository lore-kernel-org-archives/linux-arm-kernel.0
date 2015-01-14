From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 14 Jan 2015 19:42:38 +0100
Subject: [PATCH V3 11/15] ASoC: samsung: i2s: Add clk provider DT binding
 documentation
In-Reply-To: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
References: <1421260962-16892-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1421260962-16892-12-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new DT properties required for the I2S device node to be referred
as a clock provider and corresponding clock indices definition is added.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 .../devicetree/bindings/sound/samsung-i2s.txt      |   22 ++++++++++++++++++++
 include/dt-bindings/sound/samsung-i2s.h            |    8 +++++++
 2 files changed, 30 insertions(+)
 create mode 100644 include/dt-bindings/sound/samsung-i2s.h

diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.txt b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
index d188296..09e0e18 100644
--- a/Documentation/devicetree/bindings/sound/samsung-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
@@ -33,6 +33,25 @@ Required SoC Specific Properties:
   "iis" is the i2s bus clock and i2s_opclk0, i2s_opclk1 are sources of the root
   clk. i2s0 has internal mux to select the source of root clk and i2s1 and i2s2
   doesn't have any such mux.
+- #clock-cells: should be 1, this property must be present if the I2S device
+  is a clock provider in terms of the common clock bindings, described in
+  ../clock/clock-bindings.txt.
+- clock-output-names: from the common clock bindings, names of the CDCLK
+  I2S output clocks, suggested values are "i2s_cdclk0", "i2s_cdclk1",
+  "i2s_cdclk3" for the I2S0, I2S1, I2S2 devices recpectively.
+
+There are following clocks available at the I2S device nodes:
+ CLK_I2S_CDCLK    - the CDCLK (CODECLKO) gate clock,
+ CLK_I2S_RCLK_PSR - the RCLK prescaler divider clock (corresponding to the
+		    IISPSR register),
+ CLK_I2S_RCLK_SRC - the RCLKSRC mux clock (corresponding to RCLKSRC bit in
+		    IISMOD register).
+
+Refer to the SoC datasheet for availability of the above clocks.
+The CLK_I2S_RCLK_PSR and CLK_I2S_RCLK_SRC clocks are usually only available
+in the IIS Multi Audio Interface (I2S0).
+Note: Old DTs may not have the #clock-cells, clock-output-names properties
+and then not use the I2S node as a clock supplier.
 
 Optional SoC Specific Properties:
 
@@ -41,6 +60,7 @@ Optional SoC Specific Properties:
 - pinctrl-0: Should specify pin control groups used for this controller.
 - pinctrl-names: Should contain only one value - "default".
 
+
 Example:
 
 i2s0: i2s at 03830000 {
@@ -54,6 +74,8 @@ i2s0: i2s at 03830000 {
 		<&clock_audss EXYNOS_I2S_BUS>,
 		<&clock_audss EXYNOS_SCLK_I2S>;
 	clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
+	#clock-cells;
+	clock-output-names = "i2s_cdclk0";
 	samsung,idma-addr = <0x03000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2s0_bus>;
diff --git a/include/dt-bindings/sound/samsung-i2s.h b/include/dt-bindings/sound/samsung-i2s.h
new file mode 100644
index 0000000..0c69818d
--- /dev/null
+++ b/include/dt-bindings/sound/samsung-i2s.h
@@ -0,0 +1,8 @@
+#ifndef _DT_BINDINGS_SAMSUNG_I2S_H
+#define _DT_BINDINGS_SAMSUNG_I2S_H
+
+#define CLK_I2S_CDCLK		0
+#define CLK_I2S_RCLK_SRC	1
+#define CLK_I2S_RCLK_PSR	2
+
+#endif /* _DT_BINDINGS_SAMSUNG_I2S_H */
-- 
1.7.9.5
