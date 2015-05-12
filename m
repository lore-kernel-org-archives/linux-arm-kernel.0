From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 12 May 2015 14:42:07 -0700
Subject: [PATCH] regulator: of: Skip disabled regulator nodes
Message-ID: <1431466927-1329-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a regulator is listed in devicetree, but the node is marked as
"disabled" we should skip parsing the regulator init data and
deny consumers from interacting with the regulator. This
simplifies devicetree maintenance where we can have one dtsi file
with all regulators supported by a PMIC and then select what
regulators are used depending on the board configuration.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/regulator/of_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index e952439e0d83..bead57e3c67b 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -292,7 +292,7 @@ struct regulator_init_data *regulator_of_get_init_data(struct device *dev,
 		return NULL;
 	}
 
-	for_each_child_of_node(search, child) {
+	for_each_available_child_of_node(search, child) {
 		name = of_get_property(child, "regulator-compatible", NULL);
 		if (!name)
 			name = child->name;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
