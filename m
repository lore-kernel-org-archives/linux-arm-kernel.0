From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 16 Jun 2017 18:15:39 +0530
Subject: [PATCH 11/16] mmc: host: omap_hsmmc: Fix error path sequence
In-Reply-To: <20170616124544.15046-1-kishon@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
Message-ID: <20170616124544.15046-12-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the error path sequence so that clk_disable, runtime_disable etc
are done in the reverse order of how they were enabled.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9d59fe611498..967b7c7d4bd5 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2591,16 +2591,16 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 err_slot_name:
 	mmc_remove_host(mmc);
 err_irq:
-	device_init_wakeup(&pdev->dev, false);
 	if (!IS_ERR_OR_NULL(host->tx_chan))
 		dma_release_channel(host->tx_chan);
 	if (!IS_ERR_OR_NULL(host->rx_chan))
 		dma_release_channel(host->rx_chan);
+	if (host->dbclk)
+		clk_disable_unprepare(host->dbclk);
 	pm_runtime_dont_use_autosuspend(host->dev);
 	pm_runtime_put_sync(host->dev);
 	pm_runtime_disable(host->dev);
-	if (host->dbclk)
-		clk_disable_unprepare(host->dbclk);
+	device_init_wakeup(&pdev->dev, false);
 err1:
 err_gpio:
 	mmc_free_host(mmc);
-- 
2.11.0
