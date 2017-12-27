From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 27 Dec 2017 12:04:38 -0200
Subject: [PATCH 5/5] ARM: dts: imx28-cfa10049: Move i2cmux out of bus node
In-Reply-To: <1514383478-32544-1-git-send-email-festevam@gmail.com>
References: <1514383478-32544-1-git-send-email-festevam@gmail.com>
Message-ID: <1514383478-32544-5-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Move i2cmux node from soc node to root node.

i2cmux node does not have any register properties and thus shouldn't be
placed on the bus.

This fixes the following build warnings with W=1:

arch/arm/boot/dts/imx28-cfa10049.dtb: Warning (simple_bus_reg): Node /apb at 80000000/apbx at 80040000/i2cmux missing or empty reg/ranges property

Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx28-cfa10049.dts | 130 +++++++++++++++++------------------
 1 file changed, 65 insertions(+), 65 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index 4cd52d5..60e5c7f 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -19,6 +19,71 @@
 	model = "Crystalfontz CFA-10049 Board";
 	compatible = "crystalfontz,cfa10049", "crystalfontz,cfa10036", "fsl,imx28";
 
+	i2cmux {
+		compatible = "i2c-mux-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2cmux_pins_cfa10049>;
+		mux-gpios = <&gpio1 22 0 &gpio1 23 0>;
+		i2c-parent = <&i2c1>;
+
+		i2c at 0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			adc0: nau7802 at 2a {
+				compatible = "nuvoton,nau7802";
+				reg = <0x2a>;
+				nuvoton,vldo = <3000>;
+			};
+		};
+
+		i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+
+			adc1: nau7802 at 2a {
+				compatible = "nuvoton,nau7802";
+				reg = <0x2a>;
+				nuvoton,vldo = <3000>;
+			};
+		};
+
+		i2c at 2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+
+				adc2: nau7802 at 2a {
+				compatible = "nuvoton,nau7802";
+				reg = <0x2a>;
+				nuvoton,vldo = <3000>;
+			};
+		};
+
+		i2c at 3 {
+			reg = <3>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			pca9555: pca9555 at 20 {
+				compatible = "nxp,pca9555";
+				pinctrl-names = "default";
+				pinctrl-0 = <&pca_pins_cfa10049>;
+				interrupt-parent = <&gpio2>;
+				interrupts = <19 0x2>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				reg = <0x20>;
+			};
+		};
+	};
+
 	apb at 80000000 {
 		apbh at 80000000 {
 			pinctrl at 80018000 {
@@ -219,71 +284,6 @@
 				status = "okay";
 			};
 
-			i2cmux {
-				compatible = "i2c-mux-gpio";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				pinctrl-names = "default";
-				pinctrl-0 = <&i2cmux_pins_cfa10049>;
-				mux-gpios = <&gpio1 22 0 &gpio1 23 0>;
-				i2c-parent = <&i2c1>;
-
-				i2c at 0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-
-					adc0: nau7802 at 2a {
-						compatible = "nuvoton,nau7802";
-						reg = <0x2a>;
-						nuvoton,vldo = <3000>;
-					};
-				};
-
-				i2c at 1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-
-					adc1: nau7802 at 2a {
-						compatible = "nuvoton,nau7802";
-						reg = <0x2a>;
-						nuvoton,vldo = <3000>;
-					};
-				};
-
-				i2c at 2 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <2>;
-
-					adc2: nau7802 at 2a {
-						compatible = "nuvoton,nau7802";
-						reg = <0x2a>;
-						nuvoton,vldo = <3000>;
-					};
-				};
-
-				i2c at 3 {
-					reg = <3>;
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					pca9555: pca9555 at 20 {
-						compatible = "nxp,pca9555";
-						pinctrl-names = "default";
-						pinctrl-0 = <&pca_pins_cfa10049>;
-						interrupt-parent = <&gpio2>;
-						interrupts = <19 0x2>;
-						gpio-controller;
-						#gpio-cells = <2>;
-						interrupt-controller;
-						#interrupt-cells = <2>;
-						reg = <0x20>;
-					};
-				};
-			};
-
 			usbphy1: usbphy at 8007e000 {
 				status = "okay";
 			};
-- 
2.7.4
