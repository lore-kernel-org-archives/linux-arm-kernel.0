From: l.majewski@samsung.com (Lukasz Majewski)
Date: Wed, 22 Sep 2010 17:30:09 +0200
Subject: [PATCH v2 2/3] mfd: regulator: max8998: probe routine modified for
	GPIOs use
In-Reply-To: <1285169410-22343-1-git-send-email-l.majewski@samsung.com>
References: <1285169410-22343-1-git-send-email-l.majewski@samsung.com>
Message-ID: <1285169410-22343-3-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/regulator/max8998.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 41 insertions(+), 0 deletions(-)

diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 36d214a..873a565 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -678,6 +678,47 @@ static __devinit int max8998_pmic_probe(struct platform_device *pdev)
 	max8998->iodev = iodev;
 	max8998->num_regulators = pdata->num_regulators;
 	platform_set_drvdata(pdev, max8998);
+	i2c = max8998->iodev->i2c;
+
+	/* Check if platform data for max8998 has been declared */
+	if (pdata->buck1_vol[0] != 0 && pdata->buck1_vol[1] != 0 &&
+	    pdata->buck1_vol[2] != 0 && pdata->buck1_vol[3] != 0) {
+
+		for (i = 0; i < ARRAY_SIZE(pdata->buck1_vol); ++i) {
+			max8998_write_reg(i2c,
+					  MAX8998_REG_BUCK1_VOL1 + i,
+					  pdata->buck1_vol[i]);
+		}
+
+		/* Set default buck1 index - choose default voltage value */
+		max8998->buck1_idx = pdata->buck1_init_idx;
+	}
+
+	if (pdata->buck2_vol[0] != 0 && pdata->buck2_vol[1] != 0) {
+		max8998_write_reg(i2c, MAX8998_REG_BUCK2_VOL1,
+				  pdata->buck2_vol[0]);
+		max8998_write_reg(i2c, MAX8998_REG_BUCK2_VOL2,
+				  pdata->buck2_vol[1]);
+
+		/* Set default buck2 index - choose default voltage value */
+		max8998->buck2_idx = pdata->buck2_init_idx;
+	}
+
+	if (gpio_is_valid(pdata->buck1_set1) &&
+	    gpio_is_valid(pdata->buck1_set2)) {
+		gpio_request(pdata->buck1_set1, "MAX8998 BUCK1_SET1");
+		gpio_direction_output(pdata->buck1_set1,
+				      max8998->buck1_idx & 0x1);
+
+		gpio_request(pdata->buck1_set2, "MAX8998 BUCK1_SET2");
+		gpio_direction_output(pdata->buck1_set2,
+				      (max8998->buck1_idx >> 1) & 0x1);
+	}
+	if (gpio_is_valid(pdata->buck2_set3)) {
+		gpio_request(pdata->buck2_set3, "MAX8998 BUCK2_SET3");
+		gpio_direction_output(pdata->buck2_set3,
+				      max8998->buck2_idx & 0x1);
+	}
 
 	for (i = 0; i < pdata->num_regulators; i++) {
 		const struct voltage_map_desc *desc;
-- 
1.7.1
