From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 20 Jul 2010 08:07:07 +0200
Subject: [PATCH v2] regulator: MAX8998: set_voltage bugfix. ramp_up delay and
	min/max voltage
In-Reply-To: <1279391048.3070.11.camel@odin>
References: <1279391048.3070.11.camel@odin>
Message-ID: <1279606027-18345-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: MyungJoo Ham <myungjoo.ham@samsung.com>

Two issues are addressed for max8998_set_voltage function.

1. Min/Max Voltage.

	max8998_set_voltage had been using the voltage value of

	min ( voltage[i] >= max_vol , i )

	This is corrected to use:

	min ( voltage[i] >= min_vol , i )

2. Ramp Up Delay.

	max8998_set_voltage should provide delay for BUCK1/2
if ENRAMP is on. It reads RAMP value from ONOFF4 register to determine
RAMP delay length. However, when max8998_set_voltage's new voltage is
lower than the previous, we don't care because it does not deteriorate
the stability.

Changes since v1:
- rebased onto latest regulator-for-next tree

Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/regulator/max8998.c |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/max8998.c b/drivers/regulator/max8998.c
index 174fd19..78aea26 100644
--- a/drivers/regulator/max8998.c
+++ b/drivers/regulator/max8998.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
+#include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/mfd/max8998.h>
@@ -297,10 +298,13 @@ static int max8998_set_voltage(struct regulator_dev *rdev,
 {
 	struct max8998_data *max8998 = rdev_get_drvdata(rdev);
 	int min_vol = min_uV / 1000, max_vol = max_uV / 1000;
+	int previous_vol = 0;
 	const struct voltage_map_desc *desc;
 	int ldo = max8998_get_ldo(rdev);
 	int reg, shift = 0, mask, ret;
 	int i = 0;
+	u8 val;
+	bool en_ramp = false;
 
 	if (ldo > ARRAY_SIZE(ldo_voltage_map))
 		return -EINVAL;
@@ -312,15 +316,36 @@ static int max8998_set_voltage(struct regulator_dev *rdev,
 	if (max_vol < desc->min || min_vol > desc->max)
 		return -EINVAL;
 
-	while (desc->min + desc->step*i < max_vol &&
+	while (desc->min + desc->step*i < min_vol &&
 	       desc->min + desc->step*i < desc->max)
 		i++;
 
+	if (desc->min + desc->step*i > max_vol)
+		return -EINVAL;
+
 	ret = max8998_get_voltage_register(rdev, &reg, &shift, &mask);
 	if (ret)
 		return ret;
 
-	return max8998_update_reg(max8998->iodev, reg, i<<shift, mask<<shift);
+	/* wait for RAMP_UP_DELAY if rdev is BUCK1/2 and
+	 * ENRAMP is ON */
+	if (ldo == MAX8998_BUCK1 || ldo == MAX8998_BUCK2) {
+		max8998_read_reg(max8998->iodev, MAX8998_REG_ONOFF4, &val);
+		if (val & (1 << 4)) {
+			en_ramp = true;
+			previous_vol = max8998_get_voltage(rdev);
+		}
+	}
+ 
+	ret = max8998_update_reg(max8998->iodev, reg, i<<shift, mask<<shift);
+ 
+	if (en_ramp == true) {
+		int difference = desc->min + desc->step*i - previous_vol/1000;
+		if (difference > 0)
+			udelay(difference / ((val & 0x0f) + 1));
+	}
+
+	return ret;
 }
 
 static struct regulator_ops max8998_ldo_ops = {
-- 
1.7.1.569.g6f426
