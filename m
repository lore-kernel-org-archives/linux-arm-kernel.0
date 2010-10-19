From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 19 Oct 2010 12:22:44 +0200
Subject: [PATCH 3/3] add SDIO support for ST Variants
Message-ID: <1287483764-29126-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds some minor variant data and trickery to enable SDIO
on the ST Micro variants of MMCI/PL180.

Signed-off-by: Marcin Mielczarczyk <marcin.mielczarczyk@tieto.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |   37 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 36 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 1294a41..f31bebd 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -19,6 +19,7 @@
 #include <linux/highmem.h>
 #include <linux/log2.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
 #include <linux/amba/bus.h>
 #include <linux/clk.h>
 #include <linux/scatterlist.h>
@@ -49,6 +50,7 @@ static unsigned int fmax = 515633;
  *		and will not work at all.
  * @broken_blockend_dma: the MCI_DATABLOCKEND is broken on the hardware when
  *		using DMA.
+ * @sdio: variant supports SDIO
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -58,6 +60,7 @@ struct variant_data {
 	unsigned int		fifohalfsize;
 	bool			broken_blockend;
 	bool			broken_blockend_dma;
+	bool			sdio;
 };
 
 static struct variant_data variant_arm = {
@@ -72,6 +75,7 @@ static struct variant_data variant_u300 = {
 	.clkreg_enable		= 1 << 13, /* HWFCEN */
 	.datalength_bits	= 16,
 	.broken_blockend_dma	= true,
+	.sdio			= true,
 };
 
 static struct variant_data variant_ux500 = {
@@ -81,6 +85,7 @@ static struct variant_data variant_ux500 = {
 	.clkreg_enable		= 1 << 14, /* HWFCEN */
 	.datalength_bits	= 24,
 	.broken_blockend	= true,
+	.sdio			= true,
 };
 /*
  * This must be called with host->lock held
@@ -220,6 +225,11 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 		irqmask = MCI_TXFIFOHALFEMPTYMASK;
 	}
 
+	/* The ST Micro variants has a special bit to enable SDIO */
+	if (variant->sdio && host->mmc->card)
+		if (mmc_card_sdio(host->mmc->card))
+			datactrl |= MCI_ST_DPSM_SDIOEN;
+
 	writel(datactrl, base + MMCIDATACTRL);
 	writel(readl(base + MMCIMASK0) & ~MCI_DATAENDMASK, base + MMCIMASK0);
 	mmci_set_mask1(host, irqmask);
@@ -427,7 +437,32 @@ static int mmci_pio_write(struct mmci_host *host, char *buffer, unsigned int rem
 			 variant->fifosize : variant->fifohalfsize;
 		count = min(remain, maxcnt);
 
-		writesl(base + MMCIFIFO, ptr, count >> 2);
+		/*
+		 * The ST Micro variant for SDIO transfer sizes
+		 * less then 8 bytes should have clock H/W flow
+		 * control disabled.
+		 */
+		if (variant->sdio &&
+		    mmc_card_sdio(host->mmc->card)) {
+			if (count < 8)
+				writel(readl(host->base + MMCICLOCK) &
+					~variant->clkreg_enable,
+					host->base + MMCICLOCK);
+			else
+				writel(readl(host->base + MMCICLOCK) |
+					variant->clkreg_enable,
+					host->base + MMCICLOCK);
+		}
+
+		/*
+		 * SDIO especially may want to send something that is
+		 * not divisible by 4 (as opposed to card sectors
+		 * etc), and the FIFO only accept full 32-bit writes.
+		 * So compensate by adding +3 on the count, a single
+		 * byte become a 32bit write, 7 bytes will be two
+		 * 32bit writes etc.
+		 */
+		writesl(base + MMCIFIFO, ptr, (count + 3) >> 2);
 
 		ptr += count;
 		remain -= count;
-- 
1.7.2.3
