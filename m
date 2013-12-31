From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 31 Dec 2013 09:27:52 +0800
Subject: [PATCH v2] regulator: act8865: register all regulators regardless of
 how many are used
Message-ID: <1388453272-5287-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v2 changlog:
 1./ Rebased on the latest code of for-next branch.

As Mark pointed out, the driver should register all regulators
regardless of how many are used in the system in order to aid diagnostics.

But in the previous patch, only register the regulators that are used.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 drivers/regulator/act8865-regulator.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index f816ad8..5e3e1d2 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -225,8 +225,8 @@ static int act8865_pdata_from_dt(struct device *dev,
 		return matched;
 
 	pdata->regulators = devm_kzalloc(dev,
-				sizeof(struct act8865_regulator_data) * matched,
-				GFP_KERNEL);
+				sizeof(struct act8865_regulator_data) *
+				ARRAY_SIZE(act8865_matches), GFP_KERNEL);
 	if (!pdata->regulators) {
 		dev_err(dev, "%s: failed to allocate act8865 registor\n",
 						__func__);
@@ -236,10 +236,7 @@ static int act8865_pdata_from_dt(struct device *dev,
 	pdata->num_regulators = matched;
 	regulator = pdata->regulators;
 
-	for (i = 0; i < matched; i++) {
-		if (!act8865_matches[i].init_data)
-			continue;
-
+	for (i = 0; i < ARRAY_SIZE(act8865_matches); i++) {
 		regulator->id = i;
 		regulator->name = act8865_matches[i].name;
 		regulator->platform_data = act8865_matches[i].init_data;
@@ -306,7 +303,7 @@ static int act8865_pmic_probe(struct i2c_client *client,
 	}
 
 	/* Finally register devices */
-	for (i = 0; i < pdata->num_regulators; i++) {
+	for (i = 0; i < ARRAY_SIZE(act8865_matches); i++) {
 
 		id = pdata->regulators[i].id;
 
-- 
1.7.9.5
