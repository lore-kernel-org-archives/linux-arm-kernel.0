From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Thu, 26 Sep 2013 16:54:43 +0200
Subject: [PATCH 18/27] mmc: s3cmci: Remove redundant suspend and resume
 callbacks
In-Reply-To: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
References: <1380207292-16968-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1380207292-16968-19-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suspend and resume of cards are handled by the protocol layer and
consequently the mmc_suspend|resume_host APIs are marked as deprecated.

While moving away from using the deprecated APIs, there are nothing
left to be done for the suspend and resume callbacks, so remove them.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/s3cmci.c |   29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 8d6794c..2fce5ea 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1949,39 +1949,10 @@ static struct platform_device_id s3cmci_driver_ids[] = {
 
 MODULE_DEVICE_TABLE(platform, s3cmci_driver_ids);
 
-
-#ifdef CONFIG_PM
-
-static int s3cmci_suspend(struct device *dev)
-{
-	struct mmc_host *mmc = platform_get_drvdata(to_platform_device(dev));
-
-	return mmc_suspend_host(mmc);
-}
-
-static int s3cmci_resume(struct device *dev)
-{
-	struct mmc_host *mmc = platform_get_drvdata(to_platform_device(dev));
-
-	return mmc_resume_host(mmc);
-}
-
-static const struct dev_pm_ops s3cmci_pm = {
-	.suspend	= s3cmci_suspend,
-	.resume		= s3cmci_resume,
-};
-
-#define s3cmci_pm_ops &s3cmci_pm
-#else /* CONFIG_PM */
-#define s3cmci_pm_ops NULL
-#endif /* CONFIG_PM */
-
-
 static struct platform_driver s3cmci_driver = {
 	.driver	= {
 		.name	= "s3c-sdi",
 		.owner	= THIS_MODULE,
-		.pm	= s3cmci_pm_ops,
 	},
 	.id_table	= s3cmci_driver_ids,
 	.probe		= s3cmci_probe,
-- 
1.7.9.5
