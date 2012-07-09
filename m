From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jul 2012 14:14:54 +0800
Subject: [PATCH 5/7] ARM: mxs: convert tx28 board to device tree
In-Reply-To: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1341814496-17487-6-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function tx28_init is basically a rewriting of tx28_add_fec0.  All
those TX28_FEC_* gpio definitions are meant to be used as a temporary
solution before we get a generic way to set up board specific gpio
pins when booting from device tree.

Cc: Lothar Wa?mann <LW@KARO-electronics.de>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx28.dtsi |   36 +++++++++++++
 arch/arm/boot/dts/tx28.dts   |  112 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mxs/mach-mxs.c |   48 +++++++++++++++++-
 3 files changed, 195 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/tx28.dts

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 73578cb..518236b 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -186,6 +186,19 @@
 					fsl,pull-up = <0>;
 				};
 
+				duart_4pins_a: duart-4pins at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x3022 /* MX28_PAD_AUART0_CTS__DUART_RX */
+						0x3032 /* MX28_PAD_AUART0_RTS__DUART_TX */
+						0x3002 /* MX28_PAD_AUART0_RX__DUART_CTS */
+						0x3012 /* MX28_PAD_AUART0_TX__DUART_RTS */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				gpmi_pins_a: gpmi-nand at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
@@ -243,6 +256,19 @@
 					fsl,pull-up = <0>;
 				};
 
+				auart1_pins_a: auart1 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x3040 /* MX28_PAD_AUART1_RX__AUART1_RX */
+						0x3050 /* MX28_PAD_AUART1_TX__AUART1_TX */
+						0x3060 /* MX28_PAD_AUART1_CTS__AUART1_CTS */
+						0x3070 /* MX28_PAD_AUART1_RTS__AUART1_RTS */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				auart1_2pins_a: auart1-2pins at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
@@ -407,6 +433,16 @@
 					fsl,pull-up = <1>;
 				};
 
+				pwm0_pins_a: pwm0 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x3100 /* MX28_PAD_PWM0__PWM_0 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				pwm2_pins_a: pwm2 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
diff --git a/arch/arm/boot/dts/tx28.dts b/arch/arm/boot/dts/tx28.dts
new file mode 100644
index 0000000..2737c79
--- /dev/null
+++ b/arch/arm/boot/dts/tx28.dts
@@ -0,0 +1,112 @@
+/dts-v1/;
+/include/ "imx28.dtsi"
+
+/ {
+	model = "Ka-Ro electronics TX28 module";
+	compatible = "karo,tx28", "fsl,imx28";
+
+	memory {
+		reg = <0x40000000 0x08000000>;
+	};
+
+	apb at 80000000 {
+		apbh at 80000000 {
+			ssp0: ssp at 80010000 {
+				compatible = "fsl,imx28-mmc";
+				pinctrl-names = "default";
+				pinctrl-0 = <&mmc0_4bit_pins_a
+					     &mmc0_cd_cfg
+					     &mmc0_sck_cfg>;
+				bus-width = <4>;
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
+						0x31d3 /* MX28_PAD_PWM4__GPIO_3_29 */
+						0x4053 /* MX28_PAD_ENET0_TX_CLK__GPIO_4_5 */
+						0x40a3 /* MX28_PAD_ENET0_RXD3__GPIO_4_10 */
+						0x40d3 /* MX28_PAD_ENET0_RX_CLK__GPIO_4_13 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				hog_pins_b: hog-gpios-pull at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <
+						0x4023 /* MX28_PAD_ENET0_RX_EN__GPIO_4_2 */
+						0x4033 /* MX28_PAD_ENET0_RXD0__GPIO_4_3 */
+						0x4043 /* MX28_PAD_ENET0_RXD1__GPIO_4_4 */
+					>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+			};
+		};
+
+		apbx at 80040000 {
+			i2c0: i2c at 80058000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&i2c0_pins_a>;
+				status = "okay";
+
+				ds1339: rtc at 68 {
+					compatible = "mxim,ds1339";
+					reg = <0x68>;
+				};
+			};
+
+			pwm: pwm at 80064000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&pwm0_pins_a>;
+				status = "okay";
+			};
+
+			duart: serial at 80074000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&duart_4pins_a>;
+				status = "okay";
+			};
+
+			auart1: serial at 8006c000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&auart1_pins_a>;
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
+			status = "okay";
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		user {
+			label = "Heartbeat";
+			gpios = <&gpio4 10 0>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm 0 5000000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
+};
diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index 646bac5..e081666 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -12,8 +12,9 @@
 
 #include <linux/clk.h>
 #include <linux/clkdev.h>
+#include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/init.h>
+#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/irqdomain.h>
 #include <linux/micrel_phy.h>
@@ -24,6 +25,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
 #include <mach/common.h>
+#include <mach/mxs.h>
 
 static struct fb_videomode mx23evk_video_modes[] = {
 	{
@@ -250,6 +252,47 @@ static void __init apx4devkit_init(void)
 					   apx4devkit_phy_fixup);
 }
 
+#define TX28_FEC_PHY_POWER	MXS_GPIO_NR(3, 29)
+#define TX28_FEC_PHY_RESET	MXS_GPIO_NR(4, 13)
+#define TX28_FEC_MODE_1		MXS_GPIO_NR(4, 2)
+#define TX28_FEC_MODE_2		MXS_GPIO_NR(4, 3)
+#define TX28_FEC_MODE_3		MXS_GPIO_NR(4, 4)
+#define TX28_FEC_nINT		MXS_GPIO_NR(4, 5)
+
+static const struct gpio tx28_gpios[] __initconst = {
+	{ TX28_FEC_PHY_POWER, GPIOF_OUT_INIT_LOW, "fec-phy-power" },
+	{ TX28_FEC_PHY_RESET, GPIOF_OUT_INIT_LOW, "fec-phy-reset" },
+	{ TX28_FEC_MODE_1, GPIOF_OUT_INIT_LOW, "fec-mode-1" },
+	{ TX28_FEC_MODE_2, GPIOF_OUT_INIT_LOW, "fec-mode-2" },
+	{ TX28_FEC_MODE_3, GPIOF_OUT_INIT_LOW, "fec-mode-3" },
+	{ TX28_FEC_nINT, GPIOF_DIR_IN, "fec-int" },
+};
+
+static void __init tx28_init(void)
+{
+	int ret;
+
+	ret = gpio_request_array(tx28_gpios, ARRAY_SIZE(tx28_gpios));
+	if (ret) {
+		pr_err("%s: failed to request gpios: %d\n", __func__, ret);
+		return;
+	}
+
+	/* Power up fec phy */
+	gpio_set_value(TX28_FEC_PHY_POWER, 1);
+	mdelay(26); /* 25ms according to data sheet */
+
+	/* Mode strap pins */
+	gpio_set_value(TX28_FEC_MODE_1, 1);
+	gpio_set_value(TX28_FEC_MODE_2, 1);
+	gpio_set_value(TX28_FEC_MODE_3, 1);
+
+	udelay(100); /* minimum assertion time for nRST */
+
+	/* Deasserting FEC PHY RESET */
+	gpio_set_value(TX28_FEC_PHY_RESET, 1);
+}
+
 static void __init mxs_machine_init(void)
 {
 	if (of_machine_is_compatible("fsl,imx28-evk"))
@@ -260,6 +303,8 @@ static void __init mxs_machine_init(void)
 		m28evk_init();
 	else if (of_machine_is_compatible("bluegiga,apx4devkit"))
 		apx4devkit_init();
+	else if (of_machine_is_compatible("karo,tx28"))
+		tx28_init();
 
 	of_platform_populate(NULL, of_default_bus_match_table,
 			     mxs_auxdata_lookup, NULL);
@@ -277,6 +322,7 @@ static const char *imx28_dt_compat[] __initdata = {
 	"crystalfontz,cfa10036",
 	"denx,m28evk",
 	"fsl,imx28-evk",
+	"karo,tx28",
 	"fsl,imx28",
 	NULL,
 };
-- 
1.7.5.4
