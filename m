From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 27 Oct 2014 13:11:47 +0100
Subject: [PATCH v5 1/4] regulator: max77686: Replace hard-coded opmode values
 with defines
In-Reply-To: <1414411911-5539-1-git-send-email-k.kozlowski@samsung.com>
References: <1414411911-5539-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1414411911-5539-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add defines for regulator operating modes which should be more readable,
especially if one does not have Maxim 77686 datasheet.

The patch does not introduce any functional change.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Suggested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 drivers/regulator/max77686.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/max77686.c b/drivers/regulator/max77686.c
index ef1af2debbd2..c625a8a7940d 100644
--- a/drivers/regulator/max77686.c
+++ b/drivers/regulator/max77686.c
@@ -45,6 +45,23 @@
 #define MAX77686_DVS_MINUV	600000
 #define MAX77686_DVS_UVSTEP	12500
 
+/*
+ * Values used for configuring LDOs and bucks.
+ * Forcing low power mode: LDO1, 3-5, 9, 13, 17-26
+ */
+#define MAX77686_LDO_LOWPOWER		0x1
+/*
+ * On/off controlled by PWRREQ:
+ *  - LDO2, 6-8, 10-12, 14-16
+ *  - buck[1234]
+ */
+#define MAX77686_OFF_PWRREQ		0x1
+/* Low power mode controlled by PWRREQ: All LDOs */
+#define MAX77686_LDO_LOWPOWER_PWRREQ	0x2
+/* Forcing low power mode: buck[234] */
+#define MAX77686_BUCK_LOWPOWER		0x2
+#define MAX77686_NORMAL			0x3
+
 #define MAX77686_OPMODE_SHIFT	6
 #define MAX77686_OPMODE_BUCK234_SHIFT	4
 #define MAX77686_OPMODE_MASK	0x3
@@ -76,9 +93,9 @@ static int max77686_buck_set_suspend_disable(struct regulator_dev *rdev)
 	int ret, id = rdev_get_id(rdev);
 
 	if (id == MAX77686_BUCK1)
-		val = 0x1;
+		val = MAX77686_OFF_PWRREQ;
 	else
-		val = 0x1 << MAX77686_OPMODE_BUCK234_SHIFT;
+		val = MAX77686_OFF_PWRREQ << MAX77686_OPMODE_BUCK234_SHIFT;
 
 	ret = regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
 				 rdev->desc->enable_mask, val);
@@ -103,10 +120,10 @@ static int max77686_set_suspend_mode(struct regulator_dev *rdev,
 
 	switch (mode) {
 	case REGULATOR_MODE_IDLE:			/* ON in LP Mode */
-		val = 0x2 << MAX77686_OPMODE_SHIFT;
+		val = MAX77686_LDO_LOWPOWER_PWRREQ << MAX77686_OPMODE_SHIFT;
 		break;
 	case REGULATOR_MODE_NORMAL:			/* ON in Normal Mode */
-		val = 0x3 << MAX77686_OPMODE_SHIFT;
+		val = MAX77686_NORMAL << MAX77686_OPMODE_SHIFT;
 		break;
 	default:
 		pr_warn("%s: regulator_suspend_mode : 0x%x not supported\n",
@@ -133,13 +150,13 @@ static int max77686_ldo_set_suspend_mode(struct regulator_dev *rdev,
 
 	switch (mode) {
 	case REGULATOR_MODE_STANDBY:			/* switch off */
-		val = 0x1 << MAX77686_OPMODE_SHIFT;
+		val = MAX77686_OFF_PWRREQ << MAX77686_OPMODE_SHIFT;
 		break;
 	case REGULATOR_MODE_IDLE:			/* ON in LP Mode */
-		val = 0x2 << MAX77686_OPMODE_SHIFT;
+		val = MAX77686_LDO_LOWPOWER_PWRREQ << MAX77686_OPMODE_SHIFT;
 		break;
 	case REGULATOR_MODE_NORMAL:			/* ON in Normal Mode */
-		val = 0x3 << MAX77686_OPMODE_SHIFT;
+		val = MAX77686_NORMAL << MAX77686_OPMODE_SHIFT;
 		break;
 	default:
 		pr_warn("%s: regulator_suspend_mode : 0x%x not supported\n",
-- 
1.9.1
