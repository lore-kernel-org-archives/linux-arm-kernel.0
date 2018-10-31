From: matti.vaittinen@fi.rohmeurope.com (Matti Vaittinen)
Date: Wed, 31 Oct 2018 10:31:19 +0200
Subject: [PATCH 2/8] clk: clk-max77686: Clean clkdev lookup leak and use devm
In-Reply-To: <cover.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
Message-ID: <db05ac6d6721872b891aa72f9e2e82b664dca8a9.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk-max77686 never clean clkdev lookup at remove. This can cause
oops if clk-max77686 is removed and inserted again. Fix leak by
using new devm clkdev lookup registration. Simplify also error
path by using new devm_of_clk_add_parent_hw_provider.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/clk-max77686.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
index 02551fe4b87c..b1920c1d9b76 100644
--- a/drivers/clk/clk-max77686.c
+++ b/drivers/clk/clk-max77686.c
@@ -235,7 +235,7 @@ static int max77686_clk_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		ret = clk_hw_register_clkdev(&max_clk_data->hw,
+		ret = devm_clk_hw_register_clkdev(dev, &max_clk_data->hw,
 					     max_clk_data->clk_idata.name, NULL);
 		if (ret < 0) {
 			dev_err(dev, "Failed to clkdev register: %d\n", ret);
@@ -244,8 +244,8 @@ static int max77686_clk_probe(struct platform_device *pdev)
 	}
 
 	if (parent->of_node) {
-		ret = of_clk_add_hw_provider(parent->of_node, of_clk_max77686_get,
-					     drv_data);
+		ret = devm_of_clk_add_parent_hw_provider(dev,
+						of_clk_max77686_get, drv_data);
 
 		if (ret < 0) {
 			dev_err(dev, "Failed to register OF clock provider: %d\n",
@@ -261,27 +261,11 @@ static int max77686_clk_probe(struct platform_device *pdev)
 					 1 << MAX77802_CLOCK_LOW_JITTER_SHIFT);
 		if (ret < 0) {
 			dev_err(dev, "Failed to config low-jitter: %d\n", ret);
-			goto remove_of_clk_provider;
+			return ret;
 		}
 	}
 
 	return 0;
-
-remove_of_clk_provider:
-	if (parent->of_node)
-		of_clk_del_provider(parent->of_node);
-
-	return ret;
-}
-
-static int max77686_clk_remove(struct platform_device *pdev)
-{
-	struct device *parent = pdev->dev.parent;
-
-	if (parent->of_node)
-		of_clk_del_provider(parent->of_node);
-
-	return 0;
 }
 
 static const struct platform_device_id max77686_clk_id[] = {
@@ -297,7 +281,6 @@ static struct platform_driver max77686_clk_driver = {
 		.name  = "max77686-clk",
 	},
 	.probe = max77686_clk_probe,
-	.remove = max77686_clk_remove,
 	.id_table = max77686_clk_id,
 };
 
-- 
2.14.3
