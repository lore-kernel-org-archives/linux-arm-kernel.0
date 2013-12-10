From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 11 Dec 2013 02:47:16 +0400
Subject: [PATCH] gpio-charger: support wakeup events
Message-ID: <1386715636-18134-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for using gpio-charger IRQ as a wakeup event.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/power/gpio-charger.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/power/gpio-charger.c b/drivers/power/gpio-charger.c
index 4e858a2..a0024b2 100644
--- a/drivers/power/gpio-charger.c
+++ b/drivers/power/gpio-charger.c
@@ -28,6 +28,7 @@
 struct gpio_charger {
 	const struct gpio_charger_platform_data *pdata;
 	unsigned int irq;
+	bool wakeup_enabled;
 
 	struct power_supply charger;
 };
@@ -136,6 +137,8 @@ static int gpio_charger_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, gpio_charger);
 
+	device_init_wakeup(&pdev->dev, 1);
+
 	return 0;
 
 err_gpio_free:
@@ -159,18 +162,32 @@ static int gpio_charger_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
+static int gpio_charger_suspend(struct device *dev)
+{
+	struct gpio_charger *gpio_charger = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		gpio_charger->wakeup_enabled =
+			enable_irq_wake(gpio_charger->irq);
+
+	return 0;
+}
+
 static int gpio_charger_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct gpio_charger *gpio_charger = platform_get_drvdata(pdev);
 
+	if (gpio_charger->wakeup_enabled)
+		disable_irq_wake(gpio_charger->irq);
 	power_supply_changed(&gpio_charger->charger);
 
 	return 0;
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(gpio_charger_pm_ops, NULL, gpio_charger_resume);
+static SIMPLE_DEV_PM_OPS(gpio_charger_pm_ops,
+		gpio_charger_suspend, gpio_charger_resume);
 
 static struct platform_driver gpio_charger_driver = {
 	.probe = gpio_charger_probe,
-- 
1.8.4.3
