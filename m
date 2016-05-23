From: henryc.chen@mediatek.com (Henry Chen)
Date: Mon, 23 May 2016 15:13:31 +0800
Subject: [PATCH v2 3/3] regulator: mt6397: Add buck change mode regulator
 interface for mt6397
In-Reply-To: <1463987611-32139-1-git-send-email-henryc.chen@mediatek.com>
References: <1463987611-32139-1-git-send-email-henryc.chen@mediatek.com>
Message-ID: <1463987611-32139-4-git-send-email-henryc.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BUCKs of mt6397 have auto mode and pwm mode.
User can use regulator interfaces to control modes

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 drivers/regulator/mt6397-regulator.c | 89 ++++++++++++++++++++++++++++++++----
 1 file changed, 80 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/mt6397-regulator.c b/drivers/regulator/mt6397-regulator.c
index 1c45abb..c6c6aa85 100644
--- a/drivers/regulator/mt6397-regulator.c
+++ b/drivers/regulator/mt6397-regulator.c
@@ -23,6 +23,9 @@
 #include <linux/regulator/mt6397-regulator.h>
 #include <linux/regulator/of_regulator.h>
 
+#define MT6397_BUCK_MODE_AUTO	0
+#define MT6397_BUCK_MODE_FORCE_PWM	1
+
 /*
  * MT6397 regulators' information
  *
@@ -38,10 +41,14 @@ struct mt6397_regulator_info {
 	u32 vselon_reg;
 	u32 vselctrl_reg;
 	u32 vselctrl_mask;
+	u32 modeset_reg;
+	u32 modeset_mask;
+	u32 modeset_shift;
 };
 
 #define MT6397_BUCK(match, vreg, min, max, step, volt_ranges, enreg,	\
-		vosel, vosel_mask, voselon, vosel_ctrl)			\
+		vosel, vosel_mask, voselon, vosel_ctrl, _modeset_reg,	\
+		_modeset_shift)					\
 [MT6397_ID_##vreg] = {							\
 	.desc = {							\
 		.name = #vreg,						\
@@ -62,6 +69,9 @@ struct mt6397_regulator_info {
 	.vselon_reg = voselon,						\
 	.vselctrl_reg = vosel_ctrl,					\
 	.vselctrl_mask = BIT(1),					\
+	.modeset_reg = _modeset_reg,					\
+	.modeset_mask = BIT(_modeset_shift),				\
+	.modeset_shift = _modeset_shift					\
 }
 
 #define MT6397_LDO(match, vreg, ldo_volt_table, enreg, enbit, vosel,	\
@@ -145,6 +155,63 @@ static const u32 ldo_volt_table7[] = {
 	1300000, 1500000, 1800000, 2000000, 2500000, 2800000, 3000000, 3300000,
 };
 
+static int mt6397_regulator_set_mode(struct regulator_dev *rdev,
+				     unsigned int mode)
+{
+	struct mt6397_regulator_info *info = rdev_get_drvdata(rdev);
+	int ret, val;
+
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		val = MT6397_BUCK_MODE_FORCE_PWM;
+		break;
+	case REGULATOR_MODE_NORMAL:
+		val = MT6397_BUCK_MODE_AUTO;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err_mode;
+	}
+
+	dev_dbg(&rdev->dev, "mt6397 buck set_mode %#x, %#x, %#x, %#x\n",
+		info->modeset_reg, info->modeset_mask,
+		info->modeset_shift, val);
+
+	val <<= info->modeset_shift;
+	ret = regmap_update_bits(rdev->regmap, info->modeset_reg,
+				 info->modeset_mask, val);
+err_mode:
+	if (ret != 0) {
+		dev_err(&rdev->dev,
+			"Failed to set mt6397 buck mode: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static unsigned int mt6397_regulator_get_mode(struct regulator_dev *rdev)
+{
+	struct mt6397_regulator_info *info = rdev_get_drvdata(rdev);
+	int ret, regval;
+
+	ret = regmap_read(rdev->regmap, info->modeset_reg, &regval);
+	if (ret != 0) {
+		dev_err(&rdev->dev,
+			"Failed to get mt6397 buck mode: %d\n", ret);
+		return ret;
+	}
+
+	switch ((regval & info->modeset_mask) >> info->modeset_shift) {
+	case MT6397_BUCK_MODE_AUTO:
+		return REGULATOR_MODE_NORMAL;
+	case MT6397_BUCK_MODE_FORCE_PWM:
+		return REGULATOR_MODE_FAST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int mt6397_get_status(struct regulator_dev *rdev)
 {
 	int ret;
@@ -170,6 +237,8 @@ static const struct regulator_ops mt6397_volt_range_ops = {
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
 	.get_status = mt6397_get_status,
+	.set_mode = mt6397_regulator_set_mode,
+	.get_mode = mt6397_regulator_get_mode,
 };
 
 static const struct regulator_ops mt6397_volt_table_ops = {
@@ -196,28 +265,30 @@ static const struct regulator_ops mt6397_volt_fixed_ops = {
 static struct mt6397_regulator_info mt6397_regulators[] = {
 	MT6397_BUCK("buck_vpca15", VPCA15, 700000, 1493750, 6250,
 		buck_volt_range1, MT6397_VCA15_CON7, MT6397_VCA15_CON9, 0x7f,
-		MT6397_VCA15_CON10, MT6397_VCA15_CON5),
+		MT6397_VCA15_CON10, MT6397_VCA15_CON5, MT6397_VCA15_CON2, 11),
 	MT6397_BUCK("buck_vpca7", VPCA7, 700000, 1493750, 6250,
 		buck_volt_range1, MT6397_VPCA7_CON7, MT6397_VPCA7_CON9, 0x7f,
-		MT6397_VPCA7_CON10, MT6397_VPCA7_CON5),
+		MT6397_VPCA7_CON10, MT6397_VPCA7_CON5, MT6397_VPCA7_CON2, 8),
 	MT6397_BUCK("buck_vsramca15", VSRAMCA15, 700000, 1493750, 6250,
 		buck_volt_range1, MT6397_VSRMCA15_CON7, MT6397_VSRMCA15_CON9,
-		0x7f, MT6397_VSRMCA15_CON10, MT6397_VSRMCA15_CON5),
+		0x7f, MT6397_VSRMCA15_CON10, MT6397_VSRMCA15_CON5,
+		MT6397_VSRMCA15_CON2, 8),
 	MT6397_BUCK("buck_vsramca7", VSRAMCA7, 700000, 1493750, 6250,
 		buck_volt_range1, MT6397_VSRMCA7_CON7, MT6397_VSRMCA7_CON9,
-		0x7f, MT6397_VSRMCA7_CON10, MT6397_VSRMCA7_CON5),
+		0x7f, MT6397_VSRMCA7_CON10, MT6397_VSRMCA7_CON5,
+		MT6397_VSRMCA7_CON2, 8),
 	MT6397_BUCK("buck_vcore", VCORE, 700000, 1493750, 6250,
 		buck_volt_range1, MT6397_VCORE_CON7, MT6397_VCORE_CON9, 0x7f,
-		MT6397_VCORE_CON10, MT6397_VCORE_CON5),
+		MT6397_VCORE_CON10, MT6397_VCORE_CON5, MT6397_VCORE_CON2, 8),
 	MT6397_BUCK("buck_vgpu", VGPU, 700000, 1493750, 6250, buck_volt_range1,
 		MT6397_VGPU_CON7, MT6397_VGPU_CON9, 0x7f,
-		MT6397_VGPU_CON10, MT6397_VGPU_CON5),
+		MT6397_VGPU_CON10, MT6397_VGPU_CON5, MT6397_VGPU_CON2, 8),
 	MT6397_BUCK("buck_vdrm", VDRM, 800000, 1593750, 6250, buck_volt_range2,
 		MT6397_VDRM_CON7, MT6397_VDRM_CON9, 0x7f,
-		MT6397_VDRM_CON10, MT6397_VDRM_CON5),
+		MT6397_VDRM_CON10, MT6397_VDRM_CON5, MT6397_VDRM_CON2, 8),
 	MT6397_BUCK("buck_vio18", VIO18, 1500000, 2120000, 20000,
 		buck_volt_range3, MT6397_VIO18_CON7, MT6397_VIO18_CON9, 0x1f,
-		MT6397_VIO18_CON10, MT6397_VIO18_CON5),
+		MT6397_VIO18_CON10, MT6397_VIO18_CON5, MT6397_VIO18_CON2, 8),
 	MT6397_REG_FIXED("ldo_vtcxo", VTCXO, MT6397_ANALDO_CON0, 10, 2800000),
 	MT6397_REG_FIXED("ldo_va28", VA28, MT6397_ANALDO_CON1, 14, 2800000),
 	MT6397_LDO("ldo_vcama", VCAMA, ldo_volt_table1,
-- 
1.8.1.1.dirty
