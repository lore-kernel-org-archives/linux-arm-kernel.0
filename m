From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 29 Sep 2010 22:08:01 +0200
Subject: [PATCH 3/6] mmc: sdhci: introduce private get_ro
In-Reply-To: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1285790884-3516-4-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some controllers handle their write-protection differently. Introduce a
callback to be able to handle it, ensuring the same locking takes place
for it.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/mmc/host/sdhci.c |   11 +++++++----
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 96c7f60..129958e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1229,14 +1229,17 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 
 	if (host->flags & SDHCI_DEVICE_DEAD)
 		present = 0;
+	else if (host->ops->get_ro)
+		present = host->ops->get_ro(host);
 	else
-		present = sdhci_readl(host, SDHCI_PRESENT_STATE);
+		present = !(sdhci_readl(host, SDHCI_PRESENT_STATE)
+				& SDHCI_WRITE_PROTECT);
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	if (host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT)
-		return !!(present & SDHCI_WRITE_PROTECT);
-	return !(present & SDHCI_WRITE_PROTECT);
+	/* This quirk needs to be replaced by a callback-function later */
+	return host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT ?
+		!present : present;
 }
 
 static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 112543a..66f83f4 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -336,6 +336,7 @@ struct sdhci_ops {
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
+	unsigned int    (*get_ro)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.1
