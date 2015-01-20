From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 20 Jan 2015 17:24:02 +0000
Subject: [PATCH] power/reset: vexpress: Remove non-DT code
Message-ID: <1421774642-29843-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, as all VE platforms have to be booted with DT,
the code handling non-DT case can be removed.

Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/power/reset/vexpress-poweroff.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
index 9dfc9ce..be12d9b 100644
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -111,23 +111,20 @@ static int _vexpress_register_restart_handler(struct device *dev)
 
 static int vexpress_reset_probe(struct platform_device *pdev)
 {
-	enum vexpress_reset_func func;
 	const struct of_device_id *match =
 			of_match_device(vexpress_reset_of_match, &pdev->dev);
 	struct regmap *regmap;
 	int ret = 0;
 
-	if (match)
-		func = (enum vexpress_reset_func)match->data;
-	else
-		func = pdev->id_entry->driver_data;
+	if (!match)
+		return -EINVAL;
 
 	regmap = devm_regmap_init_vexpress_config(&pdev->dev);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 	dev_set_drvdata(&pdev->dev, regmap);
 
-	switch (func) {
+	switch ((enum vexpress_reset_func)match->data) {
 	case FUNC_SHUTDOWN:
 		vexpress_power_off_device = &pdev->dev;
 		pm_power_off = vexpress_power_off;
@@ -144,20 +141,12 @@ static int vexpress_reset_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static const struct platform_device_id vexpress_reset_id_table[] = {
-	{ .name = "vexpress-reset", .driver_data = FUNC_RESET, },
-	{ .name = "vexpress-shutdown", .driver_data = FUNC_SHUTDOWN, },
-	{ .name = "vexpress-reboot", .driver_data = FUNC_REBOOT, },
-	{}
-};
-
 static struct platform_driver vexpress_reset_driver = {
 	.probe = vexpress_reset_probe,
 	.driver = {
 		.name = "vexpress-reset",
 		.of_match_table = vexpress_reset_of_match,
 	},
-	.id_table = vexpress_reset_id_table,
 };
 
 static int __init vexpress_reset_init(void)
-- 
2.1.0
