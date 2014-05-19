From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 19 May 2014 10:25:30 +0200
Subject: [PATCH] regulator: AXP20x: fix wrong call to of_find_node_by_name
Message-ID: <1400487930-22949-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The of_find_node_by_name function will search for a DT node named
"regulators" after the provided np node, but will not ensure that this node
is a child of np.
This might result in retrieving a "regulators" node that is not related to
the axp20x PMIC.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/regulator/axp20x-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 78a29e6..61ae4d4 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -188,7 +188,7 @@ static int axp20x_regulator_parse_dt(struct platform_device *pdev)
 	if (!np)
 		return 0;
 
-	regulators = of_find_node_by_name(np, "regulators");
+	regulators = of_get_child_by_name(np, "regulators");
 	if (!regulators) {
 		dev_warn(&pdev->dev, "regulators node not found\n");
 	} else {
-- 
1.8.3.2
