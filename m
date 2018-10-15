From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Mon, 15 Oct 2018 11:30:13 +0200
Subject: [PATCH] dt-bindings: pinctrl: bcm4708-pinmux: improve example binding
Message-ID: <20181015093013.31651-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

Broadcom SoC pins are controlled using CRU ("Clock and Reset Unit" or
"Central Resource Unit") registers. There are more CRU registers and
functions so CRU should be represented as a separated block in DT.

Moreover CRU is a sub-block of DMU ("Device Management Unit") so that
one should also get its own node.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
 .../bindings/pinctrl/brcm,bcm4708-pinmux.txt       | 31 ++++++++++++++++------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm4708-pinmux.txt b/Documentation/devicetree/bindings/pinctrl/brcm,bcm4708-pinmux.txt
index af906f196e8c..0ce132c7e04c 100644
--- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm4708-pinmux.txt
+++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm4708-pinmux.txt
@@ -30,13 +30,28 @@ For documentation of subnodes see:
 Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
 
 Example:
-	pinctrl at 1800c1c0 {
-		compatible = "brcm,bcm4708-pinmux";
-		reg = <0x1800c1c0 0x24>;
-		reg-names = "cru_gpio_control";
-
-		spi {
-			function = "spi";
-			groups = "spi_grp";
+	dmu at 1800c000 {
+		compatible = "simple-bus";
+		ranges = <0 0x1800c000 0x1000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		cru at 100 {
+			compatible = "simple-bus";
+			reg = <0x100 0x1a4>;
+			ranges;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+ 			pin-controller at 1c0 {
+				compatible = "brcm,bcm4708-pinmux";
+				reg = <0x1c0 0x24>;
+				reg-names = "cru_gpio_control";
+
+				spi-pins {
+					function = "spi";
+					groups = "spi_grp";
+				};
+			};
 		};
 	};
-- 
2.13.7
