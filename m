From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  4 May 2012 19:23:22 +0100
Subject: [PATCH 12/15] drivers/regulator: ab8500: Split up probe() into
 manageable pieces
In-Reply-To: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1336155805-18554-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ab8500's probe() function is becoming quite large, so in the lead
up to Device Tree enablement which will fork the thread of execution
this patch splits it into 3 main areas; basic error checking will
remain in probe(), but regulator register initialisation and regulator
registration have been moved to their own functions which will
be called in sequence by probe() and the DT equivalent.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/ab8500.c |  144 ++++++++++++++++++++++++++------------------
 1 file changed, 85 insertions(+), 59 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index c7ee4c1..e403a0f 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -735,6 +735,86 @@ static struct ab8500_reg_init ab8500_reg_init[] = {
 	REG_INIT(AB8500_REGUCTRLDISCH2,		0x04, 0x44, 0x16),
 };
 
+static __devinit int
+ab8500_regulator_init_registers(struct platform_device *pdev, int id, int value)
+{
+	int err;
+
+	if (value & ~ab8500_reg_init[id].mask) {
+		dev_err(&pdev->dev,
+			"Configuration error: value outside mask.\n");
+		return -EINVAL;
+	}
+
+	err = abx500_mask_and_set_register_interruptible(
+		&pdev->dev,
+		ab8500_reg_init[id].bank,
+		ab8500_reg_init[id].addr,
+		ab8500_reg_init[id].mask,
+		value);
+	if (err < 0) {
+		dev_err(&pdev->dev,
+			"Failed to initialize 0x%02x, 0x%02x.\n",
+			ab8500_reg_init[id].bank,
+			ab8500_reg_init[id].addr);
+		return err;
+	}
+
+	dev_vdbg(&pdev->dev,
+		"init: 0x%02x, 0x%02x, 0x%02x, 0x%02x\n",
+		ab8500_reg_init[id].bank,
+		ab8500_reg_init[id].addr,
+		ab8500_reg_init[id].mask,
+		value);
+
+	return 0;
+}
+
+static __devinit int ab8500_regulator_register(struct platform_device *pdev,
+					struct regulator_init_data *init_data,
+					int id,
+					struct device_node *np)
+{
+	struct ab8500_regulator_info *info = NULL;
+	int err;
+
+	/* assign per-regulator data */
+	info = &ab8500_regulator_info[id];
+	info->dev = &pdev->dev;
+
+	/* fix for hardware before ab8500v2.0 */
+	if (abx500_get_chip_id(info->dev) < 0x20) {
+		if (info->desc.id == AB8500_LDO_AUX3) {
+			info->desc.n_voltages =
+				ARRAY_SIZE(ldo_vauxn_voltages);
+			info->voltages = ldo_vauxn_voltages;
+			info->voltages_len =
+				ARRAY_SIZE(ldo_vauxn_voltages);
+			info->voltage_mask = 0xf;
+		}
+	}
+
+	/* register regulator with framework */
+	info->regulator = regulator_register(&info->desc, &pdev->dev,
+					init_data, info, np);
+	if (IS_ERR(info->regulator)) {
+		err = PTR_ERR(info->regulator);
+		pr_err("failed to register regulator %s\n",
+			info->desc.name);
+		/* when we fail, un-register all earlier regulators */
+		while (--id >= 0) {
+			info = &ab8500_regulator_info[id];
+			regulator_unregister(info->regulator);
+		}
+		return err;
+	}
+
+	dev_vdbg(rdev_get_dev(info->regulator),
+		"%s-probed\n", info->desc.name);
+
+	return 0;
+}
+
 static __devinit int ab8500_regulator_probe(struct platform_device *pdev)
 {
 	struct ab8500 *ab8500 = dev_get_drvdata(pdev->dev.parent);
@@ -759,8 +839,7 @@ static __devinit int ab8500_regulator_probe(struct platform_device *pdev)
 
 	/* initialize registers */
 	for (i = 0; i < pdata->num_regulator_reg_init; i++) {
-		int id;
-		u8 value;
+		int id, value;
 
 		id = pdata->regulator_reg_init[i].id;
 		value = pdata->regulator_reg_init[i].value;
@@ -771,70 +850,17 @@ static __devinit int ab8500_regulator_probe(struct platform_device *pdev)
 				"Configuration error: id outside range.\n");
 			return -EINVAL;
 		}
-		if (value & ~ab8500_reg_init[id].mask) {
-			dev_err(&pdev->dev,
-				"Configuration error: value outside mask.\n");
-			return -EINVAL;
-		}
 
-		/* initialize register */
-		err = abx500_mask_and_set_register_interruptible(&pdev->dev,
-			ab8500_reg_init[id].bank,
-			ab8500_reg_init[id].addr,
-			ab8500_reg_init[id].mask,
-			value);
-		if (err < 0) {
-			dev_err(&pdev->dev,
-				"Failed to initialize 0x%02x, 0x%02x.\n",
-				ab8500_reg_init[id].bank,
-				ab8500_reg_init[id].addr);
+		err = ab8500_regulator_init_registers(pdev, id, value);
+		if (err < 0)
 			return err;
-		}
-		dev_vdbg(&pdev->dev,
-			"  init: 0x%02x, 0x%02x, 0x%02x, 0x%02x\n",
-			ab8500_reg_init[id].bank,
-			ab8500_reg_init[id].addr,
-			ab8500_reg_init[id].mask,
-			value);
 	}
 
 	/* register all regulators */
 	for (i = 0; i < ARRAY_SIZE(ab8500_regulator_info); i++) {
-		struct ab8500_regulator_info *info = NULL;
-
-		/* assign per-regulator data */
-		info = &ab8500_regulator_info[i];
-		info->dev = &pdev->dev;
-
-		/* fix for hardware before ab8500v2.0 */
-		if (abx500_get_chip_id(info->dev) < 0x20) {
-			if (info->desc.id == AB8500_LDO_AUX3) {
-				info->desc.n_voltages =
-					ARRAY_SIZE(ldo_vauxn_voltages);
-				info->voltages = ldo_vauxn_voltages;
-				info->voltages_len =
-					ARRAY_SIZE(ldo_vauxn_voltages);
-				info->voltage_mask = 0xf;
-			}
-		}
-
-		/* register regulator with framework */
-		info->regulator = regulator_register(&info->desc, &pdev->dev,
-				&pdata->regulator[i], info, NULL);
-		if (IS_ERR(info->regulator)) {
-			err = PTR_ERR(info->regulator);
-			dev_err(&pdev->dev, "failed to register regulator %s\n",
-					info->desc.name);
-			/* when we fail, un-register all earlier regulators */
-			while (--i >= 0) {
-				info = &ab8500_regulator_info[i];
-				regulator_unregister(info->regulator);
-			}
+		err = ab8500_regulator_register(pdev, &pdata->regulator[i], i, NULL);
+		if (err < 0)
 			return err;
-		}
-
-		dev_vdbg(rdev_get_dev(info->regulator),
-			"%s-probed\n", info->desc.name);
 	}
 
 	return 0;
-- 
1.7.9.5
