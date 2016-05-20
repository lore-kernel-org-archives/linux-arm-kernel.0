From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 20 May 2016 14:21:37 +0200
Subject: [PATCH] reset: oxnas: Use devm register API and get rid of platform
 remove
Message-ID: <1463746897-24813-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the brand new devm_reset_controller_register() API to get rid of
the platform driver remove callback.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/reset/reset-oxnas.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

Hi Philip,

This patch is based on your reset/next tree after the new
devm_reset_controller_register() was merged.

I hope it could be merged for 4.7.

Thanks,
Neil

diff --git a/drivers/reset/reset-oxnas.c b/drivers/reset/reset-oxnas.c
index c60fb2d..9449805 100644
--- a/drivers/reset/reset-oxnas.c
+++ b/drivers/reset/reset-oxnas.c
@@ -112,21 +112,11 @@ static int oxnas_reset_probe(struct platform_device *pdev)
 	data->rcdev.ops = &oxnas_reset_ops;
 	data->rcdev.of_node = pdev->dev.of_node;
 
-	return reset_controller_register(&data->rcdev);
-}
-
-static int oxnas_reset_remove(struct platform_device *pdev)
-{
-	struct oxnas_reset *data = platform_get_drvdata(pdev);
-
-	reset_controller_unregister(&data->rcdev);
-
-	return 0;
+	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
 }
 
 static struct platform_driver oxnas_reset_driver = {
 	.probe	= oxnas_reset_probe,
-	.remove	= oxnas_reset_remove,
 	.driver = {
 		.name		= "oxnas-reset",
 		.of_match_table	= oxnas_reset_dt_ids,
-- 
1.9.1
