From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 2 Dec 2010 17:51:18 +0100
Subject: [PATCH] mmci: corrected calculation of clock div for ux500
Message-ID: <1291308678-15497-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@stericsson.com>

The Ux500 variant of this block has a different divider.
The value used right now is too big and which means a loss
in performance. This fix corrects it.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index cabd386..21fd486 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -57,6 +57,7 @@ static unsigned int fmax = 515633;
  * @broken_blockend_dma: the MCI_DATABLOCKEND is broken on the hardware when
  *		using DMA.
  * @sdio: variant supports SDIO
+ * @st_clkdiv: true if using a ST-specific clock divider algorithm
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -69,6 +70,7 @@ struct variant_data {
 	bool			broken_blockend;
 	bool			broken_blockend_dma;
 	bool			sdio;
+	bool			st_clkdiv;
 };
 
 static struct variant_data variant_arm = {
@@ -96,7 +98,9 @@ static struct variant_data variant_ux500 = {
 	.datalength_bits	= 24,
 	.broken_blockend	= true,
 	.sdio			= true,
+	.st_clkdiv		= true,
 };
+
 /*
  * This must be called with host->lock held
  */
@@ -109,6 +113,11 @@ static void mmci_set_clkreg(struct mmci_host *host, unsigned int desired)
 		if (desired >= host->mclk) {
 			clk = MCI_CLK_BYPASS;
 			host->cclk = host->mclk;
+		} else if (variant->st_clkdiv) {
+			clk = ((host->mclk + desired - 1) / desired) - 2;
+			if (clk >= 256)
+				clk = 255;
+			host->cclk = host->mclk / (clk + 2);
 		} else {
 			clk = host->mclk / (2 * desired) - 1;
 			if (clk >= 256)
-- 
1.7.3.2
