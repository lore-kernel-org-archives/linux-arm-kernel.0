From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Mon,  4 Jul 2011 02:45:24 +0400
Subject: [PATCH V3 1/2] gpio-vbus: support disabling D+ pullup on suspend
In-Reply-To: <1309733125-10869-1-git-send-email-dbaryshkov@gmail.com>
References: <1309733125-10869-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <1309733125-10869-2-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platforms would like to disable D+ pullup on suspend, to drain as
low power, as possible. E.g. this was requested by mioa701 board
maintainers.

Suspend/resume is done in _noirq path, to force handling of pullup after
the main UDC driver suspend/before resume.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 drivers/usb/otg/gpio_vbus.c   |   42 +++++++++++++++++++++++++++++++++++++++++
 include/linux/usb/gpio_vbus.h |    1 +
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/otg/gpio_vbus.c b/drivers/usb/otg/gpio_vbus.c
index 52733d9..0754445 100644
--- a/drivers/usb/otg/gpio_vbus.c
+++ b/drivers/usb/otg/gpio_vbus.c
@@ -327,6 +327,47 @@ static int __exit gpio_vbus_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int gpio_vbus_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_vbus_data *gpio_vbus = platform_get_drvdata(pdev);
+	struct gpio_vbus_mach_info *pdata = gpio_vbus->dev->platform_data;
+
+	if (gpio_vbus->otg.gadget && pdata->disconnect_on_suspend) {
+		/* optionally disable D+ pullup */
+		if (gpio_is_valid(pdata->gpio_pullup))
+			gpio_set_value(pdata->gpio_pullup,
+					pdata->gpio_pullup_inverted);
+
+		set_vbus_draw(gpio_vbus, 0);
+	}
+	return 0;
+}
+
+static int gpio_vbus_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct gpio_vbus_data *gpio_vbus = platform_get_drvdata(pdev);
+
+	if (gpio_vbus->otg.gadget)
+		schedule_work(&gpio_vbus->work);
+
+	return 0;
+}
+static const struct dev_pm_ops gpio_vbus_pm_ops = {
+	.suspend_noirq = gpio_vbus_suspend,
+	.resume_noirq = gpio_vbus_resume,
+	.freeze_noirq = gpio_vbus_suspend,
+	.thaw_noirq = gpio_vbus_resume,
+	.poweroff_noirq = gpio_vbus_suspend,
+	.restore_noirq = gpio_vbus_resume,
+};
+#define GPIO_VBUS_PM_OPS &gpio_vbus_pm_ops
+#else
+#define GPIO_VBUS_PM_OPS NULL
+#endif
+
 /* NOTE:  the gpio-vbus device may *NOT* be hotplugged */
 
 MODULE_ALIAS("platform:gpio-vbus");
@@ -335,6 +376,7 @@ static struct platform_driver gpio_vbus_driver = {
 	.driver = {
 		.name  = "gpio-vbus",
 		.owner = THIS_MODULE,
+		.pm = GPIO_VBUS_PM_OPS,
 	},
 	.remove  = __exit_p(gpio_vbus_remove),
 };
diff --git a/include/linux/usb/gpio_vbus.h b/include/linux/usb/gpio_vbus.h
index d9f03cc..2faa38d 100644
--- a/include/linux/usb/gpio_vbus.h
+++ b/include/linux/usb/gpio_vbus.h
@@ -27,4 +27,5 @@ struct gpio_vbus_mach_info {
 	int gpio_pullup;
 	bool gpio_vbus_inverted;
 	bool gpio_pullup_inverted;
+	bool disconnect_on_suspend;
 };
-- 
1.7.5.4
