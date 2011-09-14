From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 14 Sep 2011 10:20:25 -0300
Subject: [PATCH v2] ARM: mach-mxs/mx28evk: Only register devices if their GPIO
	requests succeeded
Message-ID: <1316006425-3570-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently framebuffer and MMC devices are registered even if their associated 
GPIO pins fail to be requested.

Change the logic so that the registration of such devices only occurs if their 
GPIO requests succeeded.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Use gpio_request_array for requesting multiple LCD GPIOs
- Pass GPIOF_OUT_INIT_HIGH as the init gpio value so that gpio_set_value calls can be ommited
 
 arch/arm/mach-mxs/mach-mx28evk.c |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index 3f86e7a..5753a74 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -351,6 +351,11 @@ static struct mxs_mmc_platform_data mx28evk_mmc_pdata[] __initdata = {
 	},
 };
 
+static struct gpio mx28evk_lcd_gpios[] = {
+	{ MX28EVK_LCD_ENABLE, GPIOF_OUT_INIT_HIGH, "lcd-enable" },
+	{ MX28EVK_BL_ENABLE, GPIOF_OUT_INIT_HIGH, "bl-enable" },
+};
+
 static void __init mx28evk_init(void)
 {
 	int ret;
@@ -377,19 +382,12 @@ static void __init mx28evk_init(void)
 		mx28_add_flexcan(1, &mx28evk_flexcan_pdata[1]);
 	}
 
-	ret = gpio_request_one(MX28EVK_LCD_ENABLE, GPIOF_DIR_OUT, "lcd-enable");
-	if (ret)
-		pr_warn("failed to request gpio lcd-enable: %d\n", ret);
-	else
-		gpio_set_value(MX28EVK_LCD_ENABLE, 1);
-
-	ret = gpio_request_one(MX28EVK_BL_ENABLE, GPIOF_DIR_OUT, "bl-enable");
+	ret = gpio_request_array(mx28evk_lcd_gpios,
+				 ARRAY_SIZE(mx28evk_lcd_gpios));
 	if (ret)
-		pr_warn("failed to request gpio bl-enable: %d\n", ret);
+		pr_warn("failed to request gpio pins for lcd: %d\n", ret);
 	else
-		gpio_set_value(MX28EVK_BL_ENABLE, 1);
-
-	mx28_add_mxsfb(&mx28evk_mxsfb_pdata);
+		mx28_add_mxsfb(&mx28evk_mxsfb_pdata);
 
 	/* power on mmc slot by writing 0 to the gpio */
 	ret = gpio_request_one(MX28EVK_MMC0_SLOT_POWER, GPIOF_OUT_INIT_LOW,
@@ -401,9 +399,10 @@ static void __init mx28evk_init(void)
 	ret = gpio_request_one(MX28EVK_MMC1_SLOT_POWER, GPIOF_OUT_INIT_LOW,
 			       "mmc1-slot-power");
 	if (ret)
-		pr_warn("failed to request gpio mmc1-slot-power: %d\n", ret);
-	mx28_add_mxs_mmc(1, &mx28evk_mmc_pdata[1]);
-
+		pr_warn("failed to request gpio mmc1-slot-power: %d\n", ret);
+	else
+		mx28_add_mxs_mmc(1, &mx28evk_mmc_pdata[1]);
+
 	gpio_led_register_device(0, &mx28evk_led_data);
 }
 
-- 
1.7.1
