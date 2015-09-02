From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed,  2 Sep 2015 15:46:51 -0700
Subject: [PATCH v2 8/8] regulator: qcom_smd: Handle big endian CPUs
In-Reply-To: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
References: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1441234011-4259-9-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The smd rpm structures are always in little endian, but this
driver is not capable of being used on big endian CPUs. Annotate
the little endian data members and update the code to do the
proper byte swapping.

Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Andy Gross <agross@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes from v1:
 * New patch

 drivers/regulator/qcom_smd-regulator.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
index 9c6167dd2c8b..b72c693e29ff 100644
--- a/drivers/regulator/qcom_smd-regulator.c
+++ b/drivers/regulator/qcom_smd-regulator.c
@@ -36,9 +36,9 @@ struct qcom_rpm_reg {
 };
 
 struct rpm_regulator_req {
-	u32 key;
-	u32 nbytes;
-	u32 value;
+	__le32 key;
+	__le32 nbytes;
+	__le32 value;
 };
 
 #define RPM_KEY_SWEN	0x6e657773 /* "swen" */
@@ -62,9 +62,9 @@ static int rpm_reg_enable(struct regulator_dev *rdev)
 	struct rpm_regulator_req req;
 	int ret;
 
-	req.key = RPM_KEY_SWEN;
-	req.nbytes = sizeof(u32);
-	req.value = 1;
+	req.key = cpu_to_le32(RPM_KEY_SWEN);
+	req.nbytes = cpu_to_le32(sizeof(u32));
+	req.value = cpu_to_le32(1);
 
 	ret = rpm_reg_write_active(vreg, &req, sizeof(req));
 	if (!ret)
@@ -86,8 +86,8 @@ static int rpm_reg_disable(struct regulator_dev *rdev)
 	struct rpm_regulator_req req;
 	int ret;
 
-	req.key = RPM_KEY_SWEN;
-	req.nbytes = sizeof(u32);
+	req.key = cpu_to_le32(RPM_KEY_SWEN);
+	req.nbytes = cpu_to_le32(sizeof(u32));
 	req.value = 0;
 
 	ret = rpm_reg_write_active(vreg, &req, sizeof(req));
@@ -113,9 +113,9 @@ static int rpm_reg_set_voltage(struct regulator_dev *rdev,
 	struct rpm_regulator_req req;
 	int ret = 0;
 
-	req.key = RPM_KEY_UV;
-	req.nbytes = sizeof(u32);
-	req.value = min_uV;
+	req.key = cpu_to_le32(RPM_KEY_UV);
+	req.nbytes = cpu_to_le32(sizeof(u32));
+	req.value = cpu_to_le32(min_uV);
 
 	ret = rpm_reg_write_active(vreg, &req, sizeof(req));
 	if (!ret)
@@ -129,9 +129,9 @@ static int rpm_reg_set_load(struct regulator_dev *rdev, int load_uA)
 	struct qcom_rpm_reg *vreg = rdev_get_drvdata(rdev);
 	struct rpm_regulator_req req;
 
-	req.key = RPM_KEY_MA;
-	req.nbytes = sizeof(u32);
-	req.value = load_uA;
+	req.key = cpu_to_le32(RPM_KEY_MA);
+	req.nbytes = cpu_to_le32(sizeof(u32));
+	req.value = cpu_to_le32(load_uA);
 
 	return rpm_reg_write_active(vreg, &req, sizeof(req));
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
