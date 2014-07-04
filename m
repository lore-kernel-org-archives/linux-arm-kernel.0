From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri,  4 Jul 2014 11:55:14 +0200
Subject: [PATCH v6 15/23] regulator: max77686: Setup DVS-related GPIOs on probe
In-Reply-To: <1404467722-26687-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1404467722-26687-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1404467722-26687-16-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MAX77686 PMIC support Dyamic Voltage Scaling (DVS) on a set
of Buck regulators. A number of GPIO are connected to these
lines and are requested by the mfd driver. Setup the GPIO
pins from the regulator driver.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/regulator/max77686.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/regulator/max77686.c b/drivers/regulator/max77686.c
index ef1af2d..ecce77a 100644
--- a/drivers/regulator/max77686.c
+++ b/drivers/regulator/max77686.c
@@ -435,6 +435,12 @@ static int max77686_pmic_dt_parse_pdata(struct platform_device *pdev,
 }
 #endif /* CONFIG_OF */
 
+static inline bool max77686_is_dvs_buck(int id)
+{
+	/* BUCK 2,3 and 4 support DVS */
+	return (id >= MAX77686_BUCK2 && id <= MAX77686_BUCK4);
+}
+
 static int max77686_pmic_probe(struct platform_device *pdev)
 {
 	struct max77686_dev *iodev = dev_get_drvdata(pdev->dev.parent);
@@ -442,6 +448,9 @@ static int max77686_pmic_probe(struct platform_device *pdev)
 	struct max77686_data *max77686;
 	int i, ret = 0;
 	struct regulator_config config = { };
+	unsigned int reg;
+	int buck_default_idx;
+	int buck_old_idx;
 
 	dev_dbg(&pdev->dev, "%s\n", __func__);
 
@@ -472,13 +481,34 @@ static int max77686_pmic_probe(struct platform_device *pdev)
 	config.driver_data = max77686;
 	platform_set_drvdata(pdev, max77686);
 
+	buck_default_idx = pdata->buck_default_idx;
+	buck_old_idx = max77686_read_gpios(pdata);
+
 	for (i = 0; i < MAX77686_REGULATORS; i++) {
 		struct regulator_dev *rdev;
+		int id = pdata->regulators[i].id;
 
 		config.init_data = pdata->regulators[i].initdata;
 		config.of_node = pdata->regulators[i].of_node;
 
 		max77686->opmode[i] = regulators[i].enable_mask;
+
+		if (max77686_is_dvs_buck(id)) {
+			/* Try to copy over data so we keep firmware settings */
+			reg = regulators[i].vsel_reg;
+
+			ret = regmap_reg_copy(iodev->regmap,
+					      reg + buck_default_idx,
+					      reg + buck_old_idx);
+
+			if (ret)
+				dev_warn(&pdev->dev, "Copy err %d => %d (%d)\n",
+					 reg + buck_old_idx,
+					 reg + buck_default_idx, ret);
+
+			regulators[i].vsel_reg += buck_default_idx;
+		}
+
 		rdev = devm_regulator_register(&pdev->dev,
 						&regulators[i], &config);
 		if (IS_ERR(rdev)) {
@@ -488,6 +518,10 @@ static int max77686_pmic_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = max77686_setup_gpios(iodev->dev);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.0.0.rc2
