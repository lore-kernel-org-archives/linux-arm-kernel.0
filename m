From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 20 Aug 2012 22:43:15 -0300
Subject: [PATCH] ARM: olinuxino: Add gpio-led support
Message-ID: <1345513396-12320-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Olinuxino has a LED connected to MX23_PAD_SSP1_DETECT__GPIO_2_1 pin.

Since mmc0_4bit_pins_a defines MX23_PAD_SSP1_DETECT as SSP function, create
a new mmc0_4bit_pins_b.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx23-olinuxino.dts |   28 +++++++++++++++++++++++++++-
 arch/arm/boot/dts/imx23.dtsi          |   15 +++++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx23-olinuxino.dts b/arch/arm/boot/dts/imx23-olinuxino.dts
index a286873..dece3fe 100644
--- a/arch/arm/boot/dts/imx23-olinuxino.dts
+++ b/arch/arm/boot/dts/imx23-olinuxino.dts
@@ -27,10 +27,25 @@
 			ssp0: ssp at 80010000 {
 				compatible = "fsl,imx23-mmc";
 				pinctrl-names = "default";
-				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_pins_fixup>;
+				pinctrl-0 = <&mmc0_4bit_pins_b &mmc0_pins_fixup>;
 				bus-width = <4>;
 				status = "okay";
 			};
+
+			pinctrl at 80018000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&hog_pins_a>;
+
+				hog_pins_a: hog-gpios at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x2013 /* MX23_PAD_SSP1_DETECT__GPIO_2_1 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+			};
 		};
 
 		apbx at 80040000 {
@@ -47,4 +62,15 @@
 			};
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		user {
+			label = "green";
+			gpios = <&gpio2 1 0>;
+			linux,default-trigger = "default-on";
+			default-state = "on";
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 9700872..a8b423a 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -202,6 +202,21 @@
 					fsl,pull-up = <1>;
 				};
 
+				mmc0_4bit_pins_b: mmc0-4bit_b at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x2020 /* MX23_PAD_SSP1_DATA0__SSP1_DATA0 */
+						0x2030 /* MX23_PAD_SSP1_DATA1__SSP1_DATA1 */
+						0x2040 /* MX23_PAD_SSP1_DATA2__SSP1_DATA2 */
+						0x2050 /* MX23_PAD_SSP1_DATA3__SSP1_DATA3 */
+						0x2000 /* MX23_PAD_SSP1_CMD__SSP1_CMD */
+						0x2060 /* MX23_PAD_SSP1_SCK__SSP1_SCK */
+					>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
 				mmc0_8bit_pins_a: mmc0-8bit at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
1.7.9.5
