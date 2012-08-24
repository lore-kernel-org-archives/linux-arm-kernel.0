From: marex@denx.de (Marek Vasut)
Date: Sat, 25 Aug 2012 01:51:40 +0200
Subject: [PATCH 4/4] ARM: mxs: Add SchulerControl SPS1 DTS file
In-Reply-To: <1345852300-2213-1-git-send-email-marex@denx.de>
References: <1345852300-2213-1-git-send-email-marex@denx.de>
Message-ID: <1345852300-2213-4-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DTS file for this custom board.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28-sps1.dts |  168 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mxs/mach-mxs.c     |    3 +
 2 files changed, 171 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx28-sps1.dts

diff --git a/arch/arm/boot/dts/imx28-sps1.dts b/arch/arm/boot/dts/imx28-sps1.dts
new file mode 100644
index 0000000..d05b1cb
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-sps1.dts
@@ -0,0 +1,168 @@
+/*
+ * Copyright (C) 2012 Marek Vasut <marex@denx.de>
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
+/include/ "imx28.dtsi"
+
+/ {
+	model = "SchulerControl GmbH, SC SPS 1";
+	compatible = "schulercontrol,imx28-sps1", "fsl,imx28";
+
+	memory {
+		reg = <0x40000000 0x08000000>;
+	};
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			pinctrl at 80018000 {
+				led_pins_sps1: leds at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x0003 /* MX28_PAD_GPMI_D00__GPIO_0_0 */
+						0x0033 /* MX28_PAD_GPMI_D03__GPIO_0_3 */
+						0x0063 /* MX28_PAD_GPMI_D06__GPIO_0_6 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+			};
+
+			ssp0: ssp at 80010000 {
+				compatible = "fsl,imx28-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc0_4bit_pins_a>;
+				bus-width = <4>;
+				status = "okay";
+			};
+
+			ssp2: ssp at 80014000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,imx28-spi";
+				pinctrl-names = "default";
+				pinctrl-0 = <&spi2_pins_a>;
+				status = "okay";
+
+				flash: m25p80 at 0 {
+					#address-cells = <1>;
+					#size-cells = <1>;
+					compatible = "everspin,mr25h256", "mr25h256";
+					spi-max-frequency = <40000000>;
+					reg = <0>;
+				};
+			};
+		};
+
+		apbx at 80040000 {
+			i2c0: i2c at 80058000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c0_pins_a>;
+				clock-frequency = <400000>;
+				status = "okay";
+
+				rtc: rtc at 51 {
+					compatible = "nxp,pcf8563";
+					reg = <0x51>;
+				};
+
+				eeprom: eeprom at 52 {
+					compatible = "atmel,24c64";
+					reg = <0x52>;
+					pagesize = <32>;
+				};
+			};
+
+			duart: serial at 80074000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&duart_pins_a>;
+				status = "okay";
+			};
+
+			usbphy0: usbphy at 8007c000 {
+				status = "okay";
+			};
+
+			auart0: serial at 8006a000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart0_pins_a>;
+				status = "okay";
+			};
+
+			rtc at 80056000 {
+				status = "okay";
+			};
+		};
+	};
+
+	ahb at 80080000 {
+		usb0: usb at 80080000 {
+			vbus-supply = <&reg_usb0_vbus>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&usbphy0_pins_b>;
+			status = "okay";
+		};
+
+		mac0: ethernet at 800f0000 {
+			phy-mode = "rmii";
+			pinctrl-names = "default";
+			pinctrl-0 = <&mac0_pins_a>;
+			status = "okay";
+		};
+
+		mac1: ethernet at 800f4000 {
+			phy-mode = "rmii";
+			pinctrl-names = "default";
+			pinctrl-0 = <&mac1_pins_a>;
+			status = "okay";
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_usb0_vbus: usb0_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb0_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 9 0>;
+			enable-active-low;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_sps1>;
+		status = "okay";
+
+		led at 1 {
+			label = "sps1-1:yellow:user";
+			gpios = <&gpio0 6 0>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led at 2 {
+			label = "sps1-2:red:user";
+			gpios = <&gpio0 3 0>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led at 3 {
+			label = "sps1-3:red:user";
+			gpios = <&gpio0 0 0>;
+			default-trigger = "heartbeat";
+		};
+
+	};
+};
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 5ac45a1..f131ff1 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -279,6 +279,8 @@ static void __init mxs_machine_init(void)
 		m28evk_init();
 	else if (of_machine_is_compatible("bluegiga,apx4devkit"))
 		apx4devkit_init();
+	else if (of_machine_is_compatible("schulercontrol,imx28-sps1"))
+		imx28_evk_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     mxs_auxdata_lookup, NULL);
@@ -298,6 +300,7 @@ static const char *imx28_dt_compat[] __initdata = {
 	"denx,m28evk",
 	"fsl,imx28-evk",
 	"karo,tx28",
+	"schulercontrol,imx28-sps1",
 	"fsl,imx28",
 	NULL,
 };
-- 
1.7.10.4
