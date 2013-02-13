From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 13 Feb 2013 18:34:32 +0100
Subject: [PATCH v2 8/8] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1360776872-18584-1-git-send-email-p.zabel@pengutronix.de>
References: <1360776872-18584-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1360776872-18584-9-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/Kconfig      |   13 +++
 drivers/reset/Makefile     |    1 +
 drivers/reset/gpio-reset.c |  188 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+)
 create mode 100644 drivers/reset/gpio-reset.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 66ac385..bdf799a 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -7,3 +7,16 @@ menuconfig RESET_CONTROLLER
 	  via GPIOs or SoC-internal reset controller modules.
 
 	  If unsure, say no.
+
+if RESET_CONTROLLER
+
+config RESET_GPIO
+	tristate "GPIO reset controller support"
+	depends on GENERIC_GPIO
+	help
+	  This driver provides support for reset lines that are controlled
+	  directly by GPIOs.
+	  The delay between assertion and de-assertion of the reset signal
+	  can be configured.
+
+endif
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 1e2d83f..b854f20 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_RESET_CONTROLLER) += core.o
+obj-$(CONFIG_RESET_GPIO) += gpio-reset.o
diff --git a/drivers/reset/gpio-reset.c b/drivers/reset/gpio-reset.c
new file mode 100644
index 0000000..c7ca858
--- /dev/null
+++ b/drivers/reset/gpio-reset.c
@@ -0,0 +1,188 @@
+/*
+ * Copyright 2013 Philipp Zabel, Pengutronix
+ */
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+
+struct gpio_reset {
+	unsigned int gpio;
+	unsigned long flags;
+	unsigned int delay_ms;
+};
+
+struct gpio_reset_data {
+	struct reset_controller_dev rcdev;
+	struct gpio_reset *gpios;
+	int nr_gpios;
+};
+
+static void __gpio_reset_set(struct gpio_reset_data *drvdata,
+		unsigned long gpio_idx, int asserted)
+{
+	int value = asserted;
+
+	if (drvdata->gpios[gpio_idx].flags == GPIOF_OUT_INIT_HIGH)
+		value = !value;
+
+	gpio_set_value(drvdata->gpios[gpio_idx].gpio, value);
+}
+
+static int gpio_reset(struct reset_controller_dev *rcdev,
+		unsigned long gpio_idx)
+{
+	struct gpio_reset_data *drvdata = container_of(rcdev,
+			struct gpio_reset_data, rcdev);
+
+	if (gpio_idx >= drvdata->nr_gpios)
+		return -EINVAL;
+
+	if (drvdata->gpios[gpio_idx].delay_ms < 0)
+		return -ENOSYS;
+
+	__gpio_reset_set(drvdata, gpio_idx, 1);
+	mdelay(drvdata->gpios[gpio_idx].delay_ms);
+	__gpio_reset_set(drvdata, gpio_idx, 0);
+
+	return 0;
+}
+
+static int gpio_reset_assert(struct reset_controller_dev *rcdev,
+		unsigned long gpio_idx)
+{
+	struct gpio_reset_data *drvdata = container_of(rcdev,
+			struct gpio_reset_data, rcdev);
+
+	if (gpio_idx >= drvdata->nr_gpios)
+		return -EINVAL;
+
+	__gpio_reset_set(drvdata, gpio_idx, 1);
+
+	return 0;
+}
+
+static int gpio_reset_deassert(struct reset_controller_dev *rcdev,
+		unsigned long gpio_idx)
+{
+	struct gpio_reset_data *drvdata = container_of(rcdev,
+			struct gpio_reset_data, rcdev);
+
+	if (gpio_idx >= drvdata->nr_gpios)
+		return -EINVAL;
+
+	__gpio_reset_set(drvdata, gpio_idx, 0);
+
+	return 0;
+}
+
+static struct reset_control_ops gpio_reset_ops = {
+	.reset = gpio_reset,
+	.assert = gpio_reset_assert,
+	.deassert = gpio_reset_deassert,
+};
+
+static int gpio_reset_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct gpio_reset_data *drvdata;
+	enum of_gpio_flags flags;
+	u32 *delays = NULL;
+	int ret;
+	int i;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (drvdata == NULL)
+		return -ENOMEM;
+
+	drvdata->nr_gpios = of_gpio_named_count(np, "gpios");
+	if (drvdata->nr_gpios < 1)
+		return -EINVAL;
+
+	drvdata->gpios = devm_kzalloc(&pdev->dev, sizeof(struct gpio_reset) *
+			drvdata->nr_gpios, GFP_KERNEL);
+	if (drvdata->gpios == NULL)
+		return -ENOMEM;
+
+	if (of_find_property(np, "reset-delays", NULL)) {
+		delays = devm_kzalloc(&pdev->dev, sizeof(u32) *
+				drvdata->nr_gpios, GFP_KERNEL);
+		if (delays == NULL)
+			return -ENOMEM;
+
+		ret = of_property_read_u32_array(np, "reset-delays", delays,
+				drvdata->nr_gpios);
+		if (ret < 0)
+			return ret;
+	}
+
+	for (i = 0; i < drvdata->nr_gpios; i++) {
+		drvdata->gpios[i].gpio = of_get_named_gpio_flags(np, "gpios",
+				i, &flags);
+		if (drvdata->gpios[i].gpio < 0) {
+			dev_err(&pdev->dev, "invalid gpio for reset %d\n", i);
+			return drvdata->gpios[i].gpio;
+		}
+
+		/*
+		 * The flags are also used to remember whether a given GPIO
+		 * reset is active-low.
+		 */
+		if (flags & OF_GPIO_ACTIVE_LOW)
+			drvdata->gpios[i].flags = GPIOF_OUT_INIT_HIGH;
+		else
+			drvdata->gpios[i].flags = GPIOF_OUT_INIT_LOW;
+
+		ret = devm_gpio_request_one(&pdev->dev, drvdata->gpios[i].gpio,
+				drvdata->gpios[i].flags, NULL);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to request gpio %d for reset %d\n",
+					drvdata->gpios[i].gpio, i);
+			return ret;
+		}
+
+		if (delays != NULL)
+			drvdata->gpios[i].delay_ms = delays[i];
+		else
+			drvdata->gpios[i].delay_ms = -1; /* .reset returns -ENOSYS */
+	}
+
+	devm_kfree(&pdev->dev, delays);
+
+	drvdata->rcdev.of_node = np;
+	drvdata->rcdev.ops = &gpio_reset_ops;
+	reset_controller_register(&drvdata->rcdev);
+
+	platform_set_drvdata(pdev, drvdata);
+
+	return 0;
+}
+
+static int gpio_reset_remove(struct platform_device *pdev)
+{
+	struct gpio_reset_data *drvdata = platform_get_drvdata(pdev);
+
+	reset_controller_unregister(&drvdata->rcdev);
+
+	return 0;
+}
+
+static struct of_device_id gpio_reset_dt_ids[] = {
+	{ .compatible = "gpio-reset" },
+	{ }
+};
+
+static struct platform_driver gpio_reset_driver = {
+	.probe = gpio_reset_probe,
+	.remove = gpio_reset_remove,
+	.driver = {
+		.name = "gpio-reset",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(gpio_reset_dt_ids),
+	},
+};
+
+module_platform_driver(gpio_reset_driver);
-- 
1.7.10.4
