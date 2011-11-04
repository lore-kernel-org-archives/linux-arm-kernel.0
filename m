From: b39297@freescale.com (wu guoxing)
Date: Fri, 4 Nov 2011 18:13:52 +0800
Subject: [PATCH v3] ARM : mx35: 3ds-board: add framebuffer device
Message-ID: <1320401632-21444-1-git-send-email-b39297@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds framebuffer support for freescale mx35 3ds board

Signed-off-by: Wu Guoxing <b39297@freescale.com>
---
Changes since v2:
	1. use gpio_set_value_cansleep instead of gpio_set_value
Changes since v1:
	1. use gpio driver for mc9s08dz60

 arch/arm/mach-imx/mach-mx35_3ds.c |  113 +++++++++++++++++++++++++++++++++++++
 1 files changed, 113 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx35_3ds.c b/arch/arm/mach-imx/mach-mx35_3ds.c
index 5a5eb3e..fa19c0d 100644
--- a/arch/arm/mach-imx/mach-mx35_3ds.c
+++ b/arch/arm/mach-imx/mach-mx35_3ds.c
@@ -40,9 +40,86 @@
 #include <mach/iomux-mx35.h>
 #include <mach/irqs.h>
 #include <mach/3ds_debugboard.h>
+#include <video/platform_lcd.h>
 
 #include "devices-imx35.h"
 
+static const struct fb_videomode fb_modedb[] = {
+	{
+	 /* 800x480 @ 55 Hz */
+	 .name = "Ceramate-CLAA070VC01",
+	 .refresh = 55,
+	 .xres = 800,
+	 .yres = 480,
+	 .pixclock = 40000,
+	 .left_margin = 40,
+	 .right_margin = 40,
+	 .upper_margin = 5,
+	 .lower_margin = 5,
+	 .hsync_len = 20,
+	 .vsync_len = 10,
+	 .sync = FB_SYNC_OE_ACT_HIGH,
+	 .vmode = FB_VMODE_NONINTERLACED,
+	 .flag = 0,
+	 },
+};
+
+static const struct ipu_platform_data mx3_ipu_data __initconst = {
+	.irq_base = MXC_IPU_IRQ_START,
+};
+
+static struct mx3fb_platform_data mx3fb_pdata __initdata = {
+	.name = "Ceramate-CLAA070VC01",
+	.mode = fb_modedb,
+	.num_modes = ARRAY_SIZE(fb_modedb),
+};
+
+static struct i2c_board_info __initdata i2c_devices_3ds[] = {
+	{
+		I2C_BOARD_INFO("mc9s08dz60", 0x69),
+	},
+};
+
+static int mc9s08dz60_gpiochip_match(struct gpio_chip *chip,
+						     void *data)
+{
+	return !strcmp(chip->label, data);
+}
+
+static int mc9s08dz60_lcd_gpio_get(void)
+{
+	int ret;
+	struct gpio_chip *chip;
+	chip = gpiochip_find(
+			"mc9s08dz60", mc9s08dz60_gpiochip_match);
+	if (chip)
+		ret = chip->base + 6;
+	else {
+		pr_err("didn't find mc9s08dz60 gpio\n");
+		ret = -1;
+	}
+
+	return ret;
+}
+
+static void mx35_3ds_lcd_set_power(struct plat_lcd_data *pd, unsigned int power)
+{
+	int gpio;
+
+	gpio = mc9s08dz60_lcd_gpio_get();
+	if (gpio >= 0)
+		gpio_set_value_cansleep(gpio, power);
+}
+
+static struct plat_lcd_data mx35_3ds_lcd_data = {
+	.set_power = mx35_3ds_lcd_set_power,
+};
+
+static struct platform_device mx35_3ds_lcd = {
+	.name = "platform-lcd",
+	.dev.platform_data = &mx35_3ds_lcd_data,
+};
+
 #define EXPIO_PARENT_INT	gpio_to_irq(IMX_GPIO_NR(1, 1))
 
 static const struct imxuart_platform_data uart_pdata __initconst = {
@@ -120,6 +197,32 @@ static iomux_v3_cfg_t mx35pdk_pads[] = {
 	/* I2C1 */
 	MX35_PAD_I2C1_CLK__I2C1_SCL,
 	MX35_PAD_I2C1_DAT__I2C1_SDA,
+	/* Display */
+	MX35_PAD_LD0__IPU_DISPB_DAT_0,
+	MX35_PAD_LD1__IPU_DISPB_DAT_1,
+	MX35_PAD_LD2__IPU_DISPB_DAT_2,
+	MX35_PAD_LD3__IPU_DISPB_DAT_3,
+	MX35_PAD_LD4__IPU_DISPB_DAT_4,
+	MX35_PAD_LD5__IPU_DISPB_DAT_5,
+	MX35_PAD_LD6__IPU_DISPB_DAT_6,
+	MX35_PAD_LD7__IPU_DISPB_DAT_7,
+	MX35_PAD_LD8__IPU_DISPB_DAT_8,
+	MX35_PAD_LD9__IPU_DISPB_DAT_9,
+	MX35_PAD_LD10__IPU_DISPB_DAT_10,
+	MX35_PAD_LD11__IPU_DISPB_DAT_11,
+	MX35_PAD_LD12__IPU_DISPB_DAT_12,
+	MX35_PAD_LD13__IPU_DISPB_DAT_13,
+	MX35_PAD_LD14__IPU_DISPB_DAT_14,
+	MX35_PAD_LD15__IPU_DISPB_DAT_15,
+	MX35_PAD_LD16__IPU_DISPB_DAT_16,
+	MX35_PAD_LD17__IPU_DISPB_DAT_17,
+	MX35_PAD_D3_HSYNC__IPU_DISPB_D3_HSYNC,
+	MX35_PAD_D3_FPSHIFT__IPU_DISPB_D3_CLK,
+	MX35_PAD_D3_DRDY__IPU_DISPB_D3_DRDY,
+	MX35_PAD_CONTRAST__IPU_DISPB_CONTR,
+	MX35_PAD_D3_VSYNC__IPU_DISPB_D3_VSYNC,
+	MX35_PAD_D3_REV__IPU_DISPB_D3_REV,
+	MX35_PAD_D3_CLS__IPU_DISPB_D3_CLS,
 };
 
 static int mx35_3ds_otg_init(struct platform_device *pdev)
@@ -179,6 +282,8 @@ static const struct imxi2c_platform_data mx35_3ds_i2c0_data __initconst = {
  */
 static void __init mx35_3ds_init(void)
 {
+	struct platform_device *imx35_fb_pdev;
+
 	imx35_soc_init();
 
 	mxc_iomux_v3_setup_multiple_pads(mx35pdk_pads, ARRAY_SIZE(mx35pdk_pads));
@@ -204,6 +309,14 @@ static void __init mx35_3ds_init(void)
 		pr_warn("Init of the debugboard failed, all "
 				"devices on the debugboard are unusable.\n");
 	imx35_add_imx_i2c0(&mx35_3ds_i2c0_data);
+
+	i2c_register_board_info(
+		0, i2c_devices_3ds, ARRAY_SIZE(i2c_devices_3ds));
+
+	imx35_add_ipu_core(&mx3_ipu_data);
+	imx35_fb_pdev = imx35_add_mx3_sdc_fb(&mx3fb_pdata);
+	mx35_3ds_lcd.dev.parent = &imx35_fb_pdev->dev;
+	platform_device_register(&mx35_3ds_lcd);
 }
 
 static void __init mx35pdk_timer_init(void)
-- 
1.7.1
