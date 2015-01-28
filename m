From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 27 Jan 2015 18:46:39 -0800
Subject: [PATCH 9/9] regulator: qcom-rpm: Implement set_optimum_mode
In-Reply-To: <1422413199-17273-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1422413199-17273-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1422413199-17273-10-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass the requested load directly to the rpm.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 drivers/regulator/qcom_rpm-regulator.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/regulator/qcom_rpm-regulator.c b/drivers/regulator/qcom_rpm-regulator.c
index 8364ff3..745dd75 100644
--- a/drivers/regulator/qcom_rpm-regulator.c
+++ b/drivers/regulator/qcom_rpm-regulator.c
@@ -388,6 +388,30 @@ static int rpm_reg_is_enabled(struct regulator_dev *rdev)
 	return vreg->is_enabled;
 }
 
+static int rpm_reg_set_optimum_mode(struct regulator_dev *rdev,
+				    int input_uV, int output_uV,
+				    int load_uA)
+{
+	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
+	const struct rpm_reg_parts *parts = vreg->parts;
+	const struct request_member *req = &parts->ia;
+	int load_mA = load_uA / 1000;
+	int max_mA = req->mask >> req->shift;
+	int ret;
+
+	if (req->mask == 0)
+		return -EINVAL;
+
+	if (load_mA > max_mA)
+		load_mA = max_mA;
+
+	mutex_lock(&vreg->lock);
+	ret = rpm_reg_write(vreg, req, load_mA);
+	mutex_unlock(&vreg->lock);
+
+	return ret;
+}
+
 static struct regulator_ops uV_ops = {
 	.list_voltage = regulator_list_voltage_linear_range,
 
@@ -397,6 +421,8 @@ static struct regulator_ops uV_ops = {
 	.enable = rpm_reg_uV_enable,
 	.disable = rpm_reg_uV_disable,
 	.is_enabled = rpm_reg_is_enabled,
+
+	.set_optimum_mode = rpm_reg_set_optimum_mode,
 };
 
 static struct regulator_ops mV_ops = {
@@ -408,6 +434,8 @@ static struct regulator_ops mV_ops = {
 	.enable = rpm_reg_mV_enable,
 	.disable = rpm_reg_mV_disable,
 	.is_enabled = rpm_reg_is_enabled,
+
+	.set_optimum_mode = rpm_reg_set_optimum_mode,
 };
 
 static struct regulator_ops switch_ops = {
-- 
1.9.1
