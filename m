From: axel.lin@ingics.com (Axel Lin)
Date: Tue, 18 Dec 2012 15:43:45 +0800
Subject: [PATCH] clk: max77686: Fix return value checking for devm_kzalloc
Message-ID: <1355816625.32595.0.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

devm_kzalloc returns NULL on failure.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/clk/clk-max77686.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
index d098f72..8944214 100644
--- a/drivers/clk/clk-max77686.c
+++ b/drivers/clk/clk-max77686.c
@@ -132,7 +132,7 @@ static int max77686_clk_register(struct device *dev,
 
 	max77686->lookup = devm_kzalloc(dev, sizeof(struct clk_lookup),
 					GFP_KERNEL);
-	if (IS_ERR(max77686->lookup))
+	if (!max77686->lookup)
 		return -ENOMEM;
 
 	max77686->lookup->con_id = hw->init->name;
@@ -151,13 +151,13 @@ static int max77686_clk_probe(struct platform_device *pdev)
 
 	max77686_clks = devm_kzalloc(&pdev->dev, sizeof(struct max77686_clk *)
 					* MAX77686_CLKS_NUM, GFP_KERNEL);
-	if (IS_ERR(max77686_clks))
+	if (!max77686_clks)
 		return -ENOMEM;
 
 	for (i = 0; i < MAX77686_CLKS_NUM; i++) {
 		max77686_clks[i] = devm_kzalloc(&pdev->dev,
 					sizeof(struct max77686_clk), GFP_KERNEL);
-		if (IS_ERR(max77686_clks[i]))
+		if (!max77686_clks[i])
 			return -ENOMEM;
 	}
 
-- 
1.7.9.5
