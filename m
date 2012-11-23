From: p.paneri@samsung.com (Praveen Paneri)
Date: Fri, 23 Nov 2012 18:02:31 +0530
Subject: [PATCH v9 2/3] ARM: S3C64XX: Removing old phy setup code
In-Reply-To: <1353673952-13537-1-git-send-email-p.paneri@samsung.com>
References: <1353673952-13537-1-git-send-email-p.paneri@samsung.com>
Message-ID: <1353673952-13537-3-git-send-email-p.paneri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes old phy code from platform side. 'setup-usb-phy.c'
will be used for providing transceiver platform data in next
patch. Not all of the platform data code is removed as there are others
making use of platform_data defined for hsotg. That can be removed once
all the SoCs start using the new transceiver for usb phy setup.

Signed-off-by: Praveen Paneri <p.paneri@samsung.com>
---
 arch/arm/mach-s3c64xx/mach-crag6410.c |    3 -
 arch/arm/mach-s3c64xx/mach-smartq.c   |    3 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c |    3 -
 arch/arm/mach-s3c64xx/setup-usb-phy.c |   78 +-------------------------------
 arch/arm/plat-samsung/devs.c          |    2 +
 5 files changed, 5 insertions(+), 84 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/mach-crag6410.c b/arch/arm/mach-s3c64xx/mach-crag6410.c
index 270529e..caee50c 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410.c
@@ -31,7 +31,6 @@
 #include <linux/spi/spi.h>
 
 #include <linux/i2c/pca953x.h>
-#include <linux/platform_data/s3c-hsotg.h>
 
 #include <video/platform_lcd.h>
 
@@ -807,7 +806,6 @@ static const struct gpio_led_platform_data gpio_leds_pdata = {
 	.num_leds = ARRAY_SIZE(gpio_leds),
 };
 
-static struct s3c_hsotg_plat crag6410_hsotg_pdata;
 
 static void __init crag6410_machine_init(void)
 {
@@ -834,7 +832,6 @@ static void __init crag6410_machine_init(void)
 	s3c_i2c1_set_platdata(&i2c1_pdata);
 	s3c_fb_set_platdata(&crag6410_lcd_pdata);
 	samsung_usbphy_set_pdata(&s3c_usbphy_pdata);
-	s3c_hsotg_set_platdata(&crag6410_hsotg_pdata);
 
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
index 2f815f4..6285139 100644
--- a/arch/arm/mach-s3c64xx/mach-smartq.c
+++ b/arch/arm/mach-s3c64xx/mach-smartq.c
@@ -18,7 +18,6 @@
 #include <linux/serial_core.h>
 #include <linux/spi/spi_gpio.h>
 #include <linux/usb/gpio_vbus.h>
-#include <linux/platform_data/s3c-hsotg.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/map.h>
@@ -188,7 +187,6 @@ static struct s3c_hwmon_pdata smartq_hwmon_pdata __initdata = {
 	},
 };
 
-static struct s3c_hsotg_plat smartq_hsotg_pdata;
 
 static int __init smartq_lcd_setup_gpio(void)
 {
@@ -387,7 +385,6 @@ void __init smartq_map_io(void)
 void __init smartq_machine_init(void)
 {
 	s3c_i2c0_set_platdata(NULL);
-	s3c_hsotg_set_platdata(&smartq_hsotg_pdata);
 	s3c_hwmon_set_platdata(&smartq_hwmon_pdata);
 	s3c_sdhci1_set_platdata(&smartq_internal_hsmmc_pdata);
 	s3c_sdhci2_set_platdata(&smartq_internal_hsmmc_pdata);
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index 6575e11..d64f444 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -30,7 +30,6 @@
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/pwm_backlight.h>
-#include <linux/platform_data/s3c-hsotg.h>
 
 #ifdef CONFIG_SMDK6410_WM1190_EV1
 #include <linux/mfd/wm8350/core.h>
@@ -629,7 +628,6 @@ static struct platform_pwm_backlight_data smdk6410_bl_data = {
 	.pwm_id = 1,
 };
 
-static struct s3c_hsotg_plat smdk6410_hsotg_pdata;
 
 static void __init smdk6410_map_io(void)
 {
@@ -660,7 +658,6 @@ static void __init smdk6410_machine_init(void)
 	s3c_i2c1_set_platdata(NULL);
 	s3c_fb_set_platdata(&smdk6410_lcd_pdata);
 	samsung_usbphy_set_pdata(&s3c_usbphy_pdata);
-	s3c_hsotg_set_platdata(&smdk6410_hsotg_pdata);
 
 	samsung_keypad_set_platdata(&smdk6410_keypad_data);
 
diff --git a/arch/arm/mach-s3c64xx/setup-usb-phy.c b/arch/arm/mach-s3c64xx/setup-usb-phy.c
index 0cc9ed5..add89e3 100644
--- a/arch/arm/mach-s3c64xx/setup-usb-phy.c
+++ b/arch/arm/mach-s3c64xx/setup-usb-phy.c
@@ -9,16 +9,12 @@
  *
  */
 
-#include <linux/clk.h>
-#include <linux/delay.h>
-#include <linux/err.h>
 #include <linux/io.h>
-#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/platform_data/samsung-usbphy.h>
+
 #include <mach/map.h>
 #include <mach/regs-sys.h>
-#include <plat/cpu.h>
-#include <plat/regs-usb-hsotg-phy.h>
-#include <plat/usb-phy.h>
 
 void s5p_usb_phy_pmu_isolation(int on)
 {
@@ -35,71 +31,3 @@ struct samsung_usbphy_data s3c_usbphy_pdata __initdata = {
 	.pmu_isolation = s5p_usb_phy_pmu_isolation,
 };
 
-static int s3c_usb_otgphy_init(struct platform_device *pdev)
-{
-	struct clk *xusbxti;
-	u32 phyclk;
-
-	writel(readl(S3C64XX_OTHERS) | S3C64XX_OTHERS_USBMASK, S3C64XX_OTHERS);
-
-	/* set clock frequency for PLL */
-	phyclk = readl(S3C_PHYCLK) & ~S3C_PHYCLK_CLKSEL_MASK;
-
-	xusbxti = clk_get(&pdev->dev, "xusbxti");
-	if (xusbxti && !IS_ERR(xusbxti)) {
-		switch (clk_get_rate(xusbxti)) {
-		case 12 * MHZ:
-			phyclk |= S3C_PHYCLK_CLKSEL_12M;
-			break;
-		case 24 * MHZ:
-			phyclk |= S3C_PHYCLK_CLKSEL_24M;
-			break;
-		default:
-		case 48 * MHZ:
-			/* default reference clock */
-			break;
-		}
-		clk_put(xusbxti);
-	}
-
-	/* TODO: select external clock/oscillator */
-	writel(phyclk | S3C_PHYCLK_CLK_FORCE, S3C_PHYCLK);
-
-	/* set to normal OTG PHY */
-	writel((readl(S3C_PHYPWR) & ~S3C_PHYPWR_NORMAL_MASK), S3C_PHYPWR);
-	mdelay(1);
-
-	/* reset OTG PHY and Link */
-	writel(S3C_RSTCON_PHY | S3C_RSTCON_HCLK | S3C_RSTCON_PHYCLK,
-			S3C_RSTCON);
-	udelay(20);	/* at-least 10uS */
-	writel(0, S3C_RSTCON);
-
-	return 0;
-}
-
-static int s3c_usb_otgphy_exit(struct platform_device *pdev)
-{
-	writel((readl(S3C_PHYPWR) | S3C_PHYPWR_ANALOG_POWERDOWN |
-				S3C_PHYPWR_OTG_DISABLE), S3C_PHYPWR);
-
-	writel(readl(S3C64XX_OTHERS) & ~S3C64XX_OTHERS_USBMASK, S3C64XX_OTHERS);
-
-	return 0;
-}
-
-int s5p_usb_phy_init(struct platform_device *pdev, int type)
-{
-	if (type == S5P_USB_PHY_DEVICE)
-		return s3c_usb_otgphy_init(pdev);
-
-	return -EINVAL;
-}
-
-int s5p_usb_phy_exit(struct platform_device *pdev, int type)
-{
-	if (type == S5P_USB_PHY_DEVICE)
-		return s3c_usb_otgphy_exit(pdev);
-
-	return -EINVAL;
-}
diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index e44b606..6e9eed0 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -1497,6 +1497,7 @@ struct platform_device s3c_device_usb_hsotg = {
 	},
 };
 
+#ifndef CONFIG_SAMSUNG_DEV_USBPHY
 void __init s3c_hsotg_set_platdata(struct s3c_hsotg_plat *pd)
 {
 	struct s3c_hsotg_plat *npd;
@@ -1509,6 +1510,7 @@ void __init s3c_hsotg_set_platdata(struct s3c_hsotg_plat *pd)
 	if (!npd->phy_exit)
 		npd->phy_exit = s5p_usb_phy_exit;
 }
+#endif
 #endif /* CONFIG_S3C_DEV_USB_HSOTG */
 
 /* USB High Spped 2.0 Device (Gadget) */
-- 
1.7.1
