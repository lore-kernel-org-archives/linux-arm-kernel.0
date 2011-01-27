From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 27 Jan 2011 15:14:26 +0100
Subject: [PATCH] mmci: calculate remaining bytes at error correctly
Message-ID: <1296137666-30906-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MMCIDATACNT register contain the number of byte left at error
not the number of words, so loose the << 2 thing. Further if CRC
fails on the first block, we may end up with a negative number
of transferred bytes which is not good, and the formula was in
wrong order.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2de12fe..ec2db8c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -283,13 +283,16 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		u32 remain, success;
 
 		/* Calculate how far we are into the transfer */
-		remain = readl(host->base + MMCIDATACNT) << 2;
+		remain = readl(host->base + MMCIDATACNT);
 		success = data->blksz * data->blocks - remain;
 
 		dev_dbg(mmc_dev(host->mmc), "MCI ERROR IRQ (status %08x)\n", status);
 		if (status & MCI_DATACRCFAIL) {
 			/* Last block was not successful */
-			host->data_xfered = ((success / data->blksz) - 1 * data->blksz);
+			if (success <= data->blksz)
+				host->data_xfered = 0;
+			else
+				host->data_xfered = ((success / data->blksz) - 1) * data->blksz;
 			data->error = -EILSEQ;
 		} else if (status & MCI_DATATIMEOUT) {
 			host->data_xfered = success;
-- 
1.7.3.2
