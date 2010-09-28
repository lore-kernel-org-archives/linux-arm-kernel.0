From: arun.murthy@stericsson.com (Arun Murthy)
Date: Tue, 28 Sep 2010 16:05:30 +0530
Subject: [PATCH 3/7] leds: pwm: add a new element 'name' to platform data
In-Reply-To: <1285670134-18063-1-git-send-email-arun.murthy@stericsson.com>
References: <1285670134-18063-1-git-send-email-arun.murthy@stericsson.com>
Message-ID: <1285670134-18063-4-git-send-email-arun.murthy@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new element 'name' is added to pwm led platform data structure.
This is required to identify the pwm device.

Signed-off-by: Arun Murthy <arun.murthy@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/leds/leds-pwm.c  |    4 +++-
 include/linux/leds_pwm.h |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index da3fa8d..8da2be6 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -66,8 +66,10 @@ static int led_pwm_probe(struct platform_device *pdev)
 		cur_led = &pdata->leds[i];
 		led_dat = &leds_data[i];
 
+		if (!pdata->name)
+			pdata->name = cur_led->name;
 		led_dat->pwm = pwm_request(cur_led->pwm_id,
-				cur_led->name);
+				pdata->name);
 		if (IS_ERR(led_dat->pwm)) {
 			dev_err(&pdev->dev, "unable to request PWM %d\n",
 					cur_led->pwm_id);
diff --git a/include/linux/leds_pwm.h b/include/linux/leds_pwm.h
index 33a0711..7a847a0 100644
--- a/include/linux/leds_pwm.h
+++ b/include/linux/leds_pwm.h
@@ -16,6 +16,7 @@ struct led_pwm {
 struct led_pwm_platform_data {
 	int			num_leds;
 	struct led_pwm	*leds;
+	char *name;
 };
 
 #endif
-- 
1.7.2.dirty
