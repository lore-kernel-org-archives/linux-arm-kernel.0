From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 25 Sep 2015 11:14:09 +0200
Subject: [PATCH] pinctrl: at91-pio4: add PM stuff
Message-ID: <1443172449-19915-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow GPIOs to be configured as wakeup sources. When going to suspend,
disable all GPIO irqs excepting the one configured as wakeup sources.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/pinctrl/pinctrl-at91-pio4.c | 76 +++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 6aff632..5e2189f 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -16,6 +16,7 @@
 
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -122,6 +123,8 @@ struct atmel_pioctrl {
 	struct gpio_chip	*gpio_chip;
 	struct irq_domain	*irq_domain;
 	int			*irqs;
+	unsigned		*pm_wakeup_sources;
+	unsigned		*pm_suspend_backup;
 	struct device		*dev;
 	struct device_node	*node;
 };
@@ -214,12 +217,35 @@ static void atmel_gpio_irq_unmask(struct irq_data *d)
 			 BIT(pin->line));
 }
 
+#ifdef CONFIG_PM_SLEEP
+
+static int atmel_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct atmel_pioctrl *atmel_pioctrl = irq_data_get_irq_chip_data(d);
+	int bank = ATMEL_PIO_BANK(d->hwirq);
+	int line = ATMEL_PIO_LINE(d->hwirq);
+
+	/* The gpio controller has one interrupt line per bank. */
+	irq_set_irq_wake(atmel_pioctrl->irqs[bank], on);
+
+	if (on)
+		atmel_pioctrl->pm_wakeup_sources[bank] |= BIT(line);
+	else
+		atmel_pioctrl->pm_wakeup_sources[bank] &= ~(BIT(line));
+
+	return 0;
+}
+#else
+#define atmel_gpio_irq_set_wake NULL
+#endif /* CONFIG_PM_SLEEP */
+
 static struct irq_chip atmel_gpio_irq_chip = {
 	.name		= "GPIO",
 	.irq_ack	= atmel_gpio_irq_ack,
 	.irq_mask	= atmel_gpio_irq_mask,
 	.irq_unmask	= atmel_gpio_irq_unmask,
 	.irq_set_type	= atmel_gpio_irq_set_type,
+	.irq_set_wake	= atmel_gpio_irq_set_wake,
 };
 
 static void atmel_gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
@@ -792,6 +818,43 @@ static struct pinctrl_desc atmel_pinctrl_desc = {
 	.pmxops		= &atmel_pmxops,
 };
 
+static int atmel_pctrl_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct atmel_pioctrl *atmel_pioctrl = platform_get_drvdata(pdev);
+	int i;
+
+	/*
+	 * For each bank, save IMR to restore it later and disable all GPIO
+	 * interrupts excepting the ones marked as wakeup sources.
+	 */
+	for (i = 0; i < atmel_pioctrl->nbanks; i++) {
+		atmel_pioctrl->pm_suspend_backup[i] =
+			atmel_gpio_read(atmel_pioctrl, i, ATMEL_PIO_IMR);
+		atmel_gpio_write(atmel_pioctrl, i, ATMEL_PIO_IDR,
+				 ~atmel_pioctrl->pm_wakeup_sources[i]);
+	}
+
+	return 0;
+}
+
+static int atmel_pctrl_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct atmel_pioctrl *atmel_pioctrl = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < atmel_pioctrl->nbanks; i++)
+		atmel_gpio_write(atmel_pioctrl, i, ATMEL_PIO_IER,
+				 atmel_pioctrl->pm_suspend_backup[i]);
+
+	return 0;
+}
+
+static const struct dev_pm_ops atmel_pctrl_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(atmel_pctrl_suspend, atmel_pctrl_resume)
+};
+
 /*
  * The number of banks can be different from a SoC to another one.
  * We can have up to 16 banks.
@@ -908,6 +971,18 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 	atmel_pioctrl->gpio_chip->dev = dev;
 	atmel_pioctrl->gpio_chip->names = atmel_pioctrl->group_names;
 
+	atmel_pioctrl->pm_wakeup_sources = devm_kzalloc(dev,
+			sizeof(*atmel_pioctrl->pm_wakeup_sources)
+			* atmel_pioctrl->nbanks, GFP_KERNEL);
+	if (!atmel_pioctrl->pm_wakeup_sources)
+		return -ENOMEM;
+
+	atmel_pioctrl->pm_suspend_backup = devm_kzalloc(dev,
+			sizeof(*atmel_pioctrl->pm_suspend_backup)
+			* atmel_pioctrl->nbanks, GFP_KERNEL);
+	if (!atmel_pioctrl->pm_suspend_backup)
+		return -ENOMEM;
+
 	atmel_pioctrl->irqs = devm_kzalloc(dev, sizeof(*atmel_pioctrl->irqs)
 			* atmel_pioctrl->nbanks, GFP_KERNEL);
 	if (!atmel_pioctrl->irqs)
@@ -1006,6 +1081,7 @@ static struct platform_driver atmel_pinctrl_driver = {
 	.driver = {
 		.name = "pinctrl-at91-pio4",
 		.of_match_table = atmel_pctrl_of_match,
+		.pm = &atmel_pctrl_pm_ops,
 	},
 	.probe = atmel_pinctrl_probe,
 	.remove = atmel_pinctrl_remove,
-- 
2.5.0
