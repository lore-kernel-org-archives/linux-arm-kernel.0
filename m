From: henryc.chen@mediatek.com (Henry Chen)
Date: Mon, 10 Aug 2015 21:10:45 +0800
Subject: [PATCH v3] mfd: mt6397: Implement wake handler and suspend/resume to
 handle wake up event.
Message-ID: <1439212245-18935-1-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Implement .irq_set_wake() to get who is wakeup source and setup on suspend/reumse. Enable
mt6393_irq as wake up source properly to pinctrl by enable_irq_wake()/enable_irq_wake().

Reviewed-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
Changes since v2:
Remove the filename of title.
Remove irrelevant change.

Chandes since v1:
Used enable_irq_wake()/disable_irq_wake to handle irq wakeup source.

 drivers/mfd/mt6397-core.c       | 49 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/mt6397/core.h |  1 +
 2 files changed, 50 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 03929a6..e7d5a67 100644
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
@@ -183,6 +202,35 @@ static int mt6397_irq_init(struct mt6397_chip *mt6397)
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
+	enable_irq_wake(chip->irq);
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
+	disable_irq_wake(chip->irq);
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
@@ -237,6 +285,7 @@ static struct platform_driver mt6397_driver = {
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
