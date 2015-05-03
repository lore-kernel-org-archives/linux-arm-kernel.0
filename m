From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  3 May 2015 09:47:16 +0200
Subject: [PATCH] ARM: sunxi: dt: Split the SPI pinctrl groups
Message-ID: <1430639236-10785-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pinctrl groups for SPI until now were also adding the chip selects in
the SPI pinctrl group.

This was causing a few issues, since a board was forced to use a random
number of chipselects, even though it might use one of these chip selects
for another pin.

The number of chipselects defined was also not the same from one group to
another because of different needs at the time these groups have been
introduced, resulting in no clear view from the board DTS on what exactly
is being muxed, which even might change in the future.

Solve this by creating different pinctrl groups for the chipselects and the
standard SPI pins (CLK, MOSI and MISO) so that we fix both issues.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts      |  3 +-
 arch/arm/boot/dts/sun4i-a10-marsboard.dts       |  3 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                | 36 ++++++++++++++++++---
 arch/arm/boot/dts/sun7i-a20-bananapi.dts        |  4 ++-
 arch/arm/boot/dts/sun7i-a20-bananapro.dts       |  4 ++-
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts     |  3 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |  6 ++--
 arch/arm/boot/dts/sun7i-a20.dtsi                | 43 ++++++++++++++++++++++---
 8 files changed, 87 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 0ba67d79c2b4..85046ddce532 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -206,7 +206,8 @@
 
 &spi0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pins_a>;
+	pinctrl-0 = <&spi0_pins_a>,
+		    <&spi0_cs0_pins_a>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10-marsboard.dts b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
index 00c54d2a1824..826d25b66823 100644
--- a/arch/arm/boot/dts/sun4i-a10-marsboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-marsboard.dts
@@ -174,7 +174,8 @@
 
 &spi0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pins_a>;
+	pinctrl-0 = <&spi0_pins_a>,
+		    <&spi0_cs0_pins_a>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 1d7fd68bea1d..174a45390b4e 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -812,28 +812,56 @@
 			};
 
 			spi0_pins_a: spi0 at 0 {
-				allwinner,pins = "PI10", "PI11", "PI12", "PI13";
+				allwinner,pins = "PI11", "PI12", "PI13";
+				allwinner,function = "spi0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			spi0_cs0_pins_a: spi0_cs0 at 0 {
+				allwinner,pins = "PI10";
 				allwinner,function = "spi0";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi1_pins_a: spi1 at 0 {
-				allwinner,pins = "PI16", "PI17", "PI18", "PI19";
+				allwinner,pins = "PI17", "PI18", "PI19";
+				allwinner,function = "spi1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			spi1_cs0_pins_a: spi1_cs0 at 0 {
+				allwinner,pins = "PI16";
 				allwinner,function = "spi1";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi2_pins_a: spi2 at 0 {
-				allwinner,pins = "PB14", "PB15", "PB16", "PB17";
+				allwinner,pins = "PC20", "PC21", "PC22";
 				allwinner,function = "spi2";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi2_pins_b: spi2 at 1 {
-				allwinner,pins = "PC19", "PC20", "PC21", "PC22";
+				allwinner,pins = "PB15", "PB16", "PB17";
+				allwinner,function = "spi2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			spi2_cs0_pins_a: spi2_cs0 at 0 {
+				allwinner,pins = "PC19";
+				allwinner,function = "spi2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			spi2_cs0_pins_b: spi2_cs0 at 1 {
+				allwinner,pins = "PB14";
 				allwinner,function = "spi2";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
index b952ac445504..074df2b10c69 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
@@ -197,7 +197,9 @@
 
 &spi0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pins_a>;
+	pinctrl-0 = <&spi0_pins_a>,
+		    <&spi0_cs0_pins_a>,
+		    <&spi0_cs1_pins_a>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
index 9d9027f25a44..115e73fc7f85 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
@@ -243,7 +243,9 @@
 
 &spi0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi0_pins_a>;
+	pinctrl-0 = <&spi0_pins_a>,
+		    <&spi0_cs0_pins_a>,
+		    <&spi0_cs1_pins_a>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
index d3f15c2e721e..de66b8c80a14 100644
--- a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
+++ b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
@@ -245,7 +245,8 @@
 
 &spi2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi2_pins_b>;
+	pinctrl-0 = <&spi2_pins_b>,
+		    <&spi2_cs0_pins_b>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 82802b6cb192..719e7f175019 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -250,13 +250,15 @@
 
 &spi1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi1_pins_a>;
+	pinctrl-0 = <&spi1_pins_a>,
+		    <&spi1_cs0_pins_a>;
 	status = "okay";
 };
 
 &spi2 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&spi2_pins_a>;
+	pinctrl-0 = <&spi2_pins_a>,
+		    <&spi2_cs0_pins_a>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 4163ade867cb..824914ebea82 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -945,28 +945,63 @@
 			};
 
 			spi0_pins_a: spi0 at 0 {
-				allwinner,pins = "PI10", "PI11", "PI12", "PI13", "PI14";
+				allwinner,pins = "PI11", "PI12", "PI13";
+				allwinner,function = "spi0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			spi0_cs0_pins_a: spi0_cs0 at 0 {
+				allwinner,pins = "PI10";
+				allwinner,function = "spi0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			spi0_cs1_pins_a: spi0_cs1 at 0 {
+				allwinner,pins = "PI14";
 				allwinner,function = "spi0";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi1_pins_a: spi1 at 0 {
-				allwinner,pins = "PI16", "PI17", "PI18", "PI19";
+				allwinner,pins = "PI17", "PI18", "PI19";
+				allwinner,function = "spi1";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			spi1_cs0_pins_a: spi1_cs0 at 0 {
+				allwinner,pins = "PI16";
 				allwinner,function = "spi1";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi2_pins_a: spi2 at 0 {
-				allwinner,pins = "PC19", "PC20", "PC21", "PC22";
+				allwinner,pins = "PC20", "PC21", "PC22";
 				allwinner,function = "spi2";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
 			spi2_pins_b: spi2 at 1 {
-				allwinner,pins = "PB14", "PB15", "PB16", "PB17";
+				allwinner,pins = "PB15", "PB16", "PB17";
+				allwinner,function = "spi2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			spi2_cs0_pins_a: spi2_cs0 at 0 {
+				allwinner,pins = "PC19";
+				allwinner,function = "spi2";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			spi2_cs0_pins_b: spi2_cs0 at 1 {
+				allwinner,pins = "PB14";
 				allwinner,function = "spi2";
 				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-- 
2.3.6
