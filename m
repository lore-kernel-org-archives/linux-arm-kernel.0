From: l.majewski@samsung.com (Lukasz Majewski)
Date: Mon, 27 Sep 2010 14:32:23 +0200
Subject: [PATCH v3 1/5] mfd: regulator: max8998: separate set_voltage for ldo
	and buck
In-Reply-To: <1285590747-32404-1-git-send-email-l.majewski@samsung.com>
References: <1285590747-32404-1-git-send-email-l.majewski@samsung.com>
Message-ID: <1285590747-32404-2-git-send-email-l.majewski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/regulator/max8998.c |   43 ++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 7f5fe6f..1e5bd50 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -297,7 +297,44 @@ static int max8998_get_voltage(struct regulator_dev *rdev)
 	return max8998_list_voltage(rdev, val);
 }
 
-static int max8998_set_voltage(struct regulator_dev *rdev,
+static int max8998_set_voltage_ldo(struct regulator_dev *rdev,
+				int min_uV, int max_uV)
+{
+	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
+	struct i2c_client *i2c = max8998->iodev->i2c;
+	int min_vol = min_uV / 1000, max_vol = max_uV / 1000;
+	const struct voltage_map_desc *desc;
+	int ldo = max8998_get_ldo(rdev);
+	int reg, shift = 0, mask, ret;
+	int i = 0;
+
+	if (ldo >= ARRAY_SIZE(ldo_voltage_map))
+		return -EINVAL;
+
+	desc = ldo_voltage_map[ldo];
+	if (desc == NULL)
+		return -EINVAL;
+
+	if (max_vol < desc->min || min_vol > desc->max)
+		return -EINVAL;
+
+	while (desc->min + desc->step*i < min_vol &&
+	       desc->min + desc->step*i < desc->max)
+		i++;
+
+	if (desc->min + desc->step*i > max_vol)
+		return -EINVAL;
+
+	ret = max8998_get_voltage_register(rdev, &reg, &shift, &mask);
+	if (ret)
+		return ret;
+
+	ret = max8998_update_reg(i2c, reg, i<<shift, mask<<shift);
+
+	return ret;
+}
+
+static int max8998_set_voltage_buck(struct regulator_dev *rdev,
 				int min_uV, int max_uV)
 {
 	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
@@ -359,7 +396,7 @@ static struct regulator_ops max8998_ldo_ops = {
 	.enable			= max8998_ldo_enable,
 	.disable		= max8998_ldo_disable,
 	.get_voltage		= max8998_get_voltage,
-	.set_voltage		= max8998_set_voltage,
+	.set_voltage		= max8998_set_voltage_ldo,
 	.set_suspend_enable	= max8998_ldo_enable,
 	.set_suspend_disable	= max8998_ldo_disable,
 };
@@ -370,7 +407,7 @@ static struct regulator_ops max8998_buck_ops = {
 	.enable			= max8998_ldo_enable,
 	.disable		= max8998_ldo_disable,
 	.get_voltage		= max8998_get_voltage,
-	.set_voltage		= max8998_set_voltage,
+	.set_voltage		= max8998_set_voltage_buck,
 	.set_suspend_enable	= max8998_ldo_enable,
 	.set_suspend_disable	= max8998_ldo_disable,
 };
-- 
1.7.1
