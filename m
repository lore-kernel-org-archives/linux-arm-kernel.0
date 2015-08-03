From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Mon, 3 Aug 2015 14:59:57 +0800
Subject: [PATCH 1/2] drivers: PL061: add support for platform driver probing
In-Reply-To: <1438585198-8764-1-git-send-email-zhaoshenglong@huawei.com>
References: <1438585198-8764-1-git-send-email-zhaoshenglong@huawei.com>
Message-ID: <1438585198-8764-2-git-send-email-zhaoshenglong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shannon Zhao <shannon.zhao@linaro.org>

Since PL061 currently only supports AMBA driver, to support using GPIO
PL061 by DT or ACPI, it needs to add support for platform driver.
A DT binding is provided with this patch, ACPI support is added in a
separate one.

Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
---
 drivers/gpio/gpio-pl061.c | 108 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
index 0475613..64c10eb 100644
--- a/drivers/gpio/gpio-pl061.c
+++ b/drivers/gpio/gpio-pl061.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/pm.h>
+#include <linux/platform_device.h>
 
 #define GPIODIR 0x400
 #define GPIOIS  0x404
@@ -241,6 +242,94 @@ static struct irq_chip pl061_irqchip = {
 	.irq_set_type	= pl061_irq_type,
 };
 
+static int pl061_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pl061_platform_data *pdata = dev_get_platdata(dev);
+	struct pl061_gpio *chip;
+	int ret, irq, i, irq_base;
+	struct resource *mem;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
+		return -EINVAL;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (chip == NULL)
+		return -ENOMEM;
+
+	if (pdata) {
+		chip->gc.base = pdata->gpio_base;
+		irq_base = pdata->irq_base;
+		if (irq_base <= 0) {
+			dev_err(&pdev->dev, "invalid IRQ base in pdata\n");
+			return -ENODEV;
+		}
+	} else {
+		chip->gc.base = -1;
+		irq_base = 0;
+	}
+
+	chip->base = devm_ioremap(dev, mem->start, resource_size(mem));
+	if (IS_ERR(chip->base))
+		return PTR_ERR(chip->base);
+
+	spin_lock_init(&chip->lock);
+	if (of_property_read_bool(dev->of_node, "gpio-ranges"))
+		chip->uses_pinctrl = true;
+
+	chip->gc.request = pl061_gpio_request;
+	chip->gc.free = pl061_gpio_free;
+	chip->gc.direction_input = pl061_direction_input;
+	chip->gc.direction_output = pl061_direction_output;
+	chip->gc.get = pl061_get_value;
+	chip->gc.set = pl061_set_value;
+	chip->gc.ngpio = PL061_GPIO_NR;
+	chip->gc.label = dev_name(dev);
+	chip->gc.dev = dev;
+	chip->gc.owner = THIS_MODULE;
+
+	ret = gpiochip_add(&chip->gc);
+	if (ret)
+		return ret;
+
+	/*
+	 * irq_chip support
+	 */
+	writeb(0, chip->base + GPIOIE); /* disable irqs */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "invalid IRQ\n");
+		return -ENODEV;
+	}
+
+	ret = gpiochip_irqchip_add(&chip->gc, &pl061_irqchip,
+				   irq_base, handle_simple_irq,
+				   IRQ_TYPE_NONE);
+	if (ret) {
+		dev_info(&pdev->dev, "could not add irqchip\n");
+		return ret;
+	}
+	gpiochip_set_chained_irqchip(&chip->gc, &pl061_irqchip,
+				     irq, pl061_irq_handler);
+
+	for (i = 0; i < PL061_GPIO_NR; i++) {
+		if (pdata) {
+			if (pdata->directions & (BIT(i)))
+				pl061_direction_output(&chip->gc, i,
+						pdata->values & (BIT(i)));
+			else
+				pl061_direction_input(&chip->gc, i);
+		}
+	}
+
+	platform_set_drvdata(pdev, chip);
+	dev_info(&pdev->dev, "PL061 GPIO chip @%pa registered\n",
+		 &mem->start);
+
+	return 0;
+}
+
 static int pl061_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct device *dev = &adev->dev;
@@ -376,6 +465,23 @@ static const struct dev_pm_ops pl061_dev_pm_ops = {
 };
 #endif
 
+static const struct of_device_id pl061_of_match[] = {
+	{ .compatible = "arm,pl061", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, pl061_of_match);
+
+static struct platform_driver pl061_gpio_platform_driver = {
+	.driver = {
+		.name	= "pl061_gpio",
+		.of_match_table	= pl061_of_match,
+#ifdef CONFIG_PM
+		.pm	= &pl061_dev_pm_ops,
+#endif
+	},
+	.probe		= pl061_platform_probe,
+};
+
 static struct amba_id pl061_ids[] = {
 	{
 		.id	= 0x00041061,
@@ -399,6 +505,8 @@ static struct amba_driver pl061_gpio_driver = {
 
 static int __init pl061_gpio_init(void)
 {
+	if (platform_driver_register(&pl061_gpio_platform_driver))
+		pr_warn("could not register PL061 platform driver\n");
 	return amba_driver_register(&pl061_gpio_driver);
 }
 module_init(pl061_gpio_init);
-- 
2.0.4
