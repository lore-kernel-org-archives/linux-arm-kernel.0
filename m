From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 27 Jan 2015 18:46:34 -0800
Subject: [PATCH 4/9] regulator: wm831x-ldo: move to set_optimum_mode
In-Reply-To: <1422413199-17273-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1422413199-17273-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1422413199-17273-5-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 drivers/regulator/wm831x-ldo.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/wm831x-ldo.c b/drivers/regulator/wm831x-ldo.c
index 7ae2dc8..40d391e 100644
--- a/drivers/regulator/wm831x-ldo.c
+++ b/drivers/regulator/wm831x-ldo.c
@@ -186,15 +186,20 @@ static int wm831x_gp_ldo_get_status(struct regulator_dev *rdev)
 		return regulator_mode_to_status(ret);
 }
 
-static unsigned int wm831x_gp_ldo_get_optimum_mode(struct regulator_dev *rdev,
-						   int input_uV,
-						   int output_uV, int load_uA)
+static int wm831x_gp_ldo_set_optimum_mode(struct regulator_dev *rdev,
+					  int input_uV,
+					  int output_uV, int load_uA)
 {
+	unsigned int mode;
+
 	if (load_uA < 20000)
-		return REGULATOR_MODE_STANDBY;
-	if (load_uA < 50000)
-		return REGULATOR_MODE_IDLE;
-	return REGULATOR_MODE_NORMAL;
+		mode = REGULATOR_MODE_STANDBY;
+	else if (load_uA < 50000)
+		mode = REGULATOR_MODE_IDLE;
+	else
+		mode = REGULATOR_MODE_NORMAL;
+
+	return wm831x_gp_ldo_set_mode(rdev, mode);
 }
 
 
@@ -207,7 +212,7 @@ static struct regulator_ops wm831x_gp_ldo_ops = {
 	.get_mode = wm831x_gp_ldo_get_mode,
 	.set_mode = wm831x_gp_ldo_set_mode,
 	.get_status = wm831x_gp_ldo_get_status,
-	.get_optimum_mode = wm831x_gp_ldo_get_optimum_mode,
+	.set_optimum_mode = wm831x_gp_ldo_set_optimum_mode,
 	.get_bypass = regulator_get_bypass_regmap,
 	.set_bypass = regulator_set_bypass_regmap,
 
-- 
1.9.1
