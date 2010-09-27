From: l.majewski@samsung.com (Lukasz Majewski)
Date: Mon, 27 Sep 2010 14:32:25 +0200
Subject: [PATCH v3 3/5] mfd: regulator: max8998: BUCK1/2 internal voltages and
	indexes defined
In-Reply-To: <1285590747-32404-1-git-send-email-l.majewski@samsung.com>
References: <1285590747-32404-1-git-send-email-l.majewski@samsung.com>
Message-ID: <1285590747-32404-4-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BUCK1/2 internal voltages and indexes defined in the struct max8998_data
max_get_voltage_register now uses index values to chose proper register
More generic BUCK1/2 registers names provided

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/regulator/max8998.c         |   10 ++++++++--
 include/linux/mfd/max8998-private.h |   12 ++++++------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 1e5bd50..7ae0639 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -39,6 +39,11 @@ struct max8998_data {
 	struct max8998_dev	*iodev;
 	int			num_regulators;
 	struct regulator_dev	**rdev;
+	u8                      buck1_vol[4]; /* voltages for selection */
+	u8                      buck2_vol[2];
+	unsigned int		buck1_idx; /* index to last changed voltage */
+					   /* value in a set */
+	unsigned int		buck2_idx;
 };
 
 struct voltage_map_desc {
@@ -218,6 +223,7 @@ static int max8998_get_voltage_register(struct regulator_dev *rdev,
 				int *_reg, int *_shift, int *_mask)
 {
 	int ldo = max8998_get_ldo(rdev);
+	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
 	int reg, shift = 0, mask = 0xff;
 
 	switch (ldo) {
@@ -254,10 +260,10 @@ static int max8998_get_voltage_register(struct regulator_dev *rdev,
 		reg = MAX8998_REG_LDO12 + (ldo - MAX8998_LDO12);
 		break;
 	case MAX8998_BUCK1:
-		reg = MAX8998_REG_BUCK1_DVSARM1;
+		reg = MAX8998_REG_BUCK1_VOLTAGE1 + max8998->buck1_idx;
 		break;
 	case MAX8998_BUCK2:
-		reg = MAX8998_REG_BUCK2_DVSINT1;
+		reg = MAX8998_REG_BUCK2_VOLTAGE1 + max8998->buck2_idx;
 		break;
 	case MAX8998_BUCK3:
 		reg = MAX8998_REG_BUCK3;
diff --git a/include/linux/mfd/max8998-private.h b/include/linux/mfd/max8998-private.h
index 0ff4211..7363dea 100644
--- a/include/linux/mfd/max8998-private.h
+++ b/include/linux/mfd/max8998-private.h
@@ -48,12 +48,12 @@ enum {
 	MAX8998_REG_ONOFF2,
 	MAX8998_REG_ONOFF3,
 	MAX8998_REG_ONOFF4,
-	MAX8998_REG_BUCK1_DVSARM1,
-	MAX8998_REG_BUCK1_DVSARM2,
-	MAX8998_REG_BUCK1_DVSARM3,
-	MAX8998_REG_BUCK1_DVSARM4,
-	MAX8998_REG_BUCK2_DVSINT1,
-	MAX8998_REG_BUCK2_DVSINT2,
+	MAX8998_REG_BUCK1_VOLTAGE1,
+	MAX8998_REG_BUCK1_VOLTAGE2,
+	MAX8998_REG_BUCK1_VOLTAGE3,
+	MAX8998_REG_BUCK1_VOLTAGE4,
+	MAX8998_REG_BUCK2_VOLTAGE1,
+	MAX8998_REG_BUCK2_VOLTAGE2,
 	MAX8998_REG_BUCK3,
 	MAX8998_REG_BUCK4,
 	MAX8998_REG_LDO2_LDO3,
-- 
1.7.1
