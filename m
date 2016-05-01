From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  1 May 2016 19:37:02 +0900
Subject: [PATCH 6/7] reset: socfpga: use devm_reset_controller_register()
In-Reply-To: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
References: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462099023-11819-7-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_reset_controller_register() for the reset controller
registration and drop the .remove callback.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/reset/reset-socfpga.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/reset/reset-socfpga.c b/drivers/reset/reset-socfpga.c
index cd05a70..12add9b 100644
--- a/drivers/reset/reset-socfpga.c
+++ b/drivers/reset/reset-socfpga.c
@@ -134,16 +134,7 @@ static int socfpga_reset_probe(struct platform_device *pdev)
 	data->rcdev.ops = &socfpga_reset_ops;
 	data->rcdev.of_node = pdev->dev.of_node;
 
-	return reset_controller_register(&data->rcdev);
-}
-
-static int socfpga_reset_remove(struct platform_device *pdev)
-{
-	struct socfpga_reset_data *data = platform_get_drvdata(pdev);
-
-	reset_controller_unregister(&data->rcdev);
-
-	return 0;
+	return devm_reset_controller_register(dev, &data->rcdev);
 }
 
 static const struct of_device_id socfpga_reset_dt_ids[] = {
@@ -153,7 +144,6 @@ static const struct of_device_id socfpga_reset_dt_ids[] = {
 
 static struct platform_driver socfpga_reset_driver = {
 	.probe	= socfpga_reset_probe,
-	.remove	= socfpga_reset_remove,
 	.driver = {
 		.name		= "socfpga-reset",
 		.of_match_table	= socfpga_reset_dt_ids,
-- 
1.9.1
