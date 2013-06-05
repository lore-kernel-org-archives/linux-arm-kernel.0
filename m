From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed,  5 Jun 2013 12:34:39 +0400
Subject: [PATCH v2 4/4] leds: leds-mc13xxx: Use module_platform_driver_probe
 for driver
In-Reply-To: <1370421279-23348-1-git-send-email-shc_work@mail.ru>
References: <1370421279-23348-1-git-send-email-shc_work@mail.ru>
Message-ID: <1370421279-23348-5-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MC13XXX LEDs is a part of MC13XXX MFD and driver loaded from
parent MFD driver, so replace module_platform_driver with
module_platform_driver_probe.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/leds/leds-mc13xxx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/leds-mc13xxx.c b/drivers/leds/leds-mc13xxx.c
index 53d7afd..3b64cc9 100644
--- a/drivers/leds/leds-mc13xxx.c
+++ b/drivers/leds/leds-mc13xxx.c
@@ -175,7 +175,7 @@ static void mc13xxx_led_set(struct led_classdev *led_cdev,
 	schedule_work(&led->work);
 }
 
-static int mc13xxx_led_setup(struct mc13xxx_led *led, int max_current)
+static int __init mc13xxx_led_setup(struct mc13xxx_led *led, int max_current)
 {
 	int shift, mask, reg, ret, bank;
 
@@ -244,7 +244,7 @@ static int mc13xxx_led_setup(struct mc13xxx_led *led, int max_current)
 	return ret;
 }
 
-static int mc13783_leds_startup(struct platform_device *pdev)
+static int __init mc13783_leds_startup(struct platform_device *pdev)
 {
 	struct mc13xxx_leds_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct mc13xxx *dev = dev_get_drvdata(pdev->dev.parent);
@@ -341,7 +341,7 @@ static void mc13783_leds_shutdown(struct platform_device *pdev)
 	mc13xxx_unlock(dev);
 }
 
-static int mc13892_leds_startup(struct platform_device *pdev)
+static int __init mc13892_leds_startup(struct platform_device *pdev)
 {
 	struct mc13xxx_leds_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct mc13xxx *dev = dev_get_drvdata(pdev->dev.parent);
@@ -401,7 +401,7 @@ static void mc13892_leds_shutdown(struct platform_device *pdev)
 	mc13xxx_unlock(dev);
 }
 
-static int mc13xxx_led_probe(struct platform_device *pdev)
+static int __init mc13xxx_led_probe(struct platform_device *pdev)
 {
 	struct mc13xxx_leds_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct mc13xxx_led_devtype *devtype =
@@ -535,11 +535,10 @@ static struct platform_driver mc13xxx_led_driver = {
 		.name	= "mc13xxx-led",
 		.owner	= THIS_MODULE,
 	},
-	.probe		= mc13xxx_led_probe,
 	.remove		= mc13xxx_led_remove,
 	.id_table	= mc13xxx_led_id_table,
 };
-module_platform_driver(mc13xxx_led_driver);
+module_platform_driver_probe(mc13xxx_led_driver, mc13xxx_led_probe);
 
 MODULE_DESCRIPTION("LEDs driver for Freescale MC13XXX PMIC");
 MODULE_AUTHOR("Philippe Retornaz <philippe.retornaz@epfl.ch>");
-- 
1.8.1.5
