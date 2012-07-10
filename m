From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Jul 2012 13:36:26 +0800
Subject: [PATCH v2 6/7] ARM: mxs: convert stmp378x_devb board to device tree
In-Reply-To: <1341898587-8462-1-git-send-email-shawn.guo@linaro.org>
References: <1341898587-8462-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1341898587-8462-7-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enc28j60 spi device does not get converted to dts file, because
there is no mxs spi driver on mainline so far.  The enc28j60 spi
in mach-stmp378x_devb.c does not work anyway.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/stmp378x_devb.dts |   78 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-mxs/mach-mxs.c        |    1 +
 2 files changed, 79 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/stmp378x_devb.dts

diff --git a/arch/arm/boot/dts/stmp378x_devb.dts b/arch/arm/boot/dts/stmp378x_devb.dts
new file mode 100644
index 0000000..757a327
--- /dev/null
+++ b/arch/arm/boot/dts/stmp378x_devb.dts
@@ -0,0 +1,78 @@
+/*
+ * Copyright 2012 Freescale Semiconductor, Inc.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "imx23.dtsi"
+
+/ {
+	model = "Freescale STMP378x Development Board";
+	compatible = "fsl,stmp378x-devb", "fsl,imx23";
+
+	memory {
+		reg = <0x40000000 0x04000000>;
+	};
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			ssp0: ssp at 80010000 {
+				compatible = "fsl,imx23-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_pins_fixup>;
+				bus-width = <4>;
+				wp-gpios = <&gpio1 30 0>;
+				vmmc-supply = <&reg_vddio_sd0>;
+				status = "okay";
+			};
+
+			pinctrl at 80018000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&hog_pins_a>;
+
+				hog_pins_a: hog-gpios at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x11d3 /* MX23_PAD_PWM3__GPIO_1_29 */
+						0x11e3 /* MX23_PAD_PWM4__GPIO_1_30 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+			};
+		};
+
+		apbx at 80040000 {
+			auart0: serial at 8006c000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart0_pins_a>;
+				status = "okay";
+			};
+
+			duart: serial at 80070000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&duart_pins_a>;
+				status = "okay";
+			};
+		};
+	};
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
+};
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index c1e02ae..b3239e2 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -269,6 +269,7 @@ static void __init mxs_machine_init(void)
 
 static const char *imx23_dt_compat[] __initdata = {
 	"fsl,imx23-evk",
+	"fsl,stmp378x_devb"
 	"olimex,imx23-olinuxino",
 	"fsl,imx23",
 	NULL,
-- 
1.7.5.4
