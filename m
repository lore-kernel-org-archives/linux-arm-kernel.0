From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  1 May 2016 19:37:03 +0900
Subject: [PATCH 7/7] reset: zynq: use devm_reset_controller_register()
In-Reply-To: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
References: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1462099023-11819-8-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_reset_controller_register() for the reset controller
registration and drop the .remove callback.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/reset/reset-zynq.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/reset/reset-zynq.c b/drivers/reset/reset-zynq.c
index a7e87bc..138f2f2 100644
--- a/drivers/reset/reset-zynq.c
+++ b/drivers/reset/reset-zynq.c
@@ -122,16 +122,7 @@ static int zynq_reset_probe(struct platform_device *pdev)
 	priv->rcdev.ops = &zynq_reset_ops;
 	priv->rcdev.of_node = pdev->dev.of_node;
 
-	return reset_controller_register(&priv->rcdev);
-}
-
-static int zynq_reset_remove(struct platform_device *pdev)
-{
-	struct zynq_reset_data *priv = platform_get_drvdata(pdev);
-
-	reset_controller_unregister(&priv->rcdev);
-
-	return 0;
+	return devm_reset_controller_register(&pdev->dev, &priv->rcdev);
 }
 
 static const struct of_device_id zynq_reset_dt_ids[] = {
@@ -141,7 +132,6 @@ static const struct of_device_id zynq_reset_dt_ids[] = {
 
 static struct platform_driver zynq_reset_driver = {
 	.probe	= zynq_reset_probe,
-	.remove	= zynq_reset_remove,
 	.driver = {
 		.name		= KBUILD_MODNAME,
 		.of_match_table	= zynq_reset_dt_ids,
-- 
1.9.1
