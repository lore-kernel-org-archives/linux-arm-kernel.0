From: edubezval@gmail.com (Eduardo Valentin)
Date: Wed,  9 Mar 2016 13:35:29 -0800
Subject: [PATCH 07/13] thermal: convert mtk_thermal to use
 devm_thermal_zone_of_sensor_register
In-Reply-To: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
References: <1457559336-17652-1-git-send-email-edubezval@gmail.com>
Message-ID: <1457559336-17652-8-git-send-email-edubezval@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changes the driver to use the devm_ version
of thermal_zone_of_sensor_register and cleans
up the  local points and unregister calls.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-pm at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-mediatek at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/mtk_thermal.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 3d93b1c..2c40b0f 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -145,7 +145,6 @@ struct mtk_thermal {
 	s32 o_slope;
 	s32 vts[MT8173_NUM_SENSORS];
 
-	struct thermal_zone_device *tzd;
 };
 
 struct mtk_thermal_bank_cfg {
@@ -573,16 +572,11 @@ static int mtk_thermal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mt);
 
-	mt->tzd = thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
-				&mtk_thermal_ops);
-	if (IS_ERR(mt->tzd))
-		goto err_register;
+	devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
+					     &mtk_thermal_ops);
 
 	return 0;
 
-err_register:
-	clk_disable_unprepare(mt->clk_peri_therm);
-
 err_disable_clk_auxadc:
 	clk_disable_unprepare(mt->clk_auxadc);
 
@@ -593,8 +587,6 @@ static int mtk_thermal_remove(struct platform_device *pdev)
 {
 	struct mtk_thermal *mt = platform_get_drvdata(pdev);
 
-	thermal_zone_of_sensor_unregister(&pdev->dev, mt->tzd);
-
 	clk_disable_unprepare(mt->clk_peri_therm);
 	clk_disable_unprepare(mt->clk_auxadc);
 
-- 
2.1.4
