From: peterhuewe@gmx.de (Peter Huewe)
Date: Thu,  9 Dec 2010 23:04:52 +0100
Subject: [PATCH] leds/h1940: Use gpiolib for latch access / fix build failure
Message-ID: <1291932292-16049-1-git-send-email-peterhuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a build failure by converting leds-h1940.c to use
gpiolib for latch access introduced by 14477095abc6
(ARM: h1940: Use gpiolib for latch access)

Unfortunately this driver was not converted back then.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
KernelVersion: linux-next-20101209

Build failure:
  CC [M]  drivers/leds/leds-h1940.o
  drivers/leds/leds-h1940.c: In function 'h1940_greenled_set':
  drivers/leds/leds-h1940.c:33: error: implicit declaration of function 'h1940_latch_control'
  make[2]: *** [drivers/leds/leds-h1940

 drivers/leds/leds-h1940.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/leds/leds-h1940.c b/drivers/leds/leds-h1940.c
index 173d104..7811701 100644
--- a/drivers/leds/leds-h1940.c
+++ b/drivers/leds/leds-h1940.c
@@ -30,17 +30,17 @@ static void h1940_greenled_set(struct led_classdev *led_dev,
 {
 	switch (value) {
 	case LED_HALF:
-		h1940_latch_control(0, H1940_LATCH_LED_FLASH);
+		gpio_set_value(H1940_LATCH_LED_FLASH, 1);
 		s3c2410_gpio_setpin(S3C2410_GPA7, 1);
 		break;
 	case LED_FULL:
-		h1940_latch_control(0, H1940_LATCH_LED_GREEN);
+		gpio_set_value(H1940_LATCH_LED_GREEN, 1);
 		s3c2410_gpio_setpin(S3C2410_GPA7, 1);
 		break;
 	default:
 	case LED_OFF:
-		h1940_latch_control(H1940_LATCH_LED_FLASH, 0);
-		h1940_latch_control(H1940_LATCH_LED_GREEN, 0);
+		gpio_set_value(H1940_LATCH_LED_FLASH, 0);
+		gpio_set_value(H1940_LATCH_LED_GREEN, 0);
 		s3c2410_gpio_setpin(S3C2410_GPA7, 0);
 		break;
 	}
@@ -60,17 +60,17 @@ static void h1940_redled_set(struct led_classdev *led_dev,
 {
 	switch (value) {
 	case LED_HALF:
-		h1940_latch_control(0, H1940_LATCH_LED_FLASH);
+		gpio_set_value(H1940_LATCH_LED_FLASH, 1);
 		s3c2410_gpio_setpin(S3C2410_GPA1, 1);
 		break;
 	case LED_FULL:
-		h1940_latch_control(0, H1940_LATCH_LED_RED);
+		gpio_set_value(H1940_LATCH_LED_RED, 1);
 		s3c2410_gpio_setpin(S3C2410_GPA1, 1);
 		break;
 	default:
 	case LED_OFF:
-		h1940_latch_control(H1940_LATCH_LED_FLASH, 0);
-		h1940_latch_control(H1940_LATCH_LED_RED, 0);
+		gpio_set_value(H1940_LATCH_LED_FLASH, 0);
+		gpio_set_value(H1940_LATCH_LED_RED, 0);
 		s3c2410_gpio_setpin(S3C2410_GPA1, 0);
 		break;
 	}
@@ -91,10 +91,10 @@ static void h1940_blueled_set(struct led_classdev *led_dev,
 {
 	if (value) {
 		/* flashing Blue */
-		h1940_latch_control(0, H1940_LATCH_LED_FLASH);
+		gpio_set_value(H1940_LATCH_LED_FLASH, 1);
 		s3c2410_gpio_setpin(S3C2410_GPA3, 1);
 	} else {
-		h1940_latch_control(H1940_LATCH_LED_FLASH, 0);
+		gpio_set_value(H1940_LATCH_LED_FLASH, 0);
 		s3c2410_gpio_setpin(S3C2410_GPA3, 0);
 	}
 
-- 
1.7.2.2
