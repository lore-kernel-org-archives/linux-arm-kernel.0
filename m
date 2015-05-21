From: stefan@agner.ch (Stefan Agner)
Date: Thu, 21 May 2015 09:15:04 +0200
Subject: [PATCH v3 2/2] mmc: sdhci-pxav3: use runtime_pm enabled pltfm
 suspend/resume
In-Reply-To: <1432192504-3601-1-git-send-email-stefan@agner.ch>
References: <1432192504-3601-1-git-send-email-stefan@agner.ch>
Message-ID: <1432192504-3601-2-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the runtime_pm enabled platform suspend/resume functions.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/mmc/host/sdhci-pxav3.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index b5103a2..5ac4030 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -501,34 +501,6 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int sdhci_pxav3_suspend(struct device *dev)
-{
-	int ret;
-	struct sdhci_host *host = dev_get_drvdata(dev);
-
-	pm_runtime_get_sync(dev);
-	ret = sdhci_suspend_host(host);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
-
-	return ret;
-}
-
-static int sdhci_pxav3_resume(struct device *dev)
-{
-	int ret;
-	struct sdhci_host *host = dev_get_drvdata(dev);
-
-	pm_runtime_get_sync(dev);
-	ret = sdhci_resume_host(host);
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
-
-	return ret;
-}
-#endif
-
 #ifdef CONFIG_PM
 static int sdhci_pxav3_runtime_suspend(struct device *dev)
 {
@@ -564,7 +536,7 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
 
 #ifdef CONFIG_PM
 static const struct dev_pm_ops sdhci_pxav3_pmops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sdhci_pxav3_suspend, sdhci_pxav3_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_pltfm_rpm_suspend, sdhci_pltfm_rpm_resume)
 	SET_RUNTIME_PM_OPS(sdhci_pxav3_runtime_suspend,
 		sdhci_pxav3_runtime_resume, NULL)
 };
-- 
2.4.1
