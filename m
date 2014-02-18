From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 18 Feb 2014 13:09:28 +0000
Subject: [PATCH RFC 1/2] leds: add DT support for LEDs wired to supply and
 default brightness
Message-ID: <E1WFkQS-0005JS-L5@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some PWM outputs are wired such that the LED they're controlling is
connected to supply rather than ground.  Therefore, the duty cycle
needs to be inverted to make the LED behave as it should do.

We also provide a way to specify the default brightness when a
trigger is not specified.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
=-DO NOT APPLY-=
 Documentation/devicetree/bindings/leds/leds-pwm.txt |  3 +++
 drivers/leds/leds-pwm.c                             | 15 +++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-pwm.txt b/Documentation/devicetree/bindings/leds/leds-pwm.txt
index 7297107cf832..ffcb74ab61fd 100644
=-DO NOT APPLY-= a/Documentation/devicetree/bindings/leds/leds-pwm.txt
=+DO NOT APPLY+= b/Documentation/devicetree/bindings/leds/leds-pwm.txt
@@ -13,6 +13,9 @@ node's name represents the name of the corresponding LED.
   For the pwms and pwm-names property please refer to:
   Documentation/devicetree/bindings/pwm/pwm.txt
 - max-brightness : Maximum brightness possible for the LED
=+DO NOT APPLY+=- default-brightness : (optional) Default brightness for the LED
=+DO NOT APPLY+=- active-low : (optional) For PWMs where the LED is wired to supply
=+DO NOT APPLY+=  rather than ground.
 - label :  (optional)
   see Documentation/devicetree/bindings/leds/common.txt
 - linux,default-trigger :  (optional)
diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 605047428b5a..fe2cd849b593 100644
=-DO NOT APPLY-= a/drivers/leds/leds-pwm.c
=+DO NOT APPLY+= b/drivers/leds/leds-pwm.c
@@ -70,6 +70,10 @@ static void led_pwm_set(struct led_classdev *led_cdev,
 
 	duty *= brightness;
 	do_div(duty, max);
=+DO NOT APPLY+=
=+DO NOT APPLY+=	if (led_dat->active_low)
=+DO NOT APPLY+=		duty = led_dat->period - duty;
=+DO NOT APPLY+=
 	led_dat->duty = duty;
 
 	if (led_dat->can_sleep)
@@ -93,6 +97,10 @@ static int led_pwm_create_of(struct platform_device *pdev,
 	for_each_child_of_node(pdev->dev.of_node, child) {
 		struct led_pwm_data *led_dat = &priv->leds[priv->num_leds];
 
=+DO NOT APPLY+=		led_dat->cdev.brightness_set = led_pwm_set;
=+DO NOT APPLY+=		led_dat->cdev.brightness = LED_OFF;
=+DO NOT APPLY+=		led_dat->cdev.flags |= LED_CORE_SUSPENDRESUME;
=+DO NOT APPLY+=
 		led_dat->cdev.name = of_get_property(child, "label",
 						     NULL) ? : child->name;
 
@@ -110,10 +118,9 @@ static int led_pwm_create_of(struct platform_device *pdev,
 						"linux,default-trigger", NULL);
 		of_property_read_u32(child, "max-brightness",
 				     &led_dat->cdev.max_brightness);
-
-		led_dat->cdev.brightness_set = led_pwm_set;
-		led_dat->cdev.brightness = LED_OFF;
-		led_dat->cdev.flags |= LED_CORE_SUSPENDRESUME;
=+DO NOT APPLY+=		of_property_read_u32(child, "default-brightness",
=+DO NOT APPLY+=				     &led_dat->cdev.brightness);
=+DO NOT APPLY+=		led_dat->active_low = of_property_read_bool(child, "active-low");
 
 		led_dat->can_sleep = pwm_can_sleep(led_dat->pwm);
 		if (led_dat->can_sleep)
-- 
1.8.3.1
