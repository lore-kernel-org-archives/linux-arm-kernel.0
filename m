From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu,  6 Nov 2014 12:23:23 +0100
Subject: [PATCH] leds: leds-gpio: Fix legacy GPIO number case
Message-ID: <1415273003-27674-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the legacy case, led_dat->gpiod is initialized correctly, but
overwritten later by template->gpiod, which is NULL, causing leds-gpio
to fail with:

    gpiod_direction_output: invalid GPIO
    leds-gpio: probe of leds-gpio failed with error -22

Move the initialization of led_dat->gpiod from template->gpiod up, and
always use led_dat->gpiod later, to fix this.

Fixes: 5c51277a9ababfa4 ("leds: leds-gpio: Add support for GPIO descriptors")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/leds/leds-gpio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-gpio.c b/drivers/leds/leds-gpio.c
index ba4698c32bb04bde..b3c5d9d6a42bcd8b 100644
--- a/drivers/leds/leds-gpio.c
+++ b/drivers/leds/leds-gpio.c
@@ -92,7 +92,8 @@ static int create_gpio_led(const struct gpio_led *template,
 {
 	int ret, state;
 
-	if (!template->gpiod) {
+	led_dat->gpiod = template->gpiod;
+	if (!led_dat->gpiod) {
 		/*
 		 * This is the legacy code path for platform code that
 		 * still uses GPIO numbers. Ultimately we would like to get
@@ -122,8 +123,7 @@ static int create_gpio_led(const struct gpio_led *template,
 
 	led_dat->cdev.name = template->name;
 	led_dat->cdev.default_trigger = template->default_trigger;
-	led_dat->gpiod = template->gpiod;
-	led_dat->can_sleep = gpiod_cansleep(template->gpiod);
+	led_dat->can_sleep = gpiod_cansleep(led_dat->gpiod);
 	led_dat->blinking = 0;
 	if (blink_set) {
 		led_dat->platform_gpio_blink_set = blink_set;
-- 
1.9.1
