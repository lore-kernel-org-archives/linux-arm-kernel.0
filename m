From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 20 Sep 2010 14:55:33 +0200
Subject: [PATCHv2 3/7] ARM: S5PC110: add support for S6E63M0 LCD controller on
	Goni board
In-Reply-To: <1284987337-15365-1-git-send-email-m.szyprowski@samsung.com>
References: <1284987337-15365-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1284987337-15365-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add required platform definitions for S6E63M0 LCD controller on Samsung
Goni board.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/mach-goni.c |   71 +++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index b0ae208..b263f3a 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -16,6 +16,9 @@
 #include <linux/i2c.h>
 #include <linux/i2c-gpio.h>
 #include <linux/mfd/max8998.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_gpio.h>
+#include <linux/lcd.h>
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
@@ -111,6 +114,70 @@ static struct s3c_fb_platdata goni_lcd_pdata __initdata = {
 	.setup_gpio	= s5pv210_fb_gpio_setup_24bpp,
 };
 
+static int lcd_power_on(struct lcd_device *ld, int enable)
+{
+	return 1;
+}
+
+static int reset_lcd(struct lcd_device *ld)
+{
+	static unsigned int first = 1;
+	int reset_gpio = -1;
+
+	reset_gpio = S5PV210_MP05(5);
+
+	if (first) {
+		gpio_request(reset_gpio, "MLCD_RST");
+		first = 0;
+	}
+
+	gpio_direction_output(reset_gpio, 1);
+	return 1;
+}
+
+static struct lcd_platform_data s6e63m0_platform_data = {
+	.reset			= reset_lcd,
+	.power_on		= lcd_power_on,
+	.lcd_enabled		= 0,
+
+	.reset_delay		= 120,	/* 120ms */
+	.power_on_delay		= 25,	/* 25ms */
+	.power_off_delay	= 200,	/* 200ms */
+};
+
+#define LCD_BUS_NUM	3
+#define DISPLAY_CS	S5PV210_MP01(1)
+static struct spi_board_info spi_board_info[] __initdata = {
+	{
+		.modalias	= "s6e63m0",
+		.platform_data	= (void *)&s6e63m0_platform_data,
+		.max_speed_hz	= 1200000,
+		.bus_num	= LCD_BUS_NUM,
+		.chip_select	= 0,
+		.mode		= SPI_MODE_3,
+		.controller_data = (void *)DISPLAY_CS,
+	},
+};
+
+#define DISPLAY_CLK	S5PV210_MP04(1)
+#define DISPLAY_SI	S5PV210_MP04(3)
+static struct spi_gpio_platform_data lcd_spi_gpio_data = {
+	.sck	= DISPLAY_CLK,
+	.mosi	= DISPLAY_SI,
+	.miso	= SPI_GPIO_NO_MISO,
+
+	.num_chipselect	= 1,
+};
+
+static struct platform_device goni_spi_gpio = {
+	.name	= "spi_gpio",
+	.id	= LCD_BUS_NUM,
+	.dev	= {
+		.parent		= &s3c_device_fb.dev,
+		.platform_data	= &lcd_spi_gpio_data,
+	},
+};
+
 /* KEYPAD */
 static uint32_t keymap[] __initdata = {
 	/* KEY(row, col, keycode) */
@@ -479,6 +546,7 @@ static void goni_setup_sdhci(void)
 static struct platform_device *goni_devices[] __initdata = {
 	&s3c_device_fb,
 	&s5p_device_onenand,
+	&goni_spi_gpio,
 	&goni_i2c_gpio_pmic,
 	&goni_device_gpiokeys,
 	&s5p_device_fimc0,
@@ -509,6 +577,9 @@ static void __init goni_machine_init(void)
 	/* FB */
 	s3c_fb_set_platdata(&goni_lcd_pdata);
 
+	/* SPI */
+	spi_register_board_info(spi_board_info, ARRAY_SIZE(spi_board_info));
+
 	/* KEYPAD */
 	samsung_keypad_set_platdata(&keypad_data);
 
-- 
1.7.1.569.g6f426
