From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 19 Nov 2012 13:39:04 +0000
Subject: [PATCH] mfd: vexpress-sysreg: Remove LEDs code
Message-ID: <1353332344-16754-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the current LEDs code breaks other platform, remove it.

It shall be replaced by a generic "MMIO LEDs" driver.

Reported-by: Stephen Warren <swarren@wwwdotorg.org>
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/mfd/vexpress-sysreg.c |   77 -----------------------------------------
 1 file changed, 77 deletions(-)

Hi Arnd,

As I haven't managed to get any feedback on the generic MMIO
LEDs driver so far, I have to postpone it till next cycle and
completely remove the LED-related code from the vexpress-sysreg
driver, as it breaks other platforms today.

Would you be so kind to apply this patch, please? Alternatively
you can pull it from here:

  git://git.linaro.org/people/pawelmoll/linux.git vexpress-soc2

(this branch is based on the vexpress-soc you already have)

Cheers!

Pawel

diff --git a/drivers/mfd/vexpress-sysreg.c b/drivers/mfd/vexpress-sysreg.c
index 059d6b1..733c06b 100644
--- a/drivers/mfd/vexpress-sysreg.c
+++ b/drivers/mfd/vexpress-sysreg.c
@@ -473,80 +473,3 @@ static int __init vexpress_sysreg_init(void)
 	return platform_driver_register(&vexpress_sysreg_driver);
 }
 core_initcall(vexpress_sysreg_init);
-
-
-#if defined(CONFIG_LEDS_CLASS)
-
-struct vexpress_sysreg_led {
-	u32 mask;
-	struct led_classdev cdev;
-} vexpress_sysreg_leds[] = {
-	{ .mask = 1 << 0, .cdev.name = "v2m:green:user1",
-			.cdev.default_trigger = "heartbeat", },
-	{ .mask = 1 << 1, .cdev.name = "v2m:green:user2",
-			.cdev.default_trigger = "mmc0", },
-	{ .mask = 1 << 2, .cdev.name = "v2m:green:user3",
-			.cdev.default_trigger = "cpu0", },
-	{ .mask = 1 << 3, .cdev.name = "v2m:green:user4",
-			.cdev.default_trigger = "cpu1", },
-	{ .mask = 1 << 4, .cdev.name = "v2m:green:user5",
-			.cdev.default_trigger = "cpu2", },
-	{ .mask = 1 << 5, .cdev.name = "v2m:green:user6",
-			.cdev.default_trigger = "cpu3", },
-	{ .mask = 1 << 6, .cdev.name = "v2m:green:user7",
-			.cdev.default_trigger = "cpu4", },
-	{ .mask = 1 << 7, .cdev.name = "v2m:green:user8",
-			.cdev.default_trigger = "cpu5", },
-};
-
-static DEFINE_SPINLOCK(vexpress_sysreg_leds_lock);
-
-static void vexpress_sysreg_led_brightness_set(struct led_classdev *cdev,
-		enum led_brightness brightness)
-{
-	struct vexpress_sysreg_led *led = container_of(cdev,
-			struct vexpress_sysreg_led, cdev);
-	unsigned long flags;
-	u32 val;
-
-	spin_lock_irqsave(&vexpress_sysreg_leds_lock, flags);
-
-	val = readl(vexpress_sysreg_base + SYS_LED);
-	if (brightness == LED_OFF)
-		val &= ~led->mask;
-	else
-		val |= led->mask;
-	writel(val, vexpress_sysreg_base + SYS_LED);
-
-	spin_unlock_irqrestore(&vexpress_sysreg_leds_lock, flags);
-}
-
-static int __init vexpress_sysreg_init_leds(void)
-{
-	struct vexpress_sysreg_led *led;
-	int i;
-
-	/* Clear all user LEDs */
-	writel(0, vexpress_sysreg_base + SYS_LED);
-
-	for (i = 0, led = vexpress_sysreg_leds;
-			i < ARRAY_SIZE(vexpress_sysreg_leds); i++, led++) {
-		int err;
-
-		led->cdev.brightness_set = vexpress_sysreg_led_brightness_set;
-		err = led_classdev_register(vexpress_sysreg_dev, &led->cdev);
-		if (err) {
-			dev_err(vexpress_sysreg_dev,
-					"Failed to register LED %d! (%d)\n",
-					i, err);
-			while (led--, i--)
-				led_classdev_unregister(&led->cdev);
-			return err;
-		}
-	}
-
-	return 0;
-}
-device_initcall(vexpress_sysreg_init_leds);
-
-#endif
-- 
1.7.10.4
