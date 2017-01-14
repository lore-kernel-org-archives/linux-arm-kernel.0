From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 14 Jan 2017 17:29:18 +0000
Subject: [PATCH RFC] mmc: mxs-mmc: Implement CMD23 support
Message-ID: <1484414958-2665-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch implements support for multiblock transfers bounded
by SET_BLOCK_COUNT (CMD23) on the MXS MMC host driver.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/mxs-mmc.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index c8b8ac6..add1e70 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -153,7 +153,11 @@ static void mxs_mmc_request_done(struct mxs_mmc_host *host)
 		}
 	}
 
-	if (data) {
+	if (cmd == mrq->sbc) {
+		/* Finished CMD23, now send actual command. */
+		mxs_mmc_start_cmd(host, mrq->cmd);
+		return;
+	} else if (data) {
 		dma_unmap_sg(mmc_dev(host->mmc), data->sg,
 			     data->sg_len, ssp->dma_dir);
 		/*
@@ -166,7 +170,7 @@ static void mxs_mmc_request_done(struct mxs_mmc_host *host)
 			data->bytes_xfered = 0;
 
 		host->data = NULL;
-		if (mrq->stop) {
+		if (data->stop && (data->error || !mrq->sbc)) {
 			mxs_mmc_start_cmd(host, mrq->stop);
 			return;
 		}
@@ -495,7 +499,11 @@ static void mxs_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	WARN_ON(host->mrq != NULL);
 	host->mrq = mrq;
-	mxs_mmc_start_cmd(host, mrq->cmd);
+
+	if (mrq->sbc)
+		mxs_mmc_start_cmd(host, mrq->sbc);
+	else
+		mxs_mmc_start_cmd(host, mrq->cmd);
 }
 
 static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
@@ -642,7 +650,7 @@ static int mxs_mmc_probe(struct platform_device *pdev)
 	/* set mmc core parameters */
 	mmc->ops = &mxs_mmc_ops;
 	mmc->caps = MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED |
-		    MMC_CAP_SDIO_IRQ | MMC_CAP_NEEDS_POLL;
+		    MMC_CAP_SDIO_IRQ | MMC_CAP_NEEDS_POLL | MMC_CAP_CMD23;
 
 	host->broken_cd = of_property_read_bool(np, "broken-cd");
 
-- 
1.7.9.5
