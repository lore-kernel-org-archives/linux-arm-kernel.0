From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue,  5 Jul 2011 17:08:40 +0400
Subject: [PATCH 14/15] gpio-pullup: support disabling D+ pullup on suspend
In-Reply-To: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
References: <1309871321-11305-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1309871321-11305-15-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As it's done by gpio-vbus, support disabling D+ pullup on suspend to
save power.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/usb/otg/gpio_pullup.c |   45 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/gpio_pullup.c b/drivers/usb/otg/gpio_pullup.c
index 075d269..14c3322 100644
--- a/drivers/usb/otg/gpio_pullup.c
+++ b/drivers/usb/otg/gpio_pullup.c
@@ -132,10 +132,55 @@ static int __devexit gpio_pullup_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int gpio_pullup_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_pullup_data *gpio_pullup = platform_get_drvdata(pdev);
+	struct gpio_vbus_mach_info *pdata = gpio_pullup->dev->platform_data;
+
+	/* optionally disable D+ pullup */
+	if (gpio_pullup->otg.gadget && pdata->disconnect_on_suspend)
+		gpio_set_value(pdata->gpio_pullup,
+				pdata->gpio_pullup_inverted);
+
+	return 0;
+}
+
+static int gpio_pullup_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_pullup_data *gpio_pullup = platform_get_drvdata(pdev);
+	struct gpio_vbus_mach_info *pdata = gpio_pullup->dev->platform_data;
+
+	if (gpio_pullup->otg.gadget)
+		gpio_set_value(pdata->gpio_pullup,
+				!pdata->gpio_pullup_inverted);
+
+	return 0;
+}
+static const struct dev_pm_ops gpio_pullup_pm_ops = {
+	.suspend_noirq = gpio_pullup_suspend,
+	.resume_noirq = gpio_pullup_resume,
+	.freeze_noirq = gpio_pullup_suspend,
+	.thaw_noirq = gpio_pullup_resume,
+	.poweroff_noirq = gpio_pullup_suspend,
+	.restore_noirq = gpio_pullup_resume,
+};
+#define GPIO_PULLUP_PM_OPS (&gpio_pullup_pm_ops)
+#else
+#define GPIO_PULLUP_PM_OPS NULL
+#endif
+
+/* NOTE:  the gpio-pullup device may *NOT* be hotplugged */
+
+MODULE_ALIAS("platform:gpio-pullup");
+
 static struct platform_driver gpio_pullup_driver = {
 	.driver = {
 		.name  = "gpio-pullup",
 		.owner = THIS_MODULE,
+		.pm = GPIO_PULLUP_PM_OPS,
 	},
 	.probe		= gpio_pullup_probe,
 	.remove		= __devexit_p(gpio_pullup_remove),
-- 
1.7.5.4
