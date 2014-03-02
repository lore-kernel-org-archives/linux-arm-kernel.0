From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  2 Mar 2014 11:44:35 +0400
Subject: [PATCH 4/4] regulator: mc13xxx: Fix probing with DT
In-Reply-To: <1393746275-9253-1-git-send-email-shc_work@mail.ru>
References: <1393746275-9253-1-git-send-email-shc_work@mail.ru>
Message-ID: <1393746275-9253-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The nodes of regulators should be retrieved from parent device.
Bug was be introduced by commit (regulator: mc13xxx: Fix NULL
pointer error in non-DT mode) in conjuction with (mfd: Revert
"mfd: Always assign of_node in mfd_add_device()").

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/regulator/mc13xxx-regulator-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/mc13xxx-regulator-core.c b/drivers/regulator/mc13xxx-regulator-core.c
index bf75fca..05b9717 100644
--- a/drivers/regulator/mc13xxx-regulator-core.c
+++ b/drivers/regulator/mc13xxx-regulator-core.c
@@ -167,10 +167,10 @@ int mc13xxx_get_num_regulators_dt(struct platform_device *pdev)
 	struct device_node *parent;
 	int num;
 
-	if (!pdev->dev.of_node)
+	if (!pdev->dev.parent->of_node)
 		return -ENODEV;
 
-	parent = of_get_child_by_name(pdev->dev.of_node, "regulators");
+	parent = of_get_child_by_name(pdev->dev.parent->of_node, "regulators");
 	if (!parent)
 		return -ENODEV;
 
@@ -189,10 +189,10 @@ struct mc13xxx_regulator_init_data *mc13xxx_parse_regulators_dt(
 	struct device_node *parent, *child;
 	int i, parsed = 0;
 
-	if (!pdev->dev.of_node)
+	if (!pdev->dev.parent->of_node)
 		return NULL;
 
-	parent = of_get_child_by_name(pdev->dev.of_node, "regulators");
+	parent = of_get_child_by_name(pdev->dev.parent->of_node, "regulators");
 	if (!parent)
 		return NULL;
 
-- 
1.8.3.2
