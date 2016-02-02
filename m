From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 2 Feb 2016 19:55:06 +0800
Subject: [PATCH v2] mmc: sdhci-of-at91: fix pm runtime unbalanced issue in
 error path
Message-ID: <1454414106-4441-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device power usage counter is increased by pm_runtime_get_noresume
but isn't decreased in err_add_host error path.

Fix this issue by calling pm_runtime_put_noidle() in the error path to
restore the device's power usage counter.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Fixes: f5f17813ae9b ("mmc: sdhci-of-at91: add PM support)
---
Since v1:
 - Add Ludovic ack
 - address Ulf's comment

 drivers/mmc/host/sdhci-of-at91.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 7db7163..35c02fc 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -211,6 +211,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 pm_runtime_disable:
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
 clocks_disable_unprepare:
 	clk_disable_unprepare(priv->gck);
 	clk_disable_unprepare(priv->mainck);
-- 
1.9.1
