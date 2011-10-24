From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 24 Oct 2011 15:50:43 +0200
Subject: [PATCH 2/2] mmc: mmci: Fix incorrect handling of HW flow control for
	SDIO
In-Reply-To: <1319464243-16638-1-git-send-email-ulf.hansson@stericsson.com>
References: <1319464243-16638-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1319464243-16638-3-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>

For data writes smaller <= 8 bytes (only SDIO case), HW flow control was
disabled but never re-enabled again. This meant that a following large read
request would randomly give buffer overrun errors.

Moreover HW flow control is not needed for transfers that fits in the
FIFO of PL18x. Thus it is disabled for write operations <= the FIFO size.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
---
 drivers/mmc/host/mmci.c |   42 ++++++++++++++++++++++++------------------
 1 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 1b73177..07d1378 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -606,9 +606,32 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 
 	/* The ST Micro variants has a special bit to enable SDIO */
 	if (variant->sdio && host->mmc->card)
-		if (mmc_card_sdio(host->mmc->card))
+		if (mmc_card_sdio(host->mmc->card)) {
+			/*
+			 * The ST Micro variants has a special bit
+			 * to enable SDIO.
+			 */
 			datactrl |= MCI_ST_DPSM_SDIOEN;
 
+			/*
+			 * The ST Micro variant for SDIO transfer sizes
+			 * less then or equal to 8 bytes needs to have clock
+			 * H/W flow control disabled. Since flow control is
+			 * not really needed for anything that fits in the
+			 * FIFO, we can disable it for any write smaller
+			 * than the FIFO size.
+			 */
+			if ((host->size <= variant->fifosize) &&
+			    (data->flags & MMC_DATA_WRITE))
+				writel(readl(host->base + MMCICLOCK) &
+				       ~variant->clkreg_enable,
+				       host->base + MMCICLOCK);
+			else
+				writel(readl(host->base + MMCICLOCK) |
+				       variant->clkreg_enable,
+				       host->base + MMCICLOCK);
+		}
+
 	/*
 	 * Attempt to use DMA operation mode, if this
 	 * should fail, fall back to PIO mode
@@ -807,23 +830,6 @@ static int mmci_pio_write(struct mmci_host *host, char *buffer, unsigned int rem
 		count = min(remain, maxcnt);
 
 		/*
-		 * The ST Micro variant for SDIO transfer sizes
-		 * less then 8 bytes should have clock H/W flow
-		 * control disabled.
-		 */
-		if (variant->sdio &&
-		    mmc_card_sdio(host->mmc->card)) {
-			if (count < 8)
-				writel(readl(host->base + MMCICLOCK) &
-					~variant->clkreg_enable,
-					host->base + MMCICLOCK);
-			else
-				writel(readl(host->base + MMCICLOCK) |
-					variant->clkreg_enable,
-					host->base + MMCICLOCK);
-		}
-
-		/*
 		 * SDIO especially may want to send something that is
 		 * not divisible by 4 (as opposed to card sectors
 		 * etc), and the FIFO only accept full 32-bit writes.
-- 
1.7.5.4
