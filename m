From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  7 Oct 2016 17:22:49 +0200
Subject: [PATCH 3/10] mmc: sdhci: Export sdhci_execute_tuning() in sdhci.c
In-Reply-To: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
References: <cover.990e3503c30c18ecf50dd48bce3d52811f03ca22.1475853198.git-series.gregory.clement@free-electrons.com>
Message-ID: <f94f7f1e6f0ce1afb2d1f6b0aaf8a1817b15c8fc.1475853198.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ziji Hu <huziji@marvell.com>

Export sdhci_execute_tuning() from sdhci.c.
Thus vendor sdhci driver can execute its own tuning process.

Signed-off-by: Hu Ziji <huziji@marvell.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2250ea22231f..330119cd5a93 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1946,7 +1946,7 @@ static int sdhci_prepare_hs400_tuning(struct mmc_host *mmc, struct mmc_ios *ios)
 	return 0;
 }
 
-static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
+int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	u16 ctrl;
@@ -2135,6 +2135,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	spin_unlock_irqrestore(&host->lock, flags);
 	return err;
 }
+EXPORT_SYMBOL_GPL(sdhci_execute_tuning);
 
 static int sdhci_select_drive_strength(struct mmc_card *card,
 				       unsigned int max_dtr, int host_drv,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c38ab65b9a97..035274ddea54 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -689,6 +689,7 @@ void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
 void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
 int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 				      struct mmc_ios *ios);
+int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 
 #ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
-- 
git-series 0.8.10
