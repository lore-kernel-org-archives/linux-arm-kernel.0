From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed,  4 Jan 2012 15:12:04 +0800
Subject: [PATCH] regulator: max8925: fix enabled/disabled judgement mistake
Message-ID: <1325661124-7734-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Liu <kliu5@marvell.com>

Max8925 ldo status should be determined by two factors:
1. power up/down sequence selection(LDOCTL[4:2]).
2. i2c enable bit(LDOCTL[0]).

Max8925 ldo support two types of power up/down sequence:
1. flexible sequence(LDOCTL[4:2] = 0~6).
2. i2c sequence(LDOCTL[4:2] = 7).

With flexible sequence selected, the ldo is enabled during power up by default.
With i2c sequence selected, the ldo is controlled by the i2c enable bit(LDOCTL[0]).

Signed-off-by: Kevin Liu <kliu5@marvell.com>
Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/regulator/max8925-regulator.c |   33 ++++++++++++++++++++-------------
 1 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/max8925-regulator.c b/drivers/regulator/max8925-regulator.c
index cc9ec0e..9537f43 100644
--- a/drivers/regulator/max8925-regulator.c
+++ b/drivers/regulator/max8925-regulator.c
@@ -24,9 +24,13 @@
 #define SD1_DVM_SHIFT		5		/* SDCTL1 bit5 */
 #define SD1_DVM_EN		6		/* SDV1 bit 6 */
 
-/* bit definitions in SD & LDO control registers */
-#define OUT_ENABLE   		0x1f		/* Power U/D sequence as I2C */
-#define OUT_DISABLE		0x1e		/* Power U/D sequence as I2C */
+/* bit definitions in LDO control registers */
+#define LDO_SEQ_I2C		0x7		/* Power U/D by i2c */
+#define LDO_SEQ_MASK		0x7		/* Power U/D sequence mask */
+#define LDO_SEQ_SHIFT		2		/* Power U/D sequence offset */
+#define LDO_I2C_EN		0x1		/* Enable by i2c */
+#define LDO_I2C_EN_MASK		0x1		/* Enable mask by i2c */
+#define LDO_I2C_EN_SHIFT	0		/* Enable offset by i2c */
 
 struct max8925_regulator_info {
 	struct regulator_desc	desc;
@@ -40,7 +44,6 @@ struct max8925_regulator_info {
 	int	vol_reg;
 	int	vol_shift;
 	int	vol_nbits;
-	int	enable_bit;
 	int	enable_reg;
 };
 
@@ -98,8 +101,10 @@ static int max8925_enable(struct regulator_dev *rdev)
 	struct max8925_regulator_info *info = rdev_get_drvdata(rdev);
 
 	return max8925_set_bits(info->i2c, info->enable_reg,
-				OUT_ENABLE << info->enable_bit,
-				OUT_ENABLE << info->enable_bit);
+				LDO_SEQ_MASK << LDO_SEQ_SHIFT |
+				LDO_I2C_EN_MASK << LDO_I2C_EN_SHIFT,
+				LDO_SEQ_I2C << LDO_SEQ_SHIFT |
+				LDO_I2C_EN << LDO_I2C_EN_SHIFT);
 }
 
 static int max8925_disable(struct regulator_dev *rdev)
@@ -107,20 +112,24 @@ static int max8925_disable(struct regulator_dev *rdev)
 	struct max8925_regulator_info *info = rdev_get_drvdata(rdev);
 
 	return max8925_set_bits(info->i2c, info->enable_reg,
-				OUT_ENABLE << info->enable_bit,
-				OUT_DISABLE << info->enable_bit);
+				LDO_SEQ_MASK << LDO_SEQ_SHIFT |
+				LDO_I2C_EN_MASK << LDO_I2C_EN_SHIFT,
+				LDO_SEQ_I2C << LDO_SEQ_SHIFT);
 }
 
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
+	if (ldo_seq != LDO_SEQ_I2C)
+		return 1;
+	else
+		return ret & (LDO_I2C_EN_MASK << LDO_I2C_EN_SHIFT);
 }
 
 static int max8925_set_dvm_voltage(struct regulator_dev *rdev, int uV)
@@ -188,7 +197,6 @@ static struct regulator_ops max8925_regulator_ldo_ops = {
 	.vol_shift	= 0,					\
 	.vol_nbits	= 6,					\
 	.enable_reg	= MAX8925_SDCTL##_id,			\
-	.enable_bit	= 0,					\
 }
 
 #define MAX8925_LDO(_id, min, max, step)			\
@@ -207,7 +215,6 @@ static struct regulator_ops max8925_regulator_ldo_ops = {
 	.vol_shift	= 0,					\
 	.vol_nbits	= 6,					\
 	.enable_reg	= MAX8925_LDOCTL##_id,			\
-	.enable_bit	= 0,					\
 }
 
 static struct max8925_regulator_info max8925_regulator_info[] = {
-- 
1.7.0.4
