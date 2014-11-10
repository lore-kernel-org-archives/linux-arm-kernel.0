From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 10 Nov 2014 14:52:46 -0800
Subject: [RFC 2/2] regulator: qcom-rpm: Implement RPM assisted disable
In-Reply-To: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>
References: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <1415659966-16200-3-git-send-email-bjorn.andersson@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some regulators are used to power e.g. PLLs that clocks the core we're
running on, so we can't turn them off directly; but we do want them off
when the core is powered down. To handle this the Qualcomm SoC provides
a means to specify a "sleep state" for RPM resources that can be
triggered by the hardware when the cores are brought down.

Resources of this type should be considered always-on while the CPU(s)
are running and we can utilize the "sleep state" functionality to defer
disabling them until the CPU(s) go to sleep, if not used by other
peripherals at that time.

Other properties are kept in sync between the states, so that if the
CPU(s) go to sleep with a particular regulator still enabled there will
be no change.

Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
---
 Documentation/devicetree/bindings/mfd/qcom-rpm.txt |   28 ++++++++
 drivers/regulator/qcom_rpm-regulator.c             |   68 +++++++++++++++-----
 2 files changed, 79 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
index 4264021..4671eef 100644
--- a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
+++ b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
@@ -112,6 +112,13 @@ of valid subnodes that can operate on these resources.
 	Definition: select that the power supply should operate in hysteretic
 		    mode, instead of the default pwm mode
 
+- qcom,rpm-assisted-disable:
+	Usage: optional
+	Value type: <empty>
+	Definition: select that the regulator is supplying the active CPU(s)
+		    and can only be disabled with the assistans from the RPM
+		    after going to sleep
+
 Standard regulator bindings are used inside switch mode power supply subnodes.
 Check Documentation/devicetree/bindings/regulator/regulator.txt for more
 details.
@@ -160,6 +167,13 @@ details.
 						qcom,rpm-pm8921-nldo,
 						qcom,rpm-pm8921-nldo1200
 
+- qcom,rpm-assisted-disable:
+	Usage: optional
+	Value type: <empty>
+	Definition: select that the regulator is supplying the active CPU(s)
+		    and can only be disabled with the assistans from the RPM
+		    after going to sleep
+
 Standard regulator bindings are used inside switch low-dropout regulator
 subnodes.  Check Documentation/devicetree/bindings/regulator/regulator.txt for
 more details.
@@ -190,6 +204,13 @@ more details.
 		    2740000, 2400000, 2130000, 1920000, 1750000, 1600000,
 		    1480000, 1370000, 1280000, 1200000
 
+- qcom,rpm-assisted-disable:
+	Usage: optional
+	Value type: <empty>
+	Definition: select that the regulator is supplying the active CPU(s)
+		    and can only be disabled with the assistans from the RPM
+		    after going to sleep
+
 Standard regulator bindings are used inside negative charge pump regulator
 subnodes.  Check Documentation/devicetree/bindings/regulator/regulator.txt for
 more details.
@@ -215,6 +236,13 @@ more details.
 		    QCOM_RPM_PM8921_LVS1 - QCOM_RPM_PM8921_LVS7,
 		    QCOM_RPM_PM8921_MVS
 
+- qcom,rpm-assisted-disable:
+	Usage: optional
+	Value type: <empty>
+	Definition: select that the regulator is supplying the active CPU(s)
+		    and can only be disabled with the assistans from the RPM
+		    after going to sleep
+
 = EXAMPLE
 
 	#include <dt-bindings/mfd/qcom-rpm.h>
diff --git a/drivers/regulator/qcom_rpm-regulator.c b/drivers/regulator/qcom_rpm-regulator.c
index 4fc1c7e..2a78f59 100644
--- a/drivers/regulator/qcom_rpm-regulator.c
+++ b/drivers/regulator/qcom_rpm-regulator.c
@@ -24,6 +24,7 @@
 #include <dt-bindings/mfd/qcom-rpm.h>
 
 #define MAX_REQUEST_LEN 2
+#define RPM_NUM_STATES	2
 
 struct request_member {
 	int		word;
@@ -61,13 +62,15 @@ struct qcom_rpm_reg {
 	const struct rpm_reg_parts *parts;
 
 	int resource;
-	u32 val[MAX_REQUEST_LEN];
+	u32 val[RPM_NUM_STATES][MAX_REQUEST_LEN];
 
 	int uV;
 	int is_enabled;
 
 	bool supports_force_mode_auto;
 	bool supports_force_mode_bypass;
+
+	bool rpm_assist;
 };
 
 static const struct rpm_reg_parts rpm8660_ldo_parts = {
@@ -188,19 +191,20 @@ static const struct regulator_linear_range ncp_ranges[] = {
 };
 
 static int rpm_reg_write(struct qcom_rpm_reg *vreg,
+			 int state,
 			 const struct request_member *req,
 			 const int value)
 {
 	if (WARN_ON((value << req->shift) & ~req->mask))
 		return -EINVAL;
 
-	vreg->val[req->word] &= ~req->mask;
-	vreg->val[req->word] |= value << req->shift;
+	vreg->val[state][req->word] &= ~req->mask;
+	vreg->val[state][req->word] |= value << req->shift;
 
 	return qcom_rpm_write(vreg->rpm,
-			      RPM_ACTIVE_STATE,
+			      state,
 			      vreg->resource,
-			      vreg->val,
+			      vreg->val[state],
 			      vreg->parts->request_len);
 }
 
@@ -222,8 +226,11 @@ static int rpm_reg_set_mV_sel(struct regulator_dev *rdev,
 
 	mutex_lock(&vreg->lock);
 	vreg->uV = uV;
-	if (vreg->is_enabled)
-		ret = rpm_reg_write(vreg, req, vreg->uV / 1000);
+	if (vreg->is_enabled) {
+		ret = rpm_reg_write(vreg, RPM_ACTIVE_STATE, req, vreg->uV / 1000);
+		if (!ret && vreg->rpm_assist)
+			ret = rpm_reg_write(vreg, RPM_SLEEP_STATE, req, vreg->uV / 1000);
+	}
 	mutex_unlock(&vreg->lock);
 
 	return ret;
@@ -247,8 +254,11 @@ static int rpm_reg_set_uV_sel(struct regulator_dev *rdev,
 
 	mutex_lock(&vreg->lock);
 	vreg->uV = uV;
-	if (vreg->is_enabled)
-		ret = rpm_reg_write(vreg, req, vreg->uV);
+	if (vreg->is_enabled) {
+		ret = rpm_reg_write(vreg, RPM_ACTIVE_STATE, req, vreg->uV);
+		if (!ret && vreg->rpm_assist)
+			ret = rpm_reg_write(vreg, RPM_SLEEP_STATE, req, vreg->uV);
+	}
 	mutex_unlock(&vreg->lock);
 
 	return ret;
@@ -266,13 +276,16 @@ static int rpm_reg_mV_enable(struct regulator_dev *rdev)
 	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
 	const struct rpm_reg_parts *parts = vreg->parts;
 	const struct request_member *req = &parts->mV;
+	int state;
 	int ret;
 
 	if (req->mask == 0)
 		return -EINVAL;
 
+	state = vreg->rpm_assist ? RPM_SLEEP_STATE : RPM_ACTIVE_STATE;
+
 	mutex_lock(&vreg->lock);
-	ret = rpm_reg_write(vreg, req, vreg->uV / 1000);
+	ret = rpm_reg_write(vreg, state, req, vreg->uV / 1000);
 	if (!ret)
 		vreg->is_enabled = 1;
 	mutex_unlock(&vreg->lock);
@@ -285,13 +298,16 @@ static int rpm_reg_uV_enable(struct regulator_dev *rdev)
 	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
 	const struct rpm_reg_parts *parts = vreg->parts;
 	const struct request_member *req = &parts->uV;
+	int state;
 	int ret;
 
 	if (req->mask == 0)
 		return -EINVAL;
 
+	state = vreg->rpm_assist ? RPM_SLEEP_STATE : RPM_ACTIVE_STATE;
+
 	mutex_lock(&vreg->lock);
-	ret = rpm_reg_write(vreg, req, vreg->uV);
+	ret = rpm_reg_write(vreg, state, req, vreg->uV);
 	if (!ret)
 		vreg->is_enabled = 1;
 	mutex_unlock(&vreg->lock);
@@ -304,13 +320,16 @@ static int rpm_reg_switch_enable(struct regulator_dev *rdev)
 	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
 	const struct rpm_reg_parts *parts = vreg->parts;
 	const struct request_member *req = &parts->enable_state;
+	int state;
 	int ret;
 
 	if (req->mask == 0)
 		return -EINVAL;
 
+	state = vreg->rpm_assist ? RPM_SLEEP_STATE : RPM_ACTIVE_STATE;
+
 	mutex_lock(&vreg->lock);
-	ret = rpm_reg_write(vreg, req, 1);
+	ret = rpm_reg_write(vreg, state, req, 1);
 	if (!ret)
 		vreg->is_enabled = 1;
 	mutex_unlock(&vreg->lock);
@@ -323,13 +342,16 @@ static int rpm_reg_mV_disable(struct regulator_dev *rdev)
 	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
 	const struct rpm_reg_parts *parts = vreg->parts;
 	const struct request_member *req = &parts->mV;
+	int state;
 	int ret;
 
 	if (req->mask == 0)
 		return -EINVAL;
 
+	state = vreg->rpm_assist ? RPM_SLEEP_STATE : RPM_ACTIVE_STATE;
+
 	mutex_lock(&vreg->lock);
-	ret = rpm_reg_write(vreg, req, 0);
+	ret = rpm_reg_write(vreg, state, req, 0);
 	if (!ret)
 		vreg->is_enabled = 0;
 	mutex_unlock(&vreg->lock);
@@ -342,13 +364,16 @@ static int rpm_reg_uV_disable(struct regulator_dev *rdev)
 	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
 	const struct rpm_reg_parts *parts = vreg->parts;
 	const struct request_member *req = &parts->uV;
+	int state;
 	int ret;
 
 	if (req->mask == 0)
 		return -EINVAL;
 
+	state = vreg->rpm_assist ? RPM_SLEEP_STATE : RPM_ACTIVE_STATE;
+
 	mutex_lock(&vreg->lock);
-	ret = rpm_reg_write(vreg, req, 0);
+	ret = rpm_reg_write(vreg, state, req, 0);
 	if (!ret)
 		vreg->is_enabled = 0;
 	mutex_unlock(&vreg->lock);
@@ -361,13 +386,16 @@ static int rpm_reg_switch_disable(struct regulator_dev *rdev)
 	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
 	const struct rpm_reg_parts *parts = vreg->parts;
 	const struct request_member *req = &parts->enable_state;
+	int state;
 	int ret;
 
 	if (req->mask == 0)
 		return -EINVAL;
 
+	state = vreg->rpm_assist ? RPM_SLEEP_STATE : RPM_ACTIVE_STATE;
+
 	mutex_lock(&vreg->lock);
-	ret = rpm_reg_write(vreg, req, 0);
+	ret = rpm_reg_write(vreg, state, req, 0);
 	if (!ret)
 		vreg->is_enabled = 0;
 	mutex_unlock(&vreg->lock);
@@ -590,8 +618,11 @@ static int rpm_reg_set(struct qcom_rpm_reg *vreg,
 	if (req->mask == 0 || (value << req->shift) & ~req->mask)
 		return -EINVAL;
 
-	vreg->val[req->word] &= ~req->mask;
-	vreg->val[req->word] |= value << req->shift;
+	vreg->val[RPM_ACTIVE_STATE][req->word] &= ~req->mask;
+	vreg->val[RPM_ACTIVE_STATE][req->word] |= value << req->shift;
+
+	vreg->val[RPM_SLEEP_STATE][req->word] &= ~req->mask;
+	vreg->val[RPM_SLEEP_STATE][req->word] |= value << req->shift;
 
 	return 0;
 }
@@ -690,6 +721,9 @@ static int rpm_reg_probe(struct platform_device *pdev)
 		}
 	}
 
+	key = "qcom,rpm-assisted-disable";
+	vreg->rpm_assist = of_property_read_bool(pdev->dev.of_node, key);
+
 	if (vreg->parts->freq.mask) {
 		ret = rpm_reg_of_parse_freq(&pdev->dev, vreg);
 		if (ret < 0)
-- 
1.7.9.5
