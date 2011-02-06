From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 6 Feb 2011 11:52:54 +0000
Subject: [PATCH] Clean up set_pxa_fb_info
Message-ID: <20110206115254.GA13084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

set_pxa_fb_info() has been a long-standing wart in the naming scheme
of the pxa_set_xxx_info() functions.  This renames the function, and
combines set_pxa_fb_parent() with set_pxa_fb_info().

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
I've had this patch sitting around for a while, so it's been updated.
It might be worth merging it.

 arch/arm/mach-pxa/am200epd.c              |    4 ++--
 arch/arm/mach-pxa/balloon3.c              |    2 +-
 arch/arm/mach-pxa/cm-x2xx.c               |    2 +-
 arch/arm/mach-pxa/cm-x300.c               |    2 +-
 arch/arm/mach-pxa/colibri-pxa270-income.c |    2 +-
 arch/arm/mach-pxa/colibri-pxa3xx.c        |    2 +-
 arch/arm/mach-pxa/devices.c               |    8 ++------
 arch/arm/mach-pxa/em-x270.c               |    2 +-
 arch/arm/mach-pxa/eseries.c               |    2 +-
 arch/arm/mach-pxa/ezx.c                   |   12 ++++++------
 arch/arm/mach-pxa/idp.c                   |    2 +-
 arch/arm/mach-pxa/include/mach/pxafb.h    |    3 +--
 arch/arm/mach-pxa/littleton.c             |    2 +-
 arch/arm/mach-pxa/lpd270.c                |    2 +-
 arch/arm/mach-pxa/lubbock.c               |    2 +-
 arch/arm/mach-pxa/magician.c              |    2 +-
 arch/arm/mach-pxa/mainstone.c             |    2 +-
 arch/arm/mach-pxa/mioa701.c               |    2 +-
 arch/arm/mach-pxa/palm27x.c               |    2 +-
 arch/arm/mach-pxa/palmtc.c                |    2 +-
 arch/arm/mach-pxa/palmte2.c               |    2 +-
 arch/arm/mach-pxa/pcm990-baseboard.c      |    2 +-
 arch/arm/mach-pxa/poodle.c                |    3 +--
 arch/arm/mach-pxa/raumfeld.c              |    2 +-
 arch/arm/mach-pxa/saar.c                  |    2 +-
 arch/arm/mach-pxa/spitz.c                 |    2 +-
 arch/arm/mach-pxa/tavorevb.c              |    2 +-
 arch/arm/mach-pxa/trizeps4.c              |    4 ++--
 arch/arm/mach-pxa/viper.c                 |    2 +-
 arch/arm/mach-pxa/vpac270.c               |    2 +-
 arch/arm/mach-pxa/z2.c                    |    2 +-
 arch/arm/mach-pxa/zeus.c                  |    2 +-
 arch/arm/mach-pxa/zylonite.c              |    4 ++--
 33 files changed, 42 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
index 3499fad..10964e3 100644
--- a/arch/arm/mach-pxa/am200epd.c
+++ b/arch/arm/mach-pxa/am200epd.c
@@ -194,7 +194,7 @@ static struct notifier_block am200_fb_notif = {
 };
 
 /* this gets called as part of our init. these steps must be done now so
- * that we can use set_pxa_fb_info */
+ * that we can use pxa_set_fb_info */
 static void __init am200_presetup_fb(void)
 {
 	int fw;
@@ -249,7 +249,7 @@ static void __init am200_presetup_fb(void)
 	/* we divide since we told the LCD controller we're 16bpp */
 	am200_fb_info.modes->xres /= 2;
 
-	set_pxa_fb_info(&am200_fb_info);
+	pxa_set_fb_info(NULL, &am200_fb_info);
 
 }
 
diff --git a/arch/arm/mach-pxa/balloon3.c b/arch/arm/mach-pxa/balloon3.c
index e194d92..0e12667 100644
--- a/arch/arm/mach-pxa/balloon3.c
+++ b/arch/arm/mach-pxa/balloon3.c
@@ -264,7 +264,7 @@ static void __init balloon3_lcd_init(void)
 	}
 
 	balloon3_lcd_screen.pxafb_backlight_power = balloon3_backlight_power;
-	set_pxa_fb_info(&balloon3_lcd_screen);
+	pxa_set_fb_info(NULL, &balloon3_lcd_screen);
 	return;
 
 err2:
diff --git a/arch/arm/mach-pxa/cm-x2xx.c b/arch/arm/mach-pxa/cm-x2xx.c
index b734d84..8225e2e 100644
--- a/arch/arm/mach-pxa/cm-x2xx.c
+++ b/arch/arm/mach-pxa/cm-x2xx.c
@@ -379,7 +379,7 @@ __setup("monitor=", cmx2xx_set_display);
 
 static void __init cmx2xx_init_display(void)
 {
-	set_pxa_fb_info(cmx2xx_display);
+	pxa_set_fb_info(NULL, cmx2xx_display);
 }
 #else
 static inline void cmx2xx_init_display(void) {}
diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 7984268..0c9cfbc 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -296,7 +296,7 @@ static struct pxafb_mach_info cm_x300_lcd = {
 
 static void __init cm_x300_init_lcd(void)
 {
-	set_pxa_fb_info(&cm_x300_lcd);
+	pxa_set_fb_info(NULL, &cm_x300_lcd);
 }
 #else
 static inline void cm_x300_init_lcd(void) {}
diff --git a/arch/arm/mach-pxa/colibri-pxa270-income.c b/arch/arm/mach-pxa/colibri-pxa270-income.c
index 07b62a0..c2f164b 100644
--- a/arch/arm/mach-pxa/colibri-pxa270-income.c
+++ b/arch/arm/mach-pxa/colibri-pxa270-income.c
@@ -176,7 +176,7 @@ static struct pxafb_mach_info income_lcd_screen = {
 
 static void __init income_lcd_init(void)
 {
-	set_pxa_fb_info(&income_lcd_screen);
+	pxa_set_fb_info(NULL, &income_lcd_screen);
 }
 #else
 static inline void income_lcd_init(void) {}
diff --git a/arch/arm/mach-pxa/colibri-pxa3xx.c b/arch/arm/mach-pxa/colibri-pxa3xx.c
index 96b2d9f..3f9be41 100644
--- a/arch/arm/mach-pxa/colibri-pxa3xx.c
+++ b/arch/arm/mach-pxa/colibri-pxa3xx.c
@@ -105,7 +105,7 @@ void __init colibri_pxa3xx_init_lcd(int bl_pin)
 	lcd_bl_pin = bl_pin;
 	gpio_request(bl_pin, "lcd backlight");
 	gpio_direction_output(bl_pin, 0);
-	set_pxa_fb_info(&sharp_lq43_info);
+	pxa_set_fb_info(NULL, &sharp_lq43_info);
 }
 #endif
 
diff --git a/arch/arm/mach-pxa/devices.c b/arch/arm/mach-pxa/devices.c
index 4c766e3..edfe803 100644
--- a/arch/arm/mach-pxa/devices.c
+++ b/arch/arm/mach-pxa/devices.c
@@ -188,16 +188,12 @@ struct platform_device pxa_device_fb = {
 	.resource	= pxafb_resources,
 };
 
-void __init set_pxa_fb_info(struct pxafb_mach_info *info)
+void __init pxa_set_fb_info(struct device *parent, struct pxafb_mach_info *info)
 {
+	pxa_device_fb.dev.parent = parent;
 	pxa_register_device(&pxa_device_fb, info);
 }
 
-void __init set_pxa_fb_parent(struct device *parent_dev)
-{
-	pxa_device_fb.dev.parent = parent_dev;
-}
-
 static struct resource pxa_resource_ffuart[] = {
 	{
 		.start	= 0x40100000,
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index a78bb30..2da03a4 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -689,7 +689,7 @@ static struct pxafb_mach_info em_x270_lcd = {
 
 static void __init em_x270_init_lcd(void)
 {
-	set_pxa_fb_info(&em_x270_lcd);
+	pxa_set_fb_info(NULL, &em_x270_lcd);
 }
 #else
 static inline void em_x270_init_lcd(void) {}
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index edca0a0..8fdf5a3 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -344,7 +344,7 @@ static void __init e400_init(void)
 	/* Fixme - e400 may have a switched clock */
 	eseries_register_clks();
 	eseries_get_tmio_gpios();
-	set_pxa_fb_info(&e400_pxafb_mach_info);
+	pxa_set_fb_info(NULL, &e400_pxafb_mach_info);
 	platform_add_devices(ARRAY_AND_SIZE(e400_devices));
 	pxa_set_udc_info(&e7xx_udc_mach_info);
 }
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 87cec0a..fcd366a 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -783,7 +783,7 @@ static void __init a780_init(void)
 
 	pxa_set_i2c_info(NULL);
 
-	set_pxa_fb_info(&ezx_fb_info_1);
+	pxa_set_fb_info(NULL, &ezx_fb_info_1);
 
 	pxa_set_keypad_info(&a780_keypad_platform_data);
 
@@ -853,7 +853,7 @@ static void __init e680_init(void)
 	pxa_set_i2c_info(NULL);
 	i2c_register_board_info(0, ARRAY_AND_SIZE(e680_i2c_board_info));
 
-	set_pxa_fb_info(&ezx_fb_info_1);
+	pxa_set_fb_info(NULL, &ezx_fb_info_1);
 
 	pxa_set_keypad_info(&e680_keypad_platform_data);
 
@@ -918,7 +918,7 @@ static void __init a1200_init(void)
 	pxa_set_i2c_info(NULL);
 	i2c_register_board_info(0, ARRAY_AND_SIZE(a1200_i2c_board_info));
 
-	set_pxa_fb_info(&ezx_fb_info_2);
+	pxa_set_fb_info(NULL, &ezx_fb_info_2);
 
 	pxa_set_keypad_info(&a1200_keypad_platform_data);
 
@@ -1103,7 +1103,7 @@ static void __init a910_init(void)
 	pxa_set_i2c_info(NULL);
 	i2c_register_board_info(0, ARRAY_AND_SIZE(a910_i2c_board_info));
 
-	set_pxa_fb_info(&ezx_fb_info_2);
+	pxa_set_fb_info(NULL, &ezx_fb_info_2);
 
 	pxa_set_keypad_info(&a910_keypad_platform_data);
 
@@ -1173,7 +1173,7 @@ static void __init e6_init(void)
 	pxa_set_i2c_info(NULL);
 	i2c_register_board_info(0, ARRAY_AND_SIZE(e6_i2c_board_info));
 
-	set_pxa_fb_info(&ezx_fb_info_2);
+	pxa_set_fb_info(NULL, &ezx_fb_info_2);
 
 	pxa_set_keypad_info(&e6_keypad_platform_data);
 
@@ -1212,7 +1212,7 @@ static void __init e2_init(void)
 	pxa_set_i2c_info(NULL);
 	i2c_register_board_info(0, ARRAY_AND_SIZE(e2_i2c_board_info));
 
-	set_pxa_fb_info(&ezx_fb_info_2);
+	pxa_set_fb_info(NULL, &ezx_fb_info_2);
 
 	pxa_set_keypad_info(&e2_keypad_platform_data);
 
diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
index dd40e4a..f7fb64f 100644
--- a/arch/arm/mach-pxa/idp.c
+++ b/arch/arm/mach-pxa/idp.c
@@ -167,7 +167,7 @@ static void __init idp_init(void)
 
 	platform_device_register(&smc91x_device);
 	//platform_device_register(&mst_audio_device);
-	set_pxa_fb_info(&sharp_lm8v31);
+	pxa_set_fb_info(NULL, &sharp_lm8v31);
 	pxa_set_mci_info(&idp_mci_platform_data);
 }
 
diff --git a/arch/arm/mach-pxa/include/mach/pxafb.h b/arch/arm/mach-pxa/include/mach/pxafb.h
index 160ec83..1288e83 100644
--- a/arch/arm/mach-pxa/include/mach/pxafb.h
+++ b/arch/arm/mach-pxa/include/mach/pxafb.h
@@ -154,8 +154,7 @@ struct pxafb_mach_info {
 	void (*pxafb_lcd_power)(int, struct fb_var_screeninfo *);
 	void (*smart_update)(struct fb_info *);
 };
-void set_pxa_fb_info(struct pxafb_mach_info *hard_pxa_fb_info);
-void set_pxa_fb_parent(struct device *parent_dev);
+void pxa_set_fb_info(struct pxafb_mach_info *hard_pxa_fb_info);
 unsigned long pxafb_get_hsync_time(struct device *dev);
 
 extern int pxafb_smart_queue(struct fb_info *info, uint16_t *cmds, int);
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index ccb7bfa..4b2c45f 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -185,7 +185,7 @@ static struct pxafb_mach_info littleton_lcd_info = {
 
 static void littleton_init_lcd(void)
 {
-	set_pxa_fb_info(&littleton_lcd_info);
+	pxa_set_fb_info(NULL, &littleton_lcd_info);
 }
 #else
 static inline void littleton_init_lcd(void) {};
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index c9a3e77..8aebc58 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -480,7 +480,7 @@ static void __init lpd270_init(void)
 	pxa_set_ac97_info(NULL);
 
 	if (lpd270_lcd_to_use != NULL)
-		set_pxa_fb_info(lpd270_lcd_to_use);
+		pxa_set_fb_info(NULL, lpd270_lcd_to_use);
 
 	pxa_set_ohci_info(&lpd270_ohci_platform_data);
 }
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index dca20de..12a2a56 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -521,7 +521,7 @@ static void __init lubbock_init(void)
 
 	clk_add_alias("SA1111_CLK", NULL, "GPIO11_CLK", NULL);
 	pxa_set_udc_info(&udc_info);
-	set_pxa_fb_info(&sharp_lm8v31);
+	pxa_set_fb_info(NULL, &sharp_lm8v31);
 	pxa_set_mci_info(&lubbock_mci_platform_data);
 	pxa_set_ficp_info(&lubbock_ficp_platform_data);
 	pxa_set_ac97_info(NULL);
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 41198f0..ad70264 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -757,7 +757,7 @@ static void __init magician_init(void)
 		gpio_direction_output(GPIO104_MAGICIAN_LCD_POWER_1, 0);
 		gpio_direction_output(GPIO105_MAGICIAN_LCD_POWER_2, 0);
 		gpio_direction_output(GPIO106_MAGICIAN_LCD_POWER_3, 0);
-		set_pxa_fb_info(lcd_select ? &samsung_info : &toppoly_info);
+		pxa_set_fb_info(NULL, lcd_select ? &samsung_info : &toppoly_info);
 	} else
 		pr_err("LCD detection: CPLD mapping failed\n");
 }
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index d4b6f23..a58f522 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -592,7 +592,7 @@ static void __init mainstone_init(void)
 	else
 		mainstone_pxafb_info.modes = &toshiba_ltm035a776c_mode;
 
-	set_pxa_fb_info(&mainstone_pxafb_info);
+	pxa_set_fb_info(NULL, &mainstone_pxafb_info);
 	mainstone_backlight_register();
 
 	pxa_set_mci_info(&mainstone_mci_platform_data);
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index faafea3..18e05b1 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -795,7 +795,7 @@ static void __init mioa701_machine_init(void)
 	pxa_set_stuart_info(NULL);
 	mio_gpio_request(ARRAY_AND_SIZE(global_gpios));
 	bootstrap_init();
-	set_pxa_fb_info(&mioa701_pxafb_info);
+	pxa_set_fb_info(NULL, &mioa701_pxafb_info);
 	pxa_set_mci_info(&mioa701_mci_info);
 	pxa_set_keypad_info(&mioa701_keypad_info);
 	pxa_set_udc_info(&mioa701_udc_info);
diff --git a/arch/arm/mach-pxa/palm27x.c b/arch/arm/mach-pxa/palm27x.c
index 405b92a..4f26d78 100644
--- a/arch/arm/mach-pxa/palm27x.c
+++ b/arch/arm/mach-pxa/palm27x.c
@@ -159,7 +159,7 @@ void __init palm27x_lcd_init(int power, struct pxafb_mode_info *mode)
 		palm27x_lcd_screen.pxafb_lcd_power = palm27x_lcd_ctl;
 	}
 
-	set_pxa_fb_info(&palm27x_lcd_screen);
+	pxa_set_fb_info(NULL, &palm27x_lcd_screen);
 }
 #endif
 
diff --git a/arch/arm/mach-pxa/palmtc.c b/arch/arm/mach-pxa/palmtc.c
index a09a237..fb06bd0 100644
--- a/arch/arm/mach-pxa/palmtc.c
+++ b/arch/arm/mach-pxa/palmtc.c
@@ -507,7 +507,7 @@ static struct pxafb_mach_info palmtc_lcd_screen = {
 
 static void __init palmtc_lcd_init(void)
 {
-	set_pxa_fb_info(&palmtc_lcd_screen);
+	pxa_set_fb_info(NULL, &palmtc_lcd_screen);
 }
 #else
 static inline void palmtc_lcd_init(void) {}
diff --git a/arch/arm/mach-pxa/palmte2.c b/arch/arm/mach-pxa/palmte2.c
index 3f25014..7fdf099 100644
--- a/arch/arm/mach-pxa/palmte2.c
+++ b/arch/arm/mach-pxa/palmte2.c
@@ -363,7 +363,7 @@ static void __init palmte2_init(void)
 	pxa_set_btuart_info(NULL);
 	pxa_set_stuart_info(NULL);
 
-	set_pxa_fb_info(&palmte2_lcd_screen);
+	pxa_set_fb_info(NULL, &palmte2_lcd_screen);
 	pxa_set_mci_info(&palmte2_mci_platform_data);
 	palmte2_udc_init();
 	pxa_set_ac97_info(&palmte2_ac97_pdata);
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c b/arch/arm/mach-pxa/pcm990-baseboard.c
index 90820fa..c1a6448 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -515,7 +515,7 @@ void __init pcm990_baseboard_init(void)
 	pcm990_init_irq();
 
 #ifndef CONFIG_PCM990_DISPLAY_NONE
-	set_pxa_fb_info(&pcm990_fbinfo);
+	pxa_set_fb_info(NULL, &pcm990_fbinfo);
 #endif
 	platform_device_register(&pcm990_backlight_device);
 
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 4f0ff1a..be68ec5 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -445,8 +445,7 @@ static void __init poodle_init(void)
 	if (ret)
 		pr_warning("poodle: Unable to register LoCoMo device\n");
 
-	set_pxa_fb_parent(&poodle_locomo_device.dev);
-	set_pxa_fb_info(&poodle_fb_info);
+	pxa_set_fb_info(&poodle_locomo_device.dev, &poodle_fb_info);
 	pxa_set_udc_info(&udc_info);
 	pxa_set_mci_info(&poodle_mci_platform_data);
 	pxa_set_ficp_info(&poodle_ficp_platform_data);
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 8361151..d9a5791 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -597,7 +597,7 @@ static void __init raumfeld_lcd_init(void)
 {
 	int ret;
 
-	set_pxa_fb_info(&raumfeld_sharp_lcd_info);
+	pxa_set_fb_info(NULL, &raumfeld_sharp_lcd_info);
 
 	/* Earlier devices had the backlight regulator controlled
 	 * via PWM, later versions use another controller for that */
diff --git a/arch/arm/mach-pxa/saar.c b/arch/arm/mach-pxa/saar.c
index c1ca8cb..dd0118f 100644
--- a/arch/arm/mach-pxa/saar.c
+++ b/arch/arm/mach-pxa/saar.c
@@ -473,7 +473,7 @@ static struct pxafb_mach_info saar_lcd_info = {
 
 static void __init saar_init_lcd(void)
 {
-	set_pxa_fb_info(&saar_lcd_info);
+	pxa_set_fb_info(NULL, &saar_lcd_info);
 }
 #else
 static inline void saar_init_lcd(void) {}
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index b49a2c2..e646b6d 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -725,7 +725,7 @@ static struct pxafb_mach_info spitz_pxafb_info = {
 
 static void __init spitz_lcd_init(void)
 {
-	set_pxa_fb_info(&spitz_pxafb_info);
+	pxa_set_fb_info(NULL, &spitz_pxafb_info);
 }
 #else
 static inline void spitz_lcd_init(void) {}
diff --git a/arch/arm/mach-pxa/tavorevb.c b/arch/arm/mach-pxa/tavorevb.c
index 9cecf83..53d4a47 100644
--- a/arch/arm/mach-pxa/tavorevb.c
+++ b/arch/arm/mach-pxa/tavorevb.c
@@ -466,7 +466,7 @@ static void __init tavorevb_init_lcd(void)
 {
 	platform_device_register(&tavorevb_backlight_devices[0]);
 	platform_device_register(&tavorevb_backlight_devices[1]);
-	set_pxa_fb_info(&tavorevb_lcd_info);
+	pxa_set_fb_info(NULL, &tavorevb_lcd_info);
 }
 #else
 static inline void tavorevb_init_lcd(void) {}
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index 423261d..fa510fd 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -516,9 +516,9 @@ static void __init trizeps4_init(void)
 	pxa_set_stuart_info(NULL);
 
 	if (0)	/* dont know how to determine LCD */
-		set_pxa_fb_info(&sharp_lcd);
+		pxa_set_fb_info(NULL, &sharp_lcd);
 	else
-		set_pxa_fb_info(&toshiba_lcd);
+		pxa_set_fb_info(NULL, &toshiba_lcd);
 
 	pxa_set_mci_info(&trizeps4_mci_platform_data);
 #ifndef STATUS_LEDS_ON_STUART_PINS
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 49eeeab..53b2495 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -932,7 +932,7 @@ static void __init viper_init(void)
 	/* Wake-up serial console */
 	viper_init_serial_gpio();
 
-	set_pxa_fb_info(&fb_info);
+	pxa_set_fb_info(NULL, &fb_info);
 
 	/* v1 hardware cannot use the datacs line */
 	version = viper_hw_version();
diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index b9b5797..a46f8d1 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -573,7 +573,7 @@ static void __init vpac270_lcd_init(void)
 	}
 
 	vpac270_lcd_screen.pxafb_lcd_power = vpac270_lcd_power;
-	set_pxa_fb_info(&vpac270_lcd_screen);
+	pxa_set_fb_info(NULL, &vpac270_lcd_screen);
 	return;
 
 err2:
diff --git a/arch/arm/mach-pxa/z2.c b/arch/arm/mach-pxa/z2.c
index a323e07..084c724 100644
--- a/arch/arm/mach-pxa/z2.c
+++ b/arch/arm/mach-pxa/z2.c
@@ -272,7 +272,7 @@ static struct pxafb_mach_info z2_lcd_screen = {
 
 static void __init z2_lcd_init(void)
 {
-	set_pxa_fb_info(&z2_lcd_screen);
+	pxa_set_fb_info(NULL, &z2_lcd_screen);
 }
 #else
 static inline void z2_lcd_init(void) {}
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index f4b053b..3db0ba4 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -847,7 +847,7 @@ static void __init zeus_init(void)
 	if (zeus_setup_fb_gpios())
 		pr_err("Failed to setup fb gpios\n");
 	else
-		set_pxa_fb_info(&zeus_fb_info);
+		pxa_set_fb_info(NULL, &zeus_fb_info);
 
 	pxa_set_mci_info(&zeus_mci_platform_data);
 	pxa_set_udc_info(&zeus_udc_info);
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index a4c784a..5821185 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -208,7 +208,7 @@ static void __init zylonite_init_lcd(void)
 	platform_device_register(&zylonite_backlight_device);
 
 	if (lcd_id & 0x20) {
-		set_pxa_fb_info(&zylonite_sharp_lcd_info);
+		pxa_set_fb_info(NULL, &zylonite_sharp_lcd_info);
 		return;
 	}
 
@@ -220,7 +220,7 @@ static void __init zylonite_init_lcd(void)
 	else
 		zylonite_toshiba_lcd_info.modes = &toshiba_ltm04c380k_mode;
 
-	set_pxa_fb_info(&zylonite_toshiba_lcd_info);
+	pxa_set_fb_info(NULL, &zylonite_toshiba_lcd_info);
 }
 #else
 static inline void zylonite_init_lcd(void) {}
