From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 30 Oct 2014 12:20:43 +0100
Subject: [PATCH v3 04/14] regulator: max77686: Consistently index opmode array
 by rdev id
In-Reply-To: <1414668053-31370-1-git-send-email-k.kozlowski@samsung.com>
References: <1414668053-31370-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1414668053-31370-5-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mixed indexes were used for array of opmodes in max77686_data structure:
id of regulator and index of regulator_desc array.

These indexes are exactly the same but the mixture may confuse. Use
consistently the id of regulator.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/regulator/max77686.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/max77686.c b/drivers/regulator/max77686.c
index 09b0d8c20a9d..27c5f4556044 100644
--- a/drivers/regulator/max77686.c
+++ b/drivers/regulator/max77686.c
@@ -82,6 +82,7 @@ enum max77686_ramp_rate {
 };
 
 struct max77686_data {
+	/* Array indexed by regulator id */
 	unsigned int opmode[MAX77686_REGULATORS];
 };
 
@@ -513,12 +514,13 @@ static int max77686_pmic_probe(struct platform_device *pdev)
 
 	for (i = 0; i < MAX77686_REGULATORS; i++) {
 		struct regulator_dev *rdev;
+		int id = regulators[i].id;
 
 		config.init_data = pdata->regulators[i].initdata;
 		config.of_node = pdata->regulators[i].of_node;
 
-		max77686->opmode[i] = regulators[i].enable_mask >>
-						max77686_get_opmode_shift(i);
+		max77686->opmode[id] = regulators[i].enable_mask >>
+						max77686_get_opmode_shift(id);
 		rdev = devm_regulator_register(&pdev->dev,
 						&regulators[i], &config);
 		if (IS_ERR(rdev)) {
-- 
1.9.1
