From: jszhang@marvell.com (Jisheng Zhang)
Date: Sun, 4 Jan 2015 23:15:48 +0800
Subject: [PATCH next 2/2] mmc: sdhci-pxav3: fix pm unbalanced issue in ->
 remove()
In-Reply-To: <1420384548-7816-1-git-send-email-jszhang@marvell.com>
References: <1420384548-7816-1-git-send-email-jszhang@marvell.com>
Message-ID: <1420384548-7816-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch calls pm_runtime_put_noidle() to restore the device's usage
counter in the ->remove() implementation.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 1255dd2..4de39fb 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -412,8 +412,10 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
 	struct sdhci_pxa *pxa = pltfm_host->priv;
 
 	pm_runtime_get_sync(&pdev->dev);
-	sdhci_remove_host(host, 1);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
+	sdhci_remove_host(host, 1);
 
 	clk_disable_unprepare(pxa->clk_io);
 	if (!IS_ERR(pxa->clk_core))
-- 
2.1.4
