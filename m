From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu,  1 Nov 2012 13:26:33 +0400
Subject: [PATCH 03/15] ARM: clps711x: p720t: Using "leds-gpio" driver for LED
 control
In-Reply-To: <1351762006-27368-1-git-send-email-shc_work@mail.ru>
References: <1351762006-27368-1-git-send-email-shc_work@mail.ru>
Message-ID: <1351762006-27368-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of manually create LED class device, we will use "leds-gpio"
driver for LED control.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/common.h |    3 +
 arch/arm/mach-clps711x/p720t.c  |   79 ++++++++++++--------------------------
 2 files changed, 28 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-clps711x/common.h b/arch/arm/mach-clps711x/common.h
index fc0f065..83cfece 100644
--- a/arch/arm/mach-clps711x/common.h
+++ b/arch/arm/mach-clps711x/common.h
@@ -4,6 +4,9 @@
  * Common bits.
  */
 
+#define CLPS711X_NR_GPIO	(4 * 8 + 3)
+#define CLPS711X_GPIO(port,bit)	((port) * 8 + (bit))
+
 struct sys_timer;
 
 extern void clps711x_map_io(void);
diff --git a/arch/arm/mach-clps711x/p720t.c b/arch/arm/mach-clps711x/p720t.c
index 96d54d4..7a96312 100644
--- a/arch/arm/mach-clps711x/p720t.c
+++ b/arch/arm/mach-clps711x/p720t.c
@@ -39,6 +39,8 @@
 
 #include "common.h"
 
+#define GPIO_USERLED	CLPS711X_GPIO(3, 0)
+
 /*
  * Map the P720T system PLD. It occupies two address spaces:
  * 0x10000000 and 0x10400000. We map both regions as one.
@@ -104,67 +106,35 @@ static void __init p720t_init_early(void)
 	}
 }
 
-/*
- * LED controled by CPLD
- */
-#if defined(CONFIG_NEW_LEDS) && defined(CONFIG_LEDS_CLASS)
-static void p720t_led_set(struct led_classdev *cdev,
-			      enum led_brightness b)
-{
-	u8 reg = clps_readb(PDDR);
-
-	if (b != LED_OFF)
-		reg |= 0x1;
-	else
-		reg &= ~0x1;
-
-	clps_writeb(reg, PDDR);
-}
+static struct gpio_led p720t_gpio_leds[] = {
+	{
+		.name			= "User LED",
+		.default_trigger	= "heartbeat",
+		.gpio			= GPIO_USERLED,
+	},
+};
 
-static enum led_brightness p720t_led_get(struct led_classdev *cdev)
-{
-	u8 reg = clps_readb(PDDR);
+static struct gpio_led_platform_data p720t_gpio_led_pdata = {
+	.leds		= p720t_gpio_leds,
+	.num_leds	= ARRAY_SIZE(p720t_gpio_leds),
+};
 
-	return (reg & 0x1) ? LED_FULL : LED_OFF;
-}
+static struct platform_device p720t_gpio_led_pdev = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &p720t_gpio_led_pdata,
+	},
+};
 
-static int __init p720t_leds_init(void)
+static void __init p720t_init(void)
 {
-
-	struct led_classdev *cdev;
-	int ret;
-
-	if (!machine_is_p720t())
-		return -ENODEV;
-
-	cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
-	if (!cdev)
-		return -ENOMEM;
-
-	cdev->name = "p720t:0";
-	cdev->brightness_set = p720t_led_set;
-	cdev->brightness_get = p720t_led_get;
-	cdev->default_trigger = "heartbeat";
-
-	ret = led_classdev_register(NULL, cdev);
-	if (ret	< 0) {
-		kfree(cdev);
-		return ret;
-	}
-
-	return 0;
+	platform_device_register_simple("uart-clps711x", 0, NULL, 0);
 }
 
-/*
- * Since we may have triggers on any subsystem, defer registration
- * until after subsystem_init.
- */
-fs_initcall(p720t_leds_init);
-#endif
-
-static void __init p720t_init(void)
+static void __init p720t_init_late(void)
 {
-	platform_device_register_simple("uart-clps711x", 0, NULL, 0);
+	platform_device_register(&p720t_gpio_led_pdev);
 }
 
 MACHINE_START(P720T, "ARM-Prospector720T")
@@ -174,6 +144,7 @@ MACHINE_START(P720T, "ARM-Prospector720T")
 	.map_io		= p720t_map_io,
 	.init_early	= p720t_init_early,
 	.init_machine	= p720t_init,
+	.init_late	= p720t_init_late,
 	.init_irq	= clps711x_init_irq,
 	.restart	= clps711x_restart,
 	.timer		= &clps711x_timer,
-- 
1.7.8.6
