From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  1 Feb 2011 11:41:13 +0100
Subject: [PATCH] mmci: restrict DMA usage to large, even multiblock transfers
Message-ID: <1296556873-2730-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will restrict the use of DMA to only cover multi-block
transfers of blocks that are evenly divisible with the FIFO
halfsize (8 4-byte words, 32 bytes). This will be true for any
normal, large MMC file transfer, falling back to PIO mode for
any smallish reads.

Cc: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
With this and the previous DMA end sync code the latest MMCI
patches work fine on U8500. On external cards the first read
is an 8-byte single block, which would fail otherwise.

I believe the earlier 1-byte-burst code would circumvent this
restriction, this solution is more elegant. Whether it is also
more efficient to avoid DMA on small packets needs to be
confirmed by measurements but I suspect it is.
---
 drivers/mmc/host/mmci.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index bac15a3..9ba24fd 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -484,10 +484,14 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 		datactrl |= MCI_DPSM_DIRECTION;
 
 	/*
-	 * Attempt to use DMA operation mode, if this
-	 * should fail, fall back to PIO mode
+	 * If the transfer is more than one block, and the block size is
+	 * evenly dividable by the half FIFO so it can be chopped into
+	 * burst packets, then attempt to use DMA operation mode, if this
+	 * should fail, fall back to PIO mode.
 	 */
-	if (!mmci_dma_start_data(host, datactrl))
+	if (data->blocks > 1 &&
+	    (data->blksz % variant->fifohalfsize == 0) &&
+	    !mmci_dma_start_data(host, datactrl))
 		return;
 
 	/* IRQ mode, map the SG list for CPU reading/writing */
-- 
1.7.3.2
