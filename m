From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Thu, 22 Dec 2011 16:51:32 +0800
Subject: [PATCH] regulator: max8925: fix enabled/disabled judgement mistake
Message-ID: <1324543892-32540-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Liu <kliu5@marvell.com>

The judgement should depend on the power up/down sequence select.
With flexible power sequence, regulator is always enabled after boot up.
With i2c enabled, regulator enable/disable according to output enable bit.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/regulator/max8925-regulator.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/max8925-regulator.c b/drivers/regulator/max8925-regulator.c
index cc9ec0e..9e99420 100644
--- a/drivers/regulator/max8925-regulator.c
+++ b/drivers/regulator/max8925-regulator.c
@@ -27,6 +27,9 @@
 /* bit definitions in SD & LDO control registers */
 #define OUT_ENABLE   		0x1f		/* Power U/D sequence as I2C */
 #define OUT_DISABLE		0x1e		/* Power U/D sequence as I2C */
+#define LDO_SEQ_MASK		0x7		/* Power U/D sequence mask */
+#define LDO_SEQ_SHIFT		2		/* Power U/D sequence offset */
+#define LDO_SEQ_I2C_EN		0x7		/* Power U/D sequence as I2C_EN */
 
 struct max8925_regulator_info {
 	struct regulator_desc	desc;
@@ -114,13 +117,16 @@ static int max8925_disable(struct regulator_dev *rdev)
 static int max8925_is_enabled(struct regulator_dev *rdev)
 {
 	struct max8925_regulator_info *info = rdev_get_drvdata(rdev);
-	int ret;
+	int ldo_seq, ret;
 
 	ret = max8925_reg_read(info->i2c, info->enable_reg);
 	if (ret < 0)
 		return ret;
-
-	return ret & (1 << info->enable_bit);
+	ldo_seq = (ret >> LDO_SEQ_SHIFT) & LDO_SEQ_MASK;
+	if (ldo_seq != LDO_SEQ_I2C_EN)
+		return 1 << info->enable_bit;
+	else
+		return ret & (1 << info->enable_bit);
 }
 
 static int max8925_set_dvm_voltage(struct regulator_dev *rdev, int uV)
-- 
1.7.0.4
