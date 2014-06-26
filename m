From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 26 Jun 2014 22:49:50 +0200
Subject: [RFC 10/10] mmc: sdhci-tegra: Add IOMMU support
In-Reply-To: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1403815790-8548-11-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Attach to the device's master interface of the IOMMU at .probe() time.
IOMMU support becomes available via the DMA mapping API interoperation
code, but this explicit attachment is necessary to ensure proper probe
order.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 33100d10d176..b884614fa4e6 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -15,6 +15,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/iommu.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/io.h>
@@ -237,6 +238,11 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	match = of_match_device(sdhci_tegra_dt_match, &pdev->dev);
 	if (!match)
 		return -EINVAL;
+
+	rc = iommu_attach(&pdev->dev);
+	if (rc < 0)
+		return rc;
+
 	soc_data = match->data;
 
 	host = sdhci_pltfm_init(pdev, soc_data->pdata, 0);
@@ -310,6 +316,8 @@ static int sdhci_tegra_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_put(pltfm_host->clk);
 
+	iommu_detach(&pdev->dev);
+
 	sdhci_pltfm_free(pdev);
 
 	return 0;
-- 
2.0.0
