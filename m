From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 12 Dec 2011 16:36:04 +0100
Subject: [PATCH 2/5] mmc: mmci: Fix incorrect handling of HW flow control for
 SDIO
In-Reply-To: <1323704167-10247-1-git-send-email-ulf.hansson@stericsson.com>
References: <1323704167-10247-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1323704167-10247-3-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For data writes smaller than 8 bytes (only SDIO case), HW flow
control was disabled but never re-enabled again. This meant that
a following large read request could randomly give buffer overrun
errors.

This patch is based upon a patch from Stefan Nilsson.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Signed-off-by: Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>
---
 drivers/mmc/host/mmci.c |   38 ++++++++++++++++++++------------------
 1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index d311f83..b949e07 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -638,10 +638,28 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	if (data->flags & MMC_DATA_READ)
 		datactrl |= MCI_DPSM_DIRECTION;
 
-	/* The ST Micro variants has a special bit to enable SDIO */
 	if (variant->sdio && host->mmc->card)
-		if (mmc_card_sdio(host->mmc->card))
+		if (mmc_card_sdio(host->mmc->card)) {
+
+			/*
+			 * The ST Micro variant for SDIO write transfer sizes
+			 * less then 8 bytes must have clock H/W flow control
+			 * disabled.
+			 */
+			u32 clk;
+			if ((host->size < 8) && (data->flags & MMC_DATA_WRITE))
+				clk = host->clk_reg & ~variant->clkreg_enable;
+			else
+				clk = host->clk_reg | variant->clkreg_enable;
+
+			mmci_write_clkreg(host, clk);
+
+			/*
+			 * The ST Micro variants has a special bit
+			 * to enable SDIO.
+			 */
 			datactrl |= MCI_ST_DPSM_SDIOEN;
+		}
 
 	/*
 	 * Attempt to use DMA operation mode, if this
@@ -846,22 +864,6 @@ static int mmci_pio_write(struct mmci_host *host, char *buffer, unsigned int rem
 		count = min(remain, maxcnt);
 
 		/*
-		 * The ST Micro variant for SDIO transfer sizes
-		 * less then 8 bytes should have clock H/W flow
-		 * control disabled.
-		 */
-		if (variant->sdio &&
-		    mmc_card_sdio(host->mmc->card)) {
-			u32 clk;
-			if (count < 8)
-				clk = host->clk_reg & ~variant->clkreg_enable;
-			else
-				clk = host->clk_reg | variant->clkreg_enable;
-
-			mmci_write_clkreg(host, clk);
-		}
-
-		/*
 		 * SDIO especially may want to send something that is
 		 * not divisible by 4 (as opposed to card sectors
 		 * etc), and the FIFO only accept full 32-bit writes.
-- 
1.7.5.4
