From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 21 Oct 2014 10:25:11 +0200
Subject: [PATCH 1/2] regulator: max77686: Implement suspend disable for some
 LDOs
In-Reply-To: <1413879912-26606-1-git-send-email-k.kozlowski@samsung.com>
References: <1413879912-26606-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1413879912-26606-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some LDOs of Maxim 77686 PMIC support disabling during system suspend
(LDO{2,6,7,8,10,11,12,14,15,16}). This was already implemented as part
of set_suspend_mode function. In that case the mode was one of:
 - disable,
 - normal mode,
 - low power mode.
However there are no bindings for setting the mode during suspend.

Implement a set_suspend_disable function for regulators supporting this.
This helps reducing energy consumption during system sleep.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/regulator/max77686.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/regulator/max77686.c b/drivers/regulator/max77686.c
index ef1af2debbd2..84603051f24d 100644
--- a/drivers/regulator/max77686.c
+++ b/drivers/regulator/max77686.c
@@ -123,6 +123,24 @@ static int max77686_set_suspend_mode(struct regulator_dev *rdev,
 	return 0;
 }
 
+static int max77686_ldo_set_suspend_disable(struct regulator_dev *rdev,
+				     unsigned int mode)
+{
+	unsigned int val;
+	struct max77686_data *max77686 = rdev_get_drvdata(rdev);
+	int ret;
+
+	val = 0x1 << MAX77686_OPMODE_SHIFT;
+
+	ret = regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
+				 rdev->desc->enable_mask, val);
+	if (ret)
+		return ret;
+
+	max77686->opmode[rdev_get_id(rdev)] = val;
+	return 0;
+}
+
 /* Some LDOs supports LPM-ON/OFF/Normal-ON mode during suspend state */
 static int max77686_ldo_set_suspend_mode(struct regulator_dev *rdev,
 				     unsigned int mode)
@@ -212,6 +230,7 @@ static struct regulator_ops max77686_ldo_ops = {
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
 	.set_suspend_mode	= max77686_ldo_set_suspend_mode,
+	.set_suspend_disable	= max77686_ldo_set_suspend_disable,
 };
 
 static struct regulator_ops max77686_buck1_ops = {
-- 
1.9.1
