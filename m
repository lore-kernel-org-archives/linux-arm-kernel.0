From: csd@broadcom.com (Christian Daudt)
Date: Thu, 20 Jun 2013 14:26:36 -0700
Subject: [PATCH V5 1/2] mmc: sdhci: add card_event callback to sdhci
Message-ID: <1371763597-12440-1-git-send-email-csd@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a card_event callback to sdhci so that clients
can provide their own card_event to be called when
card_detect is triggered.

Signed-off-by: Christian Daudt <csd@broadcom.com>

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2ea429c..c0d24ef 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2046,6 +2046,10 @@ static void sdhci_card_event(struct mmc_host *mmc)
 	struct sdhci_host *host = mmc_priv(mmc);
 	unsigned long flags;
 
+	/* First check if client has provided their own card event */
+	if (host->ops->card_event)
+		host->ops->card_event(host);
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	/* Check host->mrq first in case we are runtime suspended */
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 379e09d..b037f18 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -294,6 +294,7 @@ struct sdhci_ops {
 	void	(*platform_resume)(struct sdhci_host *host);
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void	(*platform_init)(struct sdhci_host *host);
+	void    (*card_event)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.10.4
