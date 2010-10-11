From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 11 Oct 2010 16:21:01 +0200
Subject: [PATCH 1/6] mmc: sdhci-pltfm: Add structure for host-specific data
In-Reply-To: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1286806866-19258-2-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to carry some information per host, e.g. the clock. Add a
structure for it and initialize it in the generic part. Also improve
the check for a parent.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Richard R?jfors <richard.rojfors.ext@mocean-labs.com>
---

Changes since last version:

* Improved detection of a "real" parent device

 drivers/mmc/host/sdhci-pltfm.c |   10 +++++++---
 drivers/mmc/host/sdhci-pltfm.h |    7 +++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 4f126de..730fdf5 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -55,6 +55,7 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_data *pdata = pdev->dev.platform_data;
 	const struct platform_device_id *platid = platform_get_device_id(pdev);
 	struct sdhci_host *host;
+	struct sdhci_pltfm_host *pltfm_host;
 	struct resource *iomem;
 	int ret;
 
@@ -71,16 +72,19 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Invalid iomem size. You may "
 			"experience problems.\n");
 
-	if (pdev->dev.parent)
-		host = sdhci_alloc_host(pdev->dev.parent, 0);
+	/* Some PCI-based MFD need the parent here */
+	if (pdev->dev.parent != &platform_bus)
+		host = sdhci_alloc_host(pdev->dev.parent, sizeof(*pltfm_host));
 	else
-		host = sdhci_alloc_host(&pdev->dev, 0);
+		host = sdhci_alloc_host(&pdev->dev, sizeof(*pltfm_host));
 
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
 		goto err;
 	}
 
+	pltfm_host = sdhci_priv(host);
+
 	host->hw_name = "platform";
 	if (pdata && pdata->ops)
 		host->ops = pdata->ops;
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index 900f329..93a0319 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -11,8 +11,15 @@
 #ifndef _DRIVERS_MMC_SDHCI_PLTFM_H
 #define _DRIVERS_MMC_SDHCI_PLTFM_H
 
+#include <linux/clk.h>
+#include <linux/types.h>
 #include <linux/sdhci-pltfm.h>
 
+struct sdhci_pltfm_host {
+	struct clk *clk;
+	u32 scratchpad; /* to handle quirks across io-accessor calls */
+};
+
 extern struct sdhci_pltfm_data sdhci_cns3xxx_pdata;
 
 #endif /* _DRIVERS_MMC_SDHCI_PLTFM_H */
-- 
1.7.1
