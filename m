From: daniel@caiaq.de (Daniel Mack)
Date: Thu,  1 Apr 2010 10:03:23 +0200
Subject: [PATCH 1/3] ARM: MXC: mxcmmc: misc cleanups
Message-ID: <1270109005-9007-1-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Be more verbose on error messages and add one debug message.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Volker Ernst <volker.ernst@txtr.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Micha? Miros?aw <mirqus@gmail.com>
---
 drivers/mmc/host/mxcmmc.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 2df9041..44a53ee 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -151,6 +151,8 @@ static void mxcmci_softreset(struct mxcmci_host *host)
 {
 	int i;
 
+	dev_dbg(mmc_dev(host->mmc), "mxcmci_softreset\n");
+
 	/* reset sequence */
 	writew(STR_STP_CLK_RESET, host->base + MMC_REG_STR_STP_CLK);
 	writew(STR_STP_CLK_RESET | STR_STP_CLK_START_CLK,
@@ -290,16 +292,25 @@ static int mxcmci_finish_data(struct mxcmci_host *host, unsigned int stat)
 		dev_dbg(mmc_dev(host->mmc), "request failed. status: 0x%08x\n",
 				stat);
 		if (stat & STATUS_CRC_READ_ERR) {
+			dev_err(mmc_dev(host->mmc), "%s: -EILSEQ\n", __func__);
 			data->error = -EILSEQ;
 		} else if (stat & STATUS_CRC_WRITE_ERR) {
 			u32 err_code = (stat >> 9) & 0x3;
-			if (err_code == 2) /* No CRC response */
+			if (err_code == 2) { /* No CRC response */
+				dev_err(mmc_dev(host->mmc),
+					"%s: No CRC -ETIMEDOUT\n", __func__);
 				data->error = -ETIMEDOUT;
-			else
+			} else {
+				dev_err(mmc_dev(host->mmc),
+					"%s: -EILSEQ\n", __func__);
 				data->error = -EILSEQ;
+			}
 		} else if (stat & STATUS_TIME_OUT_READ) {
+			dev_err(mmc_dev(host->mmc),
+				"%s: read -ETIMEDOUT\n", __func__);
 			data->error = -ETIMEDOUT;
 		} else {
+			dev_err(mmc_dev(host->mmc), "%s: -EIO\n", __func__);
 			data->error = -EIO;
 		}
 	} else {
@@ -433,8 +444,6 @@ static int mxcmci_transfer_data(struct mxcmci_host *host)
 	struct scatterlist *sg;
 	int stat, i;
 
-	host->datasize = 0;
-
 	host->data = data;
 	host->datasize = 0;
 
-- 
1.7.0
