From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Tue, 12 Jul 2016 15:46:12 +0800
Subject: [PATCH V2 03/15] mmc: sdhci-esdhc-imx: add esdhc specific suspend
 resume callback
In-Reply-To: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1468309584-3591-4-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It will be used for platform specific suspend/resume state save/restore
work for some low power mode like Mega/Fast or LPSR mode.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index c005b4114fd4..f94c1efff830 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1254,6 +1254,16 @@ static int sdhci_esdhc_imx_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
+static int sdhci_esdhc_suspend(struct device *dev)
+{
+	return sdhci_pltfm_suspend(dev);
+}
+
+static int sdhci_esdhc_resume(struct device *dev)
+{
+	return sdhci_pltfm_resume(dev);
+}
+
 static int sdhci_esdhc_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -1289,7 +1299,7 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 #endif
 
 static const struct dev_pm_ops sdhci_esdhc_pmops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sdhci_pltfm_suspend, sdhci_pltfm_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend, sdhci_esdhc_resume)
 	SET_RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
 				sdhci_esdhc_runtime_resume, NULL)
 };
-- 
1.9.1
