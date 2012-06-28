From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Jun 2012 11:44:59 +0800
Subject: [PATCH 03/11] ARM: dts: imx23-evk: updates for mmc device
In-Reply-To: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
References: <1340855107-4664-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1340855107-4664-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 8-bit mode mmc has pin conflicts with display.  Let's use 4-bit
mode by default, so that display can be enabled together later.

Also add vmmc-supply for mmc device.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx23-evk.dts |   17 +++++++++++++++--
 arch/arm/boot/dts/imx23.dtsi    |   16 ++++++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index 6a0912b..8321fa3 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -25,9 +25,10 @@
 			ssp0: ssp at 80010000 {
 				compatible = "fsl,imx23-mmc";
 				pinctrl-names = "default";
-				pinctrl-0 = <&mmc0_8bit_pins_a &mmc0_pins_fixup>;
-				bus-width = <8>;
+				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_pins_fixup>;
+				bus-width = <4>;
 				wp-gpios = <&gpio1 30 0>;
+				vmmc-supply = <&reg_vddio_sd0>;
 				status = "okay";
 			};
 
@@ -57,4 +58,16 @@
 			};
 		};
 	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_vddio_sd0: vddio-sd0 {
+			compatible = "regulator-fixed";
+			regulator-name = "vddio-sd0";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio1 29 0>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 7274273..daade4f 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -123,6 +123,22 @@
 					fsl,pull-up = <0>;
 				};
 
+				mmc0_4bit_pins_a: mmc0-4bit at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x2020 /* MX23_PAD_SSP1_DATA0__SSP1_DATA0 */
+						0x2030 /* MX23_PAD_SSP1_DATA1__SSP1_DATA1 */
+						0x2040 /* MX23_PAD_SSP1_DATA2__SSP1_DATA2 */
+						0x2050 /* MX23_PAD_SSP1_DATA3__SSP1_DATA3 */
+						0x2000 /* MX23_PAD_SSP1_CMD__SSP1_CMD */
+						0x2010 /* MX23_PAD_SSP1_DETECT__SSP1_DETECT */
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
1.7.5.4
