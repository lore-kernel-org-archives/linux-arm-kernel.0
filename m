From: daniel@caiaq.de (Daniel Mack)
Date: Thu,  5 Nov 2009 18:13:34 +0100
Subject: [PATCH 1/3] ARM: MXC: mxcmmc: misc cleanups
In-Reply-To: <1257441216-19604-1-git-send-email-daniel@caiaq.de>
References: <1257441216-19604-1-git-send-email-daniel@caiaq.de>
Message-ID: <1257441216-19604-2-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some more debug information and fix a couple of coding style things
in mxcmmc.c.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 drivers/mmc/host/mxcmmc.c |   28 +++++++++++++++++-----------
 1 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 8867152..32ac139 100644
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
@@ -290,21 +292,29 @@ static int mxcmci_finish_data(struct mxcmci_host *host, unsigned int stat)
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
-	} else {
+	} else
 		data->bytes_xfered = host->datasize;
-	}
 
 	data_error = data->error;
 
@@ -433,8 +443,6 @@ static int mxcmci_transfer_data(struct mxcmci_host *host)
 	struct scatterlist *sg;
 	int stat, i;
 
-	host->datasize = 0;
-
 	host->data = data;
 	host->datasize = 0;
 
@@ -471,9 +479,8 @@ static void mxcmci_datawork(struct work_struct *work)
 			mxcmci_finish_request(host, host->req);
 			return;
 		}
-	} else {
+	} else
 		mxcmci_finish_request(host, host->req);
-	}
 }
 
 #ifdef HAS_DMA
@@ -495,9 +502,8 @@ static void mxcmci_data_done(struct mxcmci_host *host, unsigned int stat)
 			mxcmci_finish_request(host, host->req);
 			return;
 		}
-	} else {
+	} else
 		mxcmci_finish_request(host, host->req);
-	}
 }
 #endif /* HAS_DMA */
 
@@ -512,7 +518,7 @@ static void mxcmci_cmd_done(struct mxcmci_host *host, unsigned int stat)
 	}
 
 	/* For the DMA case the DMA engine handles the data transfer
-	 * automatically. For non DMA we have to do it ourselves.
+	 * automatically. For non DMA we have to to it ourselves.
 	 * Don't do it in interrupt context though.
 	 */
 	if (!mxcmci_use_dma(host) && host->data)
-- 
1.6.5.2
