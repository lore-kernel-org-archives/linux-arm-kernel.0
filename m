From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jul 2012 14:14:52 +0800
Subject: [PATCH 3/7] ARM: mxs: convert m28evk board to device tree
In-Reply-To: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1341814496-17487-4-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Vasut <marex@denx.de>

Signed-off-by: Marek Vasut <marex@denx.de>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28.dtsi |   21 ++++
 arch/arm/boot/dts/m28evk.dts |  241 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mxs/mach-mxs.c |   30 +++++
 3 files changed, 292 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/m28evk.dts

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 02e778b..3390607 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -232,6 +232,17 @@
 					fsl,pull-up = <0>;
 				};
 
+				auart0_2pins_a: auart0-2pins at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x3000 /* MX28_PAD_AUART0_RX__AUART0_RX */
+						0x3010 /* MX28_PAD_AUART0_TX__AUART0_TX */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				auart3_pins_a: auart3 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
@@ -373,6 +384,16 @@
 					fsl,pull-up = <0>;
 				};
 
+				pwm3_pins_a: pwm3 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x31c0 /* MX28_PAD_PWM3__PWM_3 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				lcdif_24bit_pins_a: lcdif-24bit at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
diff --git a/arch/arm/boot/dts/m28evk.dts b/arch/arm/boot/dts/m28evk.dts
new file mode 100644
index 0000000..0c22792
--- /dev/null
+++ b/arch/arm/boot/dts/m28evk.dts
@@ -0,0 +1,241 @@
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
+	model = "DENX M28EVK";
+	compatible = "denx,m28evk", "fsl,imx28";
+
+	memory {
+		reg = <0x40000000 0x08000000>;
+	};
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			gpmi-nand at 8000c000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg>;
+				status = "okay";
+
+				partition at 0 {
+					label = "bootloader";
+					reg = <0x00000000 0x00300000>;
+					read-only;
+				};
+
+				partition at 1 {
+					label = "environment";
+					reg = <0x00300000 0x00080000>;
+				};
+
+				partition at 2 {
+					label = "redundant-environment";
+					reg = <0x00380000 0x00080000>;
+				};
+
+				partition at 3 {
+					label = "kernel";
+					reg = <0x00400000 0x00400000>;
+				};
+
+				partition at 4 {
+					label = "filesystem";
+					reg = <0x00800000 0x0f800000>;
+				};
+			};
+
+			ssp0: ssp at 80010000 {
+				compatible = "fsl,imx28-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc0_8bit_pins_a
+					     &mmc0_cd_cfg
+					     &mmc0_sck_cfg>;
+				bus-width = <8>;
+				wp-gpios = <&gpio3 10 1>;
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
+						0x30a3 /* MX28_PAD_AUART2_CTS__GPIO_3_10 */
+						0x30b3 /* MX28_PAD_AUART2_RTS__GPIO_3_11 */
+						0x3103 /* MX28_PAD_PWM0__GPIO_3_16 */
+						0x3113 /* MX28_PAD_PWM1__GPIO_3_17 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				lcdif_pins_m28: lcdif-m28 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x11e0 /* MX28_PAD_LCD_DOTCLK__LCD_DOTCLK */
+						0x11f0 /* MX28_PAD_LCD_ENABLE__LCD_ENABLE */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+			};
+
+			lcdif at 80030000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&lcdif_24bit_pins_a
+					     &lcdif_pins_m28>;
+				status = "okay";
+			};
+
+			can0: can at 80032000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&can0_pins_a>;
+				status = "okay";
+			};
+
+			can1: can at 80034000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&can1_pins_a>;
+				status = "okay";
+			};
+		};
+
+		apbx at 80040000 {
+			saif0: saif at 80042000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&saif0_pins_a>;
+				status = "okay";
+			};
+
+			saif1: saif at 80046000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&saif1_pins_a>;
+				fsl,saif-master = <&saif0>;
+				status = "okay";
+			};
+
+			i2c0: i2c at 80058000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c0_pins_a>;
+				status = "okay";
+
+				sgtl5000: codec at 0a {
+					compatible = "fsl,sgtl5000";
+					reg = <0x0a>;
+					VDDA-supply = <&reg_3p3v>;
+					VDDIO-supply = <&reg_3p3v>;
+
+				};
+
+				eeprom: eeprom at 51 {
+					compatible = "atmel,24c128";
+					reg = <0x51>;
+					pagesize = <32>;
+				};
+
+				rtc: rtc at 68 {
+					compatible = "stm,mt41t62";
+					reg = <0x68>;
+				};
+			};
+
+			pwm: pwm at 80064000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pwm3_pins_a>;
+				status = "okay";
+			};
+
+			duart: serial at 80074000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&duart_pins_a>;
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
+				pinctrl-0 = <&auart3_pins_a>;
+				status = "okay";
+			};
+		};
+	};
+
+	ahb at 80080000 {
+		mac0: ethernet at 800f0000 {
+			phy-mode = "rmii";
+			pinctrl-names = "default";
+			pinctrl-0 = <&mac0_pins_a>;
+			phy-reset-gpios = <&gpio3 11 0>;
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
+		reg_3p3v: 3p3v {
+			compatible = "regulator-fixed";
+			regulator-name = "3P3V";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-always-on;
+		};
+	};
+
+	sound {
+		compatible = "fsl,imx28-evk-sgtl5000",
+			     "fsl,mxs-audio-sgtl5000";
+		model = "imx28-evk-sgtl5000";
+		saif-controllers = <&saif0 &saif1>;
+		audio-codec = <&sgtl5000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		user1 {
+			label = "Heartbeat1";
+			gpios = <&gpio3 16 0>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		user2 {
+			label = "Heartbeat2";
+			gpios = <&gpio3 17 0>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 3 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
+};
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 7bbb961..6bb6db8 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -59,6 +59,23 @@ static struct fb_videomode mx28evk_video_modes[] = {
 	},
 };
 
+static struct fb_videomode m28evk_video_modes[] = {
+	{
+		.name		= "Ampire AM-800480R2TMQW-T01H",
+		.refresh	= 60,
+		.xres		= 800,
+		.yres		= 480,
+		.pixclock	= 30066, /* picosecond (33.26 MHz) */
+		.left_margin	= 0,
+		.right_margin	= 256,
+		.upper_margin	= 0,
+		.lower_margin	= 45,
+		.hsync_len	= 1,
+		.vsync_len	= 1,
+		.sync		= FB_SYNC_DATA_ENABLE_HIGH_ACT,
+	},
+};
+
 static struct mxsfb_platform_data mxsfb_pdata __initdata;
 
 static struct of_dev_auxdata mxs_auxdata_lookup[] __initdata = {
@@ -203,12 +220,24 @@ static void __init imx28_evk_init(void)
 	mxsfb_pdata.ld_intf_width = STMLCDIF_24BIT;
 }
 
+static void __init m28evk_init(void)
+{
+	update_fec_mac_prop(OUI_DENX);
+
+	mxsfb_pdata.mode_list = m28evk_video_modes;
+	mxsfb_pdata.mode_count = ARRAY_SIZE(m28evk_video_modes);
+	mxsfb_pdata.default_bpp = 16;
+	mxsfb_pdata.ld_intf_width = STMLCDIF_18BIT;
+}
+
 static void __init mxs_machine_init(void)
 {
 	if (of_machine_is_compatible("fsl,imx28-evk"))
 		imx28_evk_init();
 	else if (of_machine_is_compatible("fsl,imx23-evk"))
 		imx23_evk_init();
+	else if (of_machine_is_compatible("denx,m28evk"))
+		m28evk_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     mxs_auxdata_lookup, NULL);
@@ -223,6 +252,7 @@ static const char *imx23_dt_compat[] __initdata = {
 
 static const char *imx28_dt_compat[] __initdata = {
 	"crystalfontz,cfa10036",
+	"denx,m28evk",
 	"fsl,imx28-evk",
 	"fsl,imx28",
 	NULL,
-- 
1.7.5.4
