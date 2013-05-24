From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 May 2013 23:13:29 +0200
Subject: [PATCH] ARM: nomadik: move the pin configuration to DT
Message-ID: <1369430009-27214-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This moves the pin configuration for the Nomadik over to the
device tree using Gabriel's bindings. Remove the auxdata
nailing down the name of the pin controller as this is no
longer necessary.

Cc: Gabriel Fernandez <gabriel.fernandez@st.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-s8815.dts    | 41 +++++++++++++++
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 82 ++++++++++++++++++++++++++++++
 arch/arm/mach-nomadik/cpu-8815.c           | 51 -------------------
 3 files changed, 123 insertions(+), 51 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
index 666945a..638ec8d 100644
--- a/arch/arm/boot/dts/ste-nomadik-s8815.dts
+++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
@@ -14,6 +14,43 @@
 		bootargs = "root=/dev/ram0 console=ttyAMA1,115200n8 earlyprintk";
 	};
 
+	pinctrl {
+		/* Hog CD pins */
+		pinctrl-names = "default";
+		pinctrl-0 = <&cd_default_mode>;
+
+		mmcsd-cd {
+			cd_default_mode: cd_default {
+				cd_default_cfg1 {
+					/* CD input GPIO */
+					ste,pins = "GPIO111_H21";
+					ste,input = <0>;
+				};
+				cd_default_cfg2 {
+					/* CD GPIO biasing */
+					ste,pins = "GPIO112_J21";
+					ste,output = <0>;
+				};
+			};
+		};
+		user-led {
+			user_led_default_mode: user_led_default {
+				user_led_default_cfg {
+					ste,pins = "GPIO2_C5";
+					ste,output = <1>;
+				};
+			};
+		};
+		user-button {
+			user_button_default_mode: user_button_default {
+				user_button_default_cfg {
+					ste,pins = "GPIO3_A4";
+					ste,input = <0>;
+				};
+			};
+		};
+	};
+
 	/* Custom board node with GPIO pins to active etc */
 	usb-s8815 {
 		/* The S8815 is using this very GPIO pin for the SMSC91x IRQs */
@@ -36,6 +73,8 @@
 			gpios = <&gpio0 2 0x1>;
 			default-state = "off";
 			linux,default-trigger = "heartbeat";
+			pinctrl-names = "default";
+			pinctrl-0 = <&user_led_default_mode>;
 		};
 	};
 
@@ -47,6 +86,8 @@
 			gpios = <&gpio0 3 0x1>;
 			linux,code = <1>; /* KEY_ESC */
 			gpio-key,wakeup;
+			pinctrl-names = "default";
+			pinctrl-0 = <&user_button_default_mode>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 51a33e0..615da87 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -94,6 +94,75 @@
 
 	pinctrl {
 		compatible = "stericsson,nmk-pinctrl-stn8815";
+		/* Pin configurations */
+		uart0 {
+			uart0_default_mux: uart0_mux {
+				u0_default_mux {
+					ste,function = "u0";
+					ste,pins = "u0_a_1";
+				};
+			};
+		};
+		uart1 {
+			uart1_default_mux: uart1_mux {
+				u1_default_mux {
+					ste,function = "u1";
+					ste,pins = "u1_a_1";
+				};
+			};
+		};
+		mmcsd {
+			mmcsd_default_mux: mmcsd_mux {
+				mmcsd_default_mux {
+					ste,function = "mmcsd";
+					ste,pins = "mmcsd_a_1";
+				};
+			};
+			mmcsd_default_mode: mmcsd_default {
+				mmcsd_default_cfg1 {
+					/* MCCLK */
+					ste,pins = "GPIO8_B10";
+					ste,output = <0>;
+				};
+				mmcsd_default_cfg2 {
+					/* MCCMDDIR, MCDAT0DIR, MCDAT31DIR */
+					ste,pins = "GPIO10_C11", "GPIO15_A12",
+					"GPIO16_C13";
+					ste,output = <1>;
+				};
+				mmcsd_default_cfg3 {
+					/* MCCMD, MCDAT3-0, MCMSFBCLK */
+					ste,pins = "GPIO9_A10", "GPIO11_B11",
+					"GPIO12_A11", "GPIO13_C12",
+					"GPIO14_B12", "GPIO24_C15";
+					ste,input = <1>;
+				};
+			};
+		};
+		i2c0 {
+			i2c0_default_mode: i2c0_default {
+				i2c0_default_cfg {
+					ste,pins = "GPIO62_D3", "GPIO63_D2";
+					ste,input = <1>;
+				};
+			};
+		};
+		i2c1 {
+			i2c1_default_mode: i2c1_default {
+				i2c1_default_cfg {
+					ste,pins = "GPIO53_L4", "GPIO54_L3";
+					ste,input = <1>;
+				};
+			};
+		};
+		i2c2 {
+			i2c2_default_mode: i2c2_default {
+				i2c2_default_cfg {
+					ste,pins = "GPIO73_C21", "GPIO74_C20";
+					ste,input = <1>;
+				};
+			};
+		};
 	};
 
 	src: src at 101e0000 {
@@ -191,6 +260,8 @@
 			<&gpio1 30 0>; /* scl */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c0_default_mode>;
 
 		stw4811 at 2d {
 			   compatible = "st,stw4811";
@@ -205,6 +276,8 @@
 			<&gpio1 21 0>; /* scl */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c1_default_mode>;
 
 		camera at 2d {
 			   compatible = "st,camera";
@@ -227,6 +300,9 @@
 			<&gpio2 9 0>; /* scl */
 		#address-cells = <1>;
 		#size-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2c2_default_mode>;
+
 		stw4811 at 2d {
 			   compatible = "st,stw4811-usb";
 			   reg = <0x2d>;
@@ -260,6 +336,8 @@
 			interrupts = <12>;
 			clocks = <&clk48>, <&pclk>;
 			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_default_mux>;
 		};
 
 		uart1: uart at 101fb000 {
@@ -269,6 +347,8 @@
 			interrupts = <17>;
 			clocks = <&clk48>, <&pclk>;
 			clock-names = "uartclk", "apb_pclk";
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart1_default_mux>;
 		};
 
 		uart2: uart at 101f2000 {
@@ -310,6 +390,8 @@
 			mmc-cap-sd-highspeed;
 			cd-gpios = <&gpio3 15 0x1>;
 			cd-inverted;
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmcsd_default_mux>, <&mmcsd_default_mode>;
 		};
 	};
 };
diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 8351617..89e2c03 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -27,8 +27,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/irqchip.h>
 #include <linux/platform_data/clk-nomadik.h>
-#include <linux/platform_data/pinctrl-nomadik.h>
-#include <linux/pinctrl/machine.h>
 #include <linux/clocksource.h>
 #include <linux/of_irq.h>
 #include <linux/of_gpio.h>
@@ -91,52 +89,6 @@
 #define NOMADIK_L2CC_BASE	0x10210000	/* L2 Cache controller */
 #define NOMADIK_UART1_VBASE	0xF01FB000
 
-static unsigned long out_low[] = { PIN_OUTPUT_LOW };
-static unsigned long out_high[] = { PIN_OUTPUT_HIGH };
-static unsigned long in_nopull[] = { PIN_INPUT_NOPULL };
-static unsigned long in_pullup[] = { PIN_INPUT_PULLUP };
-
-static struct pinctrl_map __initdata nhk8815_pinmap[] = {
-	PIN_MAP_MUX_GROUP_DEFAULT("uart0", "pinctrl-stn8815", "u0_a_1", "u0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("uart1", "pinctrl-stn8815", "u1_a_1", "u1"),
-	/* User LED on S8815 */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO2_C5", out_high),
-	/* User button on S8815 */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO3_A4", in_nopull),
-	/* Hog in MMC/SD card mux */
-	PIN_MAP_MUX_GROUP_HOG_DEFAULT("pinctrl-stn8815", "mmcsd_a_1", "mmcsd"),
-	/* MCCLK */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO8_B10", out_low),
-	/* MCCMD */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO9_A10", in_pullup),
-	/* MCCMDDIR */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO10_C11", out_high),
-	/* MCDAT3-0 */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO11_B11", in_pullup),
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO12_A11", in_pullup),
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO13_C12", in_pullup),
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO14_B12", in_pullup),
-	/* MCDAT0DIR */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO15_A12", out_high),
-	/* MCDAT31DIR */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO16_C13", out_high),
-	/* MCMSFBCLK */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO24_C15", in_pullup),
-	/* CD input GPIO */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO111_H21", in_nopull),
-	/* CD bias drive */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO112_J21", out_low),
-	/* I2C0 */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO62_D3", in_pullup),
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO63_D2", in_pullup),
-	/* I2C1 */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO53_L4", in_pullup),
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO54_L3", in_pullup),
-	/* I2C2 */
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO73_C21", in_pullup),
-	PIN_MAP_CONFIGS_PIN_HOG_DEFAULT("pinctrl-stn8815", "GPIO74_C20", in_pullup),
-};
-
 /* This is needed for LL-debug/earlyprintk/debug-macro.S */
 static struct map_desc cpu8815_io_desc[] __initdata = {
 	{
@@ -284,8 +236,6 @@ device_initcall(cpu8815_mmcsd_init);
 
 /* These are mostly to get the right device names for the clock lookups */
 static struct of_dev_auxdata cpu8815_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("stericsson,nmk-pinctrl-stn8815", 0,
-		"pinctrl-stn8815", NULL),
 	OF_DEV_AUXDATA("stericsson,fsmc-nand", NOMADIK_FSMC_BASE,
 		NULL, &cpu8815_nand_data),
 	OF_DEV_AUXDATA("arm,primecell", NOMADIK_SDI_BASE,
@@ -299,7 +249,6 @@ static void __init cpu8815_init_of(void)
 	/* At full speed latency must be >=2, so 0x249 in low bits */
 	l2x0_of_init(0x00730249, 0xfe000fff);
 #endif
-	pinctrl_register_mappings(nhk8815_pinmap, ARRAY_SIZE(nhk8815_pinmap));
 	of_platform_populate(NULL, of_default_bus_match_table,
 			cpu8815_auxdata_lookup, NULL);
 }
-- 
1.8.1.4
