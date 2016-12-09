From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  9 Dec 2016 11:29:59 +0100
Subject: [PATCH v3 03/12] mmc: sdhci: Export sdhci_execute_tuning() in sdhci.c
In-Reply-To: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
References: <cover.e0137cef24a16a2c7d795548de554993595d4a98.1481279228.git-series.gregory.clement@free-electrons.com>
Message-ID: <6fe2592010e4dbb20da55e88ef80d95c30647f10.1481279228.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hu Ziji <huziji@marvell.com>

Export sdhci_execute_tuning() from sdhci.c.
Thus vendor sdhci driver can execute its own tuning process.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8e6e4e37e3b4..e971abb1368f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1950,7 +1950,7 @@ static int sdhci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
 	return 0;
 }
 
-static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
+int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	u16 ctrl;
@@ -2139,6 +2139,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	spin_unlock_irqrestore(&host->lock, flags);
 	return err;
 }
+EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
 
 static int sdhci_select_drive_strength(struct mmc_card *card,
 				       unsigned int max_dtr, int host_drv,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cd18b6f19c3b..95beadc66849 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -691,6 +691,7 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
 void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
+int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
-- 
git-series 0.9.1
