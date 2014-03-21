From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 21 Mar 2014 13:14:16 +0100
Subject: [PATCH 19/20] mmc: mmci: Enforce DMA configuration through DT
In-Reply-To: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1395404057-27835-20-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the option to provide DMA configuration as platform data,
enforce it through DT.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c   |   24 +-----------------------
 include/linux/amba/mmci.h |   17 -----------------
 2 files changed, 1 insertion(+), 40 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index a7bda79..181445e 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -367,7 +367,6 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
 #ifdef CONFIG_DMA_ENGINE
 static void mmci_dma_setup(struct mmci_host *host)
 {
-	struct mmci_platform_data *plat = host->plat;
 	const char *rxname, *txname;
 	dma_cap_mask_t mask;
 
@@ -381,25 +380,6 @@ static void mmci_dma_setup(struct mmci_host *host)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 
-	if (plat && plat->dma_filter) {
-		if (!host->dma_rx_channel && plat->dma_rx_param) {
-			host->dma_rx_channel = dma_request_channel(mask,
-							   plat->dma_filter,
-							   plat->dma_rx_param);
-			/* E.g if no DMA hardware is present */
-			if (!host->dma_rx_channel)
-				dev_err(mmc_dev(host->mmc), "no RX DMA channel\n");
-		}
-
-		if (!host->dma_tx_channel && plat->dma_tx_param) {
-			host->dma_tx_channel = dma_request_channel(mask,
-							   plat->dma_filter,
-							   plat->dma_tx_param);
-			if (!host->dma_tx_channel)
-				dev_warn(mmc_dev(host->mmc), "no TX DMA channel\n");
-		}
-	}
-
 	/*
 	 * If only an RX channel is specified, the driver will
 	 * attempt to use it bidirectionally, however if it is
@@ -447,11 +427,9 @@ static void mmci_dma_setup(struct mmci_host *host)
  */
 static inline void mmci_dma_release(struct mmci_host *host)
 {
-	struct mmci_platform_data *plat = host->plat;
-
 	if (host->dma_rx_channel)
 		dma_release_channel(host->dma_rx_channel);
-	if (host->dma_tx_channel && plat->dma_tx_param)
+	if (host->dma_tx_channel)
 		dma_release_channel(host->dma_tx_channel);
 	host->dma_rx_channel = host->dma_tx_channel = NULL;
 }
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index b992fc9..bf339ff 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -6,9 +6,6 @@
 
 #include <linux/mmc/host.h>
 
-/* Just some dummy forwarding */
-struct dma_chan;
-
 /**
  * struct mmci_platform_data - platform configuration for the MMCI
  * (also known as PL180) block.
@@ -29,17 +26,6 @@ struct dma_chan;
  * @gpio_wp: read this GPIO pin to see if the card is write protected
  * @gpio_cd: read this GPIO pin to detect card insertion
  * @cd_invert: true if the gpio_cd pin value is active low
- * @dma_filter: function used to select an appropriate RX and TX
- * DMA channel to be used for DMA, if and only if you're deploying the
- * generic DMA engine
- * @dma_rx_param: parameter passed to the DMA allocation
- * filter in order to select an appropriate RX channel. If
- * there is a bidirectional RX+TX channel, then just specify
- * this and leave dma_tx_param set to NULL
- * @dma_tx_param: parameter passed to the DMA allocation
- * filter in order to select an appropriate TX channel. If this
- * is NULL the driver will attempt to use the RX channel as a
- * bidirectional channel
  */
 struct mmci_platform_data {
 	unsigned int f_max;
@@ -49,9 +35,6 @@ struct mmci_platform_data {
 	int	gpio_wp;
 	int	gpio_cd;
 	bool	cd_invert;
-	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
-	void *dma_rx_param;
-	void *dma_tx_param;
 };
 
 #endif
-- 
1.7.9.5
