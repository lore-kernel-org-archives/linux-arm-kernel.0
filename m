From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  1 May 2016 19:37:01 +0900
Subject: [PATCH 5/7] reset: sunxi: use devm_reset_controller_register()
In-Reply-To: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
References: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462099023-11819-6-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_reset_controller_register() for the reset controller
registration and drop the .remove callback.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/reset/reset-sunxi.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
index 677f865..3080190 100644
--- a/drivers/reset/reset-sunxi.c
+++ b/drivers/reset/reset-sunxi.c
@@ -165,21 +165,11 @@ static int sunxi_reset_probe(struct platform_device *pdev)
 	data->rcdev.ops = &sunxi_reset_ops;
 	data->rcdev.of_node = pdev->dev.of_node;
 
-	return reset_controller_register(&data->rcdev);
-}
-
-static int sunxi_reset_remove(struct platform_device *pdev)
-{
-	struct sunxi_reset_data *data = platform_get_drvdata(pdev);
-
-	reset_controller_unregister(&data->rcdev);
-
-	return 0;
+	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
 }
 
 static struct platform_driver sunxi_reset_driver = {
 	.probe	= sunxi_reset_probe,
-	.remove	= sunxi_reset_remove,
 	.driver = {
 		.name		= "sunxi-reset",
 		.of_match_table	= sunxi_reset_dt_ids,
-- 
1.9.1
