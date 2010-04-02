From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 02 Apr 2010 08:48:57 +0200
Subject: [PATCH 09/16] ARM: SMDKC100: enable frame buffer again
In-Reply-To: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
References: <1270190944-21644-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1270190944-21644-10-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables support for s3c frame buffer driver on SMDKC100 machine.
It also fixes the wrongly defined pixel clock value (it worked only before
commit eb29a5cc0b601).

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig         |    2 ++
 arch/arm/mach-s5pc100/mach-smdkc100.c |   13 +++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index 26e0028..1e7b9a7 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -22,6 +22,8 @@ config S5PC100_SETUP_FB_24BPP
 config MACH_SMDKC100
 	bool "SMDKC100"
 	select CPU_S5PC100
+	select S5PC100_SETUP_FB_24BPP
+	select S3C_DEV_FB
 	help
 	  Machine support for the Samsung SMDKC100
 
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index 8dec25f..44984be 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -85,7 +85,7 @@ static struct i2c_board_info i2c_devs0[] __initdata = {
 /* I2C1 */
 static struct i2c_board_info i2c_devs1[] __initdata = {
 };
-
+#endif
 /* LCD power controller */
 static void smdkc100_lcd_power_set(struct plat_lcd_data *pd,
 				   unsigned int power)
@@ -118,8 +118,7 @@ static struct platform_device smdkc100_lcd_powerdev = {
 static struct s3c_fb_pd_win smdkc100_fb_win0 = {
 	/* this is to ensure we use win0 */
 	.win_mode	= {
-		.refresh	= 70,
-		.pixclock	= (8+13+3+800)*(7+5+1+480),
+		.pixclock = 1000000000000ULL / ((8+13+3+800)*(7+5+1+480)*80),
 		.left_margin	= 8,
 		.right_margin	= 13,
 		.upper_margin	= 7,
@@ -139,17 +138,16 @@ static struct s3c_fb_platdata smdkc100_lcd_pdata __initdata = {
 	.vidcon1	= VIDCON1_INV_HSYNC | VIDCON1_INV_VSYNC,
 	.setup_gpio	= s5pc100_fb_gpio_setup_24bpp,
 };
-#endif
 
 static struct platform_device *smdkc100_devices[] __initdata = {
+	&s3c_device_fb,
+	&smdkc100_lcd_powerdev,
 #if 0
 	&s3c_device_i2c0,
 	&s3c_device_i2c1,
-	&s3c_device_fb,
 	&s3c_device_hsmmc0,
 	&s3c_device_hsmmc1,
 	&s3c_device_hsmmc2,
-	&smdkc100_lcd_powerdev,
 #endif
 };
 
@@ -168,7 +166,7 @@ static void __init smdkc100_machine_init(void)
 	s3c_i2c1_set_platdata(NULL);
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
-
+#endif
 	s3c_fb_set_platdata(&smdkc100_lcd_pdata);
 
 	/* LCD init */
@@ -176,7 +174,6 @@ static void __init smdkc100_machine_init(void)
 	gpio_request(S5PC100_GPH0(6), "GPH0");
 	smdkc100_lcd_power_set(&smdkc100_lcd_power_data, 0);
 	platform_add_devices(smdkc100_devices, ARRAY_SIZE(smdkc100_devices));
-#endif
 }
 
 MACHINE_START(SMDKC100, "SMDKC100")
-- 
1.6.4
