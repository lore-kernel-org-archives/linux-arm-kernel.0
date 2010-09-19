From: simon@sequanux.org (Simon Guinot)
Date: Sun, 19 Sep 2010 15:30:59 +0200
Subject: [PATCH] leds: leds-ns2: fix locking
Message-ID: <1284903059-22935-1-git-send-email-simon@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: sguinot <sguinot@e0769a12-487d-4b36-8fb5-9ece92c58341>

This patch replace all the lock functions with the irq safe variant.
The ns2_led_{set,get}_mode() functions must be safe in all context.

For example, the trigger timer call led_set_brightness() in a softirq
context.

Signed-off-by: Simon Guinot <sguinot@lacie.com>
---
 drivers/leds/leds-ns2.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/leds-ns2.c b/drivers/leds/leds-ns2.c
index 74dce4b..350eb34 100644
--- a/drivers/leds/leds-ns2.c
+++ b/drivers/leds/leds-ns2.c
@@ -81,7 +81,7 @@ static int ns2_led_get_mode(struct ns2_led_data *led_dat,
 	int cmd_level;
 	int slow_level;
 
-	read_lock(&led_dat->rw_lock);
+	read_lock_irq(&led_dat->rw_lock);
 
 	cmd_level = gpio_get_value(led_dat->cmd);
 	slow_level = gpio_get_value(led_dat->slow);
@@ -95,7 +95,7 @@ static int ns2_led_get_mode(struct ns2_led_data *led_dat,
 		}
 	}
 
-	read_unlock(&led_dat->rw_lock);
+	read_unlock_irq(&led_dat->rw_lock);
 
 	return ret;
 }
@@ -104,8 +104,9 @@ static void ns2_led_set_mode(struct ns2_led_data *led_dat,
 			     enum ns2_led_modes mode)
 {
 	int i;
+	unsigned long flags;
 
-	write_lock(&led_dat->rw_lock);
+	write_lock_irqsave(&led_dat->rw_lock, flags);
 
 	for (i = 0; i < ARRAY_SIZE(ns2_led_modval); i++) {
 		if (mode == ns2_led_modval[i].mode) {
@@ -116,7 +117,7 @@ static void ns2_led_set_mode(struct ns2_led_data *led_dat,
 		}
 	}
 
-	write_unlock(&led_dat->rw_lock);
+	write_unlock_irqrestore(&led_dat->rw_lock, flags);
 }
 
 static void ns2_led_set(struct led_classdev *led_cdev,
-- 
1.6.3.1
