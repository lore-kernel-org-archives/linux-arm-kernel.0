From: marex@denx.de (Marek Vasut)
Date: Mon, 30 Sep 2013 00:41:29 +0200
Subject: [PATCH V2] ARM: dts: mxs: Add MSR M28CU3 board
Message-ID: <1380494489-7149-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board is based on the M28 SoM with custom baseboard. Supported
are LEDs, ethernet, PWM, LCD, SD slots.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/imx28-m28cu3.dts | 266 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mxs/mach-mxs.c       |   7 +
 3 files changed, 274 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx28-m28cu3.dts

V2: Let the FEC driver handle the enet_out clock.

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cf75889..275af9b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -159,6 +159,7 @@ dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
 	imx28-cfa10057.dtb \
 	imx28-cfa10058.dtb \
 	imx28-evk.dtb \
+	imx28-m28cu3.dtb \
 	imx28-m28evk.dtb \
 	imx28-sps1.dtb \
 	imx28-tx28.dtb
diff --git a/arch/arm/boot/dts/imx28-m28cu3.dts b/arch/arm/boot/dts/imx28-m28cu3.dts
new file mode 100644
index 0000000..d3958da
--- /dev/null
+++ b/arch/arm/boot/dts/imx28-m28cu3.dts
@@ -0,0 +1,266 @@
+/*
+ * Copyright (C) 2013 Marek Vasut <marex@denx.de>
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
+#include "imx28.dtsi"
+
+/ {
+	model = "MSR M28CU3";
+	compatible = "msr,m28cu3", "fsl,imx28";
+
+	memory {
+		reg = <0x40000000 0x08000000>;
+	};
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			gpmi-nand at 8000c000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg>;
+				status = "okay";
+
+				partition at 0 {
+					label = "gpmi-nfc-0-boot";
+					reg = <0x00000000 0x01400000>;
+					read-only;
+				};
+
+				partition at 1 {
+					label = "gpmi-nfc-general-use";
+					reg = <0x01400000 0x0ec00000>;
+				};
+			};
+
+			ssp0: ssp at 80010000 {
+				compatible = "fsl,imx28-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc0_4bit_pins_a
+					     &mmc0_cd_cfg
+					     &mmc0_sck_cfg>;
+				bus-width = <4>;
+				vmmc-supply = <&reg_vddio_sd0>;
+				status = "okay";
+			};
+
+			ssp2: ssp at 80014000 {
+				compatible = "fsl,imx28-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc2_4bit_pins_a
+					     &mmc2_cd_cfg
+					     &mmc2_sck_cfg>;
+				bus-width = <4>;
+				vmmc-supply = <&reg_vddio_sd1>;
+				status = "okay";
+			};
+
+			pinctrl at 80018000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&hog_pins_a>;
+
+				hog_pins_a: hog at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_SSP2_SS0__GPIO_2_19
+						MX28_PAD_PWM4__GPIO_3_29
+						MX28_PAD_AUART2_RX__GPIO_3_8
+						MX28_PAD_ENET0_RX_CLK__GPIO_4_13
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
+				lcdif_pins_m28: lcdif-m28 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_LCD_VSYNC__LCD_VSYNC
+						MX28_PAD_LCD_HSYNC__LCD_HSYNC
+						MX28_PAD_LCD_DOTCLK__LCD_DOTCLK
+						MX28_PAD_LCD_RESET__LCD_RESET
+						MX28_PAD_LCD_CS__LCD_ENABLE
+						MX28_PAD_AUART1_TX__GPIO_3_5
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
+				led_pins_gpio: leds-m28 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						MX28_PAD_SSP3_MISO__GPIO_2_26
+						MX28_PAD_SSP3_SCK__GPIO_2_24
+					>;
+					fsl,drive-strength = <MXS_DRIVE_4mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+			};
+
+			ocotp at 8002c000 {
+				status = "okay";
+			};
+
+			lcdif at 80030000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&lcdif_24bit_pins_a
+					     &lcdif_pins_m28>;
+				display = <&display>;
+				reset-active-high;
+				status = "okay";
+
+				display: display0 {
+					bits-per-pixel = <32>;
+					bus-width = <24>;
+
+					display-timings {
+						native-mode = <&timing0>;
+						timing0: timing0 {
+							clock-frequency = <6410256>;
+							hactive = <320>;
+							vactive = <240>;
+							hback-porch = <38>;
+							hfront-porch = <20>;
+							vback-porch = <15>;
+							vfront-porch = <5>;
+							hsync-len = <30>;
+							vsync-len = <3>;
+							hsync-active = <0>;
+							vsync-active = <0>;
+							de-active = <1>;
+							pixelclk-active = <1>;
+						};
+					};
+				};
+			};
+		};
+
+		apbx at 80040000 {
+			duart: serial at 80074000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&duart_pins_b>;
+				status = "okay";
+			};
+
+			usbphy1: usbphy at 8007e000 {
+				status = "okay";
+			};
+
+			auart0: serial at 8006a000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart0_2pins_a>;
+				status = "okay";
+			};
+
+			auart3: serial at 80070000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart3_2pins_b>;
+				status = "okay";
+			};
+
+			pwm: pwm at 80064000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pwm3_pins_a>;
+				status = "okay";
+			};
+		};
+	};
+
+	ahb at 80080000 {
+		usb1: usb at 80090000 {
+			vbus-supply = <&reg_usb1_vbus>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&usbphy1_pins_a>;
+			disable-over-current;
+			status = "okay";
+		};
+
+		mac0: ethernet at 800f0000 {
+			phy-mode = "rmii";
+			pinctrl-names = "default";
+			pinctrl-0 = <&mac0_pins_a>;
+			phy-reset-gpios = <&gpio4 13 0>;
+			phy-reset-duration = <100>;
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
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 3 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&led_pins_gpio>;
+
+		user1 {
+			label = "sd0-led";
+			gpios = <&gpio2 26 0>;
+			linux,default-trigger = "mmc0";
+		};
+
+		user2 {
+			label = "sd1-led";
+			gpios = <&gpio2 24 0>;
+			linux,default-trigger = "mmc2";
+		};
+	};
+
+	regulators {
+		compatible = "simple-bus";
+
+		reg_3p3v: 3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+
+		reg_vddio_sd0: vddio-sd0 {
+			compatible = "regulator-fixed";
+			regulator-name = "vddio-sd0";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio3 29 0>;
+		};
+
+		reg_vddio_sd1: vddio-sd1 {
+			compatible = "regulator-fixed";
+			regulator-name = "vddio-sd1";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio2 19 0>;
+		};
+
+		reg_usb1_vbus: usb1_vbus {
+			compatible = "regulator-fixed";
+			regulator-name = "usb1_vbus";
+			regulator-min-microvolt = <5000000>;
+			regulator-max-microvolt = <5000000>;
+			gpio = <&gpio3 8 0>;
+			enable-active-high;
+		};
+	};
+};
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 98f6e2a..c0ceb17 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -332,6 +332,11 @@ static void __init crystalfontz_init(void)
 	update_fec_mac_prop(OUI_CRYSTALFONTZ);
 }
 
+static void __init m28cu3_init(void)
+{
+	update_fec_mac_prop(OUI_DENX);
+}
+
 static const char __init *mxs_get_soc_id(void)
 {
 	struct device_node *np;
@@ -459,6 +464,8 @@ static void __init mxs_machine_init(void)
 		apx4devkit_init();
 	else if (of_machine_is_compatible("crystalfontz,cfa10036"))
 		crystalfontz_init();
+	else if (of_machine_is_compatible("msr,m28cu3"))
+		m28cu3_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     NULL, parent);
-- 
1.8.4.rc3
