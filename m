From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Mon,  7 Aug 2017 20:40:19 +0800
Subject: [PATCH 2/3] spi: rockchip: Fix clock handling in remove
In-Reply-To: <1502109620-26813-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1502109620-26813-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1502109620-26813-3-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We are assuming clocks enabled when calling rockchip_spi_remove, which
is not always true. Those clocks might already been disabled by the
runtime PM at that time.

Call pm_runtime_get_sync before trying to disable clocks to avoid that.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/spi/spi-rockchip.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 5497650..a75fd9b 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -816,11 +816,15 @@ static int rockchip_spi_remove(struct platform_device *pdev)
 	struct spi_master *master = spi_master_get(platform_get_drvdata(pdev));
 	struct rockchip_spi *rs = spi_master_get_devdata(master);
 
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 
 	clk_disable_unprepare(rs->spiclk);
 	clk_disable_unprepare(rs->apb_pclk);
 
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+
 	if (rs->dma_tx.ch)
 		dma_release_channel(rs->dma_tx.ch);
 	if (rs->dma_rx.ch)
-- 
2.1.4
