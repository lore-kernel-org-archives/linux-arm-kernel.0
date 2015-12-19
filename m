From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun, 20 Dec 2015 01:32:12 +0200
Subject: [PATCH 3/3] arm: lpc32xx: remove direct control of GPIOs from shared
 mach file
In-Reply-To: <1450567932-22994-1-git-send-email-vz@mleia.com>
References: <1450567932-22994-1-git-send-email-vz@mleia.com>
Message-ID: <1450567932-22994-4-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change removes GPIO configuration and control of LCD, backlight
and SD voltage regulators from the shared among all LPC32xx boards
mach file, Phytec PHY3250 board should have the description of these
regulators in its DTS file.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-lpc32xx/phy3250.c | 52 -----------------------------------------
 1 file changed, 52 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 77d6b1b..0bdfa08 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -36,7 +36,6 @@
 #include <linux/clk.h>
 #include <linux/mtd/lpc32xx_slc.h>
 #include <linux/mtd/lpc32xx_mlc.h>
-#include <linux/platform_data/gpio-lpc32xx.h>
 
 #include <asm/setup.h>
 #include <asm/mach-types.h>
@@ -48,13 +47,6 @@
 #include "common.h"
 
 /*
- * Mapped GPIOLIB GPIOs
- */
-#define LCD_POWER_GPIO		LPC32XX_GPIO(LPC32XX_GPO_P3_GRP, 0)
-#define BKL_POWER_GPIO		LPC32XX_GPIO(LPC32XX_GPO_P3_GRP, 4)
-#define MMC_PWR_ENABLE_GPIO	LPC32XX_GPIO(LPC32XX_GPO_P3_GRP, 5)
-
-/*
  * AMBA LCD controller
  */
 static struct clcd_panel conn_lcd_panel = {
@@ -97,20 +89,6 @@ static int lpc32xx_clcd_setup(struct clcd_fb *fb)
 	fb->fb.fix.smem_len = PANEL_SIZE;
 	fb->panel = &conn_lcd_panel;
 
-	if (gpio_request(LCD_POWER_GPIO, "LCD power"))
-		printk(KERN_ERR "Error requesting gpio %u",
-			LCD_POWER_GPIO);
-	else if (gpio_direction_output(LCD_POWER_GPIO, 1))
-		printk(KERN_ERR "Error setting gpio %u to output",
-			LCD_POWER_GPIO);
-
-	if (gpio_request(BKL_POWER_GPIO, "LCD backlight power"))
-		printk(KERN_ERR "Error requesting gpio %u",
-			BKL_POWER_GPIO);
-	else if (gpio_direction_output(BKL_POWER_GPIO, 1))
-		printk(KERN_ERR "Error setting gpio %u to output",
-			BKL_POWER_GPIO);
-
 	return 0;
 }
 
@@ -127,29 +105,10 @@ static void lpc32xx_clcd_remove(struct clcd_fb *fb)
 		fb->fb.screen_base, fb->fb.fix.smem_start);
 }
 
-/*
- * On some early LCD modules (1307.0), the backlight logic is inverted.
- * For those board variants, swap the disable and enable states for
- * BKL_POWER_GPIO.
-*/
-static void clcd_disable(struct clcd_fb *fb)
-{
-	gpio_set_value(BKL_POWER_GPIO, 0);
-	gpio_set_value(LCD_POWER_GPIO, 0);
-}
-
-static void clcd_enable(struct clcd_fb *fb)
-{
-	gpio_set_value(BKL_POWER_GPIO, 1);
-	gpio_set_value(LCD_POWER_GPIO, 1);
-}
-
 static struct clcd_board lpc32xx_clcd_data = {
 	.name		= "Phytec LCD",
 	.check		= clcdfb_check,
 	.decode		= clcdfb_decode,
-	.disable	= clcd_disable,
-	.enable		= clcd_enable,
 	.setup		= lpc32xx_clcd_setup,
 	.mmap		= lpc32xx_clcd_mmap,
 	.remove		= lpc32xx_clcd_remove,
@@ -188,20 +147,9 @@ static struct pl08x_platform_data pl08x_pd = {
 	.mem_buses = PL08X_AHB1,
 };
 
-static int mmc_handle_ios(struct device *dev, struct mmc_ios *ios)
-{
-	/* Only on and off are supported */
-	if (ios->power_mode == MMC_POWER_OFF)
-		gpio_set_value(MMC_PWR_ENABLE_GPIO, 0);
-	else
-		gpio_set_value(MMC_PWR_ENABLE_GPIO, 1);
-	return 0;
-}
-
 static struct mmci_platform_data lpc32xx_mmci_data = {
 	.ocr_mask	= MMC_VDD_30_31 | MMC_VDD_31_32 |
 			  MMC_VDD_32_33 | MMC_VDD_33_34,
-	.ios_handler	= mmc_handle_ios,
 };
 
 static struct lpc32xx_slc_platform_data lpc32xx_slc_data = {
-- 
2.1.4
