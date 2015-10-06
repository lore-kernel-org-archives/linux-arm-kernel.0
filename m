From: mw@semihalf.com (Marcin Wojtas)
Date: Tue,  6 Oct 2015 03:22:41 +0200
Subject: [PATCH 7/8] mmc: sdhci: add init_card callback to sdhci
In-Reply-To: <1444094562-31165-1-git-send-email-mw@semihalf.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
Message-ID: <1444094562-31165-8-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some sdhci hosts may require handling quirks during card initialization at
the time when its type is already known. Hence a new callback (init_card)
is added in sdhci_ops.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/mmc/host/sdhci.c | 9 +++++++++
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cfed695..a1c308d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2200,6 +2200,14 @@ static void sdhci_card_event(struct mmc_host *mmc)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+static void sdhci_init_card(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+
+	if (host->ops->init_card)
+		host->ops->init_card(host, card);
+}
+
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.post_req	= sdhci_post_req,
@@ -2215,6 +2223,7 @@ static const struct mmc_host_ops sdhci_ops = {
 	.select_drive_strength		= sdhci_select_drive_strength,
 	.card_event			= sdhci_card_event,
 	.card_busy	= sdhci_card_busy,
+	.init_card	= sdhci_init_card,
 };
 
 /*****************************************************************************\
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c751b78..365c860 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -547,6 +547,7 @@ struct sdhci_ops {
 					 struct mmc_card *card,
 					 unsigned int max_dtr, int host_drv,
 					 int card_drv, int *drv_type);
+	void	(*init_card)(struct sdhci_host *host, struct mmc_card *card);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.8.3.1
