From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 21 Mar 2014 13:14:15 +0100
Subject: [PATCH 18/20] mmc: mmci: Enforce mmc capabilities through DT
In-Reply-To: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1395404057-27835-19-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the option to provide the flags for mmc capabilities as platform
data, enforce it through DT.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c   |    2 --
 include/linux/amba/mmci.h |    5 -----
 2 files changed, 7 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index bef3f85..a7bda79 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1516,8 +1516,6 @@ static int mmci_probe(struct amba_device *dev,
 		dev_warn(mmc_dev(mmc), "Platform OCR mask is ignored\n");
 
 	/* DT takes precedence over platform data. */
-	mmc->caps = np ? mmc->caps : plat->capabilities;
-	mmc->caps2 = np ? mmc->caps2 : plat->capabilities2;
 	if (!np) {
 		if (!plat->cd_invert)
 			mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index 0d3ff95..b992fc9 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -29,9 +29,6 @@ struct dma_chan;
  * @gpio_wp: read this GPIO pin to see if the card is write protected
  * @gpio_cd: read this GPIO pin to detect card insertion
  * @cd_invert: true if the gpio_cd pin value is active low
- * @capabilities: the capabilities of the block as implemented in
- * this platform, signify anything MMC_CAP_* from mmc/host.h
- * @capabilities2: more capabilities, MMC_CAP2_* from mmc/host.h
  * @dma_filter: function used to select an appropriate RX and TX
  * DMA channel to be used for DMA, if and only if you're deploying the
  * generic DMA engine
@@ -52,8 +49,6 @@ struct mmci_platform_data {
 	int	gpio_wp;
 	int	gpio_cd;
 	bool	cd_invert;
-	unsigned long capabilities;
-	unsigned long capabilities2;
 	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
 	void *dma_rx_param;
 	void *dma_tx_param;
-- 
1.7.9.5
