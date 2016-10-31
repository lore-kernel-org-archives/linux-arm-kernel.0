From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 31 Oct 2016 12:09:50 +0100
Subject: [PATCH 1/10] mmc: sdhci: Export sdhci_set_ios() from sdhci.c
In-Reply-To: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
Message-ID: <beb9b84b12ccc6dfc931dbd8cb7706195cdaa490.1477911954.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ziji Hu <huziji@marvell.com>

Export sdhci_set_ios() in sdhci.c.
Thus vendor sdhci driver can implement its own set_ios() routine.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 71654b90227f..ea06faf8a437 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1563,7 +1563,7 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 }
 EXPORT_SYMBOL_GPL(sdhci_set_uhs_signaling);
 
-static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	unsigned long flags;
@@ -1723,6 +1723,7 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	mmiowb();
 	spin_unlock_irqrestore(&host->lock, flags);
 }
+EXPORT_SYMBOL_GPL(sdhci_set_ios);
 
 static int sdhci_get_cd(struct mmc_host *mmc)
 {
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 766df17fb7eb..37771de4cafa 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -688,6 +688,7 @@ void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
+void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
-- 
git-series 0.8.10
