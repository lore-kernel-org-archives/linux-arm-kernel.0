From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Sat, 21 Apr 2018 16:17:31 +0200
Subject: [PATCH] pinctrl: armada-37xx: add suspend/resume support
Message-ID: <20180421141731.25556-1-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ken Ma <make@marvell.com>

Add suspend/resume hooks in pinctrl driver to handle S2RAM operations.

Beyond the traditional register save/restore operations, these hooks
also keep the GPIOs used for both-edge IRQ synchronized between their
level (low/high) and expected IRQ polarity (falling/rising edge).

Since pinctrl is an infrastructure module, its resume should be issued
prior to other IO drivers. The pinctrl PM is registered as syscore
level to make sure of it. A postcore initcall is added to register
syscore operation. Because of the use of such syscore_ops, the
suspend/resume hooks do not have access to a device pointer, and thus
need to use a global list in order to keep track of the probed devices
for which registers have to be saved/restored.

Signed-off-by: Ken Ma <make@marvell.com>
Reviewed-by: Victor Gu <xigu@marvell.com>
[miquel.raynal at bootlin.com: updated the coding style, re-wrote the
comments and the commit message]
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c | 137 ++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
index 5b63248c8209..b47b6145f08e 100644
--- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
+++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/syscore_ops.h>
 
 #include "../pinctrl-utils.h"
 
@@ -80,7 +81,22 @@ struct armada_37xx_pmx_func {
 	unsigned int		ngroups;
 };
 
+#if defined(CONFIG_PM)
+struct armada_37xx_pm_state {
+	u32 out_en_l;
+	u32 out_en_h;
+	u32 out_val_l;
+	u32 out_val_h;
+	u32 irq_en_l;
+	u32 irq_en_h;
+	u32 irq_pol_l;
+	u32 irq_pol_h;
+	u32 selection;
+};
+#endif /* CONFIG_PM */
+
 struct armada_37xx_pinctrl {
+	struct list_head		node;
 	struct regmap			*regmap;
 	void __iomem			*base;
 	const struct armada_37xx_pin_data	*data;
@@ -94,6 +110,9 @@ struct armada_37xx_pinctrl {
 	unsigned int			ngroups;
 	struct armada_37xx_pmx_func	*funcs;
 	unsigned int			nfuncs;
+#if defined(CONFIG_PM)
+	struct armada_37xx_pm_state	pm;
+#endif /* CONFIG_PM */
 };
 
 #define PIN_GRP(_name, _start, _nr, _mask, _func1, _func2)	\
@@ -149,6 +168,9 @@ struct armada_37xx_pinctrl {
 		.funcs = {_f1, _f2}			\
 	}
 
+/* Global list of devices (struct armada_37xx_pinctrl) */
+static LIST_HEAD(device_list);
+
 static struct armada_37xx_pin_group armada_37xx_nb_groups[] = {
 	PIN_GRP_GPIO("jtag", 20, 5, BIT(0), "jtag"),
 	PIN_GRP_GPIO("sdio0", 8, 3, BIT(1), "sdio"),
@@ -1049,6 +1071,9 @@ static int __init armada_37xx_pinctrl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, info);
 
+	/* Add to the global list */
+	list_add_tail(&info->node, &device_list);
+
 	return 0;
 }
 
@@ -1059,5 +1084,117 @@ static struct platform_driver armada_37xx_pinctrl_driver = {
 	},
 };
 
+#if defined(CONFIG_PM)
+static int armada_3700_pinctrl_suspend(void)
+{
+	struct armada_37xx_pinctrl *info;
+
+	list_for_each_entry(info, &device_list, node) {
+		/* Save GPIO state */
+		regmap_read(info->regmap, OUTPUT_EN, &info->pm.out_en_l);
+		regmap_read(info->regmap, OUTPUT_EN + sizeof(u32),
+			    &info->pm.out_en_h);
+		regmap_read(info->regmap, OUTPUT_VAL, &info->pm.out_val_l);
+		regmap_read(info->regmap, OUTPUT_VAL + sizeof(u32),
+			    &info->pm.out_val_h);
+
+		info->pm.irq_en_l = readl(info->base + IRQ_EN);
+		info->pm.irq_en_h = readl(info->base + IRQ_EN + sizeof(u32));
+		info->pm.irq_pol_l = readl(info->base + IRQ_POL);
+		info->pm.irq_pol_h = readl(info->base + IRQ_POL + sizeof(u32));
+
+		/* Save pinctrl state */
+		regmap_read(info->regmap, SELECTION, &info->pm.selection);
+	}
+
+	return 0;
+}
+
+static void armada_3700_pinctrl_resume(void)
+{
+	struct armada_37xx_pinctrl *info;
+	struct gpio_chip *gc;
+	struct irq_domain *d;
+	int i;
+
+	list_for_each_entry(info, &device_list, node) {
+		/* Restore GPIO state */
+		regmap_write(info->regmap, OUTPUT_EN, info->pm.out_en_l);
+		regmap_write(info->regmap, OUTPUT_EN + sizeof(u32),
+			     info->pm.out_en_h);
+		regmap_write(info->regmap, OUTPUT_VAL, info->pm.out_val_l);
+		regmap_write(info->regmap, OUTPUT_VAL + sizeof(u32),
+			     info->pm.out_val_h);
+
+		/*
+		 * Input levels may change during suspend, which is not
+		 * monitored at that time. GPIOs used for both-edge IRQs may not
+		 * be synchronized anymore with their polarities (rising/falling
+		 * edge) and must be re-configured manually.
+		 */
+		gc = &info->gpio_chip;
+		d = gc->irq.domain;
+		for (i = 0; i < gc->ngpio; i++) {
+			u32 irq_bit = BIT(i % GPIO_PER_REG);
+			u32 mask, *irq_pol, input_reg, virq, type, level;
+
+			if (i < GPIO_PER_REG) {
+				mask = info->pm.irq_en_l;
+				irq_pol = &info->pm.irq_pol_l;
+				input_reg = INPUT_VAL;
+			} else {
+				mask = info->pm.irq_en_h;
+				irq_pol = &info->pm.irq_pol_h;
+				input_reg = INPUT_VAL + sizeof(u32);
+			}
+
+			if (!(mask & irq_bit))
+				continue;
+
+			virq = irq_find_mapping(d, i);
+			type = irq_get_trigger_type(virq);
+
+			/*
+			 * Synchronize level and polarity for both-edge irqs:
+			 *     - a high input level expects a falling edge,
+			 *     - a low input level exepects a rising edge.
+			 */
+			if ((type & IRQ_TYPE_SENSE_MASK) ==
+			    IRQ_TYPE_EDGE_BOTH) {
+				regmap_read(info->regmap, input_reg, &level);
+				if ((*irq_pol ^ level) & irq_bit)
+					*irq_pol ^= irq_bit;
+			}
+		}
+
+		writel(info->pm.irq_en_l, info->base + IRQ_EN);
+		writel(info->pm.irq_en_h, info->base + IRQ_EN + sizeof(u32));
+		writel(info->pm.irq_pol_l, info->base + IRQ_POL);
+		writel(info->pm.irq_pol_h, info->base + IRQ_POL + sizeof(u32));
+
+		/* Restore pinctrl state */
+		regmap_write(info->regmap, SELECTION, info->pm.selection);
+	}
+}
+
+static struct syscore_ops armada_3700_pinctrl_syscore_ops = {
+	.suspend = armada_3700_pinctrl_suspend,
+	.resume = armada_3700_pinctrl_resume,
+};
+
+static int __init armada_3700_pinctrl_pm_init(void)
+{
+	/*
+	 * Register syscore ops for save/restore of registers across suspend.
+	 * It's important to ensure that this driver is running at an earlier
+	 * initcall level than any arch-specific init calls.
+	 */
+	register_syscore_ops(&armada_3700_pinctrl_syscore_ops);
+	return 0;
+}
+
+postcore_initcall(armada_3700_pinctrl_pm_init);
+#endif /* CONFIG_PM */
+
 builtin_platform_driver_probe(armada_37xx_pinctrl_driver,
 			      armada_37xx_pinctrl_probe);
-- 
2.14.1
