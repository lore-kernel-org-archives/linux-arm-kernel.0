From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 16 Feb 2016 21:08:23 +0800
Subject: [PATCH v5 05/13] mmc: sdhci-of-arasan: fix clk issue in
 sdhci_arasan_remove()
In-Reply-To: <1455628111-5583-1-git-send-email-jszhang@marvell.com>
References: <1455628111-5583-1-git-send-email-jszhang@marvell.com>
Message-ID: <1455628111-5583-6-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdhci_pltfm_unregister() could operate host's registers, it will cause
problems if the clk is already disabled and unprepared. Fix this issue
by moving the clk_disable_unprepare() call to the end of remove
function.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 5d9fdb3..8b4f8f7 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -201,13 +201,16 @@ clk_dis_ahb:
 
 static int sdhci_arasan_remove(struct platform_device *pdev)
 {
+	int ret;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_arasan_data *sdhci_arasan = pltfm_host->priv;
 
+	ret = sdhci_pltfm_unregister(pdev);
+
 	clk_disable_unprepare(sdhci_arasan->clk_ahb);
 
-	return sdhci_pltfm_unregister(pdev);
+	return ret;
 }
 
 static const struct of_device_id sdhci_arasan_of_match[] = {
-- 
2.7.0
