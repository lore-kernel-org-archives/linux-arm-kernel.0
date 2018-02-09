From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Fri,  9 Feb 2018 11:05:19 +0100
Subject: [PATCH 1/3] regulator: da9062: add of_map_mode support for bucks
In-Reply-To: <1518170721-28198-1-git-send-email-chf.fritz@googlemail.com>
References: <1518170721-28198-1-git-send-email-chf.fritz@googlemail.com>
Message-ID: <1518170721-28198-2-git-send-email-chf.fritz@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds of_map_mode support for bucks to set regulator modes
from within regulator framework.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
Signed-off-by: Christian Hemp <c.hemp@phytec.de>
---
 drivers/regulator/da9062-regulator.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 34a70d9..321abd0 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -119,6 +119,22 @@ static const int da9062_buck_b_limits[] = {
 	2300000, 2400000, 2500000, 2600000, 2700000, 2800000, 2900000, 3000000
 };
 
+static inline unsigned int da9062_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case BUCK_MODE_MANUAL:
+		return REGULATOR_MODE_FAST | REGULATOR_MODE_STANDBY;
+	case BUCK_MODE_SLEEP:
+		return REGULATOR_MODE_STANDBY;
+	case BUCK_MODE_SYNC:
+		return REGULATOR_MODE_FAST;
+	case BUCK_MODE_AUTO:
+		return REGULATOR_MODE_NORMAL;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int da9062_set_current_limit(struct regulator_dev *rdev,
 				    int min_ua, int max_ua)
 {
@@ -686,6 +702,7 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.vsel_reg = DA9062AA_VBUCK1_A,
 		.desc.vsel_mask = DA9062AA_VBUCK1_A_MASK,
 		.desc.linear_min_sel = 0,
+		.desc.of_map_mode = da9062_map_mode,
 		.sleep = REG_FIELD(DA9062AA_VBUCK1_A,
 			__builtin_ffs((int)DA9062AA_BUCK1_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -724,6 +741,7 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.vsel_reg = DA9062AA_VBUCK2_A,
 		.desc.vsel_mask = DA9062AA_VBUCK2_A_MASK,
 		.desc.linear_min_sel = 0,
+		.desc.of_map_mode = da9062_map_mode,
 		.sleep = REG_FIELD(DA9062AA_VBUCK2_A,
 			__builtin_ffs((int)DA9062AA_BUCK2_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -762,6 +780,7 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.vsel_reg = DA9062AA_VBUCK3_A,
 		.desc.vsel_mask = DA9062AA_VBUCK3_A_MASK,
 		.desc.linear_min_sel = 0,
+		.desc.of_map_mode = da9062_map_mode,
 		.sleep = REG_FIELD(DA9062AA_VBUCK3_A,
 			__builtin_ffs((int)DA9062AA_BUCK3_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
@@ -800,6 +819,7 @@ static const struct da9062_regulator_info local_da9062_regulator_info[] = {
 		.desc.vsel_reg = DA9062AA_VBUCK4_A,
 		.desc.vsel_mask = DA9062AA_VBUCK4_A_MASK,
 		.desc.linear_min_sel = 0,
+		.desc.of_map_mode = da9062_map_mode,
 		.sleep = REG_FIELD(DA9062AA_VBUCK4_A,
 			__builtin_ffs((int)DA9062AA_BUCK4_SL_A_MASK) - 1,
 			sizeof(unsigned int) * 8 -
-- 
2.1.4
