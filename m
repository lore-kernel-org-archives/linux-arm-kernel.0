From: msuchanek@suse.de (Michal Suchanek)
Date: Wed, 14 Feb 2018 15:38:58 +0100
Subject: [PATCH 2/2] mmc: bcm2835: print some informational messages during
 reset
In-Reply-To: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
Message-ID: <57ff1e429a7fc12300a3cca0c5e9a637beed0d3a.1518619058.git.msuchanek@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous patch does reset during hardware error so make the reset
progress more visible.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/mmc/host/bcm2835.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index ce05fe72f865..4dde8b2b62a9 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -283,10 +283,14 @@ static void bcm2835_reset_internal(struct bcm2835_host *host)
 static void bcm2835_reset(struct mmc_host *mmc)
 {
 	struct bcm2835_host *host = mmc_priv(mmc);
+	struct device *dev = &host->pdev->dev;
 
-	if (host->dma_chan)
+	if (host->dma_chan) {
+		dev_info(dev, "tearing down dma");
 		dmaengine_terminate_sync(host->dma_chan);
+	}
 	host->dma_chan = NULL;
+	dev_info(dev, "resetting");
 	bcm2835_reset_internal(host);
 }
 
-- 
2.13.6
