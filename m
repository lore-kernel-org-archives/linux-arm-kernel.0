From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 15 Oct 2010 12:21:02 +0200
Subject: [PATCH 4/6] mmc: sdhci_pltfm: pass more data on custom init-call
In-Reply-To: <1287138064-21385-1-git-send-email-w.sang@pengutronix.de>
References: <1287138064-21385-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1287138064-21385-5-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The custom init call may need more data to perform its job, so we pass
it a pointer to pdata, too. Also, always use the platform_id specific
data even if platform_data is present. Doing that, platform_data can
additionally be parsed by init() for board-specific information (via
sdhci->mmc->parent).

(Note: the old behaviour was that you could override the platform_id
specific data with your own. However, one can still do this by using the
"sdhci" id instead of "sdhci-<something>".)

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Tested-by : Eric B?nard <eric@eukrea.com>
---
 drivers/mmc/host/sdhci-pltfm.c  |    8 +++++---
 include/linux/mmc/sdhci-pltfm.h |    2 +-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 685202b..00e8a8a 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -52,15 +52,17 @@ static struct sdhci_ops sdhci_pltfm_ops = {
 
 static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 {
-	struct sdhci_pltfm_data *pdata = pdev->dev.platform_data;
 	const struct platform_device_id *platid = platform_get_device_id(pdev);
+	struct sdhci_pltfm_data *pdata;
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
 	struct resource *iomem;
 	int ret;
 
-	if (!pdata && platid && platid->driver_data)
+	if (platid && platid->driver_data)
 		pdata = (void *)platid->driver_data;
+	else
+		pdata = pdev->dev.platform_data;
 
 	iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iomem) {
@@ -109,7 +111,7 @@ static int __devinit sdhci_pltfm_probe(struct platform_device *pdev)
 	}
 
 	if (pdata && pdata->init) {
-		ret = pdata->init(host);
+		ret = pdata->init(host, pdata);
 		if (ret)
 			goto err_plat_init;
 	}
diff --git a/include/linux/mmc/sdhci-pltfm.h b/include/linux/mmc/sdhci-pltfm.h
index 0239bd7..548d59d 100644
--- a/include/linux/mmc/sdhci-pltfm.h
+++ b/include/linux/mmc/sdhci-pltfm.h
@@ -28,7 +28,7 @@ struct sdhci_host;
 struct sdhci_pltfm_data {
 	struct sdhci_ops *ops;
 	unsigned int quirks;
-	int (*init)(struct sdhci_host *host);
+	int (*init)(struct sdhci_host *host, struct sdhci_pltfm_data *pdata);
 	void (*exit)(struct sdhci_host *host);
 };
 
-- 
1.7.1
