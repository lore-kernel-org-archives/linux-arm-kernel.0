From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 28 Nov 2011 21:37:15 +0800
Subject: [PATCH 1/5] mfd: mc13xxx: add device tree probe support
In-Reply-To: <1322487439-27254-1-git-send-email-shawn.guo@linaro.org>
References: <1322487439-27254-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1322487439-27254-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It adds device tree probe support for mc13xxx mfd driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/mc13xxx-core.c |  121 ++++++++++++++++++++++++++++++++------------
 1 files changed, 89 insertions(+), 32 deletions(-)

diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index e9619ac..34332e7 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -18,11 +18,15 @@
 #include <linux/spi/spi.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/mc13xxx.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
 
 struct mc13xxx {
 	struct spi_device *spidev;
 	struct mutex lock;
-	int irq;
+	int irq_gpio;
+	int flags;
 
 	irq_handler_t irqhandler[MC13XXX_NUM_IRQ];
 	void *irqdata[MC13XXX_NUM_IRQ];
@@ -550,10 +554,7 @@ static const char *mc13xxx_get_chipname(struct mc13xxx *mc13xxx)
 
 int mc13xxx_get_flags(struct mc13xxx *mc13xxx)
 {
-	struct mc13xxx_platform_data *pdata =
-		dev_get_platdata(&mc13xxx->spidev->dev);
-
-	return pdata->flags;
+	return mc13xxx->flags;
 }
 EXPORT_SYMBOL(mc13xxx_get_flags);
 
@@ -696,17 +697,68 @@ static int mc13xxx_add_subdevice(struct mc13xxx *mc13xxx, const char *format)
 	return mc13xxx_add_subdevice_pdata(mc13xxx, format, NULL, 0);
 }
 
+#ifdef CONFIG_OF
+static int mc13xxx_probe_flags_dt(struct mc13xxx *mc13xxx)
+{
+	struct device_node *np = mc13xxx->spidev->dev.of_node;
+
+	if (!np)
+		return -ENODEV;
+
+	if (of_get_property(np, "fsl,mc13xxx-uses-adc", NULL))
+		mc13xxx->flags |= MC13XXX_USE_ADC;
+
+	if (of_get_property(np, "fsl,mc13xxx-uses-codec", NULL))
+		mc13xxx->flags |= MC13XXX_USE_CODEC;
+
+	if (of_get_property(np, "fsl,mc13xxx-uses-rtc", NULL))
+		mc13xxx->flags |= MC13XXX_USE_RTC;
+
+	if (of_get_property(np, "fsl,mc13xxx-uses-touch", NULL))
+		mc13xxx->flags |= MC13XXX_USE_TOUCHSCREEN;
+
+	return 0;
+}
+#else
+static inline int mc13xxx_probe_flags_dt(struct mc13xxx *mc13xxx)
+{
+	return -ENODEV;
+}
+#endif
+
+static const struct spi_device_id mc13xxx_device_id[] = {
+	{
+		.name = "mc13783",
+		.driver_data = MC13XXX_ID_MC13783,
+	}, {
+		.name = "mc13892",
+		.driver_data = MC13XXX_ID_MC13892,
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(spi, mc13xxx_device_id);
+
+static const struct of_device_id mc13xxx_dt_ids[] = {
+	{ .compatible = "fsl,mc13783", .data = (void *) MC13XXX_ID_MC13783, },
+	{ .compatible = "fsl,mc13892", .data = (void *) MC13XXX_ID_MC13892, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mc13xxx_dt_ids);
+
 static int mc13xxx_probe(struct spi_device *spi)
 {
+	struct device_node *np = spi->dev.of_node;
+	const struct of_device_id *of_id;
+	struct spi_driver *sdrv = to_spi_driver(spi->dev.driver);
 	struct mc13xxx *mc13xxx;
 	struct mc13xxx_platform_data *pdata = dev_get_platdata(&spi->dev);
 	enum mc13xxx_id id;
 	int ret;
 
-	if (!pdata) {
-		dev_err(&spi->dev, "invalid platform data\n");
-		return -EINVAL;
-	}
+	of_id = of_match_device(mc13xxx_dt_ids, &spi->dev);
+	if (of_id)
+		sdrv->id_table = &mc13xxx_device_id[(enum mc13xxx_id) of_id->data];
 
 	mc13xxx = kzalloc(sizeof(*mc13xxx), GFP_KERNEL);
 	if (!mc13xxx)
@@ -735,6 +787,15 @@ static int mc13xxx_probe(struct spi_device *spi)
 	if (ret)
 		goto err_mask;
 
+	mc13xxx->irq_gpio = of_get_named_gpio(np, "mc13xxx-irq-gpios", 0);
+	if (gpio_is_valid(mc13xxx->irq_gpio)) {
+		ret = gpio_request_one(mc13xxx->irq_gpio, GPIOF_IN,
+				       "mc13xxx-irq");
+		if (ret)
+			goto err_mask;
+		spi->irq = gpio_to_irq(mc13xxx->irq_gpio);
+	}
+
 	ret = request_threaded_irq(spi->irq, NULL, mc13xxx_irq_thread,
 			IRQF_ONESHOT | IRQF_TRIGGER_HIGH, "mc13xxx", mc13xxx);
 
@@ -749,28 +810,33 @@ err_revision:
 
 	mc13xxx_unlock(mc13xxx);
 
-	if (pdata->flags & MC13XXX_USE_ADC)
+	if (mc13xxx_probe_flags_dt(mc13xxx) < 0 && pdata)
+		mc13xxx->flags = pdata->flags;
+
+	if (mc13xxx->flags & MC13XXX_USE_ADC)
 		mc13xxx_add_subdevice(mc13xxx, "%s-adc");
 
-	if (pdata->flags & MC13XXX_USE_CODEC)
+	if (mc13xxx->flags & MC13XXX_USE_CODEC)
 		mc13xxx_add_subdevice(mc13xxx, "%s-codec");
 
-	mc13xxx_add_subdevice_pdata(mc13xxx, "%s-regulator",
-		&pdata->regulators, sizeof(pdata->regulators));
-
-	if (pdata->flags & MC13XXX_USE_RTC)
+	if (mc13xxx->flags & MC13XXX_USE_RTC)
 		mc13xxx_add_subdevice(mc13xxx, "%s-rtc");
 
-	if (pdata->flags & MC13XXX_USE_TOUCHSCREEN)
+	if (mc13xxx->flags & MC13XXX_USE_TOUCHSCREEN)
 		mc13xxx_add_subdevice(mc13xxx, "%s-ts");
 
-	if (pdata->leds)
+	if (pdata) {
+		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-regulator",
+			&pdata->regulators, sizeof(pdata->regulators));
 		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
 				pdata->leds, sizeof(*pdata->leds));
-
-	if (pdata->buttons)
 		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-pwrbutton",
 				pdata->buttons, sizeof(*pdata->buttons));
+	} else {
+		mc13xxx_add_subdevice(mc13xxx, "%s-regulator");
+		mc13xxx_add_subdevice(mc13xxx, "%s-led");
+		mc13xxx_add_subdevice(mc13xxx, "%s-pwrbutton");
+	}
 
 	return 0;
 }
@@ -781,6 +847,9 @@ static int __devexit mc13xxx_remove(struct spi_device *spi)
 
 	free_irq(mc13xxx->spidev->irq, mc13xxx);
 
+	if (gpio_is_valid(mc13xxx->irq_gpio))
+		gpio_free(mc13xxx->irq_gpio);
+
 	mfd_remove_devices(&spi->dev);
 
 	kfree(mc13xxx);
@@ -788,25 +857,13 @@ static int __devexit mc13xxx_remove(struct spi_device *spi)
 	return 0;
 }
 
-static const struct spi_device_id mc13xxx_device_id[] = {
-	{
-		.name = "mc13783",
-		.driver_data = MC13XXX_ID_MC13783,
-	}, {
-		.name = "mc13892",
-		.driver_data = MC13XXX_ID_MC13892,
-	}, {
-		/* sentinel */
-	}
-};
-MODULE_DEVICE_TABLE(spi, mc13xxx_device_id);
-
 static struct spi_driver mc13xxx_driver = {
 	.id_table = mc13xxx_device_id,
 	.driver = {
 		.name = "mc13xxx",
 		.bus = &spi_bus_type,
 		.owner = THIS_MODULE,
+		.of_match_table = mc13xxx_dt_ids,
 	},
 	.probe = mc13xxx_probe,
 	.remove = __devexit_p(mc13xxx_remove),
-- 
1.7.4.1
