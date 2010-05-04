From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 4 May 2010 09:54:51 -0400
Subject: [PATCH] regulator: use voltage number array in 88pm860x
Message-ID: <mailman.358.1273037764.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A lot of condition comparision statements are used in original driver. These
statements are used to check the boundary of voltage numbers since voltage
number isn't linear.

Now use array of voltage numbers instead. Clean code with simpler way.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/mfd/88pm860x-core.c  |    2 +
 drivers/regulator/88pm8607.c |  482 +++++++++++++++++++-----------------------
 include/linux/mfd/88pm860x.h |    3 +-
 3 files changed, 224 insertions(+), 263 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index 21de38d..405d2d5 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -173,6 +173,7 @@ static struct resource regulator_resources[] = {
 	PM8607_REG_RESOURCE(LDO9,  LDO9),
 	PM8607_REG_RESOURCE(LDO10, LDO10),
 	PM8607_REG_RESOURCE(LDO12, LDO12),
+	PM8607_REG_RESOURCE(VIBRATOR_SET, VIBRATOR_SET),
 	PM8607_REG_RESOURCE(LDO14, LDO14),
 };

@@ -199,6 +200,7 @@ static struct mfd_cell regulator_devs[] = {
 	PM8607_REG_DEVS(LDO9),
 	PM8607_REG_DEVS(LDO10),
 	PM8607_REG_DEVS(LDO12),
+	PM8607_REG_DEVS(LDO13),
 	PM8607_REG_DEVS(LDO14),
 };

diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
index 121bab4..7d149a8 100644
--- a/drivers/regulator/88pm8607.c
+++ b/drivers/regulator/88pm8607.c
@@ -23,9 +23,9 @@ struct pm8607_regulator_info {
 	struct regulator_dev	*regulator;
 	struct i2c_client	*i2c;

-	int	min_uV;
-	int	max_uV;
-	int	step_uV;
+	unsigned int	*vol_table;
+	unsigned int	*vol_suspend;
+
 	int	vol_reg;
 	int	vol_shift;
 	int	vol_nbits;
@@ -36,83 +36,189 @@ struct pm8607_regulator_info {
 	int	slope_double;
 };

-static inline int check_range(struct pm8607_regulator_info *info,
-				int min_uV, int max_uV)
-{
-	if (max_uV < info->min_uV || min_uV > info->max_uV || min_uV > max_uV)
-		return -EINVAL;
+static const unsigned int BUCK1_table[] = {
+	 725000,  750000,  775000,  800000,  825000,  850000,  875000,  900000,
+	 925000,  950000,  975000, 1000000, 1025000, 1050000, 1075000, 1100000,
+	1125000, 1150000, 1175000, 1200000, 1225000, 1250000, 1275000, 1300000,
+	1325000, 1350000, 1375000, 1400000, 1425000, 1450000, 1475000, 1500000,
+	      0,   25000,   50000,   75000,  100000,  125000,  150000,  175000,
+	 200000,  225000,  250000,  275000,  300000,  325000,  350000,  375000,
+	 400000,  425000,  450000,  475000,  500000,  525000,  550000,  575000,
+	 600000,  625000,  650000,  675000,  700000,  725000,  750000,  775000,
+};

-	return 0;
-}
+static const unsigned int BUCK1_suspend_table[] = {
+	      0,   25000,   50000,   75000,  100000,  125000,  150000,  175000,
+	 200000,  225000,  250000,  275000,  300000,  325000,  350000,  375000,
+	 400000,  425000,  450000,  475000,  500000,  525000,  550000,  575000,
+	 600000,  625000,  650000,  675000,  700000,  725000,  750000,  775000,
+	 800000,  825000,  850000,  875000,  900000,  925000,  950000,  975000,
+	1000000, 1025000, 1050000, 1075000, 1100000, 1125000, 1150000, 1175000,
+	1200000, 1225000, 1250000, 1275000, 1300000, 1325000, 1350000, 1375000,
+	1400000, 1425000, 1450000, 1475000, 1500000, 1500000, 1500000, 1500000,
+};
+
+static const unsigned int BUCK2_table[] = {
+	      0,   50000,  100000,  150000,  200000,  250000,  300000,  350000,
+	 400000,  450000,  500000,  550000,  600000,  650000,  700000,  750000,
+	 800000,  850000,  900000,  950000, 1000000, 1050000, 1100000, 1150000,
+	1200000, 1250000, 1300000, 1350000, 1400000, 1450000, 1500000, 1550000,
+	1600000, 1650000, 1700000, 1750000, 1800000, 1850000, 1900000, 1950000,
+	2000000, 2050000, 2100000, 2150000, 2200000, 2250000, 2300000, 2350000,
+	2400000, 2450000, 2500000, 2550000, 2600000, 2650000, 2700000, 2750000,
+	2800000, 2850000, 2900000, 2950000, 3000000, 3000000, 3000000, 3000000,
+};
+
+static const unsigned int BUCK2_suspend_table[] = {
+	      0,   50000,  100000,  150000,  200000,  250000,  300000,  350000,
+	 400000,  450000,  500000,  550000,  600000,  650000,  700000,  750000,
+	 800000,  850000,  900000,  950000, 1000000, 1050000, 1100000, 1150000,
+	1200000, 1250000, 1300000, 1350000, 1400000, 1450000, 1500000, 1550000,
+	1600000, 1650000, 1700000, 1750000, 1800000, 1850000, 1900000, 1950000,
+	2000000, 2050000, 2100000, 2150000, 2200000, 2250000, 2300000, 2350000,
+	2400000, 2450000, 2500000, 2550000, 2600000, 2650000, 2700000, 2750000,
+	2800000, 2850000, 2900000, 2950000, 3000000, 3000000, 3000000, 3000000,
+};
+
+static const unsigned int BUCK3_table[] = {
+              0,   25000,   50000,   75000,  100000,  125000,  150000,  175000,
+	 200000,  225000,  250000,  275000,  300000,  325000,  350000,  375000,
+	 400000,  425000,  450000,  475000,  500000,  525000,  550000,  575000,
+	 600000,  625000,  650000,  675000,  700000,  725000,  750000,  775000,
+	 800000,  825000,  850000,  875000,  900000,  925000,  950000,  975000,
+	1000000, 1025000, 1050000, 1075000, 1100000, 1125000, 1150000, 1175000,
+	1200000, 1225000, 1250000, 1275000, 1300000, 1325000, 1350000, 1375000,
+	1400000, 1425000, 1450000, 1475000, 1500000, 1500000, 1500000, 1500000,
+};
+
+static const unsigned int BUCK3_suspend_table[] = {
+              0,   25000,   50000,   75000,  100000,  125000,  150000,  175000,
+	 200000,  225000,  250000,  275000,  300000,  325000,  350000,  375000,
+	 400000,  425000,  450000,  475000,  500000,  525000,  550000,  575000,
+	 600000,  625000,  650000,  675000,  700000,  725000,  750000,  775000,
+	 800000,  825000,  850000,  875000,  900000,  925000,  950000,  975000,
+	1000000, 1025000, 1050000, 1075000, 1100000, 1125000, 1150000, 1175000,
+	1200000, 1225000, 1250000, 1275000, 1300000, 1325000, 1350000, 1375000,
+	1400000, 1425000, 1450000, 1475000, 1500000, 1500000, 1500000, 1500000,
+};
+
+static const unsigned int LDO1_table[] = {
+	1800000, 1200000, 2800000, 0,
+};
+
+static const unsigned int LDO1_suspend_table[] = {
+	1800000, 1200000, 0, 0,
+};
+
+static const unsigned int LDO2_table[] = {
+	1800000, 1850000, 1900000, 2700000, 2750000, 2800000, 2850000, 3300000,
+};
+
+static const unsigned int LDO2_suspend_table[] = {
+	1800000, 1850000, 1900000, 2700000, 2750000, 2800000, 2850000, 2900000,
+};
+
+static const unsigned int LDO3_table[] = {
+	1800000, 1850000, 1900000, 2700000, 2750000, 2800000, 2850000, 3300000,
+};
+
+static const unsigned int LDO3_suspend_table[] = {
+	1800000, 1850000, 1900000, 2700000, 2750000, 2800000, 2850000, 2900000,
+};
+
+static const unsigned int LDO4_table[] = {
+	1800000, 1850000, 1900000, 2700000, 2750000, 2800000, 2900000, 3300000,
+};
+
+static const unsigned int LDO4_suspend_table[] = {
+	1800000, 1850000, 1900000, 2700000, 2750000, 2800000, 2900000, 2900000,
+};
+
+static const unsigned int LDO5_table[] = {
+	2900000, 3000000, 3100000, 3300000,
+};
+
+static const unsigned int LDO5_suspend_table[] = {
+	2900000, 0, 0, 0,
+};
+
+static const unsigned int LDO6_table[] = {
+	1800000, 1850000, 2600000, 2650000, 2700000, 2750000, 2800000, 3300000,
+};
+
+static const unsigned int LDO6_suspend_table[] = {
+	1800000, 1850000, 2600000, 2650000, 2700000, 2750000, 2800000, 2900000,
+};
+
+static const unsigned int LDO7_table[] = {
+	1800000, 1850000, 1900000, 2700000, 2750000, 2800000, 2850000, 2900000,
+};
+
+static const unsigned int LDO7_suspend_table[] = {
+	1800000, 1850000, 1900000, 2700000, 2750000, 2800000, 2850000, 2900000,
+};
+
+static const unsigned int LDO8_table[] = {
+	1800000, 1850000, 1900000, 2700000, 2750000, 2800000, 2850000, 2900000,
+};
+
+static const unsigned int LDO8_suspend_table[] = {
+	1800000, 1850000, 1900000, 2700000, 2750000, 2800000, 2850000, 2900000,
+};
+
+static const unsigned int LDO9_table[] = {
+	1800000, 1850000, 1900000, 2700000, 2750000, 2800000, 2850000, 3300000,
+};
+
+static const unsigned int LDO9_suspend_table[] = {
+	1800000, 1850000, 1900000, 2700000, 2750000, 2800000, 2850000, 2900000,
+};
+
+static const unsigned int LDO10_table[] = {
+	1800000, 1850000, 1900000, 2700000, 2750000, 2800000, 2850000, 3300000,
+	1200000, 1200000, 1200000, 1200000, 1200000, 1200000, 1200000, 1200000,
+};
+
+static const unsigned int LDO10_suspend_table[] = {
+	1800000, 1850000, 1900000, 2700000, 2750000, 2800000, 2850000, 2900000,
+	1200000, 1200000, 1200000, 1200000, 1200000, 1200000, 1200000, 1200000,
+};
+
+static const unsigned int LDO12_table[] = {
+	1800000, 1900000, 2700000, 2800000, 2900000, 3000000, 3100000, 3300000,
+	1200000, 1200000, 1200000, 1200000, 1200000, 1200000, 1200000, 1200000,
+};
+
+static const unsigned int LDO12_suspend_table[] = {
+	1800000, 1900000, 2700000, 2800000, 2900000, 2900000, 2900000, 2900000,
+	1200000, 1200000, 1200000, 1200000, 1200000, 1200000, 1200000, 1200000,
+};
+
+static const unsigned int LDO13_table[] = {
+	1300000, 1800000, 2000000, 2500000, 2800000, 3000000, 0, 0,
+};
+
+static const unsigned int LDO13_suspend_table[] = {
+	0,
+};
+
+static const unsigned int LDO14_table[] = {
+	1800000, 1850000, 2700000, 2750000, 2800000, 2850000, 2900000, 3300000,
+};
+
+static const unsigned int LDO14_suspend_table[] = {
+	1800000, 1850000, 2700000, 2750000, 2800000, 2850000, 2900000, 2900000,
+};

 static int pm8607_list_voltage(struct regulator_dev *rdev, unsigned index)
 {
 	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
 	int ret = -EINVAL;

-	switch (info->desc.id) {
-	case PM8607_ID_BUCK1:
-		ret = (index < 0x1d) ? (index * 25000 + 800000) :
-			((index < 0x20) ? 1500000 :
-			((index < 0x40) ? ((index - 0x20) * 25000) :
-			-EINVAL));
-		break;
-	case PM8607_ID_BUCK3:
-		ret = (index < 0x3d) ? (index * 25000) :
-			((index < 0x40) ? 1500000 : -EINVAL);
-		if (ret < 0)
-			break;
+	if (info->vol_table && (index < (2 << info->vol_nbits))) {
+		ret = info->vol_table[index];
 		if (info->slope_double)
 			ret <<= 1;
-		break;
-	case PM8607_ID_LDO1:
-		ret = (index == 0) ? 1800000 :
-			((index == 1) ? 1200000 :
-			((index == 2) ? 2800000 : -EINVAL));
-		break;
-	case PM8607_ID_LDO5:
-		ret = (index == 0) ? 2900000 :
-			((index == 1) ? 3000000 :
-			((index == 2) ? 3100000 : 3300000));
-		break;
-	case PM8607_ID_LDO7:
-	case PM8607_ID_LDO8:
-		ret = (index < 3) ? (index * 50000 + 1800000) :
-			((index < 8) ? (index * 50000 + 2550000) :
-			 -EINVAL);
-		break;
-	case PM8607_ID_LDO12:
-		ret = (index < 2) ? (index * 100000 + 1800000) :
-			((index < 7) ? (index * 100000 + 2500000) :
-			((index == 7) ? 3300000 : 1200000));
-		break;
-	case PM8607_ID_LDO2:
-	case PM8607_ID_LDO3:
-	case PM8607_ID_LDO9:
-		ret = (index < 3) ? (index * 50000 + 1800000) :
-			((index < 7) ? (index * 50000 + 2550000) :
-			3300000);
-		break;
-	case PM8607_ID_LDO4:
-		ret = (index < 3) ? (index * 50000 + 1800000) :
-			((index < 6) ? (index * 50000 + 2550000) :
-			((index == 6) ? 2900000 : 3300000));
-		break;
-	case PM8607_ID_LDO6:
-		ret = (index < 2) ? (index * 50000 + 1800000) :
-			((index < 7) ? (index * 50000 + 2500000) :
-			3300000);
-		break;
-	case PM8607_ID_LDO10:
-		ret = (index < 3) ? (index * 50000 + 1800000) :
-			((index < 7) ? (index * 50000 + 2550000) :
-			((index == 7) ? 3300000 : 1200000));
-		break;
-	case PM8607_ID_LDO14:
-		ret = (index < 2) ? (index * 50000 + 1800000) :
-			((index < 7) ? (index * 50000 + 2600000) :
-			3300000);
-		break;
 	}
 	return ret;
 }
@@ -120,174 +226,26 @@ static int pm8607_list_voltage(struct
regulator_dev *rdev, unsigned index)
 static int choose_voltage(struct regulator_dev *rdev, int min_uV, int max_uV)
 {
 	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
-	int val = -ENOENT;
-	int ret;
+	int i, ret = -ENOENT;

-	switch (info->desc.id) {
-	case PM8607_ID_BUCK1:
-		if (min_uV >= 800000) 		/* 800mV ~ 1500mV / 25mV */
-			val = (min_uV - 775001) / 25000;
-		else {				/* 25mV ~ 775mV / 25mV */
-			val = (min_uV + 249999) / 25000;
-			val += 32;
-		}
-		break;
-	case PM8607_ID_BUCK3:
-		if (info->slope_double)
-			min_uV = min_uV >> 1;
-		val = (min_uV + 249999) / 25000; /* 0mV ~ 1500mV / 25mV */
-
-		break;
-	case PM8607_ID_LDO1:
-		if (min_uV > 1800000)
-			val = 2;
-		else if (min_uV > 1200000)
-			val = 0;
-		else
-			val = 1;
-		break;
-	case PM8607_ID_LDO5:
-		if (min_uV > 3100000)
-			val = 3;
-		else				/* 2900mV ~ 3100mV / 100mV */
-			val = (min_uV - 2800001) / 100000;
-		break;
-	case PM8607_ID_LDO7:
-	case PM8607_ID_LDO8:
-		if (min_uV < 2700000) {	/* 1800mV ~ 1900mV / 50mV */
-			if (min_uV <= 1800000)
-				val = 0;	/* 1800mv */
-			else if (min_uV <= 1900000)
-				val = (min_uV - 1750001) / 50000;
-			else
-				val = 3;	/* 2700mV */
-		} else {		 /* 2700mV ~ 2900mV / 50mV */
-			if (min_uV <= 2900000) {
-				val = (min_uV - 2650001) / 50000;
-				val += 3;
-			} else
-				val = -EINVAL;
-		}
-		break;
-	case PM8607_ID_LDO10:
-		if (min_uV > 2850000)
-			val = 7;
-		else if (min_uV <= 1200000)
-			val = 8;
-		else if (min_uV < 2700000)	/* 1800mV ~ 1900mV / 50mV */
-			val = (min_uV - 1750001) / 50000;
-		else {				/* 2700mV ~ 2850mV / 50mV */
-			val = (min_uV - 2650001) / 50000;
-			val += 3;
-		}
-		break;
-	case PM8607_ID_LDO12:
-		if (min_uV < 2700000) {		/* 1800mV ~ 1900mV / 100mV */
-			if (min_uV <= 1200000)
-				val = 8;	/* 1200mV */
-			else if (min_uV <= 1800000)
-				val = 0;	/* 1800mV */
-			else if (min_uV <= 1900000)
-				val = (min_uV - 1700001) / 100000;
-			else
-				val = 2;	/* 2700mV */
-		} else {			/* 2700mV ~ 3100mV / 100mV */
-			if (min_uV <= 3100000) {
-				val = (min_uV - 2600001) / 100000;
-				val += 2;
-			} else if (min_uV <= 3300000)
-				val = 7;
-			else
-				val = -EINVAL;
-		}
-		break;
-	case PM8607_ID_LDO2:
-	case PM8607_ID_LDO3:
-	case PM8607_ID_LDO9:
-		if (min_uV < 2700000) {	/* 1800mV ~ 1900mV / 50mV */
-			if (min_uV <= 1800000)
-				val = 0;
-			else if (min_uV <= 1900000)
-				val = (min_uV - 1750001) / 50000;
-			else
-				val = 3;	/* 2700mV */
-		} else {		 /* 2700mV ~ 2850mV / 50mV */
-			if (min_uV <= 2850000) {
-				val = (min_uV - 2650001) / 50000;
-				val += 3;
-			} else if (min_uV <= 3300000)
-				val = 7;
-			else
-				val = -EINVAL;
-		}
-		break;
-	case PM8607_ID_LDO4:
-		if (min_uV < 2700000) {	/* 1800mV ~ 1900mV / 50mV */
-			if (min_uV <= 1800000)
-				val = 0;
-			else if (min_uV <= 1900000)
-				val = (min_uV - 1750001) / 50000;
-			else
-				val = 3;	/* 2700mV */
-		} else {		 /* 2700mV ~ 2800mV / 50mV */
-			if (min_uV <= 2850000) {
-				val = (min_uV - 2650001) / 50000;
-				val += 3;
-			} else if (min_uV <= 2900000)
-				val = 6;
-			else if (min_uV <= 3300000)
-				val = 7;
-			else
-				val = -EINVAL;
-		}
-		break;
-	case PM8607_ID_LDO6:
-		if (min_uV < 2600000) {	/* 1800mV ~ 1850mV / 50mV */
-			if (min_uV <= 1800000)
-				val = 0;
-			else if (min_uV <= 1850000)
-				val = (min_uV - 1750001) / 50000;
-			else
-				val = 2;	/* 2600mV */
-		} else {		/* 2600mV ~ 2800mV / 50mV */
-			if (min_uV <= 2800000) {
-				val = (min_uV - 2550001) / 50000;
-				val += 2;
-			} else if (min_uV <= 3300000)
-				val = 7;
-			else
-				val = -EINVAL;
-		}
-		break;
-	case PM8607_ID_LDO14:
-		if (min_uV < 2700000) {	/* 1800mV ~ 1850mV / 50mV */
-			if (min_uV <= 1800000)
-				val = 0;
-			else if (min_uV <= 1850000)
-				val = (min_uV - 1750001) / 50000;
-			else
-				val = 2;	/* 2700mV */
-		} else {		 /* 2700mV ~ 2900mV / 50mV */
-			if (min_uV <= 2900000) {
-				val = (min_uV - 2650001) / 50000;
-				val += 2;
-			} else if (min_uV <= 3300000)
-				val = 7;
-			else
-				val = -EINVAL;
-		}
-		break;
+	if (info->slope_double) {
+		min_uV = min_uV >> 1;
+		max_uV = max_uV >> 1;
 	}
-	if (val >= 0) {
-		ret = pm8607_list_voltage(rdev, val);
-		if (ret > max_uV) {
-			pr_err("exceed voltage range (%d %d) uV",
-				min_uV, max_uV);
-			return -EINVAL;
+	if (info->vol_table) {
+		for (i = 0; i < (2 << info->vol_nbits); i++) {
+			if (!info->vol_table[i])
+				break;
+			if ((min_uV <= info->vol_table[i])
+				&& (max_uV >= info->vol_table[i])) {
+				ret = i;
+				break;
+			}
 		}
-	} else
-		pr_err("invalid voltage range (%d %d) uV", min_uV, max_uV);
-	return val;
+	}
+	if (ret < 0)
+		pr_err("invalid voltage range (%d %d) uV\n", min_uV, max_uV);
+	return ret;
 }

 static int pm8607_set_voltage(struct regulator_dev *rdev,
@@ -297,7 +255,7 @@ static int pm8607_set_voltage(struct regulator_dev *rdev,
 	uint8_t val, mask;
 	int ret;

-	if (check_range(info, min_uV, max_uV)) {
+	if (min_uV > max_uV) {
 		pr_err("invalid voltage range (%d, %d) uV\n", min_uV, max_uV);
 		return -EINVAL;
 	}
@@ -375,18 +333,15 @@ static struct regulator_ops pm8607_regulator_ops = {
 	.is_enabled	= pm8607_is_enabled,
 };

-#define PM8607_DVC(_id, min, max, step, vreg, nbits, ureg, ubit, ereg, ebit) \
+#define PM8607_DVC(vreg, nbits, ureg, ubit, ereg, ebit)			\
 {									\
 	.desc	= {							\
-		.name	= "BUCK" #_id,					\
+		.name	= #vreg,					\
 		.ops	= &pm8607_regulator_ops,			\
 		.type	= REGULATOR_VOLTAGE,				\
-		.id	= PM8607_ID_BUCK##_id,				\
+		.id	= PM8607_ID_##vreg,				\
 		.owner	= THIS_MODULE,					\
 	},								\
-	.min_uV		= (min) * 1000,					\
-	.max_uV		= (max) * 1000,					\
-	.step_uV	= (step) * 1000,				\
 	.vol_reg	= PM8607_##vreg,				\
 	.vol_shift	= (0),						\
 	.vol_nbits	= (nbits),					\
@@ -395,9 +350,11 @@ static struct regulator_ops pm8607_regulator_ops = {
 	.enable_reg	= PM8607_##ereg,				\
 	.enable_bit	= (ebit),					\
 	.slope_double	= (0),						\
+	.vol_table	= (unsigned int *)&vreg##_table,		\
+	.vol_suspend	= (unsigned int *)&vreg##_suspend_table,	\
 }

-#define PM8607_LDO(_id, min, max, step, vreg, shift, nbits, ereg, ebit)	\
+#define PM8607_LDO(_id, vreg, shift, nbits, ereg, ebit)			\
 {									\
 	.desc	= {							\
 		.name	= "LDO" #_id,					\
@@ -406,33 +363,34 @@ static struct regulator_ops pm8607_regulator_ops = {
 		.id	= PM8607_ID_LDO##_id,				\
 		.owner	= THIS_MODULE,					\
 	},								\
-	.min_uV		= (min) * 1000,					\
-	.max_uV		= (max) * 1000,					\
-	.step_uV	= (step) * 1000,				\
 	.vol_reg	= PM8607_##vreg,				\
 	.vol_shift	= (shift),					\
 	.vol_nbits	= (nbits),					\
 	.enable_reg	= PM8607_##ereg,				\
 	.enable_bit	= (ebit),					\
 	.slope_double	= (0),						\
+	.vol_table	= (unsigned int *)&LDO##_id##_table,		\
+	.vol_suspend	= (unsigned int *)&LDO##_id##_suspend_table,	\
 }

 static struct pm8607_regulator_info pm8607_regulator_info[] = {
-	PM8607_DVC(1, 0, 1500, 25, BUCK1, 6, GO, 0, SUPPLIES_EN11, 0),
-	PM8607_DVC(3, 0, 1500, 25, BUCK3, 6, GO, 2, SUPPLIES_EN11, 2),
-
-	PM8607_LDO(1 , 1200, 2800, 0, LDO1 , 0, 2, SUPPLIES_EN11, 3),
-	PM8607_LDO(2 , 1800, 3300, 0, LDO2 , 0, 3, SUPPLIES_EN11, 4),
-	PM8607_LDO(3 , 1800, 3300, 0, LDO3 , 0, 3, SUPPLIES_EN11, 5),
-	PM8607_LDO(4 , 1800, 3300, 0, LDO4 , 0, 3, SUPPLIES_EN11, 6),
-	PM8607_LDO(5 , 2900, 3300, 0, LDO5 , 0, 2, SUPPLIES_EN11, 7),
-	PM8607_LDO(6 , 1800, 3300, 0, LDO6 , 0, 3, SUPPLIES_EN12, 0),
-	PM8607_LDO(7 , 1800, 2900, 0, LDO7 , 0, 3, SUPPLIES_EN12, 1),
-	PM8607_LDO(8 , 1800, 2900, 0, LDO8 , 0, 3, SUPPLIES_EN12, 2),
-	PM8607_LDO(9 , 1800, 3300, 0, LDO9 , 0, 3, SUPPLIES_EN12, 3),
-	PM8607_LDO(10, 1200, 3300, 0, LDO10, 0, 4, SUPPLIES_EN11, 4),
-	PM8607_LDO(12, 1200, 3300, 0, LDO12, 0, 4, SUPPLIES_EN11, 5),
-	PM8607_LDO(14, 1800, 3300, 0, LDO14, 0, 3, SUPPLIES_EN11, 6),
+	PM8607_DVC(BUCK1, 6, GO, 0, SUPPLIES_EN11, 0),
+	PM8607_DVC(BUCK2, 6, GO, 1, SUPPLIES_EN11, 1),
+	PM8607_DVC(BUCK3, 6, GO, 2, SUPPLIES_EN11, 2),
+
+	PM8607_LDO( 1,         LDO1, 0, 2, SUPPLIES_EN11, 3),
+	PM8607_LDO( 2,         LDO2, 0, 3, SUPPLIES_EN11, 4),
+	PM8607_LDO( 3,         LDO3, 0, 3, SUPPLIES_EN11, 5),
+	PM8607_LDO( 4,         LDO4, 0, 3, SUPPLIES_EN11, 6),
+	PM8607_LDO( 5,         LDO5, 0, 2, SUPPLIES_EN11, 7),
+	PM8607_LDO( 6,         LDO6, 0, 3, SUPPLIES_EN12, 0),
+	PM8607_LDO( 7,         LDO7, 0, 3, SUPPLIES_EN12, 1),
+	PM8607_LDO( 8,         LDO8, 0, 3, SUPPLIES_EN12, 2),
+	PM8607_LDO( 9,         LDO9, 0, 3, SUPPLIES_EN12, 3),
+	PM8607_LDO(10,        LDO10, 0, 3, SUPPLIES_EN12, 4),
+	PM8607_LDO(12,        LDO12, 0, 4, SUPPLIES_EN12, 5),
+	PM8607_LDO(13, VIBRATOR_SET, 1, 3,  VIBRATOR_SET, 0),
+	PM8607_LDO(14,        LDO14, 0, 4, SUPPLIES_EN12, 6),
 };

 static inline struct pm8607_regulator_info *find_regulator_info(int id)
diff --git a/include/linux/mfd/88pm860x.h b/include/linux/mfd/88pm860x.h
index 73f92c5..e3c4ff8 100644
--- a/include/linux/mfd/88pm860x.h
+++ b/include/linux/mfd/88pm860x.h
@@ -132,6 +132,7 @@ enum {
 	PM8607_ID_LDO9,
 	PM8607_ID_LDO10,
 	PM8607_ID_LDO12,
+	PM8607_ID_LDO13,
 	PM8607_ID_LDO14,

 	PM8607_ID_RG_MAX,
@@ -309,7 +310,7 @@ struct pm860x_chip {

 };

-#define PM8607_MAX_REGULATOR	15	/* 3 Bucks, 12 LDOs */
+#define PM8607_MAX_REGULATOR	PM8607_ID_RG_MAX	/* 3 Bucks, 13 LDOs */

 enum {
 	GI2C_PORT = 0,
-- 
1.5.6.5
