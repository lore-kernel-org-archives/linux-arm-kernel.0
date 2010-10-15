From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 15 Oct 2010 12:21:01 +0200
Subject: [PATCH 3/6] mmc: sdhci: introduce private get_ro
In-Reply-To: <1287138064-21385-1-git-send-email-w.sang@pengutronix.de>
References: <1287138064-21385-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <1287138064-21385-4-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some controllers handle their write-protection differently. Introduce a
callback to be able to handle it, ensuring the same locking takes place
for it. Rename the status variable to make it more obvious why the read
from the registers needs to be inverted.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Tested-by : Eric B?nard <eric@eukrea.com>
---

Changes since last version:

rename the variable to make usage of '!' more obvious

 drivers/mmc/host/sdhci.c |   15 +++++++++------
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9cb60ba..782c0ee 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1223,22 +1223,25 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 {
 	struct sdhci_host *host;
 	unsigned long flags;
-	int present;
+	int is_readonly;
 
 	host = mmc_priv(mmc);
 
 	spin_lock_irqsave(&host->lock, flags);
 
 	if (host->flags & SDHCI_DEVICE_DEAD)
-		present = 0;
+		is_readonly = 0;
+	else if (host->ops->get_ro)
+		is_readonly = host->ops->get_ro(host);
 	else
-		present = sdhci_readl(host, SDHCI_PRESENT_STATE);
+		is_readonly = !(sdhci_readl(host, SDHCI_PRESENT_STATE)
+				& SDHCI_WRITE_PROTECT);
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	if (host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT)
-		return !!(present & SDHCI_WRITE_PROTECT);
-	return !(present & SDHCI_WRITE_PROTECT);
+	/* This quirk needs to be replaced by a callback-function later */
+	return host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT ?
+		!is_readonly : is_readonly;
 }
 
 static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index bfcd611..b7b8a3b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -214,6 +214,7 @@ struct sdhci_ops {
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
 					     u8 power_mode);
+	unsigned int    (*get_ro)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.1
