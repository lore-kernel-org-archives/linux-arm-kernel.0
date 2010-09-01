From: r65037@freescale.com (Richard Zhu)
Date: Wed, 1 Sep 2010 17:46:57 +0800
Subject: [PATCH 2/9] sdhci-2: add host's own get_ro func to support the
	controller that used it's own WP mechanism
Message-ID: <1283334417-12524-1-git-send-email-r65037@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some controllers have their own WP mechanism when implement the get_ro, add one
get_ro api to supported them.

Signed-off-by: Richard Zhu <r65037@freescale.com>
---
 drivers/mmc/host/sdhci.c |    3 +++
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2a93c27..e7e2611 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1213,6 +1213,9 @@ static int sdhci_get_ro(struct mmc_host *mmc)
 
 	host = mmc_priv(mmc);
 
+	if (host->ops->get_ro)
+		return host->ops->get_ro(host);
+
 	spin_lock_irqsave(&host->lock, flags);
 
 	if (host->flags & SDHCI_DEVICE_DEAD)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d420b4e..a4db2cc 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -322,6 +322,7 @@ struct sdhci_ops {
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
+	unsigned int	(*get_ro)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.0
