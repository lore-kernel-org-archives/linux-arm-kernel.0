From: henryc.chen@mediatek.com (Henry Chen)
Date: Thu, 30 Jul 2015 23:07:26 +0800
Subject: [PATCH] mfd: mt6397: Implement wake handler and suspend/resume for
 mt6397-core.c
Message-ID: <1438268846-22451-1-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register mt6393_irq as wake up source to pinctrl by flag "IRQF_NO_SUSPEND".
Implement .irq_set_wake() function of pmic to keep who is wakeup source,
and enable irq on .suspend()and restore irq on .resume().

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 drivers/mfd/mt6397-core.c       | 49 ++++++++++++++++++++++++++++++++++++++++-
 include/linux/mfd/mt6397/core.h |  1 +
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 03929a6..aebdee5 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -93,12 +93,31 @@ static void mt6397_irq_enable(struct irq_data *data)
 	mt6397->irq_masks_cur[reg] |= BIT(shift);
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int mt6397_irq_set_wake(struct irq_data *irq_data, unsigned int on)
+{
+	struct mt6397_chip *mt6397 = irq_data_get_irq_chip_data(irq_data);
+	int shift = irq_data->hwirq & 0xf;
+	int reg = irq_data->hwirq >> 4;
+
+	if (on)
+		mt6397->wake_mask[reg] |= BIT(shift);
+	else
+		mt6397->wake_mask[reg] &= ~BIT(shift);
+
+	return 0;
+}
+#else
+#define mt6397_irq_set_wake NULL
+#endif
+
 static struct irq_chip mt6397_irq_chip = {
 	.name = "mt6397-irq",
 	.irq_bus_lock = mt6397_irq_lock,
 	.irq_bus_sync_unlock = mt6397_irq_sync_unlock,
 	.irq_enable = mt6397_irq_enable,
 	.irq_disable = mt6397_irq_disable,
+	.irq_set_wake = mt6397_irq_set_wake,
 };
 
 static void mt6397_irq_handle_reg(struct mt6397_chip *mt6397, int reg,
@@ -142,6 +161,7 @@ static int mt6397_irq_domain_map(struct irq_domain *d, unsigned int irq,
 	irq_set_chip_data(irq, mt6397);
 	irq_set_chip_and_handler(irq, &mt6397_irq_chip, handle_level_irq);
 	irq_set_nested_thread(irq, 1);
+
 #ifdef CONFIG_ARM
 	set_irq_flags(irq, IRQF_VALID);
 #else
@@ -173,7 +193,8 @@ static int mt6397_irq_init(struct mt6397_chip *mt6397)
 	}
 
 	ret = devm_request_threaded_irq(mt6397->dev, mt6397->irq, NULL,
-		mt6397_irq_thread, IRQF_ONESHOT, "mt6397-pmic", mt6397);
+		mt6397_irq_thread, IRQF_ONESHOT | IRQF_NO_SUSPEND,
+		"mt6397-pmic", mt6397);
 	if (ret) {
 		dev_err(mt6397->dev, "failed to register irq=%d; err: %d\n",
 			mt6397->irq, ret);
@@ -183,6 +204,31 @@ static int mt6397_irq_init(struct mt6397_chip *mt6397)
 	return 0;
 }
 
+#ifdef CONFIG_PM_SLEEP
+static int mt6397_irq_suspend(struct device *dev)
+{
+	struct mt6397_chip *chip = dev_get_drvdata(dev);
+
+	regmap_write(chip->regmap, MT6397_INT_CON0, chip->wake_mask[0]);
+	regmap_write(chip->regmap, MT6397_INT_CON1, chip->wake_mask[1]);
+
+	return 0;
+}
+
+static int mt6397_irq_resume(struct device *dev)
+{
+	struct mt6397_chip *chip = dev_get_drvdata(dev);
+
+	regmap_write(chip->regmap, MT6397_INT_CON0, chip->irq_masks_cur[0]);
+	regmap_write(chip->regmap, MT6397_INT_CON1, chip->irq_masks_cur[1]);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_irq_suspend,
+			mt6397_irq_resume);
+
 static int mt6397_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -237,6 +283,7 @@ static struct platform_driver mt6397_driver = {
 	.driver = {
 		.name = "mt6397",
 		.of_match_table = of_match_ptr(mt6397_of_match),
+		.pm = &mt6397_pm_ops,
 	},
 };
 
diff --git a/include/linux/mfd/mt6397/core.h b/include/linux/mfd/mt6397/core.h
index cf5265b..45b8e8a 100644
--- a/include/linux/mfd/mt6397/core.h
+++ b/include/linux/mfd/mt6397/core.h
@@ -57,6 +57,7 @@ struct mt6397_chip {
 	int irq;
 	struct irq_domain *irq_domain;
 	struct mutex irqlock;
+	u16 wake_mask[2];
 	u16 irq_masks_cur[2];
 	u16 irq_masks_cache[2];
 };
-- 
1.8.1.1.dirty
