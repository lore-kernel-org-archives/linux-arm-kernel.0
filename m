From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 30 Oct 2013 22:12:14 +0800
Subject: [PATCH 1/5] mmc: sdhci-pltfm: export pltfm suspend/resume api
In-Reply-To: <1383142338-25062-1-git-send-email-b29396@freescale.com>
References: <1383142338-25062-1-git-send-email-b29396@freescale.com>
Message-ID: <1383142338-25062-2-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is helpful for platforms code to use to elimiate duplicated code.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    6 ++++--
 drivers/mmc/host/sdhci-pltfm.h |    2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index e2065a4..bef250e 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -237,19 +237,21 @@ int sdhci_pltfm_unregister(struct platform_device *pdev)
 EXPORT_SYMBOL_GPL(sdhci_pltfm_unregister);
 
 #ifdef CONFIG_PM
-static int sdhci_pltfm_suspend(struct device *dev)
+int sdhci_pltfm_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 
 	return sdhci_suspend_host(host);
 }
+EXPORT_SYMBOL_GPL(sdhci_pltfm_suspend);
 
-static int sdhci_pltfm_resume(struct device *dev)
+int sdhci_pltfm_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 
 	return sdhci_resume_host(host);
 }
+EXPORT_SYMBOL_GPL(sdhci_pltfm_resume);
 
 const struct dev_pm_ops sdhci_pltfm_pmops = {
 	.suspend	= sdhci_pltfm_suspend,
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index e15ced79..04bc248 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -111,6 +111,8 @@ static inline void *sdhci_pltfm_priv(struct sdhci_pltfm_host *host)
 }
 
 #ifdef CONFIG_PM
+extern int sdhci_pltfm_suspend(struct device *dev);
+extern int sdhci_pltfm_resume(struct device *dev);
 extern const struct dev_pm_ops sdhci_pltfm_pmops;
 #define SDHCI_PLTFM_PMOPS (&sdhci_pltfm_pmops)
 #else
-- 
1.7.2.rc3
