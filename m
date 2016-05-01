From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  1 May 2016 19:37:00 +0900
Subject: [PATCH 4/7] reset: pistachio: use devm_reset_controller_register()
In-Reply-To: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
References: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462099023-11819-5-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_reset_controller_register() for the reset controller
registration and drop the .remove callback.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/reset/reset-pistachio.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/reset/reset-pistachio.c b/drivers/reset/reset-pistachio.c
index 72a97a1..bbc4c06 100644
--- a/drivers/reset/reset-pistachio.c
+++ b/drivers/reset/reset-pistachio.c
@@ -121,16 +121,7 @@ static int pistachio_reset_probe(struct platform_device *pdev)
 	rd->rcdev.ops = &pistachio_reset_ops;
 	rd->rcdev.of_node = np;
 
-	return reset_controller_register(&rd->rcdev);
-}
-
-static int pistachio_reset_remove(struct platform_device *pdev)
-{
-	struct pistachio_reset_data *data = platform_get_drvdata(pdev);
-
-	reset_controller_unregister(&data->rcdev);
-
-	return 0;
+	return devm_reset_controller_register(dev, &rd->rcdev);
 }
 
 static const struct of_device_id pistachio_reset_dt_ids[] = {
@@ -141,7 +132,6 @@ MODULE_DEVICE_TABLE(of, pistachio_reset_dt_ids);
 
 static struct platform_driver pistachio_reset_driver = {
 	.probe	= pistachio_reset_probe,
-	.remove	= pistachio_reset_remove,
 	.driver = {
 		.name		= "pistachio-reset",
 		.of_match_table	= pistachio_reset_dt_ids,
-- 
1.9.1
