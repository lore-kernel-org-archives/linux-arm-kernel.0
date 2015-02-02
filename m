From: grygorii.strashko@linaro.org (grygorii.strashko at linaro.org)
Date: Mon,  2 Feb 2015 18:33:06 +0200
Subject: [PATCH] leds: add hibernation callbacks
Message-ID: <1422894786-23353-1-git-send-email-grygorii.strashko@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Grygorii Strashko <Grygorii.Strashko@linaro.org>

Setting a dev_pm_ops suspend/resume pair of callbacks but not a set of
hibernation callbacks means those pm functions will not be
called upon hibernation - that leads to system crash on ARM during
freezing if gpio-led is used in combination with CPU led trigger.
It may happen after freeze_noirq stage (GPIO is suspended)
and before syscore_suspend stage (CPU led trigger is suspended)
- usually when disable_nonboot_cpus() is called.

Fix this by using SIMPLE_DEV_PM_OPS, which appropriately
assigns the suspend and hibernation callbacks.

Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
---
 drivers/leds/led-class.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index f37d63c..4c03808 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -198,10 +198,7 @@ static int led_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops leds_class_dev_pm_ops = {
-	.suspend        = led_suspend,
-	.resume         = led_resume,
-};
+static SIMPLE_DEV_PM_OPS(leds_class_dev_pm_ops, led_suspend, led_resume);
 
 /**
  * led_classdev_register - register a new object of led_classdev class.
-- 
1.9.1
