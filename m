From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 29 Oct 2014 12:14:52 +0100
Subject: [PATCH v6 1/3] regulator: max77686: Add suspend disable for some LDOs
In-Reply-To: <1414581294-1315-1-git-send-email-k.kozlowski@samsung.com>
References: <1414581294-1315-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1414581294-1315-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some LDOs of Maxim 77686 PMIC support disabling during system suspend
(LDO{2,6,7,8,10,11,12,14,15,16}). This was already implemented as part
of set_suspend_mode function. In that case the mode was one of:
 - disable,
 - normal mode,
 - low power mode.
However there are no bindings for setting the mode during suspend.

Add suspend disable for LDO regulators supporting this. Re-use existing
max77686_buck_set_suspend_disable() function. This helps reducing
energy consumption during system sleep.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/regulator/max77686.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/max77686.c b/drivers/regulator/max77686.c
index 2ebc4257425b..f960cfc7fdc6 100644
--- a/drivers/regulator/max77686.c
+++ b/drivers/regulator/max77686.c
@@ -99,8 +99,8 @@ static unsigned int max77686_get_opmode_shift(int id)
 	}
 }
 
-/* Some BUCKS supports Normal[ON/OFF] mode during suspend */
-static int max77686_buck_set_suspend_disable(struct regulator_dev *rdev)
+/* Some BUCKs and LDOs supports Normal[ON/OFF] mode during suspend */
+static int max77686_set_suspend_disable(struct regulator_dev *rdev)
 {
 	unsigned int val, shift;
 	struct max77686_data *max77686 = rdev_get_drvdata(rdev);
@@ -195,6 +195,9 @@ static int max77686_enable(struct regulator_dev *rdev)
 
 	shift = max77686_get_opmode_shift(id);
 
+	if (max77686->opmode[id] == MAX77686_OFF_PWRREQ)
+		max77686->opmode[id] = MAX77686_NORMAL;
+
 	return regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
 				  rdev->desc->enable_mask,
 				  max77686->opmode[id] << shift);
@@ -247,6 +250,7 @@ static struct regulator_ops max77686_ldo_ops = {
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
 	.set_suspend_mode	= max77686_ldo_set_suspend_mode,
+	.set_suspend_disable	= max77686_set_suspend_disable,
 };
 
 static struct regulator_ops max77686_buck1_ops = {
@@ -258,7 +262,7 @@ static struct regulator_ops max77686_buck1_ops = {
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
-	.set_suspend_disable	= max77686_buck_set_suspend_disable,
+	.set_suspend_disable	= max77686_set_suspend_disable,
 };
 
 static struct regulator_ops max77686_buck_dvs_ops = {
@@ -271,7 +275,7 @@ static struct regulator_ops max77686_buck_dvs_ops = {
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
 	.set_ramp_delay		= max77686_set_ramp_delay,
-	.set_suspend_disable	= max77686_buck_set_suspend_disable,
+	.set_suspend_disable	= max77686_set_suspend_disable,
 };
 
 #define regulator_desc_ldo(num)		{				\
-- 
1.9.1
