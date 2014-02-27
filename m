From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Feb 2014 14:58:18 +0100
Subject: [PATCH 1/3] ARM: plat-versatile: convert LEDs to platform device
Message-ID: <1393509500-26002-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LEDs were initialized unconditionally with an fs_initcall()
which doesn't play well with multiplatform. Convert the driver
to a platform device and convert all boards with these LEDs
to register a platform device and pass the register as a
resource instead.

Tested successfully on the Versatile/AB and RealView PB1176.

Cc: Bryan Wu <cooloney@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Pawel Moll <pawel.moll@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-realview/core.c            | 15 ++++++++++
 arch/arm/mach-realview/core.h            |  1 +
 arch/arm/mach-realview/realview_eb.c     |  1 +
 arch/arm/mach-realview/realview_pb1176.c |  1 +
 arch/arm/mach-realview/realview_pb11mp.c |  1 +
 arch/arm/mach-realview/realview_pba8.c   |  1 +
 arch/arm/mach-realview/realview_pbx.c    |  1 +
 arch/arm/mach-versatile/core.c           | 16 +++++++++++
 arch/arm/plat-versatile/leds.c           | 49 ++++++++++++++++++--------------
 9 files changed, 65 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-realview/core.c b/arch/arm/mach-realview/core.c
index 1d5ee5c9a1dc..960b8dd78c44 100644
--- a/arch/arm/mach-realview/core.c
+++ b/arch/arm/mach-realview/core.c
@@ -148,6 +148,21 @@ struct platform_device realview_cf_device = {
 	},
 };
 
+static struct resource realview_leds_resources[] = {
+	{
+		.start	= REALVIEW_SYS_BASE + REALVIEW_SYS_LED_OFFSET,
+		.end	= REALVIEW_SYS_BASE + REALVIEW_SYS_LED_OFFSET + 4,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+struct platform_device realview_leds_device = {
+	.name		= "versatile-leds",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(realview_leds_resources),
+	.resource	= realview_leds_resources,
+};
+
 static struct resource realview_i2c_resource = {
 	.start		= REALVIEW_I2C_BASE,
 	.end		= REALVIEW_I2C_BASE + SZ_4K - 1,
diff --git a/arch/arm/mach-realview/core.h b/arch/arm/mach-realview/core.h
index 602ca5ec52c5..13dc830ef469 100644
--- a/arch/arm/mach-realview/core.h
+++ b/arch/arm/mach-realview/core.h
@@ -37,6 +37,7 @@ struct machine_desc;
 
 extern struct platform_device realview_flash_device;
 extern struct platform_device realview_cf_device;
+extern struct platform_device realview_leds_device;
 extern struct platform_device realview_i2c_device;
 extern struct mmci_platform_data realview_mmc0_plat_data;
 extern struct mmci_platform_data realview_mmc1_plat_data;
diff --git a/arch/arm/mach-realview/realview_eb.c b/arch/arm/mach-realview/realview_eb.c
index c85ddb2a0ad0..6bb070e80128 100644
--- a/arch/arm/mach-realview/realview_eb.c
+++ b/arch/arm/mach-realview/realview_eb.c
@@ -452,6 +452,7 @@ static void __init realview_eb_init(void)
 	realview_flash_register(&realview_eb_flash_resource, 1);
 	platform_device_register(&realview_i2c_device);
 	platform_device_register(&char_lcd_device);
+	platform_device_register(&realview_leds_device);
 	eth_device_register();
 	realview_usb_register(realview_eb_isp1761_resources);
 
diff --git a/arch/arm/mach-realview/realview_pb1176.c b/arch/arm/mach-realview/realview_pb1176.c
index c5eade76461b..173f2c15de49 100644
--- a/arch/arm/mach-realview/realview_pb1176.c
+++ b/arch/arm/mach-realview/realview_pb1176.c
@@ -367,6 +367,7 @@ static void __init realview_pb1176_init(void)
 	realview_usb_register(realview_pb1176_isp1761_resources);
 	platform_device_register(&pmu_device);
 	platform_device_register(&char_lcd_device);
+	platform_device_register(&realview_leds_device);
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
diff --git a/arch/arm/mach-realview/realview_pb11mp.c b/arch/arm/mach-realview/realview_pb11mp.c
index f4b0962578fe..bde7e6b1fd44 100644
--- a/arch/arm/mach-realview/realview_pb11mp.c
+++ b/arch/arm/mach-realview/realview_pb11mp.c
@@ -347,6 +347,7 @@ static void __init realview_pb11mp_init(void)
 	realview_eth_register(NULL, realview_pb11mp_smsc911x_resources);
 	platform_device_register(&realview_i2c_device);
 	platform_device_register(&realview_cf_device);
+	platform_device_register(&realview_leds_device);
 	realview_usb_register(realview_pb11mp_isp1761_resources);
 	platform_device_register(&pmu_device);
 
diff --git a/arch/arm/mach-realview/realview_pba8.c b/arch/arm/mach-realview/realview_pba8.c
index 10a3e1d76891..4e57a8599265 100644
--- a/arch/arm/mach-realview/realview_pba8.c
+++ b/arch/arm/mach-realview/realview_pba8.c
@@ -289,6 +289,7 @@ static void __init realview_pba8_init(void)
 	realview_eth_register(NULL, realview_pba8_smsc911x_resources);
 	platform_device_register(&realview_i2c_device);
 	platform_device_register(&realview_cf_device);
+	platform_device_register(&realview_leds_device);
 	realview_usb_register(realview_pba8_isp1761_resources);
 	platform_device_register(&pmu_device);
 
diff --git a/arch/arm/mach-realview/realview_pbx.c b/arch/arm/mach-realview/realview_pbx.c
index 9d75493e3f0c..72c96caebefa 100644
--- a/arch/arm/mach-realview/realview_pbx.c
+++ b/arch/arm/mach-realview/realview_pbx.c
@@ -385,6 +385,7 @@ static void __init realview_pbx_init(void)
 	realview_eth_register(NULL, realview_pbx_smsc911x_resources);
 	platform_device_register(&realview_i2c_device);
 	platform_device_register(&realview_cf_device);
+	platform_device_register(&realview_leds_device);
 	realview_usb_register(realview_pbx_isp1761_resources);
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
diff --git a/arch/arm/mach-versatile/core.c b/arch/arm/mach-versatile/core.c
index a335126ae18f..b31878570a00 100644
--- a/arch/arm/mach-versatile/core.c
+++ b/arch/arm/mach-versatile/core.c
@@ -310,6 +310,21 @@ static struct platform_device char_lcd_device = {
 	.resource       =       char_lcd_resources,
 };
 
+static struct resource leds_resources[] = {
+	{
+		.start	= VERSATILE_SYS_BASE + VERSATILE_SYS_LED_OFFSET,
+		.end	= VERSATILE_SYS_BASE + VERSATILE_SYS_LED_OFFSET + 4,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device leds_device = {
+	.name		= "versatile-leds",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(leds_resources),
+	.resource	= leds_resources,
+};
+
 /*
  * Clock handling
  */
@@ -795,6 +810,7 @@ void __init versatile_init(void)
 	platform_device_register(&versatile_i2c_device);
 	platform_device_register(&smc91x_device);
 	platform_device_register(&char_lcd_device);
+	platform_device_register(&leds_device);
 
 	for (i = 0; i < ARRAY_SIZE(amba_devs); i++) {
 		struct amba_device *d = amba_devs[i];
diff --git a/arch/arm/plat-versatile/leds.c b/arch/arm/plat-versatile/leds.c
index 2018f307f32e..80553022d661 100644
--- a/arch/arm/plat-versatile/leds.c
+++ b/arch/arm/plat-versatile/leds.c
@@ -7,22 +7,14 @@
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/leds.h>
-
-#include <mach/hardware.h>
-#include <mach/platform.h>
-
-#ifdef VERSATILE_SYS_BASE
-#define LEDREG	(__io_address(VERSATILE_SYS_BASE) + VERSATILE_SYS_LED_OFFSET)
-#endif
-
-#ifdef REALVIEW_SYS_BASE
-#define LEDREG	(__io_address(REALVIEW_SYS_BASE) + REALVIEW_SYS_LED_OFFSET)
-#endif
+#include <linux/platform_device.h>
 
 struct versatile_led {
+	void __iomem		*base;
 	struct led_classdev	cdev;
 	u8			mask;
 };
@@ -50,30 +42,37 @@ static void versatile_led_set(struct led_classdev *cdev,
 {
 	struct versatile_led *led = container_of(cdev,
 						 struct versatile_led, cdev);
-	u32 reg = readl(LEDREG);
+	u32 reg = readl(led->base);
 
 	if (b != LED_OFF)
 		reg |= led->mask;
 	else
 		reg &= ~led->mask;
-	writel(reg, LEDREG);
+	writel(reg, led->base);
 }
 
 static enum led_brightness versatile_led_get(struct led_classdev *cdev)
 {
 	struct versatile_led *led = container_of(cdev,
 						 struct versatile_led, cdev);
-	u32 reg = readl(LEDREG);
+	u32 reg = readl(led->base);
 
 	return (reg & led->mask) ? LED_FULL : LED_OFF;
 }
 
-static int __init versatile_leds_init(void)
+static int versatile_leds_probe(struct platform_device *dev)
 {
 	int i;
+	struct resource *res;
+	void __iomem *base;
+
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&dev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	/* All off */
-	writel(0, LEDREG);
+	writel(0, base);
 	for (i = 0; i < ARRAY_SIZE(versatile_leds); i++) {
 		struct versatile_led *led;
 
@@ -81,6 +80,7 @@ static int __init versatile_leds_init(void)
 		if (!led)
 			break;
 
+		led->base = base;
 		led->cdev.name = versatile_leds[i].name;
 		led->cdev.brightness_set = versatile_led_set;
 		led->cdev.brightness_get = versatile_led_get;
@@ -96,8 +96,15 @@ static int __init versatile_leds_init(void)
 	return 0;
 }
 
-/*
- * Since we may have triggers on any subsystem, defer registration
- * until after subsystem_init.
- */
-fs_initcall(versatile_leds_init);
+static struct platform_driver versatile_leds_driver = {
+	.driver = {
+		.name   = "versatile-leds",
+	},
+	.probe = versatile_leds_probe,
+};
+
+module_platform_driver(versatile_leds_driver);
+
+MODULE_AUTHOR("Linus Walleij <linus.walleij@linaro.org>");
+MODULE_DESCRIPTION("ARM Versatile LED driver");
+MODULE_LICENSE("GPL v2");
-- 
1.8.5.3
