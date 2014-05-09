From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 09 May 2014 16:43:10 +0900
Subject: [PATCHv2 4/5] devfreq: exynos4: Use devm_devfreq_* function using
 device resource management
In-Reply-To: <1399621391-27228-1-git-send-email-cw00.choi@samsung.com>
References: <1399621391-27228-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1399621391-27228-5-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch uses devm_devfreq_add_device()/devm_devfreq_register_opp_notifier()
to control automatically the resource of devfreq.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
---
 drivers/devfreq/exynos/exynos4_bus.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/devfreq/exynos/exynos4_bus.c b/drivers/devfreq/exynos/exynos4_bus.c
index d257f1f..bebb0a4 100644
--- a/drivers/devfreq/exynos/exynos4_bus.c
+++ b/drivers/devfreq/exynos/exynos4_bus.c
@@ -979,7 +979,7 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, data);
 
-	data->devfreq = devfreq_add_device(dev, &exynos4_devfreq_profile,
+	data->devfreq = devm_devfreq_add_device(dev, &exynos4_devfreq_profile,
 					   "simple_ondemand", NULL);
 	if (IS_ERR(data->devfreq))
 		return PTR_ERR(data->devfreq);
@@ -991,27 +991,20 @@ static int exynos4_busfreq_probe(struct platform_device *pdev)
 	busfreq_mon_reset(ppmu_data);
 
 	/* Register opp_notifier for Exynos4 busfreq */
-	err = devfreq_register_opp_notifier(dev, data->devfreq);
+	err = devm_devfreq_register_opp_notifier(dev, data->devfreq);
 	if (err < 0) {
 		dev_err(dev, "Failed to register opp notifier\n");
-		goto err_notifier_opp;
+		return err;
 	}
 
 	/* Register pm_notifier for Exynos4 busfreq */
 	err = register_pm_notifier(&data->pm_notifier);
 	if (err) {
 		dev_err(dev, "Failed to setup pm notifier\n");
-		goto err_notifier_pm;
+		return err;
 	}
 
 	return 0;
-
-err_notifier_pm:
-	devfreq_unregister_opp_notifier(dev, data->devfreq);
-err_notifier_opp:
-	devfreq_remove_device(data->devfreq);
-
-	return err;
 }
 
 static int exynos4_busfreq_remove(struct platform_device *pdev)
@@ -1020,10 +1013,6 @@ static int exynos4_busfreq_remove(struct platform_device *pdev)
 
 	/* Unregister all of notifier chain */
 	unregister_pm_notifier(&data->pm_notifier);
-	devfreq_unregister_opp_notifier(data->dev, data->devfreq);
-
-	/* Remove devfreq instance */
-	devfreq_remove_device(data->devfreq);
 
 	return 0;
 }
-- 
1.8.0
