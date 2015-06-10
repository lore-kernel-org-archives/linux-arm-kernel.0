From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Jun 2015 08:57:50 +0100
Subject: [REBASED 2/5] regulator: pwm-regulator: Separate voltage-table
 initialisation
In-Reply-To: <1433923073-907-1-git-send-email-lee.jones@linaro.org>
References: <1433923073-907-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1433923073-907-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Take this out of the main .probe() routine in order to facilitate the
introduction of different ways to obtain 'duty cycle' information.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mfd-child.c           | 47 ++++++++++++++++++++++++
 drivers/regulator/pwm-regulator.c | 77 +++++++++++++++++++++++----------------
 2 files changed, 92 insertions(+), 32 deletions(-)
 create mode 100644 drivers/mfd/mfd-child.c

diff --git a/drivers/mfd/mfd-child.c b/drivers/mfd/mfd-child.c
new file mode 100644
index 0000000..f233add
--- /dev/null
+++ b/drivers/mfd/mfd-child.c
@@ -0,0 +1,47 @@
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+
+static int simple_mfd_child_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	void __iomem *base;
+	int irq;
+
+	printk("LEE: %s %s()[%d]: Enter\n", __FILE__, __func__, __LINE__);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dev_err(&pdev->dev, "Phys: %x: %x\n", res->start, resource_size(res));
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	dev_err(&pdev->dev, "Virt: %p\n", base);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
+		return irq;
+	}
+
+	dev_err(&pdev->dev, "IRQ: %d\n", irq);
+
+	return 0;
+}
+
+static const struct of_device_id simple_mfd_child_of_match[] = {
+	{ .compatible = "simple-mfd-child" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, simple_mfd_child_of_match);
+
+static struct platform_driver simple_mfd_child_driver = {
+	.probe = simple_mfd_child_probe,
+	.driver = {
+		.name = "simple-mfd-child",
+		.of_match_table = of_match_ptr(simple_mfd_child_of_match),
+	},
+};
+module_platform_driver(simple_mfd_child_driver);
diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index ffa9612..25560fc 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -78,8 +78,7 @@ static int pwm_regulator_list_voltage(struct regulator_dev *rdev,
 
 	return drvdata->duty_cycle_table[selector].uV;
 }
-
-static struct regulator_ops pwm_regulator_voltage_ops = {
+static struct regulator_ops pwm_regulator_voltage_table_ops = {
 	.set_voltage_sel = pwm_regulator_set_voltage_sel,
 	.get_voltage_sel = pwm_regulator_get_voltage_sel,
 	.list_voltage    = pwm_regulator_list_voltage,
@@ -88,20 +87,55 @@ static struct regulator_ops pwm_regulator_voltage_ops = {
 
 static struct regulator_desc pwm_regulator_desc = {
 	.name		= "pwm-regulator",
-	.ops		= &pwm_regulator_voltage_ops,
 	.type		= REGULATOR_VOLTAGE,
 	.owner		= THIS_MODULE,
 	.supply_name    = "pwm",
 };
 
+static int pwm_regulator_init_table(struct platform_device *pdev,
+				    struct pwm_regulator_data *drvdata)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct pwm_voltages *duty_cycle_table;
+	int length;
+	int ret;
+
+	of_find_property(np, "voltage-table", &length);
+
+	if ((length < sizeof(*duty_cycle_table)) ||
+	    (length % sizeof(*duty_cycle_table))) {
+		dev_err(&pdev->dev,
+			"voltage-table length(%d) is invalid\n",
+			length);
+		return -EINVAL;
+	}
+
+	duty_cycle_table = devm_kzalloc(&pdev->dev, length, GFP_KERNEL);
+	if (!duty_cycle_table)
+		return -ENOMEM;
+
+	ret = of_property_read_u32_array(np, "voltage-table",
+					 (u32 *)duty_cycle_table,
+					 length / sizeof(u32));
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to read voltage-table\n");
+		return ret;
+	}
+
+	drvdata->duty_cycle_table	= duty_cycle_table;
+	pwm_regulator_desc.ops		= &pwm_regulator_voltage_table_ops;
+	pwm_regulator_desc.n_voltages	= length / sizeof(*duty_cycle_table);
+
+	return 0;
+}
+
 static int pwm_regulator_probe(struct platform_device *pdev)
 {
 	struct pwm_regulator_data *drvdata;
-	struct property *prop;
 	struct regulator_dev *regulator;
 	struct regulator_config config = { };
 	struct device_node *np = pdev->dev.of_node;
-	int length, ret;
+	int ret;
 
 	if (!np) {
 		dev_err(&pdev->dev, "Device Tree node missing\n");
@@ -112,36 +146,15 @@ static int pwm_regulator_probe(struct platform_device *pdev)
 	if (!drvdata)
 		return -ENOMEM;
 
-	/* determine the number of voltage-table */
-	prop = of_find_property(np, "voltage-table", &length);
-	if (!prop) {
-		dev_err(&pdev->dev, "No voltage-table\n");
-		return -EINVAL;
-	}
-
-	if ((length < sizeof(*drvdata->duty_cycle_table)) ||
-	    (length % sizeof(*drvdata->duty_cycle_table))) {
-		dev_err(&pdev->dev, "voltage-table length(%d) is invalid\n",
-			length);
+	if (of_find_property(np, "voltage-table", NULL)) {
+		ret = pwm_regulator_init_table(pdev, drvdata);
+		if (ret)
+			return ret;
+	} else {
+		dev_err(&pdev->dev, "No \"voltage-table\" supplied\n");
 		return -EINVAL;
 	}
 
-	pwm_regulator_desc.n_voltages = length / sizeof(*drvdata->duty_cycle_table);
-
-	drvdata->duty_cycle_table = devm_kzalloc(&pdev->dev,
-						 length, GFP_KERNEL);
-	if (!drvdata->duty_cycle_table)
-		return -ENOMEM;
-
-	/* read voltage table from DT property */
-	ret = of_property_read_u32_array(np, "voltage-table",
-					 (u32 *)drvdata->duty_cycle_table,
-					 length / sizeof(u32));
-	if (ret < 0) {
-		dev_err(&pdev->dev, "read voltage-table failed\n");
-		return ret;
-	}
-
 	config.init_data = of_get_regulator_init_data(&pdev->dev, np,
 						      &pwm_regulator_desc);
 	if (!config.init_data)
-- 
1.9.1
