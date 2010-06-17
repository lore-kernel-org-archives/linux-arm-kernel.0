From: eric@eukrea.com (=?utf-8?q?Eric=20B=C3=A9nard?=)
Date: Thu, 17 Jun 2010 20:59:07 +0200
Subject: [PATCH] mxcmmc: convert to pm_ops and enable/disable clock
In-Reply-To: <1276801147-4103-6-git-send-email-eric@eukrea.com>
References: <1276801147-4103-1-git-send-email-eric@eukrea.com>
	<1276801147-4103-2-git-send-email-eric@eukrea.com>
	<1276801147-4103-3-git-send-email-eric@eukrea.com>
	<1276801147-4103-4-git-send-email-eric@eukrea.com>
	<1276801147-4103-5-git-send-email-eric@eukrea.com>
	<1276801147-4103-6-git-send-email-eric@eukrea.com>
Message-ID: <1276801147-4103-7-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
Cc: s.hauer at pengutronix.de
Cc: linux-mmc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/mmc/host/mxcmmc.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index fdf33e8..350f78e 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -936,43 +936,47 @@ static int mxcmci_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-static int mxcmci_suspend(struct platform_device *dev, pm_message_t state)
+static int mxcmci_suspend(struct device *dev)
 {
-	struct mmc_host *mmc = platform_get_drvdata(dev);
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct mxcmci_host *host = mmc_priv(mmc);
 	int ret = 0;
 
 	if (mmc)
 		ret = mmc_suspend_host(mmc);
+	clk_disable(host->clk);
 
 	return ret;
 }
 
-static int mxcmci_resume(struct platform_device *dev)
+static int mxcmci_resume(struct device *dev)
 {
-	struct mmc_host *mmc = platform_get_drvdata(dev);
-	struct mxcmci_host *host;
+	struct mmc_host *mmc = dev_get_drvdata(dev);
+	struct mxcmci_host *host = mmc_priv(mmc);
 	int ret = 0;
 
-	if (mmc) {
-		host = mmc_priv(mmc);
+	clk_enable(host->clk);
+	if (mmc)
 		ret = mmc_resume_host(mmc);
-	}
 
 	return ret;
 }
-#else
-#define mxcmci_suspend  NULL
-#define mxcmci_resume   NULL
-#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops mxcmci_pm_ops = {
+	.suspend	= mxcmci_suspend,
+	.resume		= mxcmci_resume,
+};
+#endif
 
 static struct platform_driver mxcmci_driver = {
 	.probe		= mxcmci_probe,
 	.remove		= mxcmci_remove,
-	.suspend	= mxcmci_suspend,
-	.resume		= mxcmci_resume,
 	.driver		= {
 		.name		= DRIVER_NAME,
 		.owner		= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	= &mxcmci_pm_ops,
+#endif
 	}
 };
 
-- 
1.6.3.3
