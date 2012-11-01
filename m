From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu,  1 Nov 2012 13:26:34 +0400
Subject: [PATCH 04/15] ARM: clps711x: Transform clps711x-framebuffer to
 platform driver and use it
In-Reply-To: <1351762006-27368-1-git-send-email-shc_work@mail.ru>
References: <1351762006-27368-1-git-send-email-shc_work@mail.ru>
Message-ID: <1351762006-27368-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clps711x-framebuffer driver needs to be updated and this is a first step
to make it better. With this patch we are loading clps711x-framebuffer as
a platform device.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/autcpu12.c |    2 ++
 arch/arm/mach-clps711x/edb7211.c  |    2 ++
 arch/arm/mach-clps711x/p720t.c    |    2 ++
 drivers/video/clps711xfb.c        |   21 +++++++++++++++------
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-clps711x/autcpu12.c b/arch/arm/mach-clps711x/autcpu12.c
index d845dea..c20c30a 100644
--- a/arch/arm/mach-clps711x/autcpu12.c
+++ b/arch/arm/mach-clps711x/autcpu12.c
@@ -63,6 +63,8 @@ static void __init autcpu12_init(void)
 {
 	platform_device_register_simple("uart-clps711x", 0, NULL, 0);
 
+	platform_device_register_simple("video-clps711x", 0, NULL, 0);
+
 	platform_device_register_simple("cs89x0", 0, autcpu12_cs8900_resource,
 					ARRAY_SIZE(autcpu12_cs8900_resource));
 
diff --git a/arch/arm/mach-clps711x/edb7211.c b/arch/arm/mach-clps711x/edb7211.c
index 7eaaafa..ef87c43 100644
--- a/arch/arm/mach-clps711x/edb7211.c
+++ b/arch/arm/mach-clps711x/edb7211.c
@@ -85,6 +85,8 @@ static void __init edb7211_init(void)
 {
 	platform_device_register_simple("uart-clps711x", 0, NULL, 0);
 
+	platform_device_register_simple("video-clps711x", 0, NULL, 0);
+
 	platform_device_register_simple("cs89x0", 0, edb7211_cs8900_resource,
 					ARRAY_SIZE(edb7211_cs8900_resource));
 }
diff --git a/arch/arm/mach-clps711x/p720t.c b/arch/arm/mach-clps711x/p720t.c
index 7a96312..b6e2032 100644
--- a/arch/arm/mach-clps711x/p720t.c
+++ b/arch/arm/mach-clps711x/p720t.c
@@ -130,6 +130,8 @@ static struct platform_device p720t_gpio_led_pdev = {
 static void __init p720t_init(void)
 {
 	platform_device_register_simple("uart-clps711x", 0, NULL, 0);
+
+	platform_device_register_simple("video-clps711x", 0, NULL, 0);
 }
 
 static void __init p720t_init_late(void)
diff --git a/drivers/video/clps711xfb.c b/drivers/video/clps711xfb.c
index f994c8b..2ccbb9b 100644
--- a/drivers/video/clps711xfb.c
+++ b/drivers/video/clps711xfb.c
@@ -270,7 +270,7 @@ static const struct file_operations backlight_proc_fops = {
 	.write		= backlight_proc_write,
 };
 
-static void __init clps711x_guess_lcd_params(struct fb_info *info)
+static void __devinit clps711x_guess_lcd_params(struct fb_info *info)
 {
 	unsigned int lcdcon, syscon, size;
 	unsigned long phys_base = PAGE_OFFSET;
@@ -358,7 +358,7 @@ static void __init clps711x_guess_lcd_params(struct fb_info *info)
 	info->fix.type       = FB_TYPE_PACKED_PIXELS;
 }
 
-int __init clps711xfb_init(void)
+static int __devinit clps711x_fb_probe(struct platform_device *pdev)
 {
 	int err = -ENOMEM;
 
@@ -410,7 +410,7 @@ int __init clps711xfb_init(void)
 out:	return err;
 }
 
-static void __exit clps711xfb_exit(void)
+static int __devexit clps711x_fb_remove(struct platform_device *pdev)
 {
 	unregister_framebuffer(cfb);
 	kfree(cfb);
@@ -422,11 +422,20 @@ static void __exit clps711xfb_exit(void)
 		PLD_LCDEN = 0;
 		PLD_PWR &= ~(PLD_S4_ON|PLD_S3_ON|PLD_S2_ON|PLD_S1_ON);
 	}
+
+	return 0;
 }
 
-module_init(clps711xfb_init);
-module_exit(clps711xfb_exit);
+static struct platform_driver clps711x_fb_driver = {
+	.driver	= {
+		.name	= "video-clps711x",
+		.owner	= THIS_MODULE,
+	},
+	.probe	= clps711x_fb_probe,
+	.remove	= __devexit_p(clps711x_fb_remove),
+};
+module_platform_driver(clps711x_fb_driver);
 
 MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
-MODULE_DESCRIPTION("CLPS711x framebuffer driver");
+MODULE_DESCRIPTION("CLPS711X framebuffer driver");
 MODULE_LICENSE("GPL");
-- 
1.7.8.6
