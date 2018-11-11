From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 11 Nov 2018 21:23:56 +0100
Subject: [PATCH V2 4/7] mmc: bcm2835: Avoid possible races on data requests
In-Reply-To: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
References: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1541967839-2847-5-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two accesses on the data requests which are not protected by
the mutex. So fix this accordingly.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/bcm2835.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 45724ef..1c60798 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1064,10 +1064,12 @@ static void bcm2835_dma_complete_work(struct work_struct *work)
 {
 	struct bcm2835_host *host =
 		container_of(work, struct bcm2835_host, dma_work);
-	struct mmc_data *data = host->data;
+	struct mmc_data *data;
 
 	mutex_lock(&host->mutex);
 
+	data = host->data;
+
 	if (host->dma_chan) {
 		dma_unmap_sg(host->dma_chan->device->dev,
 			     data->sg, data->sg_len,
@@ -1192,9 +1194,6 @@ static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 	}
 
-	if (host->use_dma && mrq->data && (mrq->data->blocks > PIO_THRESHOLD))
-		bcm2835_prepare_dma(host, mrq->data);
-
 	mutex_lock(&host->mutex);
 
 	WARN_ON(host->mrq);
@@ -1218,6 +1217,9 @@ static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 	}
 
+	if (host->use_dma && mrq->data && (mrq->data->blocks > PIO_THRESHOLD))
+		bcm2835_prepare_dma(host, mrq->data);
+
 	host->use_sbc = !!mrq->sbc && host->mrq->data &&
 			(host->mrq->data->flags & MMC_DATA_READ);
 	if (host->use_sbc) {
-- 
2.7.4
