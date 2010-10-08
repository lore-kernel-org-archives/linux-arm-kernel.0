From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 8 Oct 2010 09:02:47 +0200
Subject: [PATCH 2/2] MMCI: add SDIO support for ST Variants
Message-ID: <1286521367-11824-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds some minor variant data and trickery to enable SDIO
on the ST Micro variants of MMCI/PL180.

Signed-off-by: Marcin Mielczarczyk <marcin.mielczarczyk@tieto.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 09bcce7..cd9414b 100644
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
@@ -54,6 +55,7 @@ struct variant_data {
 	unsigned int		fifosize;
 	unsigned int		fifohalfsize;
 	bool			singleirq;
+	bool			sdio;
 };
 
 static struct variant_data variant_arm = {
@@ -67,6 +69,7 @@ static struct variant_data variant_u300 = {
 	.fifohalfsize		= 8 * 4,
 	.clkreg_enable		= 1 << 13, /* HWFCEN */
 	.datalength_bits	= 16,
+	.sdio			= true,
 };
 
 static struct variant_data variant_ux500 = {
@@ -76,6 +79,7 @@ static struct variant_data variant_ux500 = {
 	.clkreg_enable		= 1 << 14, /* HWFCEN */
 	.datalength_bits	= 24,
 	.singleirq		= true,
+	.sdio			= true,
 };
 
 /*
@@ -217,6 +221,11 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
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
@@ -415,7 +424,32 @@ static int mmci_pio_write(struct mmci_host *host, char *buffer, unsigned int rem
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
1.6.3.3
