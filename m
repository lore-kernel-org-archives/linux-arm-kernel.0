From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 12 Dec 2011 16:36:03 +0100
Subject: [PATCH 1/5] mmc: mmci: Prepare for SDIO before setting up DMA job
In-Reply-To: <1323704167-10247-1-git-send-email-ulf.hansson@stericsson.com>
References: <1323704167-10247-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1323704167-10247-2-git-send-email-ulf.hansson@stericsson.com>
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
index b98ee98..d311f83 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -638,6 +638,11 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
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
@@ -666,11 +671,6 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
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
