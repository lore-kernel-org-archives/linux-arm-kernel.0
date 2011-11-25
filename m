From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Sat, 26 Nov 2011 07:09:03 +0800
Subject: [PATCH 6/7] ARM: pxa: enable pinmux mapping in zylonite
In-Reply-To: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
References: <1322262544-7854-1-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1322262544-7854-7-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove MFP operation in zylonite. Use pinmux mapping instead.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/Kconfig                 |    1 +
 arch/arm/mach-pxa/devices.c               |   15 ++
 arch/arm/mach-pxa/devices.h               |    1 +
 arch/arm/mach-pxa/include/mach/zylonite.h |    2 +
 arch/arm/mach-pxa/pxa3xx.c                |    1 +
 arch/arm/mach-pxa/zylonite.c              |    6 +
 arch/arm/mach-pxa/zylonite_pxa300.c       |  298 +++++++++++------------------
 arch/arm/mach-pxa/zylonite_pxa320.c       |  211 +++++----------------
 8 files changed, 183 insertions(+), 352 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 61d3c72..ea569ff 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -39,6 +39,7 @@ config MACH_ZYLONITE
 	bool
 	select PXA3xx
 	select HAVE_PWM
+	select PINCTRL
 
 config MACH_ZYLONITE300
 	bool "PXA3xx Development Platform (aka Zylonite) PXA300/310"
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 5bc1312..3302bed 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -946,6 +946,21 @@ struct platform_device pxa3xx_device_gcu = {
 	},
 };
 
+static struct resource pxa3xx_resources_pinmux[] = {
+	{
+		.start	= 0x40e10000,
+		.end	= 0x40e10fff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device pxa3xx_device_pinmux = {
+	.name		= "pxa3xx-pinmux",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(pxa3xx_resources_pinmux),
+	.resource	= pxa3xx_resources_pinmux,
+};
+
 #endif /* CONFIG_PXA3xx */
 
 #if defined(CONFIG_PXA3xx) || defined(CONFIG_PXA95x)
diff --git a/arch/arm/mach-pxa/devices.h b/arch/arm/mach-pxa/devices.h
index 1475db1..d440fbb 100644
--- a/arch/arm/mach-pxa/devices.h
+++ b/arch/arm/mach-pxa/devices.h
@@ -39,6 +39,7 @@ extern struct platform_device pxa3xx_device_nand;
 extern struct platform_device pxa3xx_device_i2c_power;
 
 extern struct platform_device pxa3xx_device_gcu;
+extern struct platform_device pxa3xx_device_pinmux;
 
 extern struct platform_device pxa_device_asoc_platform;
 extern struct platform_device pxa_device_asoc_ssp1;
diff --git a/arch/arm/mach-pxa/include/mach/zylonite.h b/arch/arm/mach-pxa/include/mach/zylonite.h
index ecca976..70e5017 100644
--- a/arch/arm/mach-pxa/include/mach/zylonite.h
+++ b/arch/arm/mach-pxa/include/mach/zylonite.h
@@ -15,6 +15,8 @@ extern int gpio_debug_led1;
 extern int gpio_debug_led2;
 
 extern int wm9713_irq;
+extern int ac97_sdata1;
+extern int mmc1_cmd1;
 
 extern int lcd_id;
 extern int lcd_orientation;
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index 4f402af..eea2cb6 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -435,6 +435,7 @@ static struct platform_device *devices[] __initdata = {
 	&pxa3xx_device_ssp4,
 	&pxa27x_device_pwm0,
 	&pxa27x_device_pwm1,
+	&pxa3xx_device_pinmux,
 };
 
 static int __init pxa3xx_init(void)
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 98eec80..13ddba0 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -41,6 +41,8 @@ int gpio_debug_led1;
 int gpio_debug_led2;
 
 int wm9713_irq;
+int ac97_sdata1;
+int mmc1_cmd1;
 
 int lcd_id;
 int lcd_orientation;
@@ -52,6 +54,7 @@ struct platform_device pxa_device_wm9713_audio = {
 
 static void __init zylonite_init_wm9713_audio(void)
 {
+	gpio_request_one(wm9713_irq, GPIOF_DIR_IN, "wm9713 irq");
 	platform_device_register(&pxa_device_wm9713_audio);
 }
 
@@ -253,6 +256,7 @@ static struct pxamci_platform_data zylonite_mci3_platform_data = {
 
 static void __init zylonite_init_mmc(void)
 {
+	gpio_request_one(mmc1_cmd1, GPIOF_DIR_IN, "mmc1 CDM1");
 	pxa_set_mci_info(&zylonite_mci_platform_data);
 	pxa3xx_set_mci2_info(&zylonite_mci2_platform_data);
 	if (cpu_is_pxa310())
@@ -408,10 +412,12 @@ static void __init zylonite_init(void)
 	 * Note: We depend that the bootloader set
 	 * the correct value to MSC register for SMC91x.
 	 */
+	gpio_request_one(gpio_eth_irq, GPIOF_DIR_IN, "eth irq");
 	smc91x_resources[1].start = PXA_GPIO_TO_IRQ(gpio_eth_irq);
 	smc91x_resources[1].end   = PXA_GPIO_TO_IRQ(gpio_eth_irq);
 	platform_device_register(&smc91x_device);
 
+	gpio_request_one(ac97_sdata1, GPIOF_DIR_IN, "SDATA_IN_1 not used");
 	pxa_set_ac97_info(NULL);
 	zylonite_init_lcd();
 	zylonite_init_mmc();
diff --git a/arch/arm/mach-pxa/zylonite_pxa300.c b/arch/arm/mach-pxa/zylonite_pxa300.c
index 86e59c0..02ccf35 100644
--- a/arch/arm/mach-pxa/zylonite_pxa300.c
+++ b/arch/arm/mach-pxa/zylonite_pxa300.c
@@ -20,202 +20,107 @@
 #include <linux/i2c/pxa-i2c.h>
 #include <linux/i2c/pca953x.h>
 #include <linux/gpio.h>
+#include <linux/pinctrl/machine.h>
 
 #include <mach/pxa300.h>
 #include <mach/zylonite.h>
 
 #include "generic.h"
 
-/* PXA300/PXA310 common configurations */
-static mfp_cfg_t common_mfp_cfg[] __initdata = {
-	/* LCD */
-	GPIO54_LCD_LDD_0,
-	GPIO55_LCD_LDD_1,
-	GPIO56_LCD_LDD_2,
-	GPIO57_LCD_LDD_3,
-	GPIO58_LCD_LDD_4,
-	GPIO59_LCD_LDD_5,
-	GPIO60_LCD_LDD_6,
-	GPIO61_LCD_LDD_7,
-	GPIO62_LCD_LDD_8,
-	GPIO63_LCD_LDD_9,
-	GPIO64_LCD_LDD_10,
-	GPIO65_LCD_LDD_11,
-	GPIO66_LCD_LDD_12,
-	GPIO67_LCD_LDD_13,
-	GPIO68_LCD_LDD_14,
-	GPIO69_LCD_LDD_15,
-	GPIO70_LCD_LDD_16,
-	GPIO71_LCD_LDD_17,
-	GPIO72_LCD_FCLK,
-	GPIO73_LCD_LCLK,
-	GPIO74_LCD_PCLK,
-	GPIO75_LCD_BIAS,
-	GPIO76_LCD_VSYNC,
-	GPIO127_LCD_CS_N,
-	GPIO20_PWM3_OUT,	/* backlight */
-
-	/* BTUART */
-	GPIO111_UART2_RTS,
-	GPIO112_UART2_RXD | MFP_LPM_EDGE_FALL,
-	GPIO113_UART2_TXD,
-	GPIO114_UART2_CTS | MFP_LPM_EDGE_BOTH,
-
-	/* STUART */
-	GPIO109_UART3_TXD,
-	GPIO110_UART3_RXD | MFP_LPM_EDGE_FALL,
-
-	/* AC97 */
-	GPIO23_AC97_nACRESET,
-	GPIO24_AC97_SYSCLK,
-	GPIO29_AC97_BITCLK,
-	GPIO25_AC97_SDATA_IN_0,
-	GPIO27_AC97_SDATA_OUT,
-	GPIO28_AC97_SYNC,
-	GPIO17_GPIO,	/* SDATA_IN_1 but unused - configure to GPIO */
-
-	/* SSP3 */
-	GPIO91_SSP3_SCLK,
-	GPIO92_SSP3_FRM,
-	GPIO93_SSP3_TXD,
-	GPIO94_SSP3_RXD,
-
-	/* WM9713 IRQ */
-	GPIO26_GPIO,
-
-	/* Keypad */
-	GPIO107_KP_DKIN_0 | MFP_LPM_EDGE_BOTH,
-	GPIO108_KP_DKIN_1 | MFP_LPM_EDGE_BOTH,
-	GPIO115_KP_MKIN_0 | MFP_LPM_EDGE_BOTH,
-	GPIO116_KP_MKIN_1 | MFP_LPM_EDGE_BOTH,
-	GPIO117_KP_MKIN_2 | MFP_LPM_EDGE_BOTH,
-	GPIO118_KP_MKIN_3 | MFP_LPM_EDGE_BOTH,
-	GPIO119_KP_MKIN_4 | MFP_LPM_EDGE_BOTH,
-	GPIO120_KP_MKIN_5 | MFP_LPM_EDGE_BOTH,
-	GPIO2_2_KP_MKIN_6 | MFP_LPM_EDGE_BOTH,
-	GPIO3_2_KP_MKIN_7 | MFP_LPM_EDGE_BOTH,
-	GPIO121_KP_MKOUT_0,
-	GPIO122_KP_MKOUT_1,
-	GPIO123_KP_MKOUT_2,
-	GPIO124_KP_MKOUT_3,
-	GPIO125_KP_MKOUT_4,
-	GPIO4_2_KP_MKOUT_5,
-	GPIO5_2_KP_MKOUT_6,
-	GPIO6_2_KP_MKOUT_7,
-
-	/* MMC1 */
-	GPIO3_MMC1_DAT0,
-	GPIO4_MMC1_DAT1 | MFP_LPM_EDGE_BOTH,
-	GPIO5_MMC1_DAT2,
-	GPIO6_MMC1_DAT3,
-	GPIO7_MMC1_CLK,
-	GPIO8_MMC1_CMD,	/* CMD0 for slot 0 */
-	GPIO15_GPIO,	/* CMD1 default as GPIO for slot 0 */
-
-	/* MMC2 */
-	GPIO9_MMC2_DAT0,
-	GPIO10_MMC2_DAT1 | MFP_LPM_EDGE_BOTH,
-	GPIO11_MMC2_DAT2,
-	GPIO12_MMC2_DAT3,
-	GPIO13_MMC2_CLK,
-	GPIO14_MMC2_CMD,
-
-	/* USB Host */
-	GPIO0_2_USBH_PEN,
-	GPIO1_2_USBH_PWR,
-
-	/* Standard I2C */
-	GPIO21_I2C_SCL,
-	GPIO22_I2C_SDA,
-
-	/* GPIO */
-	GPIO18_GPIO | MFP_PULL_HIGH,	/* GPIO Expander #0 INT_N */
-	GPIO19_GPIO | MFP_PULL_HIGH,	/* GPIO Expander #1 INT_N */
-};
-
-static mfp_cfg_t pxa300_mfp_cfg[] __initdata = {
-	/* FFUART */
-	GPIO30_UART1_RXD | MFP_LPM_EDGE_FALL,
-	GPIO31_UART1_TXD,
-	GPIO32_UART1_CTS,
-	GPIO37_UART1_RTS,
-	GPIO33_UART1_DCD,
-	GPIO34_UART1_DSR | MFP_LPM_EDGE_FALL,
-	GPIO35_UART1_RI,
-	GPIO36_UART1_DTR,
-
-	/* Ethernet */
-	GPIO2_nCS3,
-	GPIO99_GPIO,
+#define COMMON_PINMUX_MAP()					\
+	{							\
+		.name = "uart2",				\
+		.ctrl_dev_name = "pinctrl.0",			\
+		.function = "uart2",				\
+		.dev_name = "pxa2xx-uart.2",			\
+		.group = "stuart1",				\
+		.hog_on_boot = true,				\
+	}, {							\
+		.name = "key",					\
+		.ctrl_dev_name = "pinctrl.0",			\
+		.function = "key",				\
+		.dev_name = "pxa27x-keyboard",			\
+		.group = "key0",				\
+		.hog_on_boot = true,				\
+	}, {							\
+		.name = "mmc1",					\
+		.ctrl_dev_name = "pinctrl.0",			\
+		.function = "mmc1",				\
+		.group = "mmc1_0",				\
+		.hog_on_boot = true,				\
+	},							\
+	PINMUX_MAP_PRIMARY_SYS_HOG("mmc2", "mmc2"),		\
+	PINMUX_MAP_PRIMARY_SYS_HOG("usbh", "usbh"),		\
+	PINMUX_MAP_PRIMARY_SYS_HOG("ac97", "ac97"),		\
+	PINMUX_MAP_PRIMARY_SYS_HOG("smc", "smc"),		\
+	PINMUX_MAP_PRIMARY("pwm3", "pwm3", "pxa27x-pwm.1"),	\
+	PINMUX_MAP_PRIMARY("uart1", "uart1", "pxa2xx-uart.1"),	\
+	PINMUX_MAP_PRIMARY("ssp3", "ssp3", "pxa27x-ssp.2"),	\
+	PINMUX_MAP_PRIMARY("lcd", "lcd", "pxa2xx-fb"),		\
+	PINMUX_MAP_PRIMARY("i2c", "i2c", "pxa2xx-i2c.0")
+
+static struct pinmux_map pxa300_pmx_map[] = {
+	COMMON_PINMUX_MAP(),
+	{
+		.name = "uart0",
+		.ctrl_dev_name = "pinctrl.0",
+		.function = "uart0",
+		.dev_name = "pxa2xx-uart.0",
+		.group = "ffuart0",
+	},
 };
 
-static mfp_cfg_t pxa310_mfp_cfg[] __initdata = {
-	/* FFUART */
-	GPIO99_UART1_RXD | MFP_LPM_EDGE_FALL,
-	GPIO100_UART1_TXD,
-	GPIO101_UART1_CTS,
-	GPIO106_UART1_RTS,
-
-	/* Ethernet */
-	GPIO2_nCS3,
-	GPIO102_GPIO,
-
-	/* MMC3 */
-	GPIO7_2_MMC3_DAT0,
-	GPIO8_2_MMC3_DAT1 | MFP_LPM_EDGE_BOTH,
-	GPIO9_2_MMC3_DAT2,
-	GPIO10_2_MMC3_DAT3,
-	GPIO103_MMC3_CLK,
-	GPIO105_MMC3_CMD,
+static struct pinmux_map pxa310_pmx_map[] = {
+	COMMON_PINMUX_MAP(),
+	{
+		.name = "uart0",
+		.ctrl_dev_name = "pinctrl.0",
+		.function = "uart0",
+		.dev_name = "pxa2xx-uart.0",
+		.group = "ffuart2",
+	}, {
+		.name = "mmc3",
+		.ctrl_dev_name = "pinctrl.0",
+		.function = "mmc3",
+		.group = "mmc3",
+	},
 };
 
-#define NUM_LCD_DETECT_PINS	7
-
-static int lcd_detect_pins[] __initdata = {
-	MFP_PIN_GPIO71,	/* LCD_LDD_17 - ORIENT */
-	MFP_PIN_GPIO70, /* LCD_LDD_16 - LCDID[5] */
-	MFP_PIN_GPIO75, /* LCD_BIAS   - LCDID[4] */
-	MFP_PIN_GPIO73, /* LCD_LCLK   - LCDID[3] */
-	MFP_PIN_GPIO72, /* LCD_FCLK   - LCDID[2] */
-	MFP_PIN_GPIO127,/* LCD_CS_N   - LCDID[1] */
-	MFP_PIN_GPIO76, /* LCD_VSYNC  - LCDID[0] */
+static struct gpio detect_lcd_gpios[] = {
+	{71,  GPIOF_DIR_IN, "ORIENT"},
+	{70,  GPIOF_DIR_IN, "LCDID[5]"},
+	{75,  GPIOF_DIR_IN, "LCDID[4]"},
+	{73,  GPIOF_DIR_IN, "LCDID[3]"},
+	{72,  GPIOF_DIR_IN, "LCDID[2]"},
+	{127, GPIOF_DIR_IN, "LCDID[1]"},
+	{76,  GPIOF_DIR_IN, "LCDID[0]"},
 };
 
-static void __init zylonite_detect_lcd_panel(void)
+static int __init zylonite_detect_lcd_panel(void)
 {
-	unsigned long mfpr_save[NUM_LCD_DETECT_PINS];
-	int i, gpio, id = 0;
-
-	/* save the original MFP settings of these pins and configure
-	 * them as GPIO Input, DS01X, Pull Neither, Edge Clear
-	 */
-	for (i = 0; i < NUM_LCD_DETECT_PINS; i++) {
-		mfpr_save[i] = pxa3xx_mfp_read(lcd_detect_pins[i]);
-		pxa3xx_mfp_write(lcd_detect_pins[i], 0x8440);
-	}
-
-	for (i = 0; i < NUM_LCD_DETECT_PINS; i++) {
-		id = id << 1;
-		gpio = mfp_to_gpio(lcd_detect_pins[i]);
-		gpio_request(gpio, "LCD_ID_PINS");
-		gpio_direction_input(gpio);
-
-		if (gpio_get_value(gpio))
-			id = id | 0x1;
-		gpio_free(gpio);
+	int i, ret = 0, size, id = 0;
+
+	size = ARRAY_SIZE(detect_lcd_gpios);
+	ret = gpio_request_array(detect_lcd_gpios, size);
+	if (ret < 0)
+		goto out;
+	for (i = 0; i < size; i++) {
+		id <<= 1;
+		if (gpio_get_value(detect_lcd_gpios[i].gpio))
+			id |= 1;
 	}
+	gpio_free_array(detect_lcd_gpios, size);
 
 	/* lcd id, flush out bit 1 */
 	lcd_id = id & 0x3d;
 
 	/* lcd orientation, portrait or landscape */
 	lcd_orientation = (id >> 6) & 0x1;
-
-	/* restore the original MFP settings */
-	for (i = 0; i < NUM_LCD_DETECT_PINS; i++)
-		pxa3xx_mfp_write(lcd_detect_pins[i], mfpr_save[i]);
+out:
+	return ret;
 }
 
+
 #if defined(CONFIG_I2C) || defined(CONFIG_I2C_MODULE)
 static struct pca953x_platform_data gpio_exp[] = {
 	[0] = {
@@ -240,8 +145,14 @@ static struct i2c_board_info zylonite_i2c_board_info[] = {
 	},
 };
 
+static struct gpio gpio_exp_pins[] = {
+	{18, GPIOF_DIR_IN, "gpio ex0"},
+	{19, GPIOF_DIR_IN, "gpio ex1"},
+};
+
 static void __init zylonite_init_i2c(void)
 {
+	gpio_request_array(ARRAY_AND_SIZE(gpio_exp_pins));
 	pxa_set_i2c_info(NULL);
 	i2c_register_board_info(0, ARRAY_AND_SIZE(zylonite_i2c_board_info));
 }
@@ -251,30 +162,37 @@ static inline void zylonite_init_i2c(void) {}
 
 void __init zylonite_pxa300_init(void)
 {
-	if (cpu_is_pxa300() || cpu_is_pxa310()) {
-		/* initialize MFP */
-		pxa3xx_mfp_config(ARRAY_AND_SIZE(common_mfp_cfg));
+	int ret;
+	if (cpu_is_pxa300()) {
+		ret = pinmux_register_mappings(ARRAY_AND_SIZE(pxa300_pmx_map));
+		if (ret < 0)
+			goto out;
+		gpio_eth_irq = 99;
+	}
 
-		/* detect LCD panel */
-		zylonite_detect_lcd_panel();
+	if (cpu_is_pxa310()) {
+		ret = pinmux_register_mappings(ARRAY_AND_SIZE(pxa310_pmx_map));
+		if (ret < 0)
+			goto out;
+		gpio_eth_irq = 102;
+	}
 
+	if (cpu_is_pxa300() || cpu_is_pxa310()) {
+		ret = zylonite_detect_lcd_panel();
+		if (ret < 0)
+			goto out;
 		/* WM9713 IRQ */
-		wm9713_irq = mfp_to_gpio(MFP_PIN_GPIO26);
+		wm9713_irq = 26;
+		ac97_sdata1 = 17;
+		mmc1_cmd1 = 15;
 
 		zylonite_init_i2c();
 	}
 
-	if (cpu_is_pxa300()) {
-		pxa3xx_mfp_config(ARRAY_AND_SIZE(pxa300_mfp_cfg));
-		gpio_eth_irq = mfp_to_gpio(MFP_PIN_GPIO99);
-	}
-
-	if (cpu_is_pxa310()) {
-		pxa3xx_mfp_config(ARRAY_AND_SIZE(pxa310_mfp_cfg));
-		gpio_eth_irq = mfp_to_gpio(MFP_PIN_GPIO102);
-	}
-
 	/* GPIOs for Debug LEDs */
 	gpio_debug_led1 = EXT_GPIO(25);
 	gpio_debug_led2 = EXT_GPIO(26);
+	return;
+out:
+	BUG();
 }
diff --git a/arch/arm/mach-pxa/zylonite_pxa320.c b/arch/arm/mach-pxa/zylonite_pxa320.c
index 9942bac..61a47cd 100644
--- a/arch/arm/mach-pxa/zylonite_pxa320.c
+++ b/arch/arm/mach-pxa/zylonite_pxa320.c
@@ -17,199 +17,86 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/gpio.h>
+#include <linux/pinctrl/machine.h>
 
 #include <mach/pxa320.h>
 #include <mach/zylonite.h>
 
 #include "generic.h"
 
-static mfp_cfg_t mfp_cfg[] __initdata = {
-	/* LCD */
-	GPIO6_2_LCD_LDD_0,
-	GPIO7_2_LCD_LDD_1,
-	GPIO8_2_LCD_LDD_2,
-	GPIO9_2_LCD_LDD_3,
-	GPIO10_2_LCD_LDD_4,
-	GPIO11_2_LCD_LDD_5,
-	GPIO12_2_LCD_LDD_6,
-	GPIO13_2_LCD_LDD_7,
-	GPIO63_LCD_LDD_8,
-	GPIO64_LCD_LDD_9,
-	GPIO65_LCD_LDD_10,
-	GPIO66_LCD_LDD_11,
-	GPIO67_LCD_LDD_12,
-	GPIO68_LCD_LDD_13,
-	GPIO69_LCD_LDD_14,
-	GPIO70_LCD_LDD_15,
-	GPIO71_LCD_LDD_16,
-	GPIO72_LCD_LDD_17,
-	GPIO73_LCD_CS_N,
-	GPIO74_LCD_VSYNC,
-	GPIO14_2_LCD_FCLK,
-	GPIO15_2_LCD_LCLK,
-	GPIO16_2_LCD_PCLK,
-	GPIO17_2_LCD_BIAS,
-	GPIO14_PWM3_OUT,	/* backlight */
-
-	/* FFUART */
-	GPIO41_UART1_RXD | MFP_LPM_EDGE_FALL,
-	GPIO42_UART1_TXD,
-	GPIO43_UART1_CTS,
-	GPIO44_UART1_DCD,
-	GPIO45_UART1_DSR | MFP_LPM_EDGE_FALL,
-	GPIO46_UART1_RI,
-	GPIO47_UART1_DTR,
-	GPIO48_UART1_RTS,
-
-	/* AC97 */
-	GPIO34_AC97_SYSCLK,
-	GPIO35_AC97_SDATA_IN_0,
-	GPIO37_AC97_SDATA_OUT,
-	GPIO38_AC97_SYNC,
-	GPIO39_AC97_BITCLK,
-	GPIO40_AC97_nACRESET,
-	GPIO36_GPIO,	/* SDATA_IN_1 but unused - configure to GPIO */
-
-	/* SSP3 */
-	GPIO89_SSP3_SCLK,
-	GPIO90_SSP3_FRM,
-	GPIO91_SSP3_TXD,
-	GPIO92_SSP3_RXD,
-
-	/* WM9713 IRQ */
-	GPIO15_GPIO,
-
-	/* I2C */
-	GPIO32_I2C_SCL,
-	GPIO33_I2C_SDA,
-
-	/* Keypad */
-	GPIO105_KP_DKIN_0 | MFP_LPM_EDGE_BOTH,
-	GPIO106_KP_DKIN_1 | MFP_LPM_EDGE_BOTH,
-	GPIO113_KP_MKIN_0 | MFP_LPM_EDGE_BOTH,
-	GPIO114_KP_MKIN_1 | MFP_LPM_EDGE_BOTH,
-	GPIO115_KP_MKIN_2 | MFP_LPM_EDGE_BOTH,
-	GPIO116_KP_MKIN_3 | MFP_LPM_EDGE_BOTH,
-	GPIO117_KP_MKIN_4 | MFP_LPM_EDGE_BOTH,
-	GPIO118_KP_MKIN_5 | MFP_LPM_EDGE_BOTH,
-	GPIO119_KP_MKIN_6 | MFP_LPM_EDGE_BOTH,
-	GPIO120_KP_MKIN_7 | MFP_LPM_EDGE_BOTH,
-	GPIO121_KP_MKOUT_0,
-	GPIO122_KP_MKOUT_1,
-	GPIO123_KP_MKOUT_2,
-	GPIO124_KP_MKOUT_3,
-	GPIO125_KP_MKOUT_4,
-	GPIO126_KP_MKOUT_5,
-	GPIO127_KP_MKOUT_6,
-	GPIO5_2_KP_MKOUT_7,
-
-	/* Ethernet */
-	GPIO4_nCS3,
-	GPIO90_GPIO,
-
-	/* MMC1 */
-	GPIO18_MMC1_DAT0,
-	GPIO19_MMC1_DAT1 | MFP_LPM_EDGE_BOTH,
-	GPIO20_MMC1_DAT2,
-	GPIO21_MMC1_DAT3,
-	GPIO22_MMC1_CLK,
-	GPIO23_MMC1_CMD,/* CMD0 for slot 0 */
-	GPIO31_GPIO,	/* CMD1 default as GPIO for slot 0 */
-
-	/* MMC2 */
-	GPIO24_MMC2_DAT0,
-	GPIO25_MMC2_DAT1 | MFP_LPM_EDGE_BOTH,
-	GPIO26_MMC2_DAT2,
-	GPIO27_MMC2_DAT3,
-	GPIO28_MMC2_CLK,
-	GPIO29_MMC2_CMD,
-
-	/* USB Host */
-	GPIO2_2_USBH_PEN,
-	GPIO3_2_USBH_PWR,
-
-	/* Debug LEDs */
-	GPIO1_2_GPIO | MFP_LPM_DRIVE_HIGH,
-	GPIO4_2_GPIO | MFP_LPM_DRIVE_HIGH,
+static struct pinmux_map pxa320_pmx_map[] = {
+	PINMUX_MAP_PRIMARY_SYS_HOG("mmc1", "mmc1"),
+	PINMUX_MAP_PRIMARY_SYS_HOG("mmc2", "mmc2"),
+	PINMUX_MAP_PRIMARY_SYS_HOG("usbh", "usbh"),
+	PINMUX_MAP_PRIMARY_SYS_HOG("ac97", "ac97"),
+	PINMUX_MAP_PRIMARY_SYS_HOG("smc", "smc"),
+	PINMUX_MAP_PRIMARY_SYS_HOG("usim", "usim"),
+	PINMUX_MAP_PRIMARY("lcd", "lcd", "pxa2xx-fb"),
+	PINMUX_MAP_PRIMARY("uart0", "uart0", "pxa27x-uart.0"),
+	PINMUX_MAP_PRIMARY("pwm3", "pwm3", "pxa27x-pwm.1"),
+	PINMUX_MAP_PRIMARY("ssp3", "ssp3", "pxa27x-ssp.2"),
+	PINMUX_MAP_PRIMARY("i2c", "i2c", "pxa2xx-i2c.0"),
 };
 
-#define NUM_LCD_DETECT_PINS	7
-
-static int lcd_detect_pins[] __initdata = {
-	MFP_PIN_GPIO72,   /* LCD_LDD_17 - ORIENT */
-	MFP_PIN_GPIO71,   /* LCD_LDD_16 - LCDID[5] */
-	MFP_PIN_GPIO17_2, /* LCD_BIAS   - LCDID[4] */
-	MFP_PIN_GPIO15_2, /* LCD_LCLK   - LCDID[3] */
-	MFP_PIN_GPIO14_2, /* LCD_FCLK   - LCDID[2] */
-	MFP_PIN_GPIO73,   /* LCD_CS_N   - LCDID[1] */
-	MFP_PIN_GPIO74,   /* LCD_VSYNC  - LCDID[0] */
-	/*
-	 * set the MFP_PIN_GPIO 14/15/17 to alternate function other than
-	 * GPIO to avoid input level confliction with 14_2, 15_2, 17_2
-	 */
-	MFP_PIN_GPIO14,
-	MFP_PIN_GPIO15,
-	MFP_PIN_GPIO17,
+static struct gpio detect_lcd_gpios[] = {
+	{72,  GPIOF_DIR_IN, "ORIENT"},
+	{71,  GPIOF_DIR_IN, "LCDID[5]"},
+	{145, GPIOF_DIR_IN, "LCDID[4]"},
+	{143, GPIOF_DIR_IN, "LCDID[3]"},
+	{142, GPIOF_DIR_IN, "LCDID[2]"},
+	{73,  GPIOF_DIR_IN, "LCDID[1]"},
+	{74,  GPIOF_DIR_IN, "LCDID[0]"},
 };
 
-static int lcd_detect_mfpr[] __initdata = {
-	/* AF0, DS 1X, Pull Neither, Edge Clear */
-	0x8440, 0x8440, 0x8440, 0x8440, 0x8440, 0x8440, 0x8440,
-	0xc442, /* Backlight, Pull-Up, AF2 */
-	0x8445, /* AF5 */
-	0x8445, /* AF5 */
-};
-
-static void __init zylonite_detect_lcd_panel(void)
+static int __init zylonite_detect_lcd_panel(void)
 {
-	unsigned long mfpr_save[ARRAY_SIZE(lcd_detect_pins)];
-	int i, gpio, id = 0;
-
-	/* save the original MFP settings of these pins and configure them
-	 * as GPIO Input, DS01X, Pull Neither, Edge Clear
-	 */
-	for (i = 0; i < ARRAY_SIZE(lcd_detect_pins); i++) {
-		mfpr_save[i] = pxa3xx_mfp_read(lcd_detect_pins[i]);
-		pxa3xx_mfp_write(lcd_detect_pins[i], lcd_detect_mfpr[i]);
-	}
-
-	for (i = 0; i < NUM_LCD_DETECT_PINS; i++) {
-		id = id << 1;
-		gpio = mfp_to_gpio(lcd_detect_pins[i]);
-		gpio_request(gpio, "LCD_ID_PINS");
-		gpio_direction_input(gpio);
-
-		if (gpio_get_value(gpio))
-			id = id | 0x1;
-		gpio_free(gpio);
+	int i, ret = 0, size, id = 0;
+
+	size = ARRAY_SIZE(detect_lcd_gpios);
+	ret = gpio_request_array(detect_lcd_gpios, size);
+	if (ret < 0)
+		goto out;
+	for (i = 0; i < size; i++) {
+		id <<= 1;
+		if (gpio_get_value(detect_lcd_gpios[i].gpio))
+			id |= 1;
 	}
+	gpio_free_array(detect_lcd_gpios, size);
 
 	/* lcd id, flush out bit 1 */
 	lcd_id = id & 0x3d;
 
 	/* lcd orientation, portrait or landscape */
 	lcd_orientation = (id >> 6) & 0x1;
-
-	/* restore the original MFP settings */
-	for (i = 0; i < ARRAY_SIZE(lcd_detect_pins); i++)
-		pxa3xx_mfp_write(lcd_detect_pins[i], mfpr_save[i]);
+out:
+	return ret;
 }
 
 void __init zylonite_pxa320_init(void)
 {
+	int ret;
 	if (cpu_is_pxa320()) {
-		/* initialize MFP */
-		pxa3xx_mfp_config(ARRAY_AND_SIZE(mfp_cfg));
+		ret = pinmux_register_mappings(ARRAY_AND_SIZE(pxa320_pmx_map));
+		if (ret < 0)
+			goto out;
 
 		/* detect LCD panel */
 		zylonite_detect_lcd_panel();
 
 		/* GPIO pin assignment */
-		gpio_eth_irq	= mfp_to_gpio(MFP_PIN_GPIO9);
+		gpio_eth_irq	= 90;
+#if 0
+		/* FIXME: can't support additional gpio pins */
 		gpio_debug_led1	= mfp_to_gpio(MFP_PIN_GPIO1_2);
 		gpio_debug_led2	= mfp_to_gpio(MFP_PIN_GPIO4_2);
+#endif
 
 		/* WM9713 IRQ */
-		wm9713_irq = mfp_to_gpio(MFP_PIN_GPIO15);
+		wm9713_irq = 15;
+		ac97_sdata1 = 36;
+		mmc1_cmd1 = 31;
 	}
+	return;
+out:
+	BUG();
 }
-- 
1.7.0.4
