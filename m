From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 18 Jun 2015 17:11:34 -0700
Subject: [PATCH 5/7] soc: brcmstb: add wake-timer driver
In-Reply-To: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
References: <1434672696-13632-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <1434672696-13632-6-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Useful for waking the system from suspend after a specified period of
time.

This IP could potentially be supported as an RTC driver (for use with
the 'rtcwake' utility), but it is not battery backed, so that's not a
great fit. Implement a custom sysfs interface instead.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 .../ABI/testing/sysfs-driver-wktmr-brcmstb         |  12 +
 drivers/soc/brcmstb/Kconfig                        |   3 +
 drivers/soc/brcmstb/Makefile                       |   1 +
 drivers/soc/brcmstb/wktmr.c                        | 242 +++++++++++++++++++++
 4 files changed, 258 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-wktmr-brcmstb
 create mode 100644 drivers/soc/brcmstb/wktmr.c

diff --git a/Documentation/ABI/testing/sysfs-driver-wktmr-brcmstb b/Documentation/ABI/testing/sysfs-driver-wktmr-brcmstb
new file mode 100644
index 000000000000..e563f8b8d969
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-wktmr-brcmstb
@@ -0,0 +1,12 @@
+What:		/sys/bus/platform/drivers/brcm-waketimer/<MMIO-address>.waketimer/timeout
+Date:		November 21, 2014
+KernelVersion:	3.14
+Contact:	Brian Norris <norris@broadcom.com>
+Description:	The control file for the wakeup timer. This integer value
+		represents the number of seconds between a suspend operation
+		(e.g., S3 suspend-to-RAM) and the time at which the wakeup
+		timer should fire.
+
+		Values are -1 (default) or any non-negative integer. Units are
+		in seconds. The special value of -1 means the timer should not
+		wake up the system.
diff --git a/drivers/soc/brcmstb/Kconfig b/drivers/soc/brcmstb/Kconfig
index 5025dacce6f0..e818eca7e847 100644
--- a/drivers/soc/brcmstb/Kconfig
+++ b/drivers/soc/brcmstb/Kconfig
@@ -16,4 +16,7 @@ config BRCMSTB_PM
 	depends on PM
 	depends on ARM && ARCH_BRCMSTB
 
+config BRCMSTB_WKTMR
+	tristate "Support wake-up timer"
+
 endif # SOC_BRCMSTB
diff --git a/drivers/soc/brcmstb/Makefile b/drivers/soc/brcmstb/Makefile
index 677e3fa0d042..6ecba0644229 100644
--- a/drivers/soc/brcmstb/Makefile
+++ b/drivers/soc/brcmstb/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_BRCMSTB_PM)	+= pm/
 
 obj-y				+= common.o
+obj-$(CONFIG_BRCMSTB_WKTMR)	+= wktmr.o
diff --git a/drivers/soc/brcmstb/wktmr.c b/drivers/soc/brcmstb/wktmr.c
new file mode 100644
index 000000000000..89f989724d3c
--- /dev/null
+++ b/drivers/soc/brcmstb/wktmr.c
@@ -0,0 +1,242 @@
+/*
+ * Copyright ? 2014-2015 Broadcom Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/stat.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/suspend.h>
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/pm.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/pm_wakeup.h>
+#include <linux/reboot.h>
+
+#define DRV_NAME	"brcm-waketimer"
+
+struct brcmstb_waketmr {
+	struct device *dev;
+	void __iomem *base;
+	unsigned int irq;
+
+	int wake_timeout;
+	struct notifier_block reboot_notifier;
+};
+
+/* No timeout */
+#define BRCMSTB_WKTMR_DEFAULT_TIMEOUT	(-1)
+
+#define BRCMSTB_WKTMR_EVENT		0x00
+#define BRCMSTB_WKTMR_COUNTER		0x04
+#define BRCMSTB_WKTMR_ALARM		0x08
+#define BRCMSTB_WKTMR_PRESCALER		0x0C
+#define BRCMSTB_WKTMR_PRESACALER_VAL	0x10
+
+static inline void brcmstb_waketmr_clear_alarm(struct brcmstb_waketmr *timer)
+{
+	writel_relaxed(1, timer->base + BRCMSTB_WKTMR_EVENT);
+	(void)readl_relaxed(timer->base + BRCMSTB_WKTMR_EVENT);
+}
+
+static void brcmstb_waketmr_set_alarm(struct brcmstb_waketmr *timer,
+		unsigned int secs)
+{
+	unsigned int t;
+
+	brcmstb_waketmr_clear_alarm(timer);
+
+	t = readl_relaxed(timer->base + BRCMSTB_WKTMR_COUNTER);
+	writel_relaxed(t + secs + 1, timer->base + BRCMSTB_WKTMR_ALARM);
+}
+
+static irqreturn_t brcmstb_waketmr_irq(int irq, void *data)
+{
+	struct brcmstb_waketmr *timer = data;
+	pm_wakeup_event(timer->dev, 0);
+	return IRQ_HANDLED;
+}
+
+static ssize_t brcmstb_waketmr_timeout_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", timer->wake_timeout);
+}
+
+static ssize_t brcmstb_waketmr_timeout_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
+	int timeout;
+	int ret;
+
+	ret = kstrtoint(buf, 0, &timeout);
+	if (ret < 0)
+		return ret;
+
+	/* Allow -1 as "no timeout" */
+	if (timeout < -1)
+		return -EINVAL;
+
+	timer->wake_timeout = timeout;
+
+	return count;
+}
+
+static const DEVICE_ATTR(timeout, S_IRUGO | S_IWUSR,
+		brcmstb_waketmr_timeout_show,
+		brcmstb_waketmr_timeout_store);
+
+static int brcmstb_waketmr_prepare_suspend(struct brcmstb_waketmr *timer)
+{
+	struct device *dev = timer->dev;
+	int ret;
+
+	if (device_may_wakeup(dev) && timer->wake_timeout >= 0) {
+		ret = enable_irq_wake(timer->irq);
+		if (ret) {
+			dev_err(dev, "failed to enable wake-up interrupt\n");
+			return ret;
+		}
+
+		brcmstb_waketmr_set_alarm(timer, timer->wake_timeout);
+	}
+	return 0;
+}
+
+/* If enabled as a wakeup-source, arm the timer when powering off */
+static int brcmstb_waketmr_reboot(struct notifier_block *nb,
+		unsigned long action, void *data)
+{
+	struct brcmstb_waketmr *timer;
+	timer = container_of(nb, struct brcmstb_waketmr, reboot_notifier);
+
+	/* Set timer for cold boot */
+	if (action == SYS_POWER_OFF)
+		brcmstb_waketmr_prepare_suspend(timer);
+
+	return NOTIFY_DONE;
+}
+
+static int brcmstb_waketmr_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct brcmstb_waketmr *timer;
+	struct resource *res;
+	int ret;
+
+	timer = devm_kzalloc(dev, sizeof(*timer), GFP_KERNEL);
+	if (!timer)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, timer);
+
+	timer->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	timer->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(timer->base))
+		return PTR_ERR(timer->base);
+
+	/*
+	 * Set wakeup capability before requesting wakeup interrupt, so we can
+	 * process boot-time "wakeups" (e.g., from S5 soft-off)
+	 */
+	device_set_wakeup_capable(dev, true);
+	device_wakeup_enable(dev);
+
+	timer->irq = platform_get_irq(pdev, 0);
+	if ((int)timer->irq < 0)
+		return -ENODEV;
+
+	ret = devm_request_irq(dev, timer->irq, brcmstb_waketmr_irq, 0,
+			       DRV_NAME, timer);
+	if (ret < 0)
+		return ret;
+
+	timer->reboot_notifier.notifier_call = brcmstb_waketmr_reboot;
+	register_reboot_notifier(&timer->reboot_notifier);
+
+	timer->wake_timeout = BRCMSTB_WKTMR_DEFAULT_TIMEOUT;
+
+	ret = device_create_file(dev, &dev_attr_timeout);
+	if (ret)
+		unregister_reboot_notifier(&timer->reboot_notifier);
+	else
+		dev_info(dev, "registered, with irq %d\n", timer->irq);
+	return ret;
+}
+
+static int brcmstb_waketmr_remove(struct platform_device *pdev)
+{
+	struct brcmstb_waketmr *timer = dev_get_drvdata(&pdev->dev);
+
+	device_remove_file(&pdev->dev, &dev_attr_timeout);
+	unregister_reboot_notifier(&timer->reboot_notifier);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int brcmstb_waketmr_suspend(struct device *dev)
+{
+	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
+
+	return brcmstb_waketmr_prepare_suspend(timer);
+}
+
+static int brcmstb_waketmr_resume(struct device *dev)
+{
+	struct brcmstb_waketmr *timer = dev_get_drvdata(dev);
+	int ret;
+
+	if (!device_may_wakeup(dev) || timer->wake_timeout < 0)
+		return 0;
+
+	ret = disable_irq_wake(timer->irq);
+
+	brcmstb_waketmr_clear_alarm(timer);
+
+	return ret;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+static SIMPLE_DEV_PM_OPS(brcmstb_waketmr_pm_ops, brcmstb_waketmr_suspend,
+		brcmstb_waketmr_resume);
+
+static const struct of_device_id brcmstb_waketmr_of_match[] = {
+	{ .compatible = "brcm,brcmstb-waketimer" },
+	{},
+};
+
+static struct platform_driver brcmstb_waketmr_driver = {
+	.probe			= brcmstb_waketmr_probe,
+	.remove			= brcmstb_waketmr_remove,
+	.driver = {
+		.name		= DRV_NAME,
+		.pm		= &brcmstb_waketmr_pm_ops,
+		.of_match_table	= of_match_ptr(brcmstb_waketmr_of_match),
+	}
+};
+module_platform_driver(brcmstb_waketmr_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Brian Norris");
+MODULE_DESCRIPTION("Wake-up timer driver for STB chips");
-- 
1.9.1
