From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 11 Nov 2018 21:23:55 +0100
Subject: [PATCH V2 3/7] mmc: bcm2835: Release DMA channel on driver unload
In-Reply-To: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
References: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1541967839-2847-4-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to release the slave DMA channel during driver unload.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/bcm2835.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index a251be2..45724ef 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1457,6 +1457,9 @@ static int bcm2835_remove(struct platform_device *pdev)
 	cancel_work_sync(&host->dma_work);
 	cancel_delayed_work_sync(&host->timeout_work);
 
+	if (host->dma_chan_rxtx)
+		dma_release_channel(host->dma_chan_rxtx);
+
 	mmc_free_host(host->mmc);
 	platform_set_drvdata(pdev, NULL);
 
-- 
2.7.4
