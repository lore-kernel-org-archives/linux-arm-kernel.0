From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 27 Jan 2015 18:46:35 -0800
Subject: [PATCH 5/9] regulator: wm8350: move to set_optimum_mode
In-Reply-To: <1422413199-17273-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1422413199-17273-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1422413199-17273-6-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 drivers/regulator/wm8350-regulator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/wm8350-regulator.c b/drivers/regulator/wm8350-regulator.c
index 7ec7c39..f8bcaed 100644
--- a/drivers/regulator/wm8350-regulator.c
+++ b/drivers/regulator/wm8350-regulator.c
@@ -915,13 +915,13 @@ static unsigned int get_mode(int uA, const struct wm8350_dcdc_efficiency *eff)
 	return REGULATOR_MODE_NORMAL;
 }
 
-/* Query the regulator for it's most efficient mode @ uV,uA
+/* Configure the regulator for it's most efficient mode @ uV,uA
  * WM8350 regulator efficiency is pretty similar over
  * different input and output uV.
  */
-static unsigned int wm8350_dcdc_get_optimum_mode(struct regulator_dev *rdev,
-						 int input_uV, int output_uV,
-						 int output_uA)
+static int wm8350_dcdc_set_optimum_mode(struct regulator_dev *rdev,
+					int input_uV, int output_uV,
+					int output_uA)
 {
 	int dcdc = rdev_get_id(rdev), mode;
 
@@ -938,7 +938,7 @@ static unsigned int wm8350_dcdc_get_optimum_mode(struct regulator_dev *rdev,
 		mode = REGULATOR_MODE_NORMAL;
 		break;
 	}
-	return mode;
+	return wm8350_dcdc_set_mode(rdev, mode);
 }
 
 static struct regulator_ops wm8350_dcdc_ops = {
@@ -951,7 +951,7 @@ static struct regulator_ops wm8350_dcdc_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.get_mode = wm8350_dcdc_get_mode,
 	.set_mode = wm8350_dcdc_set_mode,
-	.get_optimum_mode = wm8350_dcdc_get_optimum_mode,
+	.set_optimum_mode = wm8350_dcdc_set_optimum_mode,
 	.set_suspend_voltage = wm8350_dcdc_set_suspend_voltage,
 	.set_suspend_enable = wm8350_dcdc_set_suspend_enable,
 	.set_suspend_disable = wm8350_dcdc_set_suspend_disable,
-- 
1.9.1
