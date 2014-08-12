From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 12 Aug 2014 17:14:28 +0100
Subject: [PATCH 4/5] mmc: sdhci-pci: Use SET_RUNTIME_PM_OPS macro to set
 runtime pm callbacks
In-Reply-To: <1407860069-12706-1-git-send-email-peter.griffin@linaro.org>
References: <1407860069-12706-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1407860069-12706-5-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows us to get rid of the #else condition, as the macro compiles
away to nothing if not enabled.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/mmc/host/sdhci-pci.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
index 52c42fc..745629d 100644
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -1267,20 +1267,13 @@ static int sdhci_pci_runtime_idle(struct device *dev)
 	return 0;
 }
 
-#else
-
-#define sdhci_pci_runtime_suspend	NULL
-#define sdhci_pci_runtime_resume	NULL
-#define sdhci_pci_runtime_idle		NULL
-
 #endif
 
 static const struct dev_pm_ops sdhci_pci_pm_ops = {
 	.suspend = sdhci_pci_suspend,
 	.resume = sdhci_pci_resume,
-	.runtime_suspend = sdhci_pci_runtime_suspend,
-	.runtime_resume = sdhci_pci_runtime_resume,
-	.runtime_idle = sdhci_pci_runtime_idle,
+	SET_RUNTIME_PM_OPS(sdhci_pci_runtime_suspend,
+			sdhci_pci_runtime_resume, sdhci_pci_runtime_idle)
 };
 
 /*****************************************************************************\
-- 
1.9.1
