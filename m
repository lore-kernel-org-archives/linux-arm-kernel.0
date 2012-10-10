From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 10 Oct 2012 17:43:44 +0200
Subject: [PATCH 1/2] mmc: mmci: Fix incorrect handling of HW flow control for
 SDIO
Message-ID: <1349883825-22517-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <(address hidden)>

For data writes <= 8 bytes, HW flow control was disabled but
never re-enabled when the transfer was completed. This meant
that a following read request would give buffer overrun errors.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |   38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index edc3e9b..877079e 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -654,9 +654,29 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 
 	/* The ST Micro variants has a special bit to enable SDIO */
 	if (variant->sdio && host->mmc->card)
-		if (mmc_card_sdio(host->mmc->card))
+		if (mmc_card_sdio(host->mmc->card)) {
+			/*
+			 * The ST Micro variants has a special bit
+			 * to enable SDIO.
+			 */
+			u32 clk;
+
 			datactrl |= MCI_ST_DPSM_SDIOEN;
 
+			/*
+			 * The ST Micro variant for SDIO transfer sizes
+			 * less then 8 bytes should have clock H/W flow
+			 * control disabled.
+			 */
+			if ((host->size < 8) &&
+			    (data->flags & MMC_DATA_WRITE))
+				clk = host->clk_reg & ~variant->clkreg_enable;
+			else
+				clk = host->clk_reg | variant->clkreg_enable;
+
+			mmci_write_clkreg(host, clk);
+		}
+
 	/*
 	 * Attempt to use DMA operation mode, if this
 	 * should fail, fall back to PIO mode
@@ -877,22 +897,6 @@ static int mmci_pio_write(struct mmci_host *host, char *buffer, unsigned int rem
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
1.7.10
