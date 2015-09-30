From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 30 Sep 2015 14:39:17 +0800
Subject: [PATCH 1/2] regulator: act8865: support output voltage by VSET2[] bits
In-Reply-To: <1443595158-550-1-git-send-email-wenyou.yang@atmel.com>
References: <1443595158-550-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1443595158-550-2-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the step-down DC/DC regulators, the output voltage is
selectable by setting VSEL pin that when VSEL is low, output
voltage is programmed by VSET1[] bits, and when VSEL is high,
output voltage is programmed by VSET2[] bits.

The DT property "active-semi,vsel-high" is used to specify
the VSEL pin at high on the board.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

 drivers/regulator/act8865-regulator.c |   24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index 896db16..e2b50f3 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -261,6 +261,16 @@ static const struct regulator_desc act8865_regulators[] = {
 	ACT88xx_REG("LDO_REG4", ACT8865, LDO4, VSET, "inl67"),
 };
 
+static const struct regulator_desc act8865_alt_regulators[] = {
+	ACT88xx_REG("DCDC_REG1", ACT8865, DCDC1, VSET2),
+	ACT88xx_REG("DCDC_REG2", ACT8865, DCDC2, VSET2),
+	ACT88xx_REG("DCDC_REG3", ACT8865, DCDC3, VSET2),
+	ACT88xx_REG("LDO_REG1", ACT8865, LDO1, VSET),
+	ACT88xx_REG("LDO_REG2", ACT8865, LDO2, VSET),
+	ACT88xx_REG("LDO_REG3", ACT8865, LDO3, VSET),
+	ACT88xx_REG("LDO_REG4", ACT8865, LDO4, VSET),
+};
+
 #ifdef CONFIG_OF
 static const struct of_device_id act8865_dt_ids[] = {
 	{ .compatible = "active-semi,act8600", .data = (void *)ACT8600 },
@@ -413,6 +423,7 @@ static int act8865_pmic_probe(struct i2c_client *client,
 	struct act8865 *act8865;
 	unsigned long type;
 	int off_reg, off_mask;
+	int voltage_select;
 
 	pdata = dev_get_platdata(dev);
 
@@ -424,6 +435,10 @@ static int act8865_pmic_probe(struct i2c_client *client,
 			return -ENODEV;
 
 		type = (unsigned long) id->data;
+
+		voltage_select = !!of_get_property(dev->of_node,
+						   "active-semi,vsel-high",
+						   NULL);
 	} else {
 		type = i2c_id->driver_data;
 	}
@@ -442,8 +457,13 @@ static int act8865_pmic_probe(struct i2c_client *client,
 		off_mask = ACT8846_OFF_SYSMASK;
 		break;
 	case ACT8865:
-		regulators = act8865_regulators;
-		num_regulators = ARRAY_SIZE(act8865_regulators);
+		if (voltage_select) {
+			regulators = act8865_alt_regulators;
+			num_regulators = ARRAY_SIZE(act8865_alt_regulators);
+		} else {
+			regulators = act8865_regulators;
+			num_regulators = ARRAY_SIZE(act8865_regulators);
+		}
 		off_reg = ACT8865_SYS_CTRL;
 		off_mask = ACT8865_MSTROFF;
 		break;
-- 
1.7.9.5
