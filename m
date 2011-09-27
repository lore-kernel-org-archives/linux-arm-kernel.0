From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 27 Sep 2011 09:46:43 +0200
Subject: [PATCH 3/4] mmc: mmci: Prepare for SDIO before setting up DMA job
Message-ID: <1317109603-17975-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the SDIO preparation to be done before the DMA job is setup.
This makes it possible to do DMA for SDIO transfers as well as the
earlier supported pio mode.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
---
 drivers/mmc/host/mmci.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f1d27d9..cd3bc25 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -604,6 +604,11 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	if (data->flags & MMC_DATA_READ)
 		datactrl |= MCI_DPSM_DIRECTION;
 
+	/* The ST Micro variants has a special bit to enable SDIO */
+	if (variant->sdio && host->mmc->card)
+		if (mmc_card_sdio(host->mmc->card))
+			datactrl |= MCI_ST_DPSM_SDIOEN;
+
 	/*
 	 * Attempt to use DMA operation mode, if this
 	 * should fail, fall back to PIO mode
@@ -632,11 +637,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 		irqmask = MCI_TXFIFOHALFEMPTYMASK;
 	}
 
-	/* The ST Micro variants has a special bit to enable SDIO */
-	if (variant->sdio && host->mmc->card)
-		if (mmc_card_sdio(host->mmc->card))
-			datactrl |= MCI_ST_DPSM_SDIOEN;
-
 	writel(datactrl, base + MMCIDATACTRL);
 	writel(readl(base + MMCIMASK0) & ~MCI_DATAENDMASK, base + MMCIMASK0);
 	mmci_set_mask1(host, irqmask);
-- 
1.7.5.4
