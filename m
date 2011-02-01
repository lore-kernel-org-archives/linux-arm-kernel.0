From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  1 Feb 2011 13:21:36 +0100
Subject: [PATCH] mmci: don't try DMA on anything <= fifosize
Message-ID: <1296562896-3729-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no point in using DMA on anything that will fit just fine
in the FIFO. Let's just read and retrieve it from the FIFO.

Cc: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
This patch on top of the latest DMA code makes U8500 work again,
without the need for any completion callback patches.
---
 drivers/mmc/host/mmci.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 800b69c..c87a8d2 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -463,10 +463,12 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 		datactrl |= MCI_DPSM_DIRECTION;
 
 	/*
-	 * Attempt to use DMA operation mode, if this
-	 * should fail, fall back to PIO mode
+	 * When we want to transfer something less than or equal to the FIFO
+	 * depth, PIO works just fine, no risk of overrun. Else try DMA
+	 * first and foremost.
 	 */
-	if (!mmci_dma_start_data(host, datactrl))
+	if (host->size > variant->fifosize &&
+	    !mmci_dma_start_data(host, datactrl))
 		return;
 
 	/* IRQ mode, map the SG list for CPU reading/writing */
-- 
1.7.3.2
