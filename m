From: garsilva@embeddedor.com (Gustavo A. R. Silva)
Date: Tue, 23 May 2017 18:42:27 -0500
Subject: [PATCH] mmc: host: fix potential null pointer dereference
Message-ID: <20170523234227.GA13018@embeddedgus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Null check at line 1165: if (mrq->cmd), implies that mrq->cmd might
be NULL.
Add null checks before dereferencing pointer mrq->cmd in order to avoid
any potential NULL pointer dereference.

Addresses-Coverity-ID: 1408740
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/mmc/host/bcm2835.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 1f343a4..abba9a2 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1172,7 +1172,10 @@ static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (mrq->data && !is_power_of_2(mrq->data->blksz)) {
 		dev_err(dev, "unsupported block size (%d bytes)\n",
 			mrq->data->blksz);
-		mrq->cmd->error = -EINVAL;
+
+		if (mrq->cmd)
+			mrq->cmd->error = -EINVAL;
+
 		mmc_request_done(mmc, mrq);
 		return;
 	}
@@ -1194,7 +1197,10 @@ static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
 			readl(host->ioaddr + SDCMD) & SDCMD_CMD_MASK,
 			edm);
 		bcm2835_dumpregs(host);
-		mrq->cmd->error = -EILSEQ;
+
+		if (mrq->cmd)
+			mrq->cmd->error = -EILSEQ;
+
 		bcm2835_finish_request(host);
 		mutex_unlock(&host->mutex);
 		return;
@@ -1207,7 +1213,7 @@ static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
 			if (!host->use_busy)
 				bcm2835_finish_command(host);
 		}
-	} else if (bcm2835_send_command(host, mrq->cmd)) {
+	} else if (mrq->cmd && bcm2835_send_command(host, mrq->cmd)) {
 		if (host->data && host->dma_desc) {
 			/* DMA transfer starts now, PIO starts after irq */
 			bcm2835_start_dma(host);
-- 
2.5.0
