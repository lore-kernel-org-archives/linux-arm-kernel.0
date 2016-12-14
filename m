From: eric@anholt.net (Eric Anholt)
Date: Wed, 14 Dec 2016 11:46:20 -0800
Subject: [PATCH 10/11] ARM: bcm2835: dt: Add the DSI module nodes and clocks.
In-Reply-To: <20161214194621.16499-1-eric@anholt.net>
References: <20161214194621.16499-1-eric@anholt.net>
Message-ID: <20161214194621.16499-11-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The modules stay disabled by default, and if you want to enable DSI
you'll need an overlay that connects a panel to it.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi |  8 +++++++
 arch/arm/boot/dts/bcm283x.dtsi     | 49 +++++++++++++++++++++++++++++++++++---
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index e9b47b2bbc33..365648898f3a 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -84,3 +84,11 @@
 	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
 	status = "okay";
 };
+
+&dsi0 {
+	power-domains = <&power RPI_POWER_DOMAIN_DSI0>;
+};
+
+&dsi1 {
+	power-domains = <&power RPI_POWER_DOMAIN_DSI1>;
+};
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 46d46d894a44..82a4eccfb3d8 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -93,10 +93,13 @@
 			#clock-cells = <1>;
 			reg = <0x7e101000 0x2000>;
 
-			/* CPRMAN derives everything from the platform's
-			 * oscillator.
+			/* CPRMAN derives almost everything from the
+			 * platform's oscillator.  However, the DSI
+			 * pixel clocks come from the DSI analog PHY.
 			 */
-			clocks = <&clk_osc>;
+			clocks = <&clk_osc>,
+				<&dsi0 0>, <&dsi0 1>, <&dsi0 2>,
+				<&dsi1 0>, <&dsi1 1>, <&dsi1 2>;
 		};
 
 		rng at 7e104000 {
@@ -187,6 +190,26 @@
 			interrupts = <2 14>; /* pwa1 */
 		};
 
+		dsi0: dsi at 7e209000 {
+			compatible = "brcm,bcm2835-dsi0";
+			reg = <0x7e209000 0x78>;
+			interrupts = <2 4>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+
+			clocks = <&clocks BCM2835_PLLA_DSI0>,
+				 <&clocks BCM2835_CLOCK_DSI0E>,
+				 <&clocks BCM2835_CLOCK_DSI0P>;
+			clock-names = "phy", "escape", "pixel";
+
+			clock-output-names = "dsi0_byte",
+					     "dsi0_ddr2",
+					     "dsi0_ddr";
+
+			status = "disabled";
+		};
+
 		aux: aux at 0x7e215000 {
 			compatible = "brcm,bcm2835-aux";
 			#clock-cells = <1>;
@@ -246,6 +269,26 @@
 			interrupts = <2 1>;
 		};
 
+		dsi1: dsi at 7e700000 {
+			compatible = "brcm,bcm2835-dsi1";
+			reg = <0x7e700000 0x8c>;
+			interrupts = <2 12>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#clock-cells = <1>;
+
+			clocks = <&clocks BCM2835_PLLD_DSI1>,
+				 <&clocks BCM2835_CLOCK_DSI1E>,
+				 <&clocks BCM2835_CLOCK_DSI1P>;
+			clock-names = "phy", "escape", "pixel";
+
+			clock-output-names = "dsi1_byte",
+					     "dsi1_ddr2",
+					     "dsi1_ddr";
+
+			status = "disabled";
+		};
+
 		i2c1: i2c at 7e804000 {
 			compatible = "brcm,bcm2835-i2c";
 			reg = <0x7e804000 0x1000>;
-- 
2.11.0
